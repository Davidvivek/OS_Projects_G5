
user/_zombie:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(void)
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
  if(fork() > 0)
   8:	332000ef          	jal	33a <fork>
   c:	00a04563          	bgtz	a0,16 <main+0x16>
    pause(5);  // Let child exit before parent.
  exit(0);
  10:	4501                	li	a0,0
  12:	330000ef          	jal	342 <exit>
    pause(5);  // Let child exit before parent.
  16:	4515                	li	a0,5
  18:	3ba000ef          	jal	3d2 <pause>
  1c:	bfd5                	j	10 <main+0x10>

000000000000001e <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  1e:	1141                	addi	sp,sp,-16
  20:	e406                	sd	ra,8(sp)
  22:	e022                	sd	s0,0(sp)
  24:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  26:	fdbff0ef          	jal	0 <main>
  exit(r);
  2a:	318000ef          	jal	342 <exit>

000000000000002e <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  2e:	1141                	addi	sp,sp,-16
  30:	e422                	sd	s0,8(sp)
  32:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  34:	87aa                	mv	a5,a0
  36:	0585                	addi	a1,a1,1
  38:	0785                	addi	a5,a5,1
  3a:	fff5c703          	lbu	a4,-1(a1)
  3e:	fee78fa3          	sb	a4,-1(a5)
  42:	fb75                	bnez	a4,36 <strcpy+0x8>
    ;
  return os;
}
  44:	6422                	ld	s0,8(sp)
  46:	0141                	addi	sp,sp,16
  48:	8082                	ret

000000000000004a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  4a:	1141                	addi	sp,sp,-16
  4c:	e422                	sd	s0,8(sp)
  4e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  50:	00054783          	lbu	a5,0(a0)
  54:	cb91                	beqz	a5,68 <strcmp+0x1e>
  56:	0005c703          	lbu	a4,0(a1)
  5a:	00f71763          	bne	a4,a5,68 <strcmp+0x1e>
    p++, q++;
  5e:	0505                	addi	a0,a0,1
  60:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  62:	00054783          	lbu	a5,0(a0)
  66:	fbe5                	bnez	a5,56 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  68:	0005c503          	lbu	a0,0(a1)
}
  6c:	40a7853b          	subw	a0,a5,a0
  70:	6422                	ld	s0,8(sp)
  72:	0141                	addi	sp,sp,16
  74:	8082                	ret

0000000000000076 <strlen>:

uint
strlen(const char *s)
{
  76:	1141                	addi	sp,sp,-16
  78:	e422                	sd	s0,8(sp)
  7a:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  7c:	00054783          	lbu	a5,0(a0)
  80:	cf91                	beqz	a5,9c <strlen+0x26>
  82:	0505                	addi	a0,a0,1
  84:	87aa                	mv	a5,a0
  86:	86be                	mv	a3,a5
  88:	0785                	addi	a5,a5,1
  8a:	fff7c703          	lbu	a4,-1(a5)
  8e:	ff65                	bnez	a4,86 <strlen+0x10>
  90:	40a6853b          	subw	a0,a3,a0
  94:	2505                	addiw	a0,a0,1
    ;
  return n;
}
  96:	6422                	ld	s0,8(sp)
  98:	0141                	addi	sp,sp,16
  9a:	8082                	ret
  for(n = 0; s[n]; n++)
  9c:	4501                	li	a0,0
  9e:	bfe5                	j	96 <strlen+0x20>

00000000000000a0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  a0:	1141                	addi	sp,sp,-16
  a2:	e422                	sd	s0,8(sp)
  a4:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  a6:	ca19                	beqz	a2,bc <memset+0x1c>
  a8:	87aa                	mv	a5,a0
  aa:	1602                	slli	a2,a2,0x20
  ac:	9201                	srli	a2,a2,0x20
  ae:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  b2:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  b6:	0785                	addi	a5,a5,1
  b8:	fee79de3          	bne	a5,a4,b2 <memset+0x12>
  }
  return dst;
}
  bc:	6422                	ld	s0,8(sp)
  be:	0141                	addi	sp,sp,16
  c0:	8082                	ret

00000000000000c2 <strchr>:

char*
strchr(const char *s, char c)
{
  c2:	1141                	addi	sp,sp,-16
  c4:	e422                	sd	s0,8(sp)
  c6:	0800                	addi	s0,sp,16
  for(; *s; s++)
  c8:	00054783          	lbu	a5,0(a0)
  cc:	cb99                	beqz	a5,e2 <strchr+0x20>
    if(*s == c)
  ce:	00f58763          	beq	a1,a5,dc <strchr+0x1a>
  for(; *s; s++)
  d2:	0505                	addi	a0,a0,1
  d4:	00054783          	lbu	a5,0(a0)
  d8:	fbfd                	bnez	a5,ce <strchr+0xc>
      return (char*)s;
  return 0;
  da:	4501                	li	a0,0
}
  dc:	6422                	ld	s0,8(sp)
  de:	0141                	addi	sp,sp,16
  e0:	8082                	ret
  return 0;
  e2:	4501                	li	a0,0
  e4:	bfe5                	j	dc <strchr+0x1a>

00000000000000e6 <gets>:

char*
gets(char *buf, int max)
{
  e6:	711d                	addi	sp,sp,-96
  e8:	ec86                	sd	ra,88(sp)
  ea:	e8a2                	sd	s0,80(sp)
  ec:	e4a6                	sd	s1,72(sp)
  ee:	e0ca                	sd	s2,64(sp)
  f0:	fc4e                	sd	s3,56(sp)
  f2:	f852                	sd	s4,48(sp)
  f4:	f456                	sd	s5,40(sp)
  f6:	f05a                	sd	s6,32(sp)
  f8:	ec5e                	sd	s7,24(sp)
  fa:	1080                	addi	s0,sp,96
  fc:	8baa                	mv	s7,a0
  fe:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 100:	892a                	mv	s2,a0
 102:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 104:	4aa9                	li	s5,10
 106:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 108:	89a6                	mv	s3,s1
 10a:	2485                	addiw	s1,s1,1
 10c:	0344d663          	bge	s1,s4,138 <gets+0x52>
    cc = read(0, &c, 1);
 110:	4605                	li	a2,1
 112:	faf40593          	addi	a1,s0,-81
 116:	4501                	li	a0,0
 118:	242000ef          	jal	35a <read>
    if(cc < 1)
 11c:	00a05e63          	blez	a0,138 <gets+0x52>
    buf[i++] = c;
 120:	faf44783          	lbu	a5,-81(s0)
 124:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 128:	01578763          	beq	a5,s5,136 <gets+0x50>
 12c:	0905                	addi	s2,s2,1
 12e:	fd679de3          	bne	a5,s6,108 <gets+0x22>
    buf[i++] = c;
 132:	89a6                	mv	s3,s1
 134:	a011                	j	138 <gets+0x52>
 136:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 138:	99de                	add	s3,s3,s7
 13a:	00098023          	sb	zero,0(s3)
  return buf;
}
 13e:	855e                	mv	a0,s7
 140:	60e6                	ld	ra,88(sp)
 142:	6446                	ld	s0,80(sp)
 144:	64a6                	ld	s1,72(sp)
 146:	6906                	ld	s2,64(sp)
 148:	79e2                	ld	s3,56(sp)
 14a:	7a42                	ld	s4,48(sp)
 14c:	7aa2                	ld	s5,40(sp)
 14e:	7b02                	ld	s6,32(sp)
 150:	6be2                	ld	s7,24(sp)
 152:	6125                	addi	sp,sp,96
 154:	8082                	ret

0000000000000156 <stat>:

int
stat(const char *n, struct stat *st)
{
 156:	1101                	addi	sp,sp,-32
 158:	ec06                	sd	ra,24(sp)
 15a:	e822                	sd	s0,16(sp)
 15c:	e04a                	sd	s2,0(sp)
 15e:	1000                	addi	s0,sp,32
 160:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 162:	4581                	li	a1,0
 164:	21e000ef          	jal	382 <open>
  if(fd < 0)
 168:	02054263          	bltz	a0,18c <stat+0x36>
 16c:	e426                	sd	s1,8(sp)
 16e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 170:	85ca                	mv	a1,s2
 172:	228000ef          	jal	39a <fstat>
 176:	892a                	mv	s2,a0
  close(fd);
 178:	8526                	mv	a0,s1
 17a:	1f0000ef          	jal	36a <close>
  return r;
 17e:	64a2                	ld	s1,8(sp)
}
 180:	854a                	mv	a0,s2
 182:	60e2                	ld	ra,24(sp)
 184:	6442                	ld	s0,16(sp)
 186:	6902                	ld	s2,0(sp)
 188:	6105                	addi	sp,sp,32
 18a:	8082                	ret
    return -1;
 18c:	597d                	li	s2,-1
 18e:	bfcd                	j	180 <stat+0x2a>

0000000000000190 <atoi>:

int
atoi(const char *s)
{
 190:	1141                	addi	sp,sp,-16
 192:	e422                	sd	s0,8(sp)
 194:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 196:	00054683          	lbu	a3,0(a0)
 19a:	fd06879b          	addiw	a5,a3,-48
 19e:	0ff7f793          	zext.b	a5,a5
 1a2:	4625                	li	a2,9
 1a4:	02f66863          	bltu	a2,a5,1d4 <atoi+0x44>
 1a8:	872a                	mv	a4,a0
  n = 0;
 1aa:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 1ac:	0705                	addi	a4,a4,1
 1ae:	0025179b          	slliw	a5,a0,0x2
 1b2:	9fa9                	addw	a5,a5,a0
 1b4:	0017979b          	slliw	a5,a5,0x1
 1b8:	9fb5                	addw	a5,a5,a3
 1ba:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1be:	00074683          	lbu	a3,0(a4)
 1c2:	fd06879b          	addiw	a5,a3,-48
 1c6:	0ff7f793          	zext.b	a5,a5
 1ca:	fef671e3          	bgeu	a2,a5,1ac <atoi+0x1c>
  return n;
}
 1ce:	6422                	ld	s0,8(sp)
 1d0:	0141                	addi	sp,sp,16
 1d2:	8082                	ret
  n = 0;
 1d4:	4501                	li	a0,0
 1d6:	bfe5                	j	1ce <atoi+0x3e>

00000000000001d8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1d8:	1141                	addi	sp,sp,-16
 1da:	e422                	sd	s0,8(sp)
 1dc:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 1de:	02b57463          	bgeu	a0,a1,206 <memmove+0x2e>
    while(n-- > 0)
 1e2:	00c05f63          	blez	a2,200 <memmove+0x28>
 1e6:	1602                	slli	a2,a2,0x20
 1e8:	9201                	srli	a2,a2,0x20
 1ea:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 1ee:	872a                	mv	a4,a0
      *dst++ = *src++;
 1f0:	0585                	addi	a1,a1,1
 1f2:	0705                	addi	a4,a4,1
 1f4:	fff5c683          	lbu	a3,-1(a1)
 1f8:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 1fc:	fef71ae3          	bne	a4,a5,1f0 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 200:	6422                	ld	s0,8(sp)
 202:	0141                	addi	sp,sp,16
 204:	8082                	ret
    dst += n;
 206:	00c50733          	add	a4,a0,a2
    src += n;
 20a:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 20c:	fec05ae3          	blez	a2,200 <memmove+0x28>
 210:	fff6079b          	addiw	a5,a2,-1
 214:	1782                	slli	a5,a5,0x20
 216:	9381                	srli	a5,a5,0x20
 218:	fff7c793          	not	a5,a5
 21c:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 21e:	15fd                	addi	a1,a1,-1
 220:	177d                	addi	a4,a4,-1
 222:	0005c683          	lbu	a3,0(a1)
 226:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 22a:	fee79ae3          	bne	a5,a4,21e <memmove+0x46>
 22e:	bfc9                	j	200 <memmove+0x28>

0000000000000230 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 230:	1141                	addi	sp,sp,-16
 232:	e422                	sd	s0,8(sp)
 234:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 236:	ca05                	beqz	a2,266 <memcmp+0x36>
 238:	fff6069b          	addiw	a3,a2,-1
 23c:	1682                	slli	a3,a3,0x20
 23e:	9281                	srli	a3,a3,0x20
 240:	0685                	addi	a3,a3,1
 242:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 244:	00054783          	lbu	a5,0(a0)
 248:	0005c703          	lbu	a4,0(a1)
 24c:	00e79863          	bne	a5,a4,25c <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 250:	0505                	addi	a0,a0,1
    p2++;
 252:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 254:	fed518e3          	bne	a0,a3,244 <memcmp+0x14>
  }
  return 0;
 258:	4501                	li	a0,0
 25a:	a019                	j	260 <memcmp+0x30>
      return *p1 - *p2;
 25c:	40e7853b          	subw	a0,a5,a4
}
 260:	6422                	ld	s0,8(sp)
 262:	0141                	addi	sp,sp,16
 264:	8082                	ret
  return 0;
 266:	4501                	li	a0,0
 268:	bfe5                	j	260 <memcmp+0x30>

000000000000026a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 26a:	1141                	addi	sp,sp,-16
 26c:	e406                	sd	ra,8(sp)
 26e:	e022                	sd	s0,0(sp)
 270:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 272:	f67ff0ef          	jal	1d8 <memmove>
}
 276:	60a2                	ld	ra,8(sp)
 278:	6402                	ld	s0,0(sp)
 27a:	0141                	addi	sp,sp,16
 27c:	8082                	ret

000000000000027e <sbrk>:

char *
sbrk(int n) {
 27e:	1141                	addi	sp,sp,-16
 280:	e406                	sd	ra,8(sp)
 282:	e022                	sd	s0,0(sp)
 284:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 286:	4585                	li	a1,1
 288:	142000ef          	jal	3ca <sys_sbrk>
}
 28c:	60a2                	ld	ra,8(sp)
 28e:	6402                	ld	s0,0(sp)
 290:	0141                	addi	sp,sp,16
 292:	8082                	ret

0000000000000294 <sbrklazy>:

char *
sbrklazy(int n) {
 294:	1141                	addi	sp,sp,-16
 296:	e406                	sd	ra,8(sp)
 298:	e022                	sd	s0,0(sp)
 29a:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 29c:	4589                	li	a1,2
 29e:	12c000ef          	jal	3ca <sys_sbrk>
}
 2a2:	60a2                	ld	ra,8(sp)
 2a4:	6402                	ld	s0,0(sp)
 2a6:	0141                	addi	sp,sp,16
 2a8:	8082                	ret

00000000000002aa <thread_create>:
// thread_create allocates a page-sized stack, calls clone(fn, arg, stacktop).
// Returns the new thread's pid, or -1 on error.
// The stack is passed back via *stack so the caller can free it after join.
int
thread_create(void(*fn)(void*), void *arg, void **stack)
{
 2aa:	7179                	addi	sp,sp,-48
 2ac:	f406                	sd	ra,40(sp)
 2ae:	f022                	sd	s0,32(sp)
 2b0:	e84a                	sd	s2,16(sp)
 2b2:	e44e                	sd	s3,8(sp)
 2b4:	e052                	sd	s4,0(sp)
 2b6:	1800                	addi	s0,sp,48
 2b8:	89aa                	mv	s3,a0
 2ba:	8a2e                	mv	s4,a1
 2bc:	8932                	mv	s2,a2
  char *s = malloc(PGSIZE);
 2be:	6505                	lui	a0,0x1
 2c0:	596000ef          	jal	856 <malloc>
  if(s == 0)
 2c4:	cd0d                	beqz	a0,2fe <thread_create+0x54>
 2c6:	ec26                	sd	s1,24(sp)
 2c8:	84aa                	mv	s1,a0
    return -1;
  *stack = s;
 2ca:	00a93023          	sd	a0,0(s2)
  // Stack grows downward: pass the top of the allocated region.
  int pid = clone(fn, arg, s + PGSIZE);
 2ce:	6605                	lui	a2,0x1
 2d0:	962a                	add	a2,a2,a0
 2d2:	85d2                	mv	a1,s4
 2d4:	854e                	mv	a0,s3
 2d6:	134000ef          	jal	40a <clone>
  if(pid < 0){
 2da:	00054a63          	bltz	a0,2ee <thread_create+0x44>
 2de:	64e2                	ld	s1,24(sp)
    free(s);
    *stack = 0;
    return -1;
  }
  return pid;
}
 2e0:	70a2                	ld	ra,40(sp)
 2e2:	7402                	ld	s0,32(sp)
 2e4:	6942                	ld	s2,16(sp)
 2e6:	69a2                	ld	s3,8(sp)
 2e8:	6a02                	ld	s4,0(sp)
 2ea:	6145                	addi	sp,sp,48
 2ec:	8082                	ret
    free(s);
 2ee:	8526                	mv	a0,s1
 2f0:	4e4000ef          	jal	7d4 <free>
    *stack = 0;
 2f4:	00093023          	sd	zero,0(s2)
    return -1;
 2f8:	557d                	li	a0,-1
 2fa:	64e2                	ld	s1,24(sp)
 2fc:	b7d5                	j	2e0 <thread_create+0x36>
    return -1;
 2fe:	557d                	li	a0,-1
 300:	b7c5                	j	2e0 <thread_create+0x36>

0000000000000302 <thread_join>:
// Wait for any child thread to exit.
// If stack is non-null, frees the memory pointed to by *stack and clears it.
// Returns the joined thread's pid, or -1 on error.
int
thread_join(void **stack)
{
 302:	1101                	addi	sp,sp,-32
 304:	ec06                	sd	ra,24(sp)
 306:	e822                	sd	s0,16(sp)
 308:	e426                	sd	s1,8(sp)
 30a:	e04a                	sd	s2,0(sp)
 30c:	1000                	addi	s0,sp,32
 30e:	84aa                	mv	s1,a0
  int pid = join();
 310:	102000ef          	jal	412 <join>
  if(pid < 0)
 314:	02054163          	bltz	a0,336 <thread_join+0x34>
 318:	892a                	mv	s2,a0
    return -1;
  if(stack && *stack){
 31a:	c499                	beqz	s1,328 <thread_join+0x26>
 31c:	6088                	ld	a0,0(s1)
 31e:	c509                	beqz	a0,328 <thread_join+0x26>
    free(*stack);
 320:	4b4000ef          	jal	7d4 <free>
    *stack = 0;
 324:	0004b023          	sd	zero,0(s1)
  }
  return pid;
}
 328:	854a                	mv	a0,s2
 32a:	60e2                	ld	ra,24(sp)
 32c:	6442                	ld	s0,16(sp)
 32e:	64a2                	ld	s1,8(sp)
 330:	6902                	ld	s2,0(sp)
 332:	6105                	addi	sp,sp,32
 334:	8082                	ret
    return -1;
 336:	597d                	li	s2,-1
 338:	bfc5                	j	328 <thread_join+0x26>

000000000000033a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 33a:	4885                	li	a7,1
 ecall
 33c:	00000073          	ecall
 ret
 340:	8082                	ret

0000000000000342 <exit>:
.global exit
exit:
 li a7, SYS_exit
 342:	4889                	li	a7,2
 ecall
 344:	00000073          	ecall
 ret
 348:	8082                	ret

000000000000034a <wait>:
.global wait
wait:
 li a7, SYS_wait
 34a:	488d                	li	a7,3
 ecall
 34c:	00000073          	ecall
 ret
 350:	8082                	ret

0000000000000352 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 352:	4891                	li	a7,4
 ecall
 354:	00000073          	ecall
 ret
 358:	8082                	ret

000000000000035a <read>:
.global read
read:
 li a7, SYS_read
 35a:	4895                	li	a7,5
 ecall
 35c:	00000073          	ecall
 ret
 360:	8082                	ret

0000000000000362 <write>:
.global write
write:
 li a7, SYS_write
 362:	48c1                	li	a7,16
 ecall
 364:	00000073          	ecall
 ret
 368:	8082                	ret

000000000000036a <close>:
.global close
close:
 li a7, SYS_close
 36a:	48d5                	li	a7,21
 ecall
 36c:	00000073          	ecall
 ret
 370:	8082                	ret

0000000000000372 <kill>:
.global kill
kill:
 li a7, SYS_kill
 372:	4899                	li	a7,6
 ecall
 374:	00000073          	ecall
 ret
 378:	8082                	ret

000000000000037a <exec>:
.global exec
exec:
 li a7, SYS_exec
 37a:	489d                	li	a7,7
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <open>:
.global open
open:
 li a7, SYS_open
 382:	48bd                	li	a7,15
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 38a:	48c5                	li	a7,17
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 392:	48c9                	li	a7,18
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 39a:	48a1                	li	a7,8
 ecall
 39c:	00000073          	ecall
 ret
 3a0:	8082                	ret

00000000000003a2 <link>:
.global link
link:
 li a7, SYS_link
 3a2:	48cd                	li	a7,19
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3aa:	48d1                	li	a7,20
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3b2:	48a5                	li	a7,9
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <dup>:
.global dup
dup:
 li a7, SYS_dup
 3ba:	48a9                	li	a7,10
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3c2:	48ad                	li	a7,11
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 3ca:	48b1                	li	a7,12
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <pause>:
.global pause
pause:
 li a7, SYS_pause
 3d2:	48b5                	li	a7,13
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3da:	48b9                	li	a7,14
 ecall
 3dc:	00000073          	ecall
 ret
 3e0:	8082                	ret

00000000000003e2 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 3e2:	48d9                	li	a7,22
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <lock_create>:
.global lock_create
lock_create:
 li a7, SYS_lock_create
 3ea:	48dd                	li	a7,23
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <lock_acquire>:
.global lock_acquire
lock_acquire:
 li a7, SYS_lock_acquire
 3f2:	48e1                	li	a7,24
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <lock_release>:
.global lock_release
lock_release:
 li a7, SYS_lock_release
 3fa:	48e5                	li	a7,25
 ecall
 3fc:	00000073          	ecall
 ret
 400:	8082                	ret

0000000000000402 <lock_destroy>:
.global lock_destroy
lock_destroy:
 li a7, SYS_lock_destroy
 402:	48e9                	li	a7,26
 ecall
 404:	00000073          	ecall
 ret
 408:	8082                	ret

000000000000040a <clone>:
.global clone
clone:
 li a7, SYS_clone
 40a:	48ed                	li	a7,27
 ecall
 40c:	00000073          	ecall
 ret
 410:	8082                	ret

0000000000000412 <join>:
.global join
join:
 li a7, SYS_join
 412:	48f1                	li	a7,28
 ecall
 414:	00000073          	ecall
 ret
 418:	8082                	ret

000000000000041a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 41a:	1101                	addi	sp,sp,-32
 41c:	ec06                	sd	ra,24(sp)
 41e:	e822                	sd	s0,16(sp)
 420:	1000                	addi	s0,sp,32
 422:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 426:	4605                	li	a2,1
 428:	fef40593          	addi	a1,s0,-17
 42c:	f37ff0ef          	jal	362 <write>
}
 430:	60e2                	ld	ra,24(sp)
 432:	6442                	ld	s0,16(sp)
 434:	6105                	addi	sp,sp,32
 436:	8082                	ret

0000000000000438 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 438:	715d                	addi	sp,sp,-80
 43a:	e486                	sd	ra,72(sp)
 43c:	e0a2                	sd	s0,64(sp)
 43e:	f84a                	sd	s2,48(sp)
 440:	0880                	addi	s0,sp,80
 442:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 444:	c299                	beqz	a3,44a <printint+0x12>
 446:	0805c363          	bltz	a1,4cc <printint+0x94>
  neg = 0;
 44a:	4881                	li	a7,0
 44c:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 450:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 452:	00000517          	auipc	a0,0x0
 456:	50650513          	addi	a0,a0,1286 # 958 <digits>
 45a:	883e                	mv	a6,a5
 45c:	2785                	addiw	a5,a5,1
 45e:	02c5f733          	remu	a4,a1,a2
 462:	972a                	add	a4,a4,a0
 464:	00074703          	lbu	a4,0(a4)
 468:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 46c:	872e                	mv	a4,a1
 46e:	02c5d5b3          	divu	a1,a1,a2
 472:	0685                	addi	a3,a3,1
 474:	fec773e3          	bgeu	a4,a2,45a <printint+0x22>
  if(neg)
 478:	00088b63          	beqz	a7,48e <printint+0x56>
    buf[i++] = '-';
 47c:	fd078793          	addi	a5,a5,-48
 480:	97a2                	add	a5,a5,s0
 482:	02d00713          	li	a4,45
 486:	fee78423          	sb	a4,-24(a5)
 48a:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 48e:	02f05a63          	blez	a5,4c2 <printint+0x8a>
 492:	fc26                	sd	s1,56(sp)
 494:	f44e                	sd	s3,40(sp)
 496:	fb840713          	addi	a4,s0,-72
 49a:	00f704b3          	add	s1,a4,a5
 49e:	fff70993          	addi	s3,a4,-1
 4a2:	99be                	add	s3,s3,a5
 4a4:	37fd                	addiw	a5,a5,-1
 4a6:	1782                	slli	a5,a5,0x20
 4a8:	9381                	srli	a5,a5,0x20
 4aa:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 4ae:	fff4c583          	lbu	a1,-1(s1)
 4b2:	854a                	mv	a0,s2
 4b4:	f67ff0ef          	jal	41a <putc>
  while(--i >= 0)
 4b8:	14fd                	addi	s1,s1,-1
 4ba:	ff349ae3          	bne	s1,s3,4ae <printint+0x76>
 4be:	74e2                	ld	s1,56(sp)
 4c0:	79a2                	ld	s3,40(sp)
}
 4c2:	60a6                	ld	ra,72(sp)
 4c4:	6406                	ld	s0,64(sp)
 4c6:	7942                	ld	s2,48(sp)
 4c8:	6161                	addi	sp,sp,80
 4ca:	8082                	ret
    x = -xx;
 4cc:	40b005b3          	neg	a1,a1
    neg = 1;
 4d0:	4885                	li	a7,1
    x = -xx;
 4d2:	bfad                	j	44c <printint+0x14>

00000000000004d4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4d4:	711d                	addi	sp,sp,-96
 4d6:	ec86                	sd	ra,88(sp)
 4d8:	e8a2                	sd	s0,80(sp)
 4da:	e0ca                	sd	s2,64(sp)
 4dc:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4de:	0005c903          	lbu	s2,0(a1)
 4e2:	28090663          	beqz	s2,76e <vprintf+0x29a>
 4e6:	e4a6                	sd	s1,72(sp)
 4e8:	fc4e                	sd	s3,56(sp)
 4ea:	f852                	sd	s4,48(sp)
 4ec:	f456                	sd	s5,40(sp)
 4ee:	f05a                	sd	s6,32(sp)
 4f0:	ec5e                	sd	s7,24(sp)
 4f2:	e862                	sd	s8,16(sp)
 4f4:	e466                	sd	s9,8(sp)
 4f6:	8b2a                	mv	s6,a0
 4f8:	8a2e                	mv	s4,a1
 4fa:	8bb2                	mv	s7,a2
  state = 0;
 4fc:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 4fe:	4481                	li	s1,0
 500:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 502:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 506:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 50a:	06c00c93          	li	s9,108
 50e:	a005                	j	52e <vprintf+0x5a>
        putc(fd, c0);
 510:	85ca                	mv	a1,s2
 512:	855a                	mv	a0,s6
 514:	f07ff0ef          	jal	41a <putc>
 518:	a019                	j	51e <vprintf+0x4a>
    } else if(state == '%'){
 51a:	03598263          	beq	s3,s5,53e <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 51e:	2485                	addiw	s1,s1,1
 520:	8726                	mv	a4,s1
 522:	009a07b3          	add	a5,s4,s1
 526:	0007c903          	lbu	s2,0(a5)
 52a:	22090a63          	beqz	s2,75e <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 52e:	0009079b          	sext.w	a5,s2
    if(state == 0){
 532:	fe0994e3          	bnez	s3,51a <vprintf+0x46>
      if(c0 == '%'){
 536:	fd579de3          	bne	a5,s5,510 <vprintf+0x3c>
        state = '%';
 53a:	89be                	mv	s3,a5
 53c:	b7cd                	j	51e <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 53e:	00ea06b3          	add	a3,s4,a4
 542:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 546:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 548:	c681                	beqz	a3,550 <vprintf+0x7c>
 54a:	9752                	add	a4,a4,s4
 54c:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 550:	05878363          	beq	a5,s8,596 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 554:	05978d63          	beq	a5,s9,5ae <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 558:	07500713          	li	a4,117
 55c:	0ee78763          	beq	a5,a4,64a <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 560:	07800713          	li	a4,120
 564:	12e78963          	beq	a5,a4,696 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 568:	07000713          	li	a4,112
 56c:	14e78e63          	beq	a5,a4,6c8 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 570:	06300713          	li	a4,99
 574:	18e78e63          	beq	a5,a4,710 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 578:	07300713          	li	a4,115
 57c:	1ae78463          	beq	a5,a4,724 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 580:	02500713          	li	a4,37
 584:	04e79563          	bne	a5,a4,5ce <vprintf+0xfa>
        putc(fd, '%');
 588:	02500593          	li	a1,37
 58c:	855a                	mv	a0,s6
 58e:	e8dff0ef          	jal	41a <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 592:	4981                	li	s3,0
 594:	b769                	j	51e <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 596:	008b8913          	addi	s2,s7,8
 59a:	4685                	li	a3,1
 59c:	4629                	li	a2,10
 59e:	000ba583          	lw	a1,0(s7)
 5a2:	855a                	mv	a0,s6
 5a4:	e95ff0ef          	jal	438 <printint>
 5a8:	8bca                	mv	s7,s2
      state = 0;
 5aa:	4981                	li	s3,0
 5ac:	bf8d                	j	51e <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 5ae:	06400793          	li	a5,100
 5b2:	02f68963          	beq	a3,a5,5e4 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 5b6:	06c00793          	li	a5,108
 5ba:	04f68263          	beq	a3,a5,5fe <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 5be:	07500793          	li	a5,117
 5c2:	0af68063          	beq	a3,a5,662 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 5c6:	07800793          	li	a5,120
 5ca:	0ef68263          	beq	a3,a5,6ae <vprintf+0x1da>
        putc(fd, '%');
 5ce:	02500593          	li	a1,37
 5d2:	855a                	mv	a0,s6
 5d4:	e47ff0ef          	jal	41a <putc>
        putc(fd, c0);
 5d8:	85ca                	mv	a1,s2
 5da:	855a                	mv	a0,s6
 5dc:	e3fff0ef          	jal	41a <putc>
      state = 0;
 5e0:	4981                	li	s3,0
 5e2:	bf35                	j	51e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5e4:	008b8913          	addi	s2,s7,8
 5e8:	4685                	li	a3,1
 5ea:	4629                	li	a2,10
 5ec:	000bb583          	ld	a1,0(s7)
 5f0:	855a                	mv	a0,s6
 5f2:	e47ff0ef          	jal	438 <printint>
        i += 1;
 5f6:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 5f8:	8bca                	mv	s7,s2
      state = 0;
 5fa:	4981                	li	s3,0
        i += 1;
 5fc:	b70d                	j	51e <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 5fe:	06400793          	li	a5,100
 602:	02f60763          	beq	a2,a5,630 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 606:	07500793          	li	a5,117
 60a:	06f60963          	beq	a2,a5,67c <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 60e:	07800793          	li	a5,120
 612:	faf61ee3          	bne	a2,a5,5ce <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 616:	008b8913          	addi	s2,s7,8
 61a:	4681                	li	a3,0
 61c:	4641                	li	a2,16
 61e:	000bb583          	ld	a1,0(s7)
 622:	855a                	mv	a0,s6
 624:	e15ff0ef          	jal	438 <printint>
        i += 2;
 628:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 62a:	8bca                	mv	s7,s2
      state = 0;
 62c:	4981                	li	s3,0
        i += 2;
 62e:	bdc5                	j	51e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 630:	008b8913          	addi	s2,s7,8
 634:	4685                	li	a3,1
 636:	4629                	li	a2,10
 638:	000bb583          	ld	a1,0(s7)
 63c:	855a                	mv	a0,s6
 63e:	dfbff0ef          	jal	438 <printint>
        i += 2;
 642:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 644:	8bca                	mv	s7,s2
      state = 0;
 646:	4981                	li	s3,0
        i += 2;
 648:	bdd9                	j	51e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 64a:	008b8913          	addi	s2,s7,8
 64e:	4681                	li	a3,0
 650:	4629                	li	a2,10
 652:	000be583          	lwu	a1,0(s7)
 656:	855a                	mv	a0,s6
 658:	de1ff0ef          	jal	438 <printint>
 65c:	8bca                	mv	s7,s2
      state = 0;
 65e:	4981                	li	s3,0
 660:	bd7d                	j	51e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 662:	008b8913          	addi	s2,s7,8
 666:	4681                	li	a3,0
 668:	4629                	li	a2,10
 66a:	000bb583          	ld	a1,0(s7)
 66e:	855a                	mv	a0,s6
 670:	dc9ff0ef          	jal	438 <printint>
        i += 1;
 674:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 676:	8bca                	mv	s7,s2
      state = 0;
 678:	4981                	li	s3,0
        i += 1;
 67a:	b555                	j	51e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 67c:	008b8913          	addi	s2,s7,8
 680:	4681                	li	a3,0
 682:	4629                	li	a2,10
 684:	000bb583          	ld	a1,0(s7)
 688:	855a                	mv	a0,s6
 68a:	dafff0ef          	jal	438 <printint>
        i += 2;
 68e:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 690:	8bca                	mv	s7,s2
      state = 0;
 692:	4981                	li	s3,0
        i += 2;
 694:	b569                	j	51e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 696:	008b8913          	addi	s2,s7,8
 69a:	4681                	li	a3,0
 69c:	4641                	li	a2,16
 69e:	000be583          	lwu	a1,0(s7)
 6a2:	855a                	mv	a0,s6
 6a4:	d95ff0ef          	jal	438 <printint>
 6a8:	8bca                	mv	s7,s2
      state = 0;
 6aa:	4981                	li	s3,0
 6ac:	bd8d                	j	51e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6ae:	008b8913          	addi	s2,s7,8
 6b2:	4681                	li	a3,0
 6b4:	4641                	li	a2,16
 6b6:	000bb583          	ld	a1,0(s7)
 6ba:	855a                	mv	a0,s6
 6bc:	d7dff0ef          	jal	438 <printint>
        i += 1;
 6c0:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 6c2:	8bca                	mv	s7,s2
      state = 0;
 6c4:	4981                	li	s3,0
        i += 1;
 6c6:	bda1                	j	51e <vprintf+0x4a>
 6c8:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 6ca:	008b8d13          	addi	s10,s7,8
 6ce:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 6d2:	03000593          	li	a1,48
 6d6:	855a                	mv	a0,s6
 6d8:	d43ff0ef          	jal	41a <putc>
  putc(fd, 'x');
 6dc:	07800593          	li	a1,120
 6e0:	855a                	mv	a0,s6
 6e2:	d39ff0ef          	jal	41a <putc>
 6e6:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6e8:	00000b97          	auipc	s7,0x0
 6ec:	270b8b93          	addi	s7,s7,624 # 958 <digits>
 6f0:	03c9d793          	srli	a5,s3,0x3c
 6f4:	97de                	add	a5,a5,s7
 6f6:	0007c583          	lbu	a1,0(a5)
 6fa:	855a                	mv	a0,s6
 6fc:	d1fff0ef          	jal	41a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 700:	0992                	slli	s3,s3,0x4
 702:	397d                	addiw	s2,s2,-1
 704:	fe0916e3          	bnez	s2,6f0 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 708:	8bea                	mv	s7,s10
      state = 0;
 70a:	4981                	li	s3,0
 70c:	6d02                	ld	s10,0(sp)
 70e:	bd01                	j	51e <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 710:	008b8913          	addi	s2,s7,8
 714:	000bc583          	lbu	a1,0(s7)
 718:	855a                	mv	a0,s6
 71a:	d01ff0ef          	jal	41a <putc>
 71e:	8bca                	mv	s7,s2
      state = 0;
 720:	4981                	li	s3,0
 722:	bbf5                	j	51e <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 724:	008b8993          	addi	s3,s7,8
 728:	000bb903          	ld	s2,0(s7)
 72c:	00090f63          	beqz	s2,74a <vprintf+0x276>
        for(; *s; s++)
 730:	00094583          	lbu	a1,0(s2)
 734:	c195                	beqz	a1,758 <vprintf+0x284>
          putc(fd, *s);
 736:	855a                	mv	a0,s6
 738:	ce3ff0ef          	jal	41a <putc>
        for(; *s; s++)
 73c:	0905                	addi	s2,s2,1
 73e:	00094583          	lbu	a1,0(s2)
 742:	f9f5                	bnez	a1,736 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 744:	8bce                	mv	s7,s3
      state = 0;
 746:	4981                	li	s3,0
 748:	bbd9                	j	51e <vprintf+0x4a>
          s = "(null)";
 74a:	00000917          	auipc	s2,0x0
 74e:	20690913          	addi	s2,s2,518 # 950 <malloc+0xfa>
        for(; *s; s++)
 752:	02800593          	li	a1,40
 756:	b7c5                	j	736 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 758:	8bce                	mv	s7,s3
      state = 0;
 75a:	4981                	li	s3,0
 75c:	b3c9                	j	51e <vprintf+0x4a>
 75e:	64a6                	ld	s1,72(sp)
 760:	79e2                	ld	s3,56(sp)
 762:	7a42                	ld	s4,48(sp)
 764:	7aa2                	ld	s5,40(sp)
 766:	7b02                	ld	s6,32(sp)
 768:	6be2                	ld	s7,24(sp)
 76a:	6c42                	ld	s8,16(sp)
 76c:	6ca2                	ld	s9,8(sp)
    }
  }
}
 76e:	60e6                	ld	ra,88(sp)
 770:	6446                	ld	s0,80(sp)
 772:	6906                	ld	s2,64(sp)
 774:	6125                	addi	sp,sp,96
 776:	8082                	ret

0000000000000778 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 778:	715d                	addi	sp,sp,-80
 77a:	ec06                	sd	ra,24(sp)
 77c:	e822                	sd	s0,16(sp)
 77e:	1000                	addi	s0,sp,32
 780:	e010                	sd	a2,0(s0)
 782:	e414                	sd	a3,8(s0)
 784:	e818                	sd	a4,16(s0)
 786:	ec1c                	sd	a5,24(s0)
 788:	03043023          	sd	a6,32(s0)
 78c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 790:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 794:	8622                	mv	a2,s0
 796:	d3fff0ef          	jal	4d4 <vprintf>
}
 79a:	60e2                	ld	ra,24(sp)
 79c:	6442                	ld	s0,16(sp)
 79e:	6161                	addi	sp,sp,80
 7a0:	8082                	ret

00000000000007a2 <printf>:

void
printf(const char *fmt, ...)
{
 7a2:	711d                	addi	sp,sp,-96
 7a4:	ec06                	sd	ra,24(sp)
 7a6:	e822                	sd	s0,16(sp)
 7a8:	1000                	addi	s0,sp,32
 7aa:	e40c                	sd	a1,8(s0)
 7ac:	e810                	sd	a2,16(s0)
 7ae:	ec14                	sd	a3,24(s0)
 7b0:	f018                	sd	a4,32(s0)
 7b2:	f41c                	sd	a5,40(s0)
 7b4:	03043823          	sd	a6,48(s0)
 7b8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7bc:	00840613          	addi	a2,s0,8
 7c0:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7c4:	85aa                	mv	a1,a0
 7c6:	4505                	li	a0,1
 7c8:	d0dff0ef          	jal	4d4 <vprintf>
}
 7cc:	60e2                	ld	ra,24(sp)
 7ce:	6442                	ld	s0,16(sp)
 7d0:	6125                	addi	sp,sp,96
 7d2:	8082                	ret

00000000000007d4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7d4:	1141                	addi	sp,sp,-16
 7d6:	e422                	sd	s0,8(sp)
 7d8:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7da:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7de:	00001797          	auipc	a5,0x1
 7e2:	8227b783          	ld	a5,-2014(a5) # 1000 <freep>
 7e6:	a02d                	j	810 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7e8:	4618                	lw	a4,8(a2)
 7ea:	9f2d                	addw	a4,a4,a1
 7ec:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7f0:	6398                	ld	a4,0(a5)
 7f2:	6310                	ld	a2,0(a4)
 7f4:	a83d                	j	832 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7f6:	ff852703          	lw	a4,-8(a0)
 7fa:	9f31                	addw	a4,a4,a2
 7fc:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 7fe:	ff053683          	ld	a3,-16(a0)
 802:	a091                	j	846 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 804:	6398                	ld	a4,0(a5)
 806:	00e7e463          	bltu	a5,a4,80e <free+0x3a>
 80a:	00e6ea63          	bltu	a3,a4,81e <free+0x4a>
{
 80e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 810:	fed7fae3          	bgeu	a5,a3,804 <free+0x30>
 814:	6398                	ld	a4,0(a5)
 816:	00e6e463          	bltu	a3,a4,81e <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 81a:	fee7eae3          	bltu	a5,a4,80e <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 81e:	ff852583          	lw	a1,-8(a0)
 822:	6390                	ld	a2,0(a5)
 824:	02059813          	slli	a6,a1,0x20
 828:	01c85713          	srli	a4,a6,0x1c
 82c:	9736                	add	a4,a4,a3
 82e:	fae60de3          	beq	a2,a4,7e8 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 832:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 836:	4790                	lw	a2,8(a5)
 838:	02061593          	slli	a1,a2,0x20
 83c:	01c5d713          	srli	a4,a1,0x1c
 840:	973e                	add	a4,a4,a5
 842:	fae68ae3          	beq	a3,a4,7f6 <free+0x22>
    p->s.ptr = bp->s.ptr;
 846:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 848:	00000717          	auipc	a4,0x0
 84c:	7af73c23          	sd	a5,1976(a4) # 1000 <freep>
}
 850:	6422                	ld	s0,8(sp)
 852:	0141                	addi	sp,sp,16
 854:	8082                	ret

0000000000000856 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 856:	7139                	addi	sp,sp,-64
 858:	fc06                	sd	ra,56(sp)
 85a:	f822                	sd	s0,48(sp)
 85c:	f426                	sd	s1,40(sp)
 85e:	ec4e                	sd	s3,24(sp)
 860:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 862:	02051493          	slli	s1,a0,0x20
 866:	9081                	srli	s1,s1,0x20
 868:	04bd                	addi	s1,s1,15
 86a:	8091                	srli	s1,s1,0x4
 86c:	0014899b          	addiw	s3,s1,1
 870:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 872:	00000517          	auipc	a0,0x0
 876:	78e53503          	ld	a0,1934(a0) # 1000 <freep>
 87a:	c915                	beqz	a0,8ae <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 87c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 87e:	4798                	lw	a4,8(a5)
 880:	08977a63          	bgeu	a4,s1,914 <malloc+0xbe>
 884:	f04a                	sd	s2,32(sp)
 886:	e852                	sd	s4,16(sp)
 888:	e456                	sd	s5,8(sp)
 88a:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 88c:	8a4e                	mv	s4,s3
 88e:	0009871b          	sext.w	a4,s3
 892:	6685                	lui	a3,0x1
 894:	00d77363          	bgeu	a4,a3,89a <malloc+0x44>
 898:	6a05                	lui	s4,0x1
 89a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 89e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8a2:	00000917          	auipc	s2,0x0
 8a6:	75e90913          	addi	s2,s2,1886 # 1000 <freep>
  if(p == SBRK_ERROR)
 8aa:	5afd                	li	s5,-1
 8ac:	a081                	j	8ec <malloc+0x96>
 8ae:	f04a                	sd	s2,32(sp)
 8b0:	e852                	sd	s4,16(sp)
 8b2:	e456                	sd	s5,8(sp)
 8b4:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 8b6:	00000797          	auipc	a5,0x0
 8ba:	75a78793          	addi	a5,a5,1882 # 1010 <base>
 8be:	00000717          	auipc	a4,0x0
 8c2:	74f73123          	sd	a5,1858(a4) # 1000 <freep>
 8c6:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8c8:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8cc:	b7c1                	j	88c <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 8ce:	6398                	ld	a4,0(a5)
 8d0:	e118                	sd	a4,0(a0)
 8d2:	a8a9                	j	92c <malloc+0xd6>
  hp->s.size = nu;
 8d4:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8d8:	0541                	addi	a0,a0,16
 8da:	efbff0ef          	jal	7d4 <free>
  return freep;
 8de:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 8e2:	c12d                	beqz	a0,944 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8e4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8e6:	4798                	lw	a4,8(a5)
 8e8:	02977263          	bgeu	a4,s1,90c <malloc+0xb6>
    if(p == freep)
 8ec:	00093703          	ld	a4,0(s2)
 8f0:	853e                	mv	a0,a5
 8f2:	fef719e3          	bne	a4,a5,8e4 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 8f6:	8552                	mv	a0,s4
 8f8:	987ff0ef          	jal	27e <sbrk>
  if(p == SBRK_ERROR)
 8fc:	fd551ce3          	bne	a0,s5,8d4 <malloc+0x7e>
        return 0;
 900:	4501                	li	a0,0
 902:	7902                	ld	s2,32(sp)
 904:	6a42                	ld	s4,16(sp)
 906:	6aa2                	ld	s5,8(sp)
 908:	6b02                	ld	s6,0(sp)
 90a:	a03d                	j	938 <malloc+0xe2>
 90c:	7902                	ld	s2,32(sp)
 90e:	6a42                	ld	s4,16(sp)
 910:	6aa2                	ld	s5,8(sp)
 912:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 914:	fae48de3          	beq	s1,a4,8ce <malloc+0x78>
        p->s.size -= nunits;
 918:	4137073b          	subw	a4,a4,s3
 91c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 91e:	02071693          	slli	a3,a4,0x20
 922:	01c6d713          	srli	a4,a3,0x1c
 926:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 928:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 92c:	00000717          	auipc	a4,0x0
 930:	6ca73a23          	sd	a0,1748(a4) # 1000 <freep>
      return (void*)(p + 1);
 934:	01078513          	addi	a0,a5,16
  }
}
 938:	70e2                	ld	ra,56(sp)
 93a:	7442                	ld	s0,48(sp)
 93c:	74a2                	ld	s1,40(sp)
 93e:	69e2                	ld	s3,24(sp)
 940:	6121                	addi	sp,sp,64
 942:	8082                	ret
 944:	7902                	ld	s2,32(sp)
 946:	6a42                	ld	s4,16(sp)
 948:	6aa2                	ld	s5,8(sp)
 94a:	6b02                	ld	s6,0(sp)
 94c:	b7f5                	j	938 <malloc+0xe2>
