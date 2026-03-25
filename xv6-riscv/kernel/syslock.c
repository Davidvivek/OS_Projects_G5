// syslock.c – user-space mutex lock system calls for xv6
// Provides: lock_create, lock_acquire, lock_release, lock_destroy

#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "proc.h"

// One entry in the kernel-managed user lock table
struct userlock {
  int used;            // 1 if slot is allocated
  int locked;          // 1 if currently held
  int pid;             // pid of the process holding the lock (0 = none)
  struct spinlock lk;  // protects this entry's metadata
};

struct userlock locks[NLOCK];

// Call once at boot – initialise every slot's spinlock
void
lockinit(void)
{
  for(int i = 0; i < NLOCK; i++){
    initlock(&locks[i].lk, "userlock");
    locks[i].used   = 0;
    locks[i].locked = 0;
    locks[i].pid    = 0;
  }
}

// Allocate a new user lock. Returns its id (0..NLOCK-1) or -1.
uint64
sys_lock_create(void)
{
  for(int i = 0; i < NLOCK; i++){
    acquire(&locks[i].lk);
    if(!locks[i].used){
      locks[i].used   = 1;
      locks[i].locked = 0;
      locks[i].pid    = 0;
      release(&locks[i].lk);
      return i;
    }
    release(&locks[i].lk);
  }
  return -1;  // no free slot
}

// Acquire the lock identified by id.
// Blocks (sleeps) until the lock becomes free.
uint64
sys_lock_acquire(void)
{
  int id;
  argint(0, &id);

  if(id < 0 || id >= NLOCK)
    return -1;

  acquire(&locks[id].lk);

  if(!locks[id].used){
    release(&locks[id].lk);
    return -1;
  }

  // Sleep while the lock is held by another process
  while(locks[id].locked){
    sleep(&locks[id], &locks[id].lk);
  }

  locks[id].locked = 1;
  locks[id].pid    = myproc()->pid;
  release(&locks[id].lk);
  return 0;
}

// Release the lock identified by id.
// Only the process that acquired it may release it.
uint64
sys_lock_release(void)
{
  int id;
  argint(0, &id);

  if(id < 0 || id >= NLOCK)
    return -1;

  acquire(&locks[id].lk);

  if(!locks[id].used || !locks[id].locked){
    release(&locks[id].lk);
    return -1;
  }

  if(locks[id].pid != myproc()->pid){
    // Only the owner may release
    release(&locks[id].lk);
    return -1;
  }

  locks[id].locked = 0;
  locks[id].pid    = 0;
  wakeup(&locks[id]);       // wake any sleepers waiting on this lock
  release(&locks[id].lk);
  return 0;
}

// Destroy (free) the lock slot identified by id.
uint64
sys_lock_destroy(void)
{
  int id;
  argint(0, &id);

  if(id < 0 || id >= NLOCK)
    return -1;

  acquire(&locks[id].lk);

  if(!locks[id].used){
    release(&locks[id].lk);
    return -1;
  }

  locks[id].used   = 0;
  locks[id].locked = 0;
  locks[id].pid    = 0;
  release(&locks[id].lk);
  return 0;
}
