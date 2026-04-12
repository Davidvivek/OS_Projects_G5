#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main() {
  uint wtime, rtime;
  int pid = fork();
  if(pid == 0){
    for(volatile int i = 0; i < 1000000; i++);
    exit(0);
  }
  waitx(0, &wtime, &rtime);
  printf("wtime=%d rtime=%d\n", wtime, rtime);
  exit(0);
}
