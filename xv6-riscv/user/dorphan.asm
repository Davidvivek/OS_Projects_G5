
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
  10:	9c450513          	addi	a0,a0,-1596 # 9d0 <malloc+0x106>
  14:	402000ef          	jal	416 <mkdir>
  18:	c919                	beqz	a0,2e <main+0x2e>
    printf("%s: mkdir dd failed\n", s);
  1a:	85a6                	mv	a1,s1
  1c:	00001517          	auipc	a0,0x1
  20:	9bc50513          	addi	a0,a0,-1604 # 9d8 <malloc+0x10e>
  24:	7f2000ef          	jal	816 <printf>
    exit(1);
  28:	4505                	li	a0,1
  2a:	384000ef          	jal	3ae <exit>
  }

  if(chdir("dd") != 0){
  2e:	00001517          	auipc	a0,0x1
  32:	9a250513          	addi	a0,a0,-1630 # 9d0 <malloc+0x106>
  36:	3e8000ef          	jal	41e <chdir>
  3a:	c919                	beqz	a0,50 <main+0x50>
    printf("%s: chdir dd failed\n", s);
  3c:	85a6                	mv	a1,s1
  3e:	00001517          	auipc	a0,0x1
  42:	9b250513          	addi	a0,a0,-1614 # 9f0 <malloc+0x126>
  46:	7d0000ef          	jal	816 <printf>
    exit(1);
  4a:	4505                	li	a0,1
  4c:	362000ef          	jal	3ae <exit>
  }

  if (unlink("../dd") < 0) {
  50:	00001517          	auipc	a0,0x1
  54:	9b850513          	addi	a0,a0,-1608 # a08 <malloc+0x13e>
  58:	3a6000ef          	jal	3fe <unlink>
  5c:	00054d63          	bltz	a0,76 <main+0x76>
    printf("%s: unlink failed\n", s);
    exit(1);
  }
  printf("wait for kill and reclaim\n");
  60:	00001517          	auipc	a0,0x1
  64:	9c850513          	addi	a0,a0,-1592 # a28 <malloc+0x15e>
  68:	7ae000ef          	jal	816 <printf>
  // sit around until killed
  for(;;) pause(1000);
  6c:	3e800513          	li	a0,1000
  70:	3ce000ef          	jal	43e <pause>
  74:	bfe5                	j	6c <main+0x6c>
    printf("%s: unlink failed\n", s);
  76:	85a6                	mv	a1,s1
  78:	00001517          	auipc	a0,0x1
  7c:	99850513          	addi	a0,a0,-1640 # a10 <malloc+0x146>
  80:	796000ef          	jal	816 <printf>
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
 32c:	59e000ef          	jal	8ca <malloc>
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
 35c:	4ec000ef          	jal	848 <free>
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
 38c:	4bc000ef          	jal	848 <free>
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

000000000000048e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 48e:	1101                	addi	sp,sp,-32
 490:	ec06                	sd	ra,24(sp)
 492:	e822                	sd	s0,16(sp)
 494:	1000                	addi	s0,sp,32
 496:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 49a:	4605                	li	a2,1
 49c:	fef40593          	addi	a1,s0,-17
 4a0:	f2fff0ef          	jal	3ce <write>
}
 4a4:	60e2                	ld	ra,24(sp)
 4a6:	6442                	ld	s0,16(sp)
 4a8:	6105                	addi	sp,sp,32
 4aa:	8082                	ret

00000000000004ac <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 4ac:	715d                	addi	sp,sp,-80
 4ae:	e486                	sd	ra,72(sp)
 4b0:	e0a2                	sd	s0,64(sp)
 4b2:	f84a                	sd	s2,48(sp)
 4b4:	0880                	addi	s0,sp,80
 4b6:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 4b8:	c299                	beqz	a3,4be <printint+0x12>
 4ba:	0805c363          	bltz	a1,540 <printint+0x94>
  neg = 0;
 4be:	4881                	li	a7,0
 4c0:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 4c4:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 4c6:	00000517          	auipc	a0,0x0
 4ca:	58a50513          	addi	a0,a0,1418 # a50 <digits>
 4ce:	883e                	mv	a6,a5
 4d0:	2785                	addiw	a5,a5,1
 4d2:	02c5f733          	remu	a4,a1,a2
 4d6:	972a                	add	a4,a4,a0
 4d8:	00074703          	lbu	a4,0(a4)
 4dc:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 4e0:	872e                	mv	a4,a1
 4e2:	02c5d5b3          	divu	a1,a1,a2
 4e6:	0685                	addi	a3,a3,1
 4e8:	fec773e3          	bgeu	a4,a2,4ce <printint+0x22>
  if(neg)
 4ec:	00088b63          	beqz	a7,502 <printint+0x56>
    buf[i++] = '-';
 4f0:	fd078793          	addi	a5,a5,-48
 4f4:	97a2                	add	a5,a5,s0
 4f6:	02d00713          	li	a4,45
 4fa:	fee78423          	sb	a4,-24(a5)
 4fe:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 502:	02f05a63          	blez	a5,536 <printint+0x8a>
 506:	fc26                	sd	s1,56(sp)
 508:	f44e                	sd	s3,40(sp)
 50a:	fb840713          	addi	a4,s0,-72
 50e:	00f704b3          	add	s1,a4,a5
 512:	fff70993          	addi	s3,a4,-1
 516:	99be                	add	s3,s3,a5
 518:	37fd                	addiw	a5,a5,-1
 51a:	1782                	slli	a5,a5,0x20
 51c:	9381                	srli	a5,a5,0x20
 51e:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 522:	fff4c583          	lbu	a1,-1(s1)
 526:	854a                	mv	a0,s2
 528:	f67ff0ef          	jal	48e <putc>
  while(--i >= 0)
 52c:	14fd                	addi	s1,s1,-1
 52e:	ff349ae3          	bne	s1,s3,522 <printint+0x76>
 532:	74e2                	ld	s1,56(sp)
 534:	79a2                	ld	s3,40(sp)
}
 536:	60a6                	ld	ra,72(sp)
 538:	6406                	ld	s0,64(sp)
 53a:	7942                	ld	s2,48(sp)
 53c:	6161                	addi	sp,sp,80
 53e:	8082                	ret
    x = -xx;
 540:	40b005b3          	neg	a1,a1
    neg = 1;
 544:	4885                	li	a7,1
    x = -xx;
 546:	bfad                	j	4c0 <printint+0x14>

0000000000000548 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 548:	711d                	addi	sp,sp,-96
 54a:	ec86                	sd	ra,88(sp)
 54c:	e8a2                	sd	s0,80(sp)
 54e:	e0ca                	sd	s2,64(sp)
 550:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 552:	0005c903          	lbu	s2,0(a1)
 556:	28090663          	beqz	s2,7e2 <vprintf+0x29a>
 55a:	e4a6                	sd	s1,72(sp)
 55c:	fc4e                	sd	s3,56(sp)
 55e:	f852                	sd	s4,48(sp)
 560:	f456                	sd	s5,40(sp)
 562:	f05a                	sd	s6,32(sp)
 564:	ec5e                	sd	s7,24(sp)
 566:	e862                	sd	s8,16(sp)
 568:	e466                	sd	s9,8(sp)
 56a:	8b2a                	mv	s6,a0
 56c:	8a2e                	mv	s4,a1
 56e:	8bb2                	mv	s7,a2
  state = 0;
 570:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 572:	4481                	li	s1,0
 574:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 576:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 57a:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 57e:	06c00c93          	li	s9,108
 582:	a005                	j	5a2 <vprintf+0x5a>
        putc(fd, c0);
 584:	85ca                	mv	a1,s2
 586:	855a                	mv	a0,s6
 588:	f07ff0ef          	jal	48e <putc>
 58c:	a019                	j	592 <vprintf+0x4a>
    } else if(state == '%'){
 58e:	03598263          	beq	s3,s5,5b2 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 592:	2485                	addiw	s1,s1,1
 594:	8726                	mv	a4,s1
 596:	009a07b3          	add	a5,s4,s1
 59a:	0007c903          	lbu	s2,0(a5)
 59e:	22090a63          	beqz	s2,7d2 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 5a2:	0009079b          	sext.w	a5,s2
    if(state == 0){
 5a6:	fe0994e3          	bnez	s3,58e <vprintf+0x46>
      if(c0 == '%'){
 5aa:	fd579de3          	bne	a5,s5,584 <vprintf+0x3c>
        state = '%';
 5ae:	89be                	mv	s3,a5
 5b0:	b7cd                	j	592 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 5b2:	00ea06b3          	add	a3,s4,a4
 5b6:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 5ba:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 5bc:	c681                	beqz	a3,5c4 <vprintf+0x7c>
 5be:	9752                	add	a4,a4,s4
 5c0:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 5c4:	05878363          	beq	a5,s8,60a <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 5c8:	05978d63          	beq	a5,s9,622 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 5cc:	07500713          	li	a4,117
 5d0:	0ee78763          	beq	a5,a4,6be <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 5d4:	07800713          	li	a4,120
 5d8:	12e78963          	beq	a5,a4,70a <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 5dc:	07000713          	li	a4,112
 5e0:	14e78e63          	beq	a5,a4,73c <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 5e4:	06300713          	li	a4,99
 5e8:	18e78e63          	beq	a5,a4,784 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 5ec:	07300713          	li	a4,115
 5f0:	1ae78463          	beq	a5,a4,798 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 5f4:	02500713          	li	a4,37
 5f8:	04e79563          	bne	a5,a4,642 <vprintf+0xfa>
        putc(fd, '%');
 5fc:	02500593          	li	a1,37
 600:	855a                	mv	a0,s6
 602:	e8dff0ef          	jal	48e <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 606:	4981                	li	s3,0
 608:	b769                	j	592 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 60a:	008b8913          	addi	s2,s7,8
 60e:	4685                	li	a3,1
 610:	4629                	li	a2,10
 612:	000ba583          	lw	a1,0(s7)
 616:	855a                	mv	a0,s6
 618:	e95ff0ef          	jal	4ac <printint>
 61c:	8bca                	mv	s7,s2
      state = 0;
 61e:	4981                	li	s3,0
 620:	bf8d                	j	592 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 622:	06400793          	li	a5,100
 626:	02f68963          	beq	a3,a5,658 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 62a:	06c00793          	li	a5,108
 62e:	04f68263          	beq	a3,a5,672 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 632:	07500793          	li	a5,117
 636:	0af68063          	beq	a3,a5,6d6 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 63a:	07800793          	li	a5,120
 63e:	0ef68263          	beq	a3,a5,722 <vprintf+0x1da>
        putc(fd, '%');
 642:	02500593          	li	a1,37
 646:	855a                	mv	a0,s6
 648:	e47ff0ef          	jal	48e <putc>
        putc(fd, c0);
 64c:	85ca                	mv	a1,s2
 64e:	855a                	mv	a0,s6
 650:	e3fff0ef          	jal	48e <putc>
      state = 0;
 654:	4981                	li	s3,0
 656:	bf35                	j	592 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 658:	008b8913          	addi	s2,s7,8
 65c:	4685                	li	a3,1
 65e:	4629                	li	a2,10
 660:	000bb583          	ld	a1,0(s7)
 664:	855a                	mv	a0,s6
 666:	e47ff0ef          	jal	4ac <printint>
        i += 1;
 66a:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 66c:	8bca                	mv	s7,s2
      state = 0;
 66e:	4981                	li	s3,0
        i += 1;
 670:	b70d                	j	592 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 672:	06400793          	li	a5,100
 676:	02f60763          	beq	a2,a5,6a4 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 67a:	07500793          	li	a5,117
 67e:	06f60963          	beq	a2,a5,6f0 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 682:	07800793          	li	a5,120
 686:	faf61ee3          	bne	a2,a5,642 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 68a:	008b8913          	addi	s2,s7,8
 68e:	4681                	li	a3,0
 690:	4641                	li	a2,16
 692:	000bb583          	ld	a1,0(s7)
 696:	855a                	mv	a0,s6
 698:	e15ff0ef          	jal	4ac <printint>
        i += 2;
 69c:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 69e:	8bca                	mv	s7,s2
      state = 0;
 6a0:	4981                	li	s3,0
        i += 2;
 6a2:	bdc5                	j	592 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6a4:	008b8913          	addi	s2,s7,8
 6a8:	4685                	li	a3,1
 6aa:	4629                	li	a2,10
 6ac:	000bb583          	ld	a1,0(s7)
 6b0:	855a                	mv	a0,s6
 6b2:	dfbff0ef          	jal	4ac <printint>
        i += 2;
 6b6:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 6b8:	8bca                	mv	s7,s2
      state = 0;
 6ba:	4981                	li	s3,0
        i += 2;
 6bc:	bdd9                	j	592 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 6be:	008b8913          	addi	s2,s7,8
 6c2:	4681                	li	a3,0
 6c4:	4629                	li	a2,10
 6c6:	000be583          	lwu	a1,0(s7)
 6ca:	855a                	mv	a0,s6
 6cc:	de1ff0ef          	jal	4ac <printint>
 6d0:	8bca                	mv	s7,s2
      state = 0;
 6d2:	4981                	li	s3,0
 6d4:	bd7d                	j	592 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6d6:	008b8913          	addi	s2,s7,8
 6da:	4681                	li	a3,0
 6dc:	4629                	li	a2,10
 6de:	000bb583          	ld	a1,0(s7)
 6e2:	855a                	mv	a0,s6
 6e4:	dc9ff0ef          	jal	4ac <printint>
        i += 1;
 6e8:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 6ea:	8bca                	mv	s7,s2
      state = 0;
 6ec:	4981                	li	s3,0
        i += 1;
 6ee:	b555                	j	592 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6f0:	008b8913          	addi	s2,s7,8
 6f4:	4681                	li	a3,0
 6f6:	4629                	li	a2,10
 6f8:	000bb583          	ld	a1,0(s7)
 6fc:	855a                	mv	a0,s6
 6fe:	dafff0ef          	jal	4ac <printint>
        i += 2;
 702:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 704:	8bca                	mv	s7,s2
      state = 0;
 706:	4981                	li	s3,0
        i += 2;
 708:	b569                	j	592 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 70a:	008b8913          	addi	s2,s7,8
 70e:	4681                	li	a3,0
 710:	4641                	li	a2,16
 712:	000be583          	lwu	a1,0(s7)
 716:	855a                	mv	a0,s6
 718:	d95ff0ef          	jal	4ac <printint>
 71c:	8bca                	mv	s7,s2
      state = 0;
 71e:	4981                	li	s3,0
 720:	bd8d                	j	592 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 722:	008b8913          	addi	s2,s7,8
 726:	4681                	li	a3,0
 728:	4641                	li	a2,16
 72a:	000bb583          	ld	a1,0(s7)
 72e:	855a                	mv	a0,s6
 730:	d7dff0ef          	jal	4ac <printint>
        i += 1;
 734:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 736:	8bca                	mv	s7,s2
      state = 0;
 738:	4981                	li	s3,0
        i += 1;
 73a:	bda1                	j	592 <vprintf+0x4a>
 73c:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 73e:	008b8d13          	addi	s10,s7,8
 742:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 746:	03000593          	li	a1,48
 74a:	855a                	mv	a0,s6
 74c:	d43ff0ef          	jal	48e <putc>
  putc(fd, 'x');
 750:	07800593          	li	a1,120
 754:	855a                	mv	a0,s6
 756:	d39ff0ef          	jal	48e <putc>
 75a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 75c:	00000b97          	auipc	s7,0x0
 760:	2f4b8b93          	addi	s7,s7,756 # a50 <digits>
 764:	03c9d793          	srli	a5,s3,0x3c
 768:	97de                	add	a5,a5,s7
 76a:	0007c583          	lbu	a1,0(a5)
 76e:	855a                	mv	a0,s6
 770:	d1fff0ef          	jal	48e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 774:	0992                	slli	s3,s3,0x4
 776:	397d                	addiw	s2,s2,-1
 778:	fe0916e3          	bnez	s2,764 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 77c:	8bea                	mv	s7,s10
      state = 0;
 77e:	4981                	li	s3,0
 780:	6d02                	ld	s10,0(sp)
 782:	bd01                	j	592 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 784:	008b8913          	addi	s2,s7,8
 788:	000bc583          	lbu	a1,0(s7)
 78c:	855a                	mv	a0,s6
 78e:	d01ff0ef          	jal	48e <putc>
 792:	8bca                	mv	s7,s2
      state = 0;
 794:	4981                	li	s3,0
 796:	bbf5                	j	592 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 798:	008b8993          	addi	s3,s7,8
 79c:	000bb903          	ld	s2,0(s7)
 7a0:	00090f63          	beqz	s2,7be <vprintf+0x276>
        for(; *s; s++)
 7a4:	00094583          	lbu	a1,0(s2)
 7a8:	c195                	beqz	a1,7cc <vprintf+0x284>
          putc(fd, *s);
 7aa:	855a                	mv	a0,s6
 7ac:	ce3ff0ef          	jal	48e <putc>
        for(; *s; s++)
 7b0:	0905                	addi	s2,s2,1
 7b2:	00094583          	lbu	a1,0(s2)
 7b6:	f9f5                	bnez	a1,7aa <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 7b8:	8bce                	mv	s7,s3
      state = 0;
 7ba:	4981                	li	s3,0
 7bc:	bbd9                	j	592 <vprintf+0x4a>
          s = "(null)";
 7be:	00000917          	auipc	s2,0x0
 7c2:	28a90913          	addi	s2,s2,650 # a48 <malloc+0x17e>
        for(; *s; s++)
 7c6:	02800593          	li	a1,40
 7ca:	b7c5                	j	7aa <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 7cc:	8bce                	mv	s7,s3
      state = 0;
 7ce:	4981                	li	s3,0
 7d0:	b3c9                	j	592 <vprintf+0x4a>
 7d2:	64a6                	ld	s1,72(sp)
 7d4:	79e2                	ld	s3,56(sp)
 7d6:	7a42                	ld	s4,48(sp)
 7d8:	7aa2                	ld	s5,40(sp)
 7da:	7b02                	ld	s6,32(sp)
 7dc:	6be2                	ld	s7,24(sp)
 7de:	6c42                	ld	s8,16(sp)
 7e0:	6ca2                	ld	s9,8(sp)
    }
  }
}
 7e2:	60e6                	ld	ra,88(sp)
 7e4:	6446                	ld	s0,80(sp)
 7e6:	6906                	ld	s2,64(sp)
 7e8:	6125                	addi	sp,sp,96
 7ea:	8082                	ret

00000000000007ec <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7ec:	715d                	addi	sp,sp,-80
 7ee:	ec06                	sd	ra,24(sp)
 7f0:	e822                	sd	s0,16(sp)
 7f2:	1000                	addi	s0,sp,32
 7f4:	e010                	sd	a2,0(s0)
 7f6:	e414                	sd	a3,8(s0)
 7f8:	e818                	sd	a4,16(s0)
 7fa:	ec1c                	sd	a5,24(s0)
 7fc:	03043023          	sd	a6,32(s0)
 800:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 804:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 808:	8622                	mv	a2,s0
 80a:	d3fff0ef          	jal	548 <vprintf>
}
 80e:	60e2                	ld	ra,24(sp)
 810:	6442                	ld	s0,16(sp)
 812:	6161                	addi	sp,sp,80
 814:	8082                	ret

0000000000000816 <printf>:

void
printf(const char *fmt, ...)
{
 816:	711d                	addi	sp,sp,-96
 818:	ec06                	sd	ra,24(sp)
 81a:	e822                	sd	s0,16(sp)
 81c:	1000                	addi	s0,sp,32
 81e:	e40c                	sd	a1,8(s0)
 820:	e810                	sd	a2,16(s0)
 822:	ec14                	sd	a3,24(s0)
 824:	f018                	sd	a4,32(s0)
 826:	f41c                	sd	a5,40(s0)
 828:	03043823          	sd	a6,48(s0)
 82c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 830:	00840613          	addi	a2,s0,8
 834:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 838:	85aa                	mv	a1,a0
 83a:	4505                	li	a0,1
 83c:	d0dff0ef          	jal	548 <vprintf>
}
 840:	60e2                	ld	ra,24(sp)
 842:	6442                	ld	s0,16(sp)
 844:	6125                	addi	sp,sp,96
 846:	8082                	ret

0000000000000848 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 848:	1141                	addi	sp,sp,-16
 84a:	e422                	sd	s0,8(sp)
 84c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 84e:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 852:	00000797          	auipc	a5,0x0
 856:	7ae7b783          	ld	a5,1966(a5) # 1000 <freep>
 85a:	a02d                	j	884 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 85c:	4618                	lw	a4,8(a2)
 85e:	9f2d                	addw	a4,a4,a1
 860:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 864:	6398                	ld	a4,0(a5)
 866:	6310                	ld	a2,0(a4)
 868:	a83d                	j	8a6 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 86a:	ff852703          	lw	a4,-8(a0)
 86e:	9f31                	addw	a4,a4,a2
 870:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 872:	ff053683          	ld	a3,-16(a0)
 876:	a091                	j	8ba <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 878:	6398                	ld	a4,0(a5)
 87a:	00e7e463          	bltu	a5,a4,882 <free+0x3a>
 87e:	00e6ea63          	bltu	a3,a4,892 <free+0x4a>
{
 882:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 884:	fed7fae3          	bgeu	a5,a3,878 <free+0x30>
 888:	6398                	ld	a4,0(a5)
 88a:	00e6e463          	bltu	a3,a4,892 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 88e:	fee7eae3          	bltu	a5,a4,882 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 892:	ff852583          	lw	a1,-8(a0)
 896:	6390                	ld	a2,0(a5)
 898:	02059813          	slli	a6,a1,0x20
 89c:	01c85713          	srli	a4,a6,0x1c
 8a0:	9736                	add	a4,a4,a3
 8a2:	fae60de3          	beq	a2,a4,85c <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 8a6:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8aa:	4790                	lw	a2,8(a5)
 8ac:	02061593          	slli	a1,a2,0x20
 8b0:	01c5d713          	srli	a4,a1,0x1c
 8b4:	973e                	add	a4,a4,a5
 8b6:	fae68ae3          	beq	a3,a4,86a <free+0x22>
    p->s.ptr = bp->s.ptr;
 8ba:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 8bc:	00000717          	auipc	a4,0x0
 8c0:	74f73223          	sd	a5,1860(a4) # 1000 <freep>
}
 8c4:	6422                	ld	s0,8(sp)
 8c6:	0141                	addi	sp,sp,16
 8c8:	8082                	ret

00000000000008ca <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8ca:	7139                	addi	sp,sp,-64
 8cc:	fc06                	sd	ra,56(sp)
 8ce:	f822                	sd	s0,48(sp)
 8d0:	f426                	sd	s1,40(sp)
 8d2:	ec4e                	sd	s3,24(sp)
 8d4:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8d6:	02051493          	slli	s1,a0,0x20
 8da:	9081                	srli	s1,s1,0x20
 8dc:	04bd                	addi	s1,s1,15
 8de:	8091                	srli	s1,s1,0x4
 8e0:	0014899b          	addiw	s3,s1,1
 8e4:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 8e6:	00000517          	auipc	a0,0x0
 8ea:	71a53503          	ld	a0,1818(a0) # 1000 <freep>
 8ee:	c915                	beqz	a0,922 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8f0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8f2:	4798                	lw	a4,8(a5)
 8f4:	08977a63          	bgeu	a4,s1,988 <malloc+0xbe>
 8f8:	f04a                	sd	s2,32(sp)
 8fa:	e852                	sd	s4,16(sp)
 8fc:	e456                	sd	s5,8(sp)
 8fe:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 900:	8a4e                	mv	s4,s3
 902:	0009871b          	sext.w	a4,s3
 906:	6685                	lui	a3,0x1
 908:	00d77363          	bgeu	a4,a3,90e <malloc+0x44>
 90c:	6a05                	lui	s4,0x1
 90e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 912:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 916:	00000917          	auipc	s2,0x0
 91a:	6ea90913          	addi	s2,s2,1770 # 1000 <freep>
  if(p == SBRK_ERROR)
 91e:	5afd                	li	s5,-1
 920:	a081                	j	960 <malloc+0x96>
 922:	f04a                	sd	s2,32(sp)
 924:	e852                	sd	s4,16(sp)
 926:	e456                	sd	s5,8(sp)
 928:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 92a:	00001797          	auipc	a5,0x1
 92e:	8de78793          	addi	a5,a5,-1826 # 1208 <base>
 932:	00000717          	auipc	a4,0x0
 936:	6cf73723          	sd	a5,1742(a4) # 1000 <freep>
 93a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 93c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 940:	b7c1                	j	900 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 942:	6398                	ld	a4,0(a5)
 944:	e118                	sd	a4,0(a0)
 946:	a8a9                	j	9a0 <malloc+0xd6>
  hp->s.size = nu;
 948:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 94c:	0541                	addi	a0,a0,16
 94e:	efbff0ef          	jal	848 <free>
  return freep;
 952:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 956:	c12d                	beqz	a0,9b8 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 958:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 95a:	4798                	lw	a4,8(a5)
 95c:	02977263          	bgeu	a4,s1,980 <malloc+0xb6>
    if(p == freep)
 960:	00093703          	ld	a4,0(s2)
 964:	853e                	mv	a0,a5
 966:	fef719e3          	bne	a4,a5,958 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 96a:	8552                	mv	a0,s4
 96c:	97fff0ef          	jal	2ea <sbrk>
  if(p == SBRK_ERROR)
 970:	fd551ce3          	bne	a0,s5,948 <malloc+0x7e>
        return 0;
 974:	4501                	li	a0,0
 976:	7902                	ld	s2,32(sp)
 978:	6a42                	ld	s4,16(sp)
 97a:	6aa2                	ld	s5,8(sp)
 97c:	6b02                	ld	s6,0(sp)
 97e:	a03d                	j	9ac <malloc+0xe2>
 980:	7902                	ld	s2,32(sp)
 982:	6a42                	ld	s4,16(sp)
 984:	6aa2                	ld	s5,8(sp)
 986:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 988:	fae48de3          	beq	s1,a4,942 <malloc+0x78>
        p->s.size -= nunits;
 98c:	4137073b          	subw	a4,a4,s3
 990:	c798                	sw	a4,8(a5)
        p += p->s.size;
 992:	02071693          	slli	a3,a4,0x20
 996:	01c6d713          	srli	a4,a3,0x1c
 99a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 99c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9a0:	00000717          	auipc	a4,0x0
 9a4:	66a73023          	sd	a0,1632(a4) # 1000 <freep>
      return (void*)(p + 1);
 9a8:	01078513          	addi	a0,a5,16
  }
}
 9ac:	70e2                	ld	ra,56(sp)
 9ae:	7442                	ld	s0,48(sp)
 9b0:	74a2                	ld	s1,40(sp)
 9b2:	69e2                	ld	s3,24(sp)
 9b4:	6121                	addi	sp,sp,64
 9b6:	8082                	ret
 9b8:	7902                	ld	s2,32(sp)
 9ba:	6a42                	ld	s4,16(sp)
 9bc:	6aa2                	ld	s5,8(sp)
 9be:	6b02                	ld	s6,0(sp)
 9c0:	b7f5                	j	9ac <malloc+0xe2>
