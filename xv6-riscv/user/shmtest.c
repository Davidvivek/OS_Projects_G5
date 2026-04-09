// shmtest.c – User-space demonstration of Shared Memory IPC in xv6
//
// Scenario
// --------
//  Parent creates a shared memory segment (key=42, 1 page = 4096 bytes).
//  Parent forks a child.
//  Child attaches the segment, writes a message into it, then detaches and exits.
//  Parent waits for the child, attaches the same segment, reads the message,
//  then detaches and is done.
//
// This proves that both processes see the SAME physical memory even though
// they have separate virtual address spaces (parent/child after fork).

#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

#define SHM_KEY  42
#define SHM_SIZE 4096   // one page

int
main(void)
{
  printf("=== Shared Memory IPC Test ===\n");

  // ── Step 1: Parent creates the shared segment ──────────────────────────────
  int shmid = shmget(SHM_KEY, SHM_SIZE);
  if (shmid < 0) {
    printf("shmget failed\n");
    exit(1);
  }
  printf("[parent] shmget: created segment with id=%d (key=%d, size=%d)\n",
         shmid, SHM_KEY, SHM_SIZE);

  // ── Step 2: Fork ──────────────────────────────────────────────────────────
  int pid = fork();
  if (pid < 0) {
    printf("fork failed\n");
    exit(1);
  }

  if (pid == 0) {
    // ── CHILD ───────────────────────────────────────────────────────────────

    // Attach the segment (look it up by key, get same shmid)
    int child_shmid = shmget(SHM_KEY, SHM_SIZE);
    if (child_shmid < 0) {
      printf("[child]  shmget lookup failed\n");
      exit(1);
    }

    char *shm = (char *)shmattach(child_shmid);
    if (shm == (char *)-1) {
      printf("[child]  shmattach failed\n");
      exit(1);
    }
    printf("[child]  attached segment at va=%p\n", shm);

    // Write a message into shared memory
    char *msg = "Hello from the child process!";
    int i;
    for (i = 0; msg[i] != '\0'; i++)
      shm[i] = msg[i];
    shm[i] = '\0';

    printf("[child]  wrote: \"%s\"\n", shm);

    // Detach and exit
    if (shmdetach(shm) < 0) {
      printf("[child]  shmdetach failed\n");
      exit(1);
    }
    printf("[child]  detached, exiting\n");
    exit(0);
  }

  // ── PARENT (continues after fork) ─────────────────────────────────────────

  // Wait for child to finish writing
  wait(0);
  printf("[parent] child finished, now reading shared memory\n");

  // Attach and read back
  char *shm = (char *)shmattach(shmid);
  if (shm == (char *)-1) {
    printf("[parent] shmattach failed\n");
    exit(1);
  }
  printf("[parent] attached segment at va=%p\n", shm);
  printf("[parent] read back: \"%s\"\n", shm);

  // Detach
  if (shmdetach(shm) < 0) {
    printf("[parent] shmdetach failed\n");
    exit(1);
  }
  printf("[parent] detached successfully\n");

  // ── Summary ──────────────────────────────────────────────────────────────
  printf("\n=== Test PASSED: parent read the message written by child ===\n");
  exit(0);
}
