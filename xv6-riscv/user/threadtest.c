#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

#define STACK_SIZE 4096
#define NUM_THREADS 3

// Shared global counter and its lock.
volatile int counter = 0;
int counter_lock;

// Thread function receives its thread number as arg.
void
thread_fn(void *arg)
{
  int id = (int)(uint64)arg;
  
  lock_acquire(counter_lock);
  counter++;
  printf("Thread %d running, counter is now %d\n", id, counter);
  lock_release(counter_lock);
  
  exit(0);
}

int
main(void)
{
  printf("threadtest: starting %d threads\n", NUM_THREADS);

  counter_lock = lock_create();
  if(counter_lock < 0){
    printf("threadtest: failed to create lock\n");
    exit(1);
  }

  // We need to keep track of the stack pointers so we can free them during join
  void *stacks[NUM_THREADS];

  for(int i = 0; i < NUM_THREADS; i++){
    int tid = thread_create(thread_fn, (void*)(uint64)(i + 1), &stacks[i]);
    if(tid < 0){
      printf("threadtest: clone failed for thread %d\n", i);
      exit(1);
    }
    lock_acquire(counter_lock);
    printf("threadtest: spawned thread %d with tid %d\n", i + 1, tid);
    lock_release(counter_lock);
  }

  // Join all threads and automatically free their stacks.
  for(int i = 0; i < NUM_THREADS; i++){
    int tid = thread_join(&stacks[i]);
    if(tid < 0){
      printf("threadtest: join failed\n");
      exit(1);
    }
    lock_acquire(counter_lock);
    printf("threadtest: joined tid %d\n", tid);
    lock_release(counter_lock);
  }
  
  lock_destroy(counter_lock);

  printf("threadtest: all threads done, final counter = %d\n", counter);
  exit(0);
}
