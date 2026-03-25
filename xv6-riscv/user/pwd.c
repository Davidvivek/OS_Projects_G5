#include "kernel/types.h"
#include "kernel/param.h"
#include "user/user.h"

int
main(void)
{
  char buf[MAXPATH];

  if(getcwd(buf, sizeof(buf)) < 0){
    fprintf(2, "pwd: getcwd failed\n");
    exit(1);
  }
  printf("%s\n", buf);
  exit(0);
}
