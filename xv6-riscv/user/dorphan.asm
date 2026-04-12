
user/_dorphan:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char buf[BUFSZ];

int
main(int argc, char **argv)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	addi	s0,sp,32
  char *s = argv[0];
   a:	6184                	ld	s1,0(a1)

  if(mkdir("dd") != 0){
   c:	00001517          	auipc	a0,0x1
  10:	9d450513          	addi	a0,a0,-1580 # 9e0 <malloc+0xfc>
  14:	402000ef          	jal	416 <mkdir>
  18:	c919                	beqz	a0,2e <main+0x2e>
    printf("%s: mkdir dd failed\n", s);
  1a:	85a6                	mv	a1,s1
  1c:	00001517          	auipc	a0,0x1
  20:	9cc50513          	addi	a0,a0,-1588 # 9e8 <malloc+0x104>
  24:	00d000ef          	jal	830 <printf>
    exit(1);
  28:	4505                	li	a0,1
  2a:	384000ef          	jal	3ae <exit>
  }

  if(chdir("dd") != 0){
  2e:	00001517          	auipc	a0,0x1
  32:	9b250513          	addi	a0,a0,-1614 # 9e0 <malloc+0xfc>
  36:	3e8000ef          	jal	41e <chdir>
  3a:	c919                	beqz	a0,50 <main+0x50>
    printf("%s: chdir dd failed\n", s);
  3c:	85a6                	mv	a1,s1
  3e:	00001517          	auipc	a0,0x1
  42:	9c250513          	addi	a0,a0,-1598 # a00 <malloc+0x11c>
  46:	7ea000ef          	jal	830 <printf>
    exit(1);
  4a:	4505                	li	a0,1
  4c:	362000ef          	jal	3ae <exit>
  }

  if (unlink("../dd") < 0) {
  50:	00001517          	auipc	a0,0x1
  54:	9c850513          	addi	a0,a0,-1592 # a18 <malloc+0x134>
  58:	3a6000ef          	jal	3fe <unlink>
  5c:	00054d63          	bltz	a0,76 <main+0x76>
    printf("%s: unlink failed\n", s);
    exit(1);
  }
  printf("wait for kill and reclaim\n");
  60:	00001517          	auipc	a0,0x1
  64:	9d850513          	addi	a0,a0,-1576 # a38 <malloc+0x154>
  68:	7c8000ef          	jal	830 <printf>
  // sit around until killed
  for(;;) pause(1000);
  6c:	3e800513          	li	a0,1000
  70:	3ce000ef          	jal	43e <pause>
  74:	bfe5                	j	6c <main+0x6c>
    printf("%s: unlink failed\n", s);
  76:	85a6                	mv	a1,s1
  78:	00001517          	auipc	a0,0x1
  7c:	9a850513          	addi	a0,a0,-1624 # a20 <malloc+0x13c>
  80:	7b0000ef          	jal	830 <printf>
    exit(1);
  84:	4505                	li	a0,1
  86:	328000ef          	jal	3ae <exit>

000000000000008a <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  8a:	1141                	addi	sp,sp,-16
  8c:	e406                	sd	ra,8(sp)
  8e:	e022                	sd	s0,0(sp)
  90:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  92:	f6fff0ef          	jal	0 <main>
  exit(r);
  96:	318000ef          	jal	3ae <exit>

000000000000009a <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  9a:	1141                	addi	sp,sp,-16
  9c:	e422                	sd	s0,8(sp)
  9e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  a0:	87aa                	mv	a5,a0
  a2:	0585                	addi	a1,a1,1
  a4:	0785                	addi	a5,a5,1
  a6:	fff5c703          	lbu	a4,-1(a1)
  aa:	fee78fa3          	sb	a4,-1(a5)
  ae:	fb75                	bnez	a4,a2 <strcpy+0x8>
    ;
  return os;
}
  b0:	6422                	ld	s0,8(sp)
  b2:	0141                	addi	sp,sp,16
  b4:	8082                	ret

00000000000000b6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  b6:	1141                	addi	sp,sp,-16
  b8:	e422                	sd	s0,8(sp)
  ba:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  bc:	00054783          	lbu	a5,0(a0)
  c0:	cb91                	beqz	a5,d4 <strcmp+0x1e>
  c2:	0005c703          	lbu	a4,0(a1)
  c6:	00f71763          	bne	a4,a5,d4 <strcmp+0x1e>
    p++, q++;
  ca:	0505                	addi	a0,a0,1
  cc:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  ce:	00054783          	lbu	a5,0(a0)
  d2:	fbe5                	bnez	a5,c2 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  d4:	0005c503          	lbu	a0,0(a1)
}
  d8:	40a7853b          	subw	a0,a5,a0
  dc:	6422                	ld	s0,8(sp)
  de:	0141                	addi	sp,sp,16
  e0:	8082                	ret

00000000000000e2 <strlen>:

uint
strlen(const char *s)
{
  e2:	1141                	addi	sp,sp,-16
  e4:	e422                	sd	s0,8(sp)
  e6:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  e8:	00054783          	lbu	a5,0(a0)
  ec:	cf91                	beqz	a5,108 <strlen+0x26>
  ee:	0505                	addi	a0,a0,1
  f0:	87aa                	mv	a5,a0
  f2:	86be                	mv	a3,a5
  f4:	0785                	addi	a5,a5,1
  f6:	fff7c703          	lbu	a4,-1(a5)
  fa:	ff65                	bnez	a4,f2 <strlen+0x10>
  fc:	40a6853b          	subw	a0,a3,a0
 100:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 102:	6422                	ld	s0,8(sp)
 104:	0141                	addi	sp,sp,16
 106:	8082                	ret
  for(n = 0; s[n]; n++)
 108:	4501                	li	a0,0
 10a:	bfe5                	j	102 <strlen+0x20>

000000000000010c <memset>:

void*
memset(void *dst, int c, uint n)
{
 10c:	1141                	addi	sp,sp,-16
 10e:	e422                	sd	s0,8(sp)
 110:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 112:	ca19                	beqz	a2,128 <memset+0x1c>
 114:	87aa                	mv	a5,a0
 116:	1602                	slli	a2,a2,0x20
 118:	9201                	srli	a2,a2,0x20
 11a:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 11e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 122:	0785                	addi	a5,a5,1
 124:	fee79de3          	bne	a5,a4,11e <memset+0x12>
  }
  return dst;
}
 128:	6422                	ld	s0,8(sp)
 12a:	0141                	addi	sp,sp,16
 12c:	8082                	ret

000000000000012e <strchr>:

char*
strchr(const char *s, char c)
{
 12e:	1141                	addi	sp,sp,-16
 130:	e422                	sd	s0,8(sp)
 132:	0800                	addi	s0,sp,16
  for(; *s; s++)
 134:	00054783          	lbu	a5,0(a0)
 138:	cb99                	beqz	a5,14e <strchr+0x20>
    if(*s == c)
 13a:	00f58763          	beq	a1,a5,148 <strchr+0x1a>
  for(; *s; s++)
 13e:	0505                	addi	a0,a0,1
 140:	00054783          	lbu	a5,0(a0)
 144:	fbfd                	bnez	a5,13a <strchr+0xc>
      return (char*)s;
  return 0;
 146:	4501                	li	a0,0
}
 148:	6422                	ld	s0,8(sp)
 14a:	0141                	addi	sp,sp,16
 14c:	8082                	ret
  return 0;
 14e:	4501                	li	a0,0
 150:	bfe5                	j	148 <strchr+0x1a>

0000000000000152 <gets>:

char*
gets(char *buf, int max)
{
 152:	711d                	addi	sp,sp,-96
 154:	ec86                	sd	ra,88(sp)
 156:	e8a2                	sd	s0,80(sp)
 158:	e4a6                	sd	s1,72(sp)
 15a:	e0ca                	sd	s2,64(sp)
 15c:	fc4e                	sd	s3,56(sp)
 15e:	f852                	sd	s4,48(sp)
 160:	f456                	sd	s5,40(sp)
 162:	f05a                	sd	s6,32(sp)
 164:	ec5e                	sd	s7,24(sp)
 166:	1080                	addi	s0,sp,96
 168:	8baa                	mv	s7,a0
 16a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 16c:	892a                	mv	s2,a0
 16e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 170:	4aa9                	li	s5,10
 172:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 174:	89a6                	mv	s3,s1
 176:	2485                	addiw	s1,s1,1
 178:	0344d663          	bge	s1,s4,1a4 <gets+0x52>
    cc = read(0, &c, 1);
 17c:	4605                	li	a2,1
 17e:	faf40593          	addi	a1,s0,-81
 182:	4501                	li	a0,0
 184:	242000ef          	jal	3c6 <read>
    if(cc < 1)
 188:	00a05e63          	blez	a0,1a4 <gets+0x52>
    buf[i++] = c;
 18c:	faf44783          	lbu	a5,-81(s0)
 190:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 194:	01578763          	beq	a5,s5,1a2 <gets+0x50>
 198:	0905                	addi	s2,s2,1
 19a:	fd679de3          	bne	a5,s6,174 <gets+0x22>
    buf[i++] = c;
 19e:	89a6                	mv	s3,s1
 1a0:	a011                	j	1a4 <gets+0x52>
 1a2:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1a4:	99de                	add	s3,s3,s7
 1a6:	00098023          	sb	zero,0(s3)
  return buf;
}
 1aa:	855e                	mv	a0,s7
 1ac:	60e6                	ld	ra,88(sp)
 1ae:	6446                	ld	s0,80(sp)
 1b0:	64a6                	ld	s1,72(sp)
 1b2:	6906                	ld	s2,64(sp)
 1b4:	79e2                	ld	s3,56(sp)
 1b6:	7a42                	ld	s4,48(sp)
 1b8:	7aa2                	ld	s5,40(sp)
 1ba:	7b02                	ld	s6,32(sp)
 1bc:	6be2                	ld	s7,24(sp)
 1be:	6125                	addi	sp,sp,96
 1c0:	8082                	ret

00000000000001c2 <stat>:

int
stat(const char *n, struct stat *st)
{
 1c2:	1101                	addi	sp,sp,-32
 1c4:	ec06                	sd	ra,24(sp)
 1c6:	e822                	sd	s0,16(sp)
 1c8:	e04a                	sd	s2,0(sp)
 1ca:	1000                	addi	s0,sp,32
 1cc:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1ce:	4581                	li	a1,0
 1d0:	21e000ef          	jal	3ee <open>
  if(fd < 0)
 1d4:	02054263          	bltz	a0,1f8 <stat+0x36>
 1d8:	e426                	sd	s1,8(sp)
 1da:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1dc:	85ca                	mv	a1,s2
 1de:	228000ef          	jal	406 <fstat>
 1e2:	892a                	mv	s2,a0
  close(fd);
 1e4:	8526                	mv	a0,s1
 1e6:	1f0000ef          	jal	3d6 <close>
  return r;
 1ea:	64a2                	ld	s1,8(sp)
}
 1ec:	854a                	mv	a0,s2
 1ee:	60e2                	ld	ra,24(sp)
 1f0:	6442                	ld	s0,16(sp)
 1f2:	6902                	ld	s2,0(sp)
 1f4:	6105                	addi	sp,sp,32
 1f6:	8082                	ret
    return -1;
 1f8:	597d                	li	s2,-1
 1fa:	bfcd                	j	1ec <stat+0x2a>

00000000000001fc <atoi>:

int
atoi(const char *s)
{
 1fc:	1141                	addi	sp,sp,-16
 1fe:	e422                	sd	s0,8(sp)
 200:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 202:	00054683          	lbu	a3,0(a0)
 206:	fd06879b          	addiw	a5,a3,-48
 20a:	0ff7f793          	zext.b	a5,a5
 20e:	4625                	li	a2,9
 210:	02f66863          	bltu	a2,a5,240 <atoi+0x44>
 214:	872a                	mv	a4,a0
  n = 0;
 216:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 218:	0705                	addi	a4,a4,1
 21a:	0025179b          	slliw	a5,a0,0x2
 21e:	9fa9                	addw	a5,a5,a0
 220:	0017979b          	slliw	a5,a5,0x1
 224:	9fb5                	addw	a5,a5,a3
 226:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 22a:	00074683          	lbu	a3,0(a4)
 22e:	fd06879b          	addiw	a5,a3,-48
 232:	0ff7f793          	zext.b	a5,a5
 236:	fef671e3          	bgeu	a2,a5,218 <atoi+0x1c>
  return n;
}
 23a:	6422                	ld	s0,8(sp)
 23c:	0141                	addi	sp,sp,16
 23e:	8082                	ret
  n = 0;
 240:	4501                	li	a0,0
 242:	bfe5                	j	23a <atoi+0x3e>

0000000000000244 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 244:	1141                	addi	sp,sp,-16
 246:	e422                	sd	s0,8(sp)
 248:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 24a:	02b57463          	bgeu	a0,a1,272 <memmove+0x2e>
    while(n-- > 0)
 24e:	00c05f63          	blez	a2,26c <memmove+0x28>
 252:	1602                	slli	a2,a2,0x20
 254:	9201                	srli	a2,a2,0x20
 256:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 25a:	872a                	mv	a4,a0
      *dst++ = *src++;
 25c:	0585                	addi	a1,a1,1
 25e:	0705                	addi	a4,a4,1
 260:	fff5c683          	lbu	a3,-1(a1)
 264:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 268:	fef71ae3          	bne	a4,a5,25c <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 26c:	6422                	ld	s0,8(sp)
 26e:	0141                	addi	sp,sp,16
 270:	8082                	ret
    dst += n;
 272:	00c50733          	add	a4,a0,a2
    src += n;
 276:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 278:	fec05ae3          	blez	a2,26c <memmove+0x28>
 27c:	fff6079b          	addiw	a5,a2,-1
 280:	1782                	slli	a5,a5,0x20
 282:	9381                	srli	a5,a5,0x20
 284:	fff7c793          	not	a5,a5
 288:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 28a:	15fd                	addi	a1,a1,-1
 28c:	177d                	addi	a4,a4,-1
 28e:	0005c683          	lbu	a3,0(a1)
 292:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 296:	fee79ae3          	bne	a5,a4,28a <memmove+0x46>
 29a:	bfc9                	j	26c <memmove+0x28>

000000000000029c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 29c:	1141                	addi	sp,sp,-16
 29e:	e422                	sd	s0,8(sp)
 2a0:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2a2:	ca05                	beqz	a2,2d2 <memcmp+0x36>
 2a4:	fff6069b          	addiw	a3,a2,-1
 2a8:	1682                	slli	a3,a3,0x20
 2aa:	9281                	srli	a3,a3,0x20
 2ac:	0685                	addi	a3,a3,1
 2ae:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2b0:	00054783          	lbu	a5,0(a0)
 2b4:	0005c703          	lbu	a4,0(a1)
 2b8:	00e79863          	bne	a5,a4,2c8 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2bc:	0505                	addi	a0,a0,1
    p2++;
 2be:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2c0:	fed518e3          	bne	a0,a3,2b0 <memcmp+0x14>
  }
  return 0;
 2c4:	4501                	li	a0,0
 2c6:	a019                	j	2cc <memcmp+0x30>
      return *p1 - *p2;
 2c8:	40e7853b          	subw	a0,a5,a4
}
 2cc:	6422                	ld	s0,8(sp)
 2ce:	0141                	addi	sp,sp,16
 2d0:	8082                	ret
  return 0;
 2d2:	4501                	li	a0,0
 2d4:	bfe5                	j	2cc <memcmp+0x30>

00000000000002d6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2d6:	1141                	addi	sp,sp,-16
 2d8:	e406                	sd	ra,8(sp)
 2da:	e022                	sd	s0,0(sp)
 2dc:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2de:	f67ff0ef          	jal	244 <memmove>
}
 2e2:	60a2                	ld	ra,8(sp)
 2e4:	6402                	ld	s0,0(sp)
 2e6:	0141                	addi	sp,sp,16
 2e8:	8082                	ret

00000000000002ea <sbrk>:

char *
sbrk(int n) {
 2ea:	1141                	addi	sp,sp,-16
 2ec:	e406                	sd	ra,8(sp)
 2ee:	e022                	sd	s0,0(sp)
 2f0:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 2f2:	4585                	li	a1,1
 2f4:	142000ef          	jal	436 <sys_sbrk>
}
 2f8:	60a2                	ld	ra,8(sp)
 2fa:	6402                	ld	s0,0(sp)
 2fc:	0141                	addi	sp,sp,16
 2fe:	8082                	ret

0000000000000300 <sbrklazy>:

char *
sbrklazy(int n) {
 300:	1141                	addi	sp,sp,-16
 302:	e406                	sd	ra,8(sp)
 304:	e022                	sd	s0,0(sp)
 306:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 308:	4589                	li	a1,2
 30a:	12c000ef          	jal	436 <sys_sbrk>
}
 30e:	60a2                	ld	ra,8(sp)
 310:	6402                	ld	s0,0(sp)
 312:	0141                	addi	sp,sp,16
 314:	8082                	ret

0000000000000316 <thread_create>:
// thread_create allocates a page-sized stack, calls clone(fn, arg, stacktop).
// Returns the new thread's pid, or -1 on error.
// The stack is passed back via *stack so the caller can free it after join.
int
thread_create(void(*fn)(void*), void *arg, void **stack)
{
 316:	7179                	addi	sp,sp,-48
 318:	f406                	sd	ra,40(sp)
 31a:	f022                	sd	s0,32(sp)
 31c:	e84a                	sd	s2,16(sp)
 31e:	e44e                	sd	s3,8(sp)
 320:	e052                	sd	s4,0(sp)
 322:	1800                	addi	s0,sp,48
 324:	89aa                	mv	s3,a0
 326:	8a2e                	mv	s4,a1
 328:	8932                	mv	s2,a2
  char *s = malloc(PGSIZE);
 32a:	6505                	lui	a0,0x1
 32c:	5b8000ef          	jal	8e4 <malloc>
  if(s == 0)
 330:	cd0d                	beqz	a0,36a <thread_create+0x54>
 332:	ec26                	sd	s1,24(sp)
 334:	84aa                	mv	s1,a0
    return -1;
  *stack = s;
 336:	00a93023          	sd	a0,0(s2)
  // Stack grows downward- pass the top of the allocated region.
  int pid = clone(fn, arg, s + PGSIZE);
 33a:	6605                	lui	a2,0x1
 33c:	962a                	add	a2,a2,a0
 33e:	85d2                	mv	a1,s4
 340:	854e                	mv	a0,s3
 342:	134000ef          	jal	476 <clone>
  if(pid < 0){
 346:	00054a63          	bltz	a0,35a <thread_create+0x44>
 34a:	64e2                	ld	s1,24(sp)
    free(s);
    *stack = 0;
    return -1;
  }
  return pid;
}
 34c:	70a2                	ld	ra,40(sp)
 34e:	7402                	ld	s0,32(sp)
 350:	6942                	ld	s2,16(sp)
 352:	69a2                	ld	s3,8(sp)
 354:	6a02                	ld	s4,0(sp)
 356:	6145                	addi	sp,sp,48
 358:	8082                	ret
    free(s);
 35a:	8526                	mv	a0,s1
 35c:	506000ef          	jal	862 <free>
    *stack = 0;
 360:	00093023          	sd	zero,0(s2)
    return -1;
 364:	557d                	li	a0,-1
 366:	64e2                	ld	s1,24(sp)
 368:	b7d5                	j	34c <thread_create+0x36>
    return -1;
 36a:	557d                	li	a0,-1
 36c:	b7c5                	j	34c <thread_create+0x36>

000000000000036e <thread_join>:
// Wait for any child thread to exit.
// If stack is non-null, frees the memory pointed to by *stack and clears it.
// Returns the joined thread's pid, or -1 Son error.
int
thread_join(void **stack)
{
 36e:	1101                	addi	sp,sp,-32
 370:	ec06                	sd	ra,24(sp)
 372:	e822                	sd	s0,16(sp)
 374:	e426                	sd	s1,8(sp)
 376:	e04a                	sd	s2,0(sp)
 378:	1000                	addi	s0,sp,32
 37a:	84aa                	mv	s1,a0
  int pid = join();
 37c:	102000ef          	jal	47e <join>
  if(pid < 0)
 380:	02054163          	bltz	a0,3a2 <thread_join+0x34>
 384:	892a                	mv	s2,a0
    return -1;
  if(stack && *stack){
 386:	c499                	beqz	s1,394 <thread_join+0x26>
 388:	6088                	ld	a0,0(s1)
 38a:	c509                	beqz	a0,394 <thread_join+0x26>
    free(*stack);
 38c:	4d6000ef          	jal	862 <free>
    *stack = 0;
 390:	0004b023          	sd	zero,0(s1)
  }
  return pid;
}
 394:	854a                	mv	a0,s2
 396:	60e2                	ld	ra,24(sp)
 398:	6442                	ld	s0,16(sp)
 39a:	64a2                	ld	s1,8(sp)
 39c:	6902                	ld	s2,0(sp)
 39e:	6105                	addi	sp,sp,32
 3a0:	8082                	ret
    return -1;
 3a2:	597d                	li	s2,-1
 3a4:	bfc5                	j	394 <thread_join+0x26>

00000000000003a6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3a6:	4885                	li	a7,1
 ecall
 3a8:	00000073          	ecall
 ret
 3ac:	8082                	ret

00000000000003ae <exit>:
.global exit
exit:
 li a7, SYS_exit
 3ae:	4889                	li	a7,2
 ecall
 3b0:	00000073          	ecall
 ret
 3b4:	8082                	ret

00000000000003b6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3b6:	488d                	li	a7,3
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3be:	4891                	li	a7,4
 ecall
 3c0:	00000073          	ecall
 ret
 3c4:	8082                	ret

00000000000003c6 <read>:
.global read
read:
 li a7, SYS_read
 3c6:	4895                	li	a7,5
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <write>:
.global write
write:
 li a7, SYS_write
 3ce:	48c1                	li	a7,16
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <close>:
.global close
close:
 li a7, SYS_close
 3d6:	48d5                	li	a7,21
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <kill>:
.global kill
kill:
 li a7, SYS_kill
 3de:	4899                	li	a7,6
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3e6:	489d                	li	a7,7
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <open>:
.global open
open:
 li a7, SYS_open
 3ee:	48bd                	li	a7,15
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3f6:	48c5                	li	a7,17
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3fe:	48c9                	li	a7,18
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 406:	48a1                	li	a7,8
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <link>:
.global link
link:
 li a7, SYS_link
 40e:	48cd                	li	a7,19
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 416:	48d1                	li	a7,20
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 41e:	48a5                	li	a7,9
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <dup>:
.global dup
dup:
 li a7, SYS_dup
 426:	48a9                	li	a7,10
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 42e:	48ad                	li	a7,11
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 436:	48b1                	li	a7,12
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <pause>:
.global pause
pause:
 li a7, SYS_pause
 43e:	48b5                	li	a7,13
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 446:	48b9                	li	a7,14
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 44e:	48d9                	li	a7,22
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <lock_create>:
.global lock_create
lock_create:
 li a7, SYS_lock_create
 456:	48dd                	li	a7,23
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <lock_acquire>:
.global lock_acquire
lock_acquire:
 li a7, SYS_lock_acquire
 45e:	48e1                	li	a7,24
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <lock_release>:
.global lock_release
lock_release:
 li a7, SYS_lock_release
 466:	48e5                	li	a7,25
 ecall
 468:	00000073          	ecall
 ret
 46c:	8082                	ret

000000000000046e <lock_destroy>:
.global lock_destroy
lock_destroy:
 li a7, SYS_lock_destroy
 46e:	48e9                	li	a7,26
 ecall
 470:	00000073          	ecall
 ret
 474:	8082                	ret

0000000000000476 <clone>:
.global clone
clone:
 li a7, SYS_clone
 476:	48ed                	li	a7,27
 ecall
 478:	00000073          	ecall
 ret
 47c:	8082                	ret

000000000000047e <join>:
.global join
join:
 li a7, SYS_join
 47e:	48f1                	li	a7,28
 ecall
 480:	00000073          	ecall
 ret
 484:	8082                	ret

0000000000000486 <getprocessinfo>:
.global getprocessinfo
getprocessinfo:
 li a7, SYS_getprocessinfo
 486:	48f5                	li	a7,29
 ecall
 488:	00000073          	ecall
 ret
 48c:	8082                	ret

000000000000048e <shmget>:
.global shmget
shmget:
 li a7, SYS_shmget
 48e:	48f9                	li	a7,30
 ecall
 490:	00000073          	ecall
 ret
 494:	8082                	ret

0000000000000496 <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 496:	48fd                	li	a7,31
 ecall
 498:	00000073          	ecall
 ret
 49c:	8082                	ret

000000000000049e <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 49e:	02000893          	li	a7,32
 ecall
 4a2:	00000073          	ecall
 ret
 4a6:	8082                	ret

00000000000004a8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4a8:	1101                	addi	sp,sp,-32
 4aa:	ec06                	sd	ra,24(sp)
 4ac:	e822                	sd	s0,16(sp)
 4ae:	1000                	addi	s0,sp,32
 4b0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4b4:	4605                	li	a2,1
 4b6:	fef40593          	addi	a1,s0,-17
 4ba:	f15ff0ef          	jal	3ce <write>
}
 4be:	60e2                	ld	ra,24(sp)
 4c0:	6442                	ld	s0,16(sp)
 4c2:	6105                	addi	sp,sp,32
 4c4:	8082                	ret

00000000000004c6 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 4c6:	715d                	addi	sp,sp,-80
 4c8:	e486                	sd	ra,72(sp)
 4ca:	e0a2                	sd	s0,64(sp)
 4cc:	f84a                	sd	s2,48(sp)
 4ce:	0880                	addi	s0,sp,80
 4d0:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 4d2:	c299                	beqz	a3,4d8 <printint+0x12>
 4d4:	0805c363          	bltz	a1,55a <printint+0x94>
  neg = 0;
 4d8:	4881                	li	a7,0
 4da:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 4de:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 4e0:	00000517          	auipc	a0,0x0
 4e4:	58050513          	addi	a0,a0,1408 # a60 <digits>
 4e8:	883e                	mv	a6,a5
 4ea:	2785                	addiw	a5,a5,1
 4ec:	02c5f733          	remu	a4,a1,a2
 4f0:	972a                	add	a4,a4,a0
 4f2:	00074703          	lbu	a4,0(a4)
 4f6:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 4fa:	872e                	mv	a4,a1
 4fc:	02c5d5b3          	divu	a1,a1,a2
 500:	0685                	addi	a3,a3,1
 502:	fec773e3          	bgeu	a4,a2,4e8 <printint+0x22>
  if(neg)
 506:	00088b63          	beqz	a7,51c <printint+0x56>
    buf[i++] = '-';
 50a:	fd078793          	addi	a5,a5,-48
 50e:	97a2                	add	a5,a5,s0
 510:	02d00713          	li	a4,45
 514:	fee78423          	sb	a4,-24(a5)
 518:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 51c:	02f05a63          	blez	a5,550 <printint+0x8a>
 520:	fc26                	sd	s1,56(sp)
 522:	f44e                	sd	s3,40(sp)
 524:	fb840713          	addi	a4,s0,-72
 528:	00f704b3          	add	s1,a4,a5
 52c:	fff70993          	addi	s3,a4,-1
 530:	99be                	add	s3,s3,a5
 532:	37fd                	addiw	a5,a5,-1
 534:	1782                	slli	a5,a5,0x20
 536:	9381                	srli	a5,a5,0x20
 538:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 53c:	fff4c583          	lbu	a1,-1(s1)
 540:	854a                	mv	a0,s2
 542:	f67ff0ef          	jal	4a8 <putc>
  while(--i >= 0)
 546:	14fd                	addi	s1,s1,-1
 548:	ff349ae3          	bne	s1,s3,53c <printint+0x76>
 54c:	74e2                	ld	s1,56(sp)
 54e:	79a2                	ld	s3,40(sp)
}
 550:	60a6                	ld	ra,72(sp)
 552:	6406                	ld	s0,64(sp)
 554:	7942                	ld	s2,48(sp)
 556:	6161                	addi	sp,sp,80
 558:	8082                	ret
    x = -xx;
 55a:	40b005b3          	neg	a1,a1
    neg = 1;
 55e:	4885                	li	a7,1
    x = -xx;
 560:	bfad                	j	4da <printint+0x14>

0000000000000562 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 562:	711d                	addi	sp,sp,-96
 564:	ec86                	sd	ra,88(sp)
 566:	e8a2                	sd	s0,80(sp)
 568:	e0ca                	sd	s2,64(sp)
 56a:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 56c:	0005c903          	lbu	s2,0(a1)
 570:	28090663          	beqz	s2,7fc <vprintf+0x29a>
 574:	e4a6                	sd	s1,72(sp)
 576:	fc4e                	sd	s3,56(sp)
 578:	f852                	sd	s4,48(sp)
 57a:	f456                	sd	s5,40(sp)
 57c:	f05a                	sd	s6,32(sp)
 57e:	ec5e                	sd	s7,24(sp)
 580:	e862                	sd	s8,16(sp)
 582:	e466                	sd	s9,8(sp)
 584:	8b2a                	mv	s6,a0
 586:	8a2e                	mv	s4,a1
 588:	8bb2                	mv	s7,a2
  state = 0;
 58a:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 58c:	4481                	li	s1,0
 58e:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 590:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 594:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 598:	06c00c93          	li	s9,108
 59c:	a005                	j	5bc <vprintf+0x5a>
        putc(fd, c0);
 59e:	85ca                	mv	a1,s2
 5a0:	855a                	mv	a0,s6
 5a2:	f07ff0ef          	jal	4a8 <putc>
 5a6:	a019                	j	5ac <vprintf+0x4a>
    } else if(state == '%'){
 5a8:	03598263          	beq	s3,s5,5cc <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 5ac:	2485                	addiw	s1,s1,1
 5ae:	8726                	mv	a4,s1
 5b0:	009a07b3          	add	a5,s4,s1
 5b4:	0007c903          	lbu	s2,0(a5)
 5b8:	22090a63          	beqz	s2,7ec <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 5bc:	0009079b          	sext.w	a5,s2
    if(state == 0){
 5c0:	fe0994e3          	bnez	s3,5a8 <vprintf+0x46>
      if(c0 == '%'){
 5c4:	fd579de3          	bne	a5,s5,59e <vprintf+0x3c>
        state = '%';
 5c8:	89be                	mv	s3,a5
 5ca:	b7cd                	j	5ac <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 5cc:	00ea06b3          	add	a3,s4,a4
 5d0:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 5d4:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 5d6:	c681                	beqz	a3,5de <vprintf+0x7c>
 5d8:	9752                	add	a4,a4,s4
 5da:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 5de:	05878363          	beq	a5,s8,624 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 5e2:	05978d63          	beq	a5,s9,63c <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 5e6:	07500713          	li	a4,117
 5ea:	0ee78763          	beq	a5,a4,6d8 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 5ee:	07800713          	li	a4,120
 5f2:	12e78963          	beq	a5,a4,724 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 5f6:	07000713          	li	a4,112
 5fa:	14e78e63          	beq	a5,a4,756 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 5fe:	06300713          	li	a4,99
 602:	18e78e63          	beq	a5,a4,79e <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 606:	07300713          	li	a4,115
 60a:	1ae78463          	beq	a5,a4,7b2 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 60e:	02500713          	li	a4,37
 612:	04e79563          	bne	a5,a4,65c <vprintf+0xfa>
        putc(fd, '%');
 616:	02500593          	li	a1,37
 61a:	855a                	mv	a0,s6
 61c:	e8dff0ef          	jal	4a8 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 620:	4981                	li	s3,0
 622:	b769                	j	5ac <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 624:	008b8913          	addi	s2,s7,8
 628:	4685                	li	a3,1
 62a:	4629                	li	a2,10
 62c:	000ba583          	lw	a1,0(s7)
 630:	855a                	mv	a0,s6
 632:	e95ff0ef          	jal	4c6 <printint>
 636:	8bca                	mv	s7,s2
      state = 0;
 638:	4981                	li	s3,0
 63a:	bf8d                	j	5ac <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 63c:	06400793          	li	a5,100
 640:	02f68963          	beq	a3,a5,672 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 644:	06c00793          	li	a5,108
 648:	04f68263          	beq	a3,a5,68c <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 64c:	07500793          	li	a5,117
 650:	0af68063          	beq	a3,a5,6f0 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 654:	07800793          	li	a5,120
 658:	0ef68263          	beq	a3,a5,73c <vprintf+0x1da>
        putc(fd, '%');
 65c:	02500593          	li	a1,37
 660:	855a                	mv	a0,s6
 662:	e47ff0ef          	jal	4a8 <putc>
        putc(fd, c0);
 666:	85ca                	mv	a1,s2
 668:	855a                	mv	a0,s6
 66a:	e3fff0ef          	jal	4a8 <putc>
      state = 0;
 66e:	4981                	li	s3,0
 670:	bf35                	j	5ac <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 672:	008b8913          	addi	s2,s7,8
 676:	4685                	li	a3,1
 678:	4629                	li	a2,10
 67a:	000bb583          	ld	a1,0(s7)
 67e:	855a                	mv	a0,s6
 680:	e47ff0ef          	jal	4c6 <printint>
        i += 1;
 684:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 686:	8bca                	mv	s7,s2
      state = 0;
 688:	4981                	li	s3,0
        i += 1;
 68a:	b70d                	j	5ac <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 68c:	06400793          	li	a5,100
 690:	02f60763          	beq	a2,a5,6be <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 694:	07500793          	li	a5,117
 698:	06f60963          	beq	a2,a5,70a <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 69c:	07800793          	li	a5,120
 6a0:	faf61ee3          	bne	a2,a5,65c <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6a4:	008b8913          	addi	s2,s7,8
 6a8:	4681                	li	a3,0
 6aa:	4641                	li	a2,16
 6ac:	000bb583          	ld	a1,0(s7)
 6b0:	855a                	mv	a0,s6
 6b2:	e15ff0ef          	jal	4c6 <printint>
        i += 2;
 6b6:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 6b8:	8bca                	mv	s7,s2
      state = 0;
 6ba:	4981                	li	s3,0
        i += 2;
 6bc:	bdc5                	j	5ac <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6be:	008b8913          	addi	s2,s7,8
 6c2:	4685                	li	a3,1
 6c4:	4629                	li	a2,10
 6c6:	000bb583          	ld	a1,0(s7)
 6ca:	855a                	mv	a0,s6
 6cc:	dfbff0ef          	jal	4c6 <printint>
        i += 2;
 6d0:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 6d2:	8bca                	mv	s7,s2
      state = 0;
 6d4:	4981                	li	s3,0
        i += 2;
 6d6:	bdd9                	j	5ac <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 6d8:	008b8913          	addi	s2,s7,8
 6dc:	4681                	li	a3,0
 6de:	4629                	li	a2,10
 6e0:	000be583          	lwu	a1,0(s7)
 6e4:	855a                	mv	a0,s6
 6e6:	de1ff0ef          	jal	4c6 <printint>
 6ea:	8bca                	mv	s7,s2
      state = 0;
 6ec:	4981                	li	s3,0
 6ee:	bd7d                	j	5ac <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6f0:	008b8913          	addi	s2,s7,8
 6f4:	4681                	li	a3,0
 6f6:	4629                	li	a2,10
 6f8:	000bb583          	ld	a1,0(s7)
 6fc:	855a                	mv	a0,s6
 6fe:	dc9ff0ef          	jal	4c6 <printint>
        i += 1;
 702:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 704:	8bca                	mv	s7,s2
      state = 0;
 706:	4981                	li	s3,0
        i += 1;
 708:	b555                	j	5ac <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 70a:	008b8913          	addi	s2,s7,8
 70e:	4681                	li	a3,0
 710:	4629                	li	a2,10
 712:	000bb583          	ld	a1,0(s7)
 716:	855a                	mv	a0,s6
 718:	dafff0ef          	jal	4c6 <printint>
        i += 2;
 71c:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 71e:	8bca                	mv	s7,s2
      state = 0;
 720:	4981                	li	s3,0
        i += 2;
 722:	b569                	j	5ac <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 724:	008b8913          	addi	s2,s7,8
 728:	4681                	li	a3,0
 72a:	4641                	li	a2,16
 72c:	000be583          	lwu	a1,0(s7)
 730:	855a                	mv	a0,s6
 732:	d95ff0ef          	jal	4c6 <printint>
 736:	8bca                	mv	s7,s2
      state = 0;
 738:	4981                	li	s3,0
 73a:	bd8d                	j	5ac <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 73c:	008b8913          	addi	s2,s7,8
 740:	4681                	li	a3,0
 742:	4641                	li	a2,16
 744:	000bb583          	ld	a1,0(s7)
 748:	855a                	mv	a0,s6
 74a:	d7dff0ef          	jal	4c6 <printint>
        i += 1;
 74e:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 750:	8bca                	mv	s7,s2
      state = 0;
 752:	4981                	li	s3,0
        i += 1;
 754:	bda1                	j	5ac <vprintf+0x4a>
 756:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 758:	008b8d13          	addi	s10,s7,8
 75c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 760:	03000593          	li	a1,48
 764:	855a                	mv	a0,s6
 766:	d43ff0ef          	jal	4a8 <putc>
  putc(fd, 'x');
 76a:	07800593          	li	a1,120
 76e:	855a                	mv	a0,s6
 770:	d39ff0ef          	jal	4a8 <putc>
 774:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 776:	00000b97          	auipc	s7,0x0
 77a:	2eab8b93          	addi	s7,s7,746 # a60 <digits>
 77e:	03c9d793          	srli	a5,s3,0x3c
 782:	97de                	add	a5,a5,s7
 784:	0007c583          	lbu	a1,0(a5)
 788:	855a                	mv	a0,s6
 78a:	d1fff0ef          	jal	4a8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 78e:	0992                	slli	s3,s3,0x4
 790:	397d                	addiw	s2,s2,-1
 792:	fe0916e3          	bnez	s2,77e <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 796:	8bea                	mv	s7,s10
      state = 0;
 798:	4981                	li	s3,0
 79a:	6d02                	ld	s10,0(sp)
 79c:	bd01                	j	5ac <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 79e:	008b8913          	addi	s2,s7,8
 7a2:	000bc583          	lbu	a1,0(s7)
 7a6:	855a                	mv	a0,s6
 7a8:	d01ff0ef          	jal	4a8 <putc>
 7ac:	8bca                	mv	s7,s2
      state = 0;
 7ae:	4981                	li	s3,0
 7b0:	bbf5                	j	5ac <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 7b2:	008b8993          	addi	s3,s7,8
 7b6:	000bb903          	ld	s2,0(s7)
 7ba:	00090f63          	beqz	s2,7d8 <vprintf+0x276>
        for(; *s; s++)
 7be:	00094583          	lbu	a1,0(s2)
 7c2:	c195                	beqz	a1,7e6 <vprintf+0x284>
          putc(fd, *s);
 7c4:	855a                	mv	a0,s6
 7c6:	ce3ff0ef          	jal	4a8 <putc>
        for(; *s; s++)
 7ca:	0905                	addi	s2,s2,1
 7cc:	00094583          	lbu	a1,0(s2)
 7d0:	f9f5                	bnez	a1,7c4 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 7d2:	8bce                	mv	s7,s3
      state = 0;
 7d4:	4981                	li	s3,0
 7d6:	bbd9                	j	5ac <vprintf+0x4a>
          s = "(null)";
 7d8:	00000917          	auipc	s2,0x0
 7dc:	28090913          	addi	s2,s2,640 # a58 <malloc+0x174>
        for(; *s; s++)
 7e0:	02800593          	li	a1,40
 7e4:	b7c5                	j	7c4 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 7e6:	8bce                	mv	s7,s3
      state = 0;
 7e8:	4981                	li	s3,0
 7ea:	b3c9                	j	5ac <vprintf+0x4a>
 7ec:	64a6                	ld	s1,72(sp)
 7ee:	79e2                	ld	s3,56(sp)
 7f0:	7a42                	ld	s4,48(sp)
 7f2:	7aa2                	ld	s5,40(sp)
 7f4:	7b02                	ld	s6,32(sp)
 7f6:	6be2                	ld	s7,24(sp)
 7f8:	6c42                	ld	s8,16(sp)
 7fa:	6ca2                	ld	s9,8(sp)
    }
  }
}
 7fc:	60e6                	ld	ra,88(sp)
 7fe:	6446                	ld	s0,80(sp)
 800:	6906                	ld	s2,64(sp)
 802:	6125                	addi	sp,sp,96
 804:	8082                	ret

0000000000000806 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 806:	715d                	addi	sp,sp,-80
 808:	ec06                	sd	ra,24(sp)
 80a:	e822                	sd	s0,16(sp)
 80c:	1000                	addi	s0,sp,32
 80e:	e010                	sd	a2,0(s0)
 810:	e414                	sd	a3,8(s0)
 812:	e818                	sd	a4,16(s0)
 814:	ec1c                	sd	a5,24(s0)
 816:	03043023          	sd	a6,32(s0)
 81a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 81e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 822:	8622                	mv	a2,s0
 824:	d3fff0ef          	jal	562 <vprintf>
}
 828:	60e2                	ld	ra,24(sp)
 82a:	6442                	ld	s0,16(sp)
 82c:	6161                	addi	sp,sp,80
 82e:	8082                	ret

0000000000000830 <printf>:

void
printf(const char *fmt, ...)
{
 830:	711d                	addi	sp,sp,-96
 832:	ec06                	sd	ra,24(sp)
 834:	e822                	sd	s0,16(sp)
 836:	1000                	addi	s0,sp,32
 838:	e40c                	sd	a1,8(s0)
 83a:	e810                	sd	a2,16(s0)
 83c:	ec14                	sd	a3,24(s0)
 83e:	f018                	sd	a4,32(s0)
 840:	f41c                	sd	a5,40(s0)
 842:	03043823          	sd	a6,48(s0)
 846:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 84a:	00840613          	addi	a2,s0,8
 84e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 852:	85aa                	mv	a1,a0
 854:	4505                	li	a0,1
 856:	d0dff0ef          	jal	562 <vprintf>
}
 85a:	60e2                	ld	ra,24(sp)
 85c:	6442                	ld	s0,16(sp)
 85e:	6125                	addi	sp,sp,96
 860:	8082                	ret

0000000000000862 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 862:	1141                	addi	sp,sp,-16
 864:	e422                	sd	s0,8(sp)
 866:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 868:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 86c:	00000797          	auipc	a5,0x0
 870:	7947b783          	ld	a5,1940(a5) # 1000 <freep>
 874:	a02d                	j	89e <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 876:	4618                	lw	a4,8(a2)
 878:	9f2d                	addw	a4,a4,a1
 87a:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 87e:	6398                	ld	a4,0(a5)
 880:	6310                	ld	a2,0(a4)
 882:	a83d                	j	8c0 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 884:	ff852703          	lw	a4,-8(a0)
 888:	9f31                	addw	a4,a4,a2
 88a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 88c:	ff053683          	ld	a3,-16(a0)
 890:	a091                	j	8d4 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 892:	6398                	ld	a4,0(a5)
 894:	00e7e463          	bltu	a5,a4,89c <free+0x3a>
 898:	00e6ea63          	bltu	a3,a4,8ac <free+0x4a>
{
 89c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 89e:	fed7fae3          	bgeu	a5,a3,892 <free+0x30>
 8a2:	6398                	ld	a4,0(a5)
 8a4:	00e6e463          	bltu	a3,a4,8ac <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8a8:	fee7eae3          	bltu	a5,a4,89c <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 8ac:	ff852583          	lw	a1,-8(a0)
 8b0:	6390                	ld	a2,0(a5)
 8b2:	02059813          	slli	a6,a1,0x20
 8b6:	01c85713          	srli	a4,a6,0x1c
 8ba:	9736                	add	a4,a4,a3
 8bc:	fae60de3          	beq	a2,a4,876 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 8c0:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8c4:	4790                	lw	a2,8(a5)
 8c6:	02061593          	slli	a1,a2,0x20
 8ca:	01c5d713          	srli	a4,a1,0x1c
 8ce:	973e                	add	a4,a4,a5
 8d0:	fae68ae3          	beq	a3,a4,884 <free+0x22>
    p->s.ptr = bp->s.ptr;
 8d4:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 8d6:	00000717          	auipc	a4,0x0
 8da:	72f73523          	sd	a5,1834(a4) # 1000 <freep>
}
 8de:	6422                	ld	s0,8(sp)
 8e0:	0141                	addi	sp,sp,16
 8e2:	8082                	ret

00000000000008e4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8e4:	7139                	addi	sp,sp,-64
 8e6:	fc06                	sd	ra,56(sp)
 8e8:	f822                	sd	s0,48(sp)
 8ea:	f426                	sd	s1,40(sp)
 8ec:	ec4e                	sd	s3,24(sp)
 8ee:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8f0:	02051493          	slli	s1,a0,0x20
 8f4:	9081                	srli	s1,s1,0x20
 8f6:	04bd                	addi	s1,s1,15
 8f8:	8091                	srli	s1,s1,0x4
 8fa:	0014899b          	addiw	s3,s1,1
 8fe:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 900:	00000517          	auipc	a0,0x0
 904:	70053503          	ld	a0,1792(a0) # 1000 <freep>
 908:	c915                	beqz	a0,93c <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 90a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 90c:	4798                	lw	a4,8(a5)
 90e:	08977a63          	bgeu	a4,s1,9a2 <malloc+0xbe>
 912:	f04a                	sd	s2,32(sp)
 914:	e852                	sd	s4,16(sp)
 916:	e456                	sd	s5,8(sp)
 918:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 91a:	8a4e                	mv	s4,s3
 91c:	0009871b          	sext.w	a4,s3
 920:	6685                	lui	a3,0x1
 922:	00d77363          	bgeu	a4,a3,928 <malloc+0x44>
 926:	6a05                	lui	s4,0x1
 928:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 92c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 930:	00000917          	auipc	s2,0x0
 934:	6d090913          	addi	s2,s2,1744 # 1000 <freep>
  if(p == SBRK_ERROR)
 938:	5afd                	li	s5,-1
 93a:	a081                	j	97a <malloc+0x96>
 93c:	f04a                	sd	s2,32(sp)
 93e:	e852                	sd	s4,16(sp)
 940:	e456                	sd	s5,8(sp)
 942:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 944:	00001797          	auipc	a5,0x1
 948:	8c478793          	addi	a5,a5,-1852 # 1208 <base>
 94c:	00000717          	auipc	a4,0x0
 950:	6af73a23          	sd	a5,1716(a4) # 1000 <freep>
 954:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 956:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 95a:	b7c1                	j	91a <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 95c:	6398                	ld	a4,0(a5)
 95e:	e118                	sd	a4,0(a0)
 960:	a8a9                	j	9ba <malloc+0xd6>
  hp->s.size = nu;
 962:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 966:	0541                	addi	a0,a0,16
 968:	efbff0ef          	jal	862 <free>
  return freep;
 96c:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 970:	c12d                	beqz	a0,9d2 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 972:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 974:	4798                	lw	a4,8(a5)
 976:	02977263          	bgeu	a4,s1,99a <malloc+0xb6>
    if(p == freep)
 97a:	00093703          	ld	a4,0(s2)
 97e:	853e                	mv	a0,a5
 980:	fef719e3          	bne	a4,a5,972 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 984:	8552                	mv	a0,s4
 986:	965ff0ef          	jal	2ea <sbrk>
  if(p == SBRK_ERROR)
 98a:	fd551ce3          	bne	a0,s5,962 <malloc+0x7e>
        return 0;
 98e:	4501                	li	a0,0
 990:	7902                	ld	s2,32(sp)
 992:	6a42                	ld	s4,16(sp)
 994:	6aa2                	ld	s5,8(sp)
 996:	6b02                	ld	s6,0(sp)
 998:	a03d                	j	9c6 <malloc+0xe2>
 99a:	7902                	ld	s2,32(sp)
 99c:	6a42                	ld	s4,16(sp)
 99e:	6aa2                	ld	s5,8(sp)
 9a0:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 9a2:	fae48de3          	beq	s1,a4,95c <malloc+0x78>
        p->s.size -= nunits;
 9a6:	4137073b          	subw	a4,a4,s3
 9aa:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9ac:	02071693          	slli	a3,a4,0x20
 9b0:	01c6d713          	srli	a4,a3,0x1c
 9b4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9b6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9ba:	00000717          	auipc	a4,0x0
 9be:	64a73323          	sd	a0,1606(a4) # 1000 <freep>
      return (void*)(p + 1);
 9c2:	01078513          	addi	a0,a5,16
  }
}
 9c6:	70e2                	ld	ra,56(sp)
 9c8:	7442                	ld	s0,48(sp)
 9ca:	74a2                	ld	s1,40(sp)
 9cc:	69e2                	ld	s3,24(sp)
 9ce:	6121                	addi	sp,sp,64
 9d0:	8082                	ret
 9d2:	7902                	ld	s2,32(sp)
 9d4:	6a42                	ld	s4,16(sp)
 9d6:	6aa2                	ld	s5,8(sp)
 9d8:	6b02                	ld	s6,0(sp)
 9da:	b7f5                	j	9c6 <malloc+0xe2>
