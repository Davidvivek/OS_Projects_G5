#include "kernel/types.h"
#include "kernel/syscall.h"
#include "user/user.h"

int main() {
  int f = getcount(SYS_fork);
  int w = getcount(SYS_write);
  int r = getcount(SYS_read);
  printf("fork  count = %d\n", f);
  printf("write count = %d\n", w);
  printf("read  count = %d\n", r);
  exit(0);
}
