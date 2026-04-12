#include "kernel/types.h"
#include "kernel/syscall.h"
#include "user/user.h"

int main() {
  trace(1 << SYS_fork);
  printf("tracing fork:\n");
  fork();
  wait(0);
  exit(0);
}
