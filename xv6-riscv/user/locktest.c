// locktest.c – demonstrate the lock_create/acquire/release/destroy syscalls
// Usage: locktest
//
// Forks a child process. Both parent and child acquire the same lock
// and print their PID while inside the critical section.
// Because the lock enforces mutual exclusion, the sections cannot overlap.

#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int
main(void)
{
  int lk = lock_create();
  if(lk < 0){
    printf("locktest: lock_create failed\n");
    exit(1);
  }

  printf("Lock test starting (lock id = %d)\n", lk);

  int pid = fork();
  if(pid < 0){
    printf("locktest: fork failed\n");
    lock_destroy(lk);
    exit(1);
  }

  // ---- both parent and child reach this point ----

  int me = getpid();
  for(int i = 0; i < 3; i++){
    if(lock_acquire(lk) < 0){
      printf("Process %d: lock_acquire failed\n", me);
      exit(1);
    }

    // --- critical section ---
    printf("Process %d: >>> INSIDE critical section (iteration %d)\n", me, i);
    // small busy loop to make the overlap more visible in output
    for(volatile int j = 0; j < 100000; j++)
      ;
    printf("Process %d: <<< LEAVING critical section (iteration %d)\n", me, i);
    // --- end critical section ---

    if(lock_release(lk) < 0){
      printf("Process %d: lock_release failed\n", me);
      exit(1);
    }
  }

  if(pid == 0){
    // child exits
    exit(0);
  } else {
    // parent waits for child
    int status;
    wait(&status);

    if(lock_destroy(lk) < 0){
      printf("locktest: lock_destroy failed\n");
      exit(1);
    }
    printf("Lock test done. Lock %d destroyed.\n", lk);
  }

  exit(0);
}
