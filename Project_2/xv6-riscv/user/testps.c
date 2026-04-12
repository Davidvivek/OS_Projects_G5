#include "kernel/types.h"
#include "user/user.h"

int main() {
  fork();
  fork();
  ps();
  wait(0);
  wait(0);
  exit(0);
}
