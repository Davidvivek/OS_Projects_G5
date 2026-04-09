// sysshm.c – Shared Memory IPC system calls for xv6
//
// Provides three system calls:
//   shmget(int key, int size)  – Create or look up a shared memory segment.
//                                Returns a segment id (shmid) >= 0, or -1.
//   shmattach(int shmid)       – Map segment into the calling process's
//                                address space.  Returns the virtual address,
//                                or (void*)-1 on error.
//   shmdetach(void *addr)      – Unmap the segment from the calling process.
//                                Returns 0 on success, -1 on error.
//
// Design notes:
//   * A global table of NSHM slots is kept in the kernel.  Each slot holds
//     the integer key, a reference count, and the physical pages that back
//     the segment.
//   * Segments are page-aligned; the requested size is rounded up to the
//     next page boundary (PGSIZE).
//   * shmattach() appends the shared region above the current heap of the
//     calling process (above p->sz) without incrementing p->sz, so that
//     normal heap allocations (sbrk) do not collide with the shared region.
//     The virtual address returned to the caller is stored per-process so
//     that shmdetach() can locate and unmap it.
//   * Physical pages are allocated once at shmget() time and freed when the
//     last process detaches (refcount drops to 0).

#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "proc.h"

// ── per-segment descriptor ────────────────────────────────────────────────────

struct shmseg {
  int      used;                    // 1 if slot is allocated
  int      key;                     // caller-chosen integer key
  int      npages;                  // number of pages in this segment
  int      refcnt;                  // number of processes currently attached
  uint64   pages[SHM_MAXPAGES];    // physical addresses of backing pages
  struct spinlock lk;               // protects this slot
};

static struct shmseg segtable[NSHM];

// ── per-process attachment record ─────────────────────────────────────────────
// Each process can attach at most NSHM segments simultaneously.

struct shmattach {
  int    shmid;   // index into segtable; -1 means unused slot
  uint64 va;      // virtual address where it was mapped in this process
  int    npages;  // how many pages were mapped
};

// Stored inside struct proc.  We use a parallel array keyed by proc index.
// To keep proc.h simple we store it here in a static table indexed by pid.
// Since xv6 has at most NPROC processes the array is small.
static struct shmattach attachtable[NPROC][NSHM];
static struct spinlock  attachtable_lk;

// ── boot-time initialisation ──────────────────────────────────────────────────

void
shminit(void)
{
  initlock(&attachtable_lk, "attachtable");
  for (int i = 0; i < NSHM; i++) {
    initlock(&segtable[i].lk, "shmseg");
    segtable[i].used   = 0;
    segtable[i].refcnt = 0;
  }
  for (int p = 0; p < NPROC; p++)
    for (int s = 0; s < NSHM; s++)
      attachtable[p][s].shmid = -1;
}

// ── helper: find slot index for a pid ─────────────────────────────────────────

static int
pidslot(int pid)
{
  // xv6 pids start at 1; use pid-1 as index (capped at NPROC-1)
  int idx = pid - 1;
  if (idx < 0 || idx >= NPROC)
    return -1;
  return idx;
}

// ── sys_shmget ────────────────────────────────────────────────────────────────
// int shmget(int key, int size)
// Creates a new shared segment with the given key and size (bytes), or
// returns the id of an existing segment with the same key.
// Returns shmid >= 0 on success, -1 on failure.

uint64
sys_shmget(void)
{
  int key, size;
  argint(0, &key);
  argint(1, &size);

  if (size <= 0)
    return -1;

  int npages = (size + PGSIZE - 1) / PGSIZE;  // round up
  if (npages > SHM_MAXPAGES)
    return -1;

  // First pass: look for an existing segment with the same key.
  for (int i = 0; i < NSHM; i++) {
    acquire(&segtable[i].lk);
    if (segtable[i].used && segtable[i].key == key) {
      int id = i;
      release(&segtable[i].lk);
      return id;
    }
    release(&segtable[i].lk);
  }

  // Second pass: allocate a new slot.
  for (int i = 0; i < NSHM; i++) {
    acquire(&segtable[i].lk);
    if (!segtable[i].used) {
      // Allocate physical pages now.
      for (int p = 0; p < npages; p++) {
        char *mem = kalloc();
        if (mem == 0) {
          // Roll back already-allocated pages.
          for (int q = 0; q < p; q++)
            kfree((void *)segtable[i].pages[q]);
          release(&segtable[i].lk);
          return -1;
        }
        memset(mem, 0, PGSIZE);
        segtable[i].pages[p] = (uint64)mem;
      }
      segtable[i].used   = 1;
      segtable[i].key    = key;
      segtable[i].npages = npages;
      segtable[i].refcnt = 0;
      release(&segtable[i].lk);
      return i;
    }
    release(&segtable[i].lk);
  }

  return -1;  // no free slot
}

// ── sys_shmattach ─────────────────────────────────────────────────────────────
// void *shmattach(int shmid)
// Maps the shared segment identified by shmid into the calling process's
// virtual address space.  The region is placed just above p->sz so it does
// not interfere with the heap.
// Returns the virtual address on success, or (uint64)-1 on failure.

uint64
sys_shmattach(void)
{
  int shmid;
  argint(0, &shmid);

  if (shmid < 0 || shmid >= NSHM)
    return (uint64)-1;

  struct proc *p = myproc();
  int pslot = pidslot(p->pid);
  if (pslot < 0)
    return (uint64)-1;

  acquire(&segtable[shmid].lk);
  if (!segtable[shmid].used) {
    release(&segtable[shmid].lk);
    return (uint64)-1;
  }
  int npages = segtable[shmid].npages;
  release(&segtable[shmid].lk);

  // Choose a virtual address above the current process size, page-aligned.
  // We skip 1 guard page above p->sz to separate heap from shared region.
  uint64 va = PGROUNDUP(p->sz) + PGSIZE;

  // Check all pages fit before TRAPFRAME.
  if (va + (uint64)npages * PGSIZE > TRAPFRAME)
    return (uint64)-1;

  // Map each physical page.
  acquire(&segtable[shmid].lk);
  for (int pg = 0; pg < npages; pg++) {
    uint64 pa = segtable[shmid].pages[pg];
    if (mappages(p->pagetable, va + (uint64)pg * PGSIZE,
                 PGSIZE, pa, PTE_R | PTE_W | PTE_U) != 0) {
      // Unmap what we already mapped (don't free physical pages).
      uvmunmap(p->pagetable, va, pg, 0);
      release(&segtable[shmid].lk);
      return (uint64)-1;
    }
  }
  segtable[shmid].refcnt++;
  release(&segtable[shmid].lk);

  // Record the attachment in the per-process table.
  acquire(&attachtable_lk);
  for (int s = 0; s < NSHM; s++) {
    if (attachtable[pslot][s].shmid == -1) {
      attachtable[pslot][s].shmid  = shmid;
      attachtable[pslot][s].va     = va;
      attachtable[pslot][s].npages = npages;
      break;
    }
  }
  release(&attachtable_lk);

  return va;
}

// ── sys_shmdetach ─────────────────────────────────────────────────────────────
// int shmdetach(void *addr)
// Unmaps the shared segment that was attached at virtual address addr.
// Frees physical pages if this was the last attachment.
// Returns 0 on success, -1 on error.

uint64
sys_shmdetach(void)
{
  uint64 addr;
  argaddr(0, &addr);

  struct proc *p = myproc();
  int pslot = pidslot(p->pid);
  if (pslot < 0)
    return -1;

  // Find the attachment record.
  acquire(&attachtable_lk);
  int found = -1;
  for (int s = 0; s < NSHM; s++) {
    if (attachtable[pslot][s].shmid != -1 &&
        attachtable[pslot][s].va == addr) {
      found = s;
      break;
    }
  }
  if (found < 0) {
    release(&attachtable_lk);
    return -1;
  }

  int shmid  = attachtable[pslot][found].shmid;
  int npages = attachtable[pslot][found].npages;

  // Clear the record before releasing the lock so no double-detach.
  attachtable[pslot][found].shmid = -1;
  attachtable[pslot][found].va    = 0;
  release(&attachtable_lk);

  // Unmap the virtual pages (do NOT free physical pages yet).
  uvmunmap(p->pagetable, addr, npages, 0);

  // Decrement refcount; free physical pages if last user.
  acquire(&segtable[shmid].lk);
  segtable[shmid].refcnt--;
  if (segtable[shmid].refcnt == 0) {
    for (int pg = 0; pg < segtable[shmid].npages; pg++)
      kfree((void *)segtable[shmid].pages[pg]);
    segtable[shmid].used = 0;
  }
  release(&segtable[shmid].lk);

  return 0;
}
