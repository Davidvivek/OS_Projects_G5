// sysshm.c - Shared Memory IPC for xv6
// Adds three syscalls: shmget, shmattach, shmdetach
// Lets two processes read/write the same physical memory pages.

#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "proc.h"

// One shared memory segment
struct shmseg {
  int     used;
  int     key;
  int     npages;
  int     refcnt;
  uint64  pages[SHM_MAXPAGES];
  struct spinlock lk;
};

static struct shmseg segtable[NSHM];

// Tracks which segments each process has attached, and at what address
struct shmattach {
  int    shmid;   // -1 means this slot is free
  uint64 va;
  int    npages;
};

static struct shmattach attachtable[NPROC][NSHM];
static struct spinlock  attachtable_lk;

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

// Maps pid -> index in attachtable (pids start at 1)
static int
pidslot(int pid)
{
  int idx = pid - 1;
  if (idx < 0 || idx >= NPROC)
    return -1;
  return idx;
}

// shmget(key, size) - create a new shared segment or return an existing one
// with the same key. Returns the segment id on success, -1 on failure.
uint64
sys_shmget(void)
{
  int key, size;
  argint(0, &key);
  argint(1, &size);

  if (size <= 0)
    return -1;

  int npages = (size + PGSIZE - 1) / PGSIZE;
  if (npages > SHM_MAXPAGES)
    return -1;

  // If a segment with this key already exists, just return its id
  for (int i = 0; i < NSHM; i++) {
    acquire(&segtable[i].lk);
    if (segtable[i].used && segtable[i].key == key) {
      int id = i;
      release(&segtable[i].lk);
      return id;
    }
    release(&segtable[i].lk);
  }

  // Otherwise allocate a new slot and grab physical pages for it
  for (int i = 0; i < NSHM; i++) {
    acquire(&segtable[i].lk);
    if (!segtable[i].used) {
      for (int p = 0; p < npages; p++) {
        char *mem = kalloc();
        if (mem == 0) {
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

  return -1;
}

// shmattach(shmid) - map the shared segment into this process's address space.
// The region is placed just above the process heap so it doesn't interfere
// with normal memory. Returns the virtual address, or -1 on failure.
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

  // Place shared region one guard page above the heap
  uint64 va = PGROUNDUP(p->sz) + PGSIZE;
  if (va + (uint64)npages * PGSIZE > TRAPFRAME)
    return (uint64)-1;

  acquire(&segtable[shmid].lk);
  for (int pg = 0; pg < npages; pg++) {
    uint64 pa = segtable[shmid].pages[pg];
    if (mappages(p->pagetable, va + (uint64)pg * PGSIZE,
                 PGSIZE, pa, PTE_R | PTE_W | PTE_U) != 0) {
      uvmunmap(p->pagetable, va, pg, 0);
      release(&segtable[shmid].lk);
      return (uint64)-1;
    }
  }
  segtable[shmid].refcnt++;
  release(&segtable[shmid].lk);

  // Remember this attachment so we can undo it in shmdetach
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

// shmdetach(addr) - unmap the shared segment that was attached at addr.
// The physical pages are kept alive so other processes can still attach.
// Returns 0 on success, -1 on failure.
uint64
sys_shmdetach(void)
{
  uint64 addr;
  argaddr(0, &addr);

  struct proc *p = myproc();
  int pslot = pidslot(p->pid);
  if (pslot < 0)
    return -1;

  // Find the record for this address
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

  // Clear our record first to prevent a double-detach
  attachtable[pslot][found].shmid = -1;
  attachtable[pslot][found].va    = 0;
  release(&attachtable_lk);

  // Remove the mapping from this process's page table (don't free the pages)
  uvmunmap(p->pagetable, addr, npages, 0);

  acquire(&segtable[shmid].lk);
  segtable[shmid].refcnt--;
  release(&segtable[shmid].lk);

  return 0;
}
