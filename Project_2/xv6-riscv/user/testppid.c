#include "kernel/types.h"
#include "user/user.h"

int main() {
  printf("my pid     = %d\n", getpid());
  printf("parent pid = %d\n", getppid());
  int pid = fork();
  if(pid == 0){
    printf("[child] my pid     = %d\n", getpid());
    printf("[child] parent pid = %d\n", getppid());
    exit(0);
  }
  wait(0);
  exit(0);
}
