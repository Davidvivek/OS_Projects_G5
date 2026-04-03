
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
  10:	9b450513          	addi	a0,a0,-1612 # 9c0 <malloc+0xfe>
  14:	402000ef          	jal	416 <mkdir>
  18:	c919                	beqz	a0,2e <main+0x2e>
    printf("%s: mkdir dd failed\n", s);
  1a:	85a6                	mv	a1,s1
  1c:	00001517          	auipc	a0,0x1
  20:	9ac50513          	addi	a0,a0,-1620 # 9c8 <malloc+0x106>
  24:	7ea000ef          	jal	80e <printf>
    exit(1);
  28:	4505                	li	a0,1
  2a:	384000ef          	jal	3ae <exit>
  }

  if(chdir("dd") != 0){
  2e:	00001517          	auipc	a0,0x1
  32:	99250513          	addi	a0,a0,-1646 # 9c0 <malloc+0xfe>
  36:	3e8000ef          	jal	41e <chdir>
  3a:	c919                	beqz	a0,50 <main+0x50>
    printf("%s: chdir dd failed\n", s);
  3c:	85a6                	mv	a1,s1
  3e:	00001517          	auipc	a0,0x1
  42:	9a250513          	addi	a0,a0,-1630 # 9e0 <malloc+0x11e>
  46:	7c8000ef          	jal	80e <printf>
    exit(1);
  4a:	4505                	li	a0,1
  4c:	362000ef          	jal	3ae <exit>
  }

  if (unlink("../dd") < 0) {
  50:	00001517          	auipc	a0,0x1
  54:	9a850513          	addi	a0,a0,-1624 # 9f8 <malloc+0x136>
  58:	3a6000ef          	jal	3fe <unlink>
  5c:	00054d63          	bltz	a0,76 <main+0x76>
    printf("%s: unlink failed\n", s);
    exit(1);
  }
  printf("wait for kill and reclaim\n");
  60:	00001517          	auipc	a0,0x1
  64:	9b850513          	addi	a0,a0,-1608 # a18 <malloc+0x156>
  68:	7a6000ef          	jal	80e <printf>
  // sit around until killed
  for(;;) pause(1000);
  6c:	3e800513          	li	a0,1000
  70:	3ce000ef          	jal	43e <pause>
  74:	bfe5                	j	6c <main+0x6c>
    printf("%s: unlink failed\n", s);
  76:	85a6                	mv	a1,s1
  78:	00001517          	auipc	a0,0x1
  7c:	98850513          	addi	a0,a0,-1656 # a00 <malloc+0x13e>
  80:	78e000ef          	jal	80e <printf>
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
 32c:	596000ef          	jal	8c2 <malloc>
  if(s == 0)
 330:	cd0d                	beqz	a0,36a <thread_create+0x54>
 332:	ec26                	sd	s1,24(sp)
 334:	84aa                	mv	s1,a0
    return -1;
  *stack = s;
 336:	00a93023          	sd	a0,0(s2)
  // Stack grows downward: pass the top of the allocated region.
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
 35c:	4e4000ef          	jal	840 <free>
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
// Returns the joined thread's pid, or -1 on error.
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
 38c:	4b4000ef          	jal	840 <free>
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

0000000000000486 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 486:	1101                	addi	sp,sp,-32
 488:	ec06                	sd	ra,24(sp)
 48a:	e822                	sd	s0,16(sp)
 48c:	1000                	addi	s0,sp,32
 48e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 492:	4605                	li	a2,1
 494:	fef40593          	addi	a1,s0,-17
 498:	f37ff0ef          	jal	3ce <write>
}
 49c:	60e2                	ld	ra,24(sp)
 49e:	6442                	ld	s0,16(sp)
 4a0:	6105                	addi	sp,sp,32
 4a2:	8082                	ret

00000000000004a4 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 4a4:	715d                	addi	sp,sp,-80
 4a6:	e486                	sd	ra,72(sp)
 4a8:	e0a2                	sd	s0,64(sp)
 4aa:	f84a                	sd	s2,48(sp)
 4ac:	0880                	addi	s0,sp,80
 4ae:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 4b0:	c299                	beqz	a3,4b6 <printint+0x12>
 4b2:	0805c363          	bltz	a1,538 <printint+0x94>
  neg = 0;
 4b6:	4881                	li	a7,0
 4b8:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 4bc:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 4be:	00000517          	auipc	a0,0x0
 4c2:	58250513          	addi	a0,a0,1410 # a40 <digits>
 4c6:	883e                	mv	a6,a5
 4c8:	2785                	addiw	a5,a5,1
 4ca:	02c5f733          	remu	a4,a1,a2
 4ce:	972a                	add	a4,a4,a0
 4d0:	00074703          	lbu	a4,0(a4)
 4d4:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 4d8:	872e                	mv	a4,a1
 4da:	02c5d5b3          	divu	a1,a1,a2
 4de:	0685                	addi	a3,a3,1
 4e0:	fec773e3          	bgeu	a4,a2,4c6 <printint+0x22>
  if(neg)
 4e4:	00088b63          	beqz	a7,4fa <printint+0x56>
    buf[i++] = '-';
 4e8:	fd078793          	addi	a5,a5,-48
 4ec:	97a2                	add	a5,a5,s0
 4ee:	02d00713          	li	a4,45
 4f2:	fee78423          	sb	a4,-24(a5)
 4f6:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 4fa:	02f05a63          	blez	a5,52e <printint+0x8a>
 4fe:	fc26                	sd	s1,56(sp)
 500:	f44e                	sd	s3,40(sp)
 502:	fb840713          	addi	a4,s0,-72
 506:	00f704b3          	add	s1,a4,a5
 50a:	fff70993          	addi	s3,a4,-1
 50e:	99be                	add	s3,s3,a5
 510:	37fd                	addiw	a5,a5,-1
 512:	1782                	slli	a5,a5,0x20
 514:	9381                	srli	a5,a5,0x20
 516:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 51a:	fff4c583          	lbu	a1,-1(s1)
 51e:	854a                	mv	a0,s2
 520:	f67ff0ef          	jal	486 <putc>
  while(--i >= 0)
 524:	14fd                	addi	s1,s1,-1
 526:	ff349ae3          	bne	s1,s3,51a <printint+0x76>
 52a:	74e2                	ld	s1,56(sp)
 52c:	79a2                	ld	s3,40(sp)
}
 52e:	60a6                	ld	ra,72(sp)
 530:	6406                	ld	s0,64(sp)
 532:	7942                	ld	s2,48(sp)
 534:	6161                	addi	sp,sp,80
 536:	8082                	ret
    x = -xx;
 538:	40b005b3          	neg	a1,a1
    neg = 1;
 53c:	4885                	li	a7,1
    x = -xx;
 53e:	bfad                	j	4b8 <printint+0x14>

0000000000000540 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 540:	711d                	addi	sp,sp,-96
 542:	ec86                	sd	ra,88(sp)
 544:	e8a2                	sd	s0,80(sp)
 546:	e0ca                	sd	s2,64(sp)
 548:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 54a:	0005c903          	lbu	s2,0(a1)
 54e:	28090663          	beqz	s2,7da <vprintf+0x29a>
 552:	e4a6                	sd	s1,72(sp)
 554:	fc4e                	sd	s3,56(sp)
 556:	f852                	sd	s4,48(sp)
 558:	f456                	sd	s5,40(sp)
 55a:	f05a                	sd	s6,32(sp)
 55c:	ec5e                	sd	s7,24(sp)
 55e:	e862                	sd	s8,16(sp)
 560:	e466                	sd	s9,8(sp)
 562:	8b2a                	mv	s6,a0
 564:	8a2e                	mv	s4,a1
 566:	8bb2                	mv	s7,a2
  state = 0;
 568:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 56a:	4481                	li	s1,0
 56c:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 56e:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 572:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 576:	06c00c93          	li	s9,108
 57a:	a005                	j	59a <vprintf+0x5a>
        putc(fd, c0);
 57c:	85ca                	mv	a1,s2
 57e:	855a                	mv	a0,s6
 580:	f07ff0ef          	jal	486 <putc>
 584:	a019                	j	58a <vprintf+0x4a>
    } else if(state == '%'){
 586:	03598263          	beq	s3,s5,5aa <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 58a:	2485                	addiw	s1,s1,1
 58c:	8726                	mv	a4,s1
 58e:	009a07b3          	add	a5,s4,s1
 592:	0007c903          	lbu	s2,0(a5)
 596:	22090a63          	beqz	s2,7ca <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 59a:	0009079b          	sext.w	a5,s2
    if(state == 0){
 59e:	fe0994e3          	bnez	s3,586 <vprintf+0x46>
      if(c0 == '%'){
 5a2:	fd579de3          	bne	a5,s5,57c <vprintf+0x3c>
        state = '%';
 5a6:	89be                	mv	s3,a5
 5a8:	b7cd                	j	58a <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 5aa:	00ea06b3          	add	a3,s4,a4
 5ae:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 5b2:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 5b4:	c681                	beqz	a3,5bc <vprintf+0x7c>
 5b6:	9752                	add	a4,a4,s4
 5b8:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 5bc:	05878363          	beq	a5,s8,602 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 5c0:	05978d63          	beq	a5,s9,61a <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 5c4:	07500713          	li	a4,117
 5c8:	0ee78763          	beq	a5,a4,6b6 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 5cc:	07800713          	li	a4,120
 5d0:	12e78963          	beq	a5,a4,702 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 5d4:	07000713          	li	a4,112
 5d8:	14e78e63          	beq	a5,a4,734 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 5dc:	06300713          	li	a4,99
 5e0:	18e78e63          	beq	a5,a4,77c <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 5e4:	07300713          	li	a4,115
 5e8:	1ae78463          	beq	a5,a4,790 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 5ec:	02500713          	li	a4,37
 5f0:	04e79563          	bne	a5,a4,63a <vprintf+0xfa>
        putc(fd, '%');
 5f4:	02500593          	li	a1,37
 5f8:	855a                	mv	a0,s6
 5fa:	e8dff0ef          	jal	486 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 5fe:	4981                	li	s3,0
 600:	b769                	j	58a <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 602:	008b8913          	addi	s2,s7,8
 606:	4685                	li	a3,1
 608:	4629                	li	a2,10
 60a:	000ba583          	lw	a1,0(s7)
 60e:	855a                	mv	a0,s6
 610:	e95ff0ef          	jal	4a4 <printint>
 614:	8bca                	mv	s7,s2
      state = 0;
 616:	4981                	li	s3,0
 618:	bf8d                	j	58a <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 61a:	06400793          	li	a5,100
 61e:	02f68963          	beq	a3,a5,650 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 622:	06c00793          	li	a5,108
 626:	04f68263          	beq	a3,a5,66a <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 62a:	07500793          	li	a5,117
 62e:	0af68063          	beq	a3,a5,6ce <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 632:	07800793          	li	a5,120
 636:	0ef68263          	beq	a3,a5,71a <vprintf+0x1da>
        putc(fd, '%');
 63a:	02500593          	li	a1,37
 63e:	855a                	mv	a0,s6
 640:	e47ff0ef          	jal	486 <putc>
        putc(fd, c0);
 644:	85ca                	mv	a1,s2
 646:	855a                	mv	a0,s6
 648:	e3fff0ef          	jal	486 <putc>
      state = 0;
 64c:	4981                	li	s3,0
 64e:	bf35                	j	58a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 650:	008b8913          	addi	s2,s7,8
 654:	4685                	li	a3,1
 656:	4629                	li	a2,10
 658:	000bb583          	ld	a1,0(s7)
 65c:	855a                	mv	a0,s6
 65e:	e47ff0ef          	jal	4a4 <printint>
        i += 1;
 662:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 664:	8bca                	mv	s7,s2
      state = 0;
 666:	4981                	li	s3,0
        i += 1;
 668:	b70d                	j	58a <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 66a:	06400793          	li	a5,100
 66e:	02f60763          	beq	a2,a5,69c <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 672:	07500793          	li	a5,117
 676:	06f60963          	beq	a2,a5,6e8 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 67a:	07800793          	li	a5,120
 67e:	faf61ee3          	bne	a2,a5,63a <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 682:	008b8913          	addi	s2,s7,8
 686:	4681                	li	a3,0
 688:	4641                	li	a2,16
 68a:	000bb583          	ld	a1,0(s7)
 68e:	855a                	mv	a0,s6
 690:	e15ff0ef          	jal	4a4 <printint>
        i += 2;
 694:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 696:	8bca                	mv	s7,s2
      state = 0;
 698:	4981                	li	s3,0
        i += 2;
 69a:	bdc5                	j	58a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 69c:	008b8913          	addi	s2,s7,8
 6a0:	4685                	li	a3,1
 6a2:	4629                	li	a2,10
 6a4:	000bb583          	ld	a1,0(s7)
 6a8:	855a                	mv	a0,s6
 6aa:	dfbff0ef          	jal	4a4 <printint>
        i += 2;
 6ae:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 6b0:	8bca                	mv	s7,s2
      state = 0;
 6b2:	4981                	li	s3,0
        i += 2;
 6b4:	bdd9                	j	58a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 6b6:	008b8913          	addi	s2,s7,8
 6ba:	4681                	li	a3,0
 6bc:	4629                	li	a2,10
 6be:	000be583          	lwu	a1,0(s7)
 6c2:	855a                	mv	a0,s6
 6c4:	de1ff0ef          	jal	4a4 <printint>
 6c8:	8bca                	mv	s7,s2
      state = 0;
 6ca:	4981                	li	s3,0
 6cc:	bd7d                	j	58a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6ce:	008b8913          	addi	s2,s7,8
 6d2:	4681                	li	a3,0
 6d4:	4629                	li	a2,10
 6d6:	000bb583          	ld	a1,0(s7)
 6da:	855a                	mv	a0,s6
 6dc:	dc9ff0ef          	jal	4a4 <printint>
        i += 1;
 6e0:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 6e2:	8bca                	mv	s7,s2
      state = 0;
 6e4:	4981                	li	s3,0
        i += 1;
 6e6:	b555                	j	58a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6e8:	008b8913          	addi	s2,s7,8
 6ec:	4681                	li	a3,0
 6ee:	4629                	li	a2,10
 6f0:	000bb583          	ld	a1,0(s7)
 6f4:	855a                	mv	a0,s6
 6f6:	dafff0ef          	jal	4a4 <printint>
        i += 2;
 6fa:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 6fc:	8bca                	mv	s7,s2
      state = 0;
 6fe:	4981                	li	s3,0
        i += 2;
 700:	b569                	j	58a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 702:	008b8913          	addi	s2,s7,8
 706:	4681                	li	a3,0
 708:	4641                	li	a2,16
 70a:	000be583          	lwu	a1,0(s7)
 70e:	855a                	mv	a0,s6
 710:	d95ff0ef          	jal	4a4 <printint>
 714:	8bca                	mv	s7,s2
      state = 0;
 716:	4981                	li	s3,0
 718:	bd8d                	j	58a <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 71a:	008b8913          	addi	s2,s7,8
 71e:	4681                	li	a3,0
 720:	4641                	li	a2,16
 722:	000bb583          	ld	a1,0(s7)
 726:	855a                	mv	a0,s6
 728:	d7dff0ef          	jal	4a4 <printint>
        i += 1;
 72c:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 72e:	8bca                	mv	s7,s2
      state = 0;
 730:	4981                	li	s3,0
        i += 1;
 732:	bda1                	j	58a <vprintf+0x4a>
 734:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 736:	008b8d13          	addi	s10,s7,8
 73a:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 73e:	03000593          	li	a1,48
 742:	855a                	mv	a0,s6
 744:	d43ff0ef          	jal	486 <putc>
  putc(fd, 'x');
 748:	07800593          	li	a1,120
 74c:	855a                	mv	a0,s6
 74e:	d39ff0ef          	jal	486 <putc>
 752:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 754:	00000b97          	auipc	s7,0x0
 758:	2ecb8b93          	addi	s7,s7,748 # a40 <digits>
 75c:	03c9d793          	srli	a5,s3,0x3c
 760:	97de                	add	a5,a5,s7
 762:	0007c583          	lbu	a1,0(a5)
 766:	855a                	mv	a0,s6
 768:	d1fff0ef          	jal	486 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 76c:	0992                	slli	s3,s3,0x4
 76e:	397d                	addiw	s2,s2,-1
 770:	fe0916e3          	bnez	s2,75c <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 774:	8bea                	mv	s7,s10
      state = 0;
 776:	4981                	li	s3,0
 778:	6d02                	ld	s10,0(sp)
 77a:	bd01                	j	58a <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 77c:	008b8913          	addi	s2,s7,8
 780:	000bc583          	lbu	a1,0(s7)
 784:	855a                	mv	a0,s6
 786:	d01ff0ef          	jal	486 <putc>
 78a:	8bca                	mv	s7,s2
      state = 0;
 78c:	4981                	li	s3,0
 78e:	bbf5                	j	58a <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 790:	008b8993          	addi	s3,s7,8
 794:	000bb903          	ld	s2,0(s7)
 798:	00090f63          	beqz	s2,7b6 <vprintf+0x276>
        for(; *s; s++)
 79c:	00094583          	lbu	a1,0(s2)
 7a0:	c195                	beqz	a1,7c4 <vprintf+0x284>
          putc(fd, *s);
 7a2:	855a                	mv	a0,s6
 7a4:	ce3ff0ef          	jal	486 <putc>
        for(; *s; s++)
 7a8:	0905                	addi	s2,s2,1
 7aa:	00094583          	lbu	a1,0(s2)
 7ae:	f9f5                	bnez	a1,7a2 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 7b0:	8bce                	mv	s7,s3
      state = 0;
 7b2:	4981                	li	s3,0
 7b4:	bbd9                	j	58a <vprintf+0x4a>
          s = "(null)";
 7b6:	00000917          	auipc	s2,0x0
 7ba:	28290913          	addi	s2,s2,642 # a38 <malloc+0x176>
        for(; *s; s++)
 7be:	02800593          	li	a1,40
 7c2:	b7c5                	j	7a2 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 7c4:	8bce                	mv	s7,s3
      state = 0;
 7c6:	4981                	li	s3,0
 7c8:	b3c9                	j	58a <vprintf+0x4a>
 7ca:	64a6                	ld	s1,72(sp)
 7cc:	79e2                	ld	s3,56(sp)
 7ce:	7a42                	ld	s4,48(sp)
 7d0:	7aa2                	ld	s5,40(sp)
 7d2:	7b02                	ld	s6,32(sp)
 7d4:	6be2                	ld	s7,24(sp)
 7d6:	6c42                	ld	s8,16(sp)
 7d8:	6ca2                	ld	s9,8(sp)
    }
  }
}
 7da:	60e6                	ld	ra,88(sp)
 7dc:	6446                	ld	s0,80(sp)
 7de:	6906                	ld	s2,64(sp)
 7e0:	6125                	addi	sp,sp,96
 7e2:	8082                	ret

00000000000007e4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7e4:	715d                	addi	sp,sp,-80
 7e6:	ec06                	sd	ra,24(sp)
 7e8:	e822                	sd	s0,16(sp)
 7ea:	1000                	addi	s0,sp,32
 7ec:	e010                	sd	a2,0(s0)
 7ee:	e414                	sd	a3,8(s0)
 7f0:	e818                	sd	a4,16(s0)
 7f2:	ec1c                	sd	a5,24(s0)
 7f4:	03043023          	sd	a6,32(s0)
 7f8:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7fc:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 800:	8622                	mv	a2,s0
 802:	d3fff0ef          	jal	540 <vprintf>
}
 806:	60e2                	ld	ra,24(sp)
 808:	6442                	ld	s0,16(sp)
 80a:	6161                	addi	sp,sp,80
 80c:	8082                	ret

000000000000080e <printf>:

void
printf(const char *fmt, ...)
{
 80e:	711d                	addi	sp,sp,-96
 810:	ec06                	sd	ra,24(sp)
 812:	e822                	sd	s0,16(sp)
 814:	1000                	addi	s0,sp,32
 816:	e40c                	sd	a1,8(s0)
 818:	e810                	sd	a2,16(s0)
 81a:	ec14                	sd	a3,24(s0)
 81c:	f018                	sd	a4,32(s0)
 81e:	f41c                	sd	a5,40(s0)
 820:	03043823          	sd	a6,48(s0)
 824:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 828:	00840613          	addi	a2,s0,8
 82c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 830:	85aa                	mv	a1,a0
 832:	4505                	li	a0,1
 834:	d0dff0ef          	jal	540 <vprintf>
}
 838:	60e2                	ld	ra,24(sp)
 83a:	6442                	ld	s0,16(sp)
 83c:	6125                	addi	sp,sp,96
 83e:	8082                	ret

0000000000000840 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 840:	1141                	addi	sp,sp,-16
 842:	e422                	sd	s0,8(sp)
 844:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 846:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 84a:	00000797          	auipc	a5,0x0
 84e:	7b67b783          	ld	a5,1974(a5) # 1000 <freep>
 852:	a02d                	j	87c <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 854:	4618                	lw	a4,8(a2)
 856:	9f2d                	addw	a4,a4,a1
 858:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 85c:	6398                	ld	a4,0(a5)
 85e:	6310                	ld	a2,0(a4)
 860:	a83d                	j	89e <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 862:	ff852703          	lw	a4,-8(a0)
 866:	9f31                	addw	a4,a4,a2
 868:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 86a:	ff053683          	ld	a3,-16(a0)
 86e:	a091                	j	8b2 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 870:	6398                	ld	a4,0(a5)
 872:	00e7e463          	bltu	a5,a4,87a <free+0x3a>
 876:	00e6ea63          	bltu	a3,a4,88a <free+0x4a>
{
 87a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 87c:	fed7fae3          	bgeu	a5,a3,870 <free+0x30>
 880:	6398                	ld	a4,0(a5)
 882:	00e6e463          	bltu	a3,a4,88a <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 886:	fee7eae3          	bltu	a5,a4,87a <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 88a:	ff852583          	lw	a1,-8(a0)
 88e:	6390                	ld	a2,0(a5)
 890:	02059813          	slli	a6,a1,0x20
 894:	01c85713          	srli	a4,a6,0x1c
 898:	9736                	add	a4,a4,a3
 89a:	fae60de3          	beq	a2,a4,854 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 89e:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8a2:	4790                	lw	a2,8(a5)
 8a4:	02061593          	slli	a1,a2,0x20
 8a8:	01c5d713          	srli	a4,a1,0x1c
 8ac:	973e                	add	a4,a4,a5
 8ae:	fae68ae3          	beq	a3,a4,862 <free+0x22>
    p->s.ptr = bp->s.ptr;
 8b2:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 8b4:	00000717          	auipc	a4,0x0
 8b8:	74f73623          	sd	a5,1868(a4) # 1000 <freep>
}
 8bc:	6422                	ld	s0,8(sp)
 8be:	0141                	addi	sp,sp,16
 8c0:	8082                	ret

00000000000008c2 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8c2:	7139                	addi	sp,sp,-64
 8c4:	fc06                	sd	ra,56(sp)
 8c6:	f822                	sd	s0,48(sp)
 8c8:	f426                	sd	s1,40(sp)
 8ca:	ec4e                	sd	s3,24(sp)
 8cc:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8ce:	02051493          	slli	s1,a0,0x20
 8d2:	9081                	srli	s1,s1,0x20
 8d4:	04bd                	addi	s1,s1,15
 8d6:	8091                	srli	s1,s1,0x4
 8d8:	0014899b          	addiw	s3,s1,1
 8dc:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 8de:	00000517          	auipc	a0,0x0
 8e2:	72253503          	ld	a0,1826(a0) # 1000 <freep>
 8e6:	c915                	beqz	a0,91a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8e8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8ea:	4798                	lw	a4,8(a5)
 8ec:	08977a63          	bgeu	a4,s1,980 <malloc+0xbe>
 8f0:	f04a                	sd	s2,32(sp)
 8f2:	e852                	sd	s4,16(sp)
 8f4:	e456                	sd	s5,8(sp)
 8f6:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 8f8:	8a4e                	mv	s4,s3
 8fa:	0009871b          	sext.w	a4,s3
 8fe:	6685                	lui	a3,0x1
 900:	00d77363          	bgeu	a4,a3,906 <malloc+0x44>
 904:	6a05                	lui	s4,0x1
 906:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 90a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 90e:	00000917          	auipc	s2,0x0
 912:	6f290913          	addi	s2,s2,1778 # 1000 <freep>
  if(p == SBRK_ERROR)
 916:	5afd                	li	s5,-1
 918:	a081                	j	958 <malloc+0x96>
 91a:	f04a                	sd	s2,32(sp)
 91c:	e852                	sd	s4,16(sp)
 91e:	e456                	sd	s5,8(sp)
 920:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 922:	00001797          	auipc	a5,0x1
 926:	8e678793          	addi	a5,a5,-1818 # 1208 <base>
 92a:	00000717          	auipc	a4,0x0
 92e:	6cf73b23          	sd	a5,1750(a4) # 1000 <freep>
 932:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 934:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 938:	b7c1                	j	8f8 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 93a:	6398                	ld	a4,0(a5)
 93c:	e118                	sd	a4,0(a0)
 93e:	a8a9                	j	998 <malloc+0xd6>
  hp->s.size = nu;
 940:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 944:	0541                	addi	a0,a0,16
 946:	efbff0ef          	jal	840 <free>
  return freep;
 94a:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 94e:	c12d                	beqz	a0,9b0 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 950:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 952:	4798                	lw	a4,8(a5)
 954:	02977263          	bgeu	a4,s1,978 <malloc+0xb6>
    if(p == freep)
 958:	00093703          	ld	a4,0(s2)
 95c:	853e                	mv	a0,a5
 95e:	fef719e3          	bne	a4,a5,950 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 962:	8552                	mv	a0,s4
 964:	987ff0ef          	jal	2ea <sbrk>
  if(p == SBRK_ERROR)
 968:	fd551ce3          	bne	a0,s5,940 <malloc+0x7e>
        return 0;
 96c:	4501                	li	a0,0
 96e:	7902                	ld	s2,32(sp)
 970:	6a42                	ld	s4,16(sp)
 972:	6aa2                	ld	s5,8(sp)
 974:	6b02                	ld	s6,0(sp)
 976:	a03d                	j	9a4 <malloc+0xe2>
 978:	7902                	ld	s2,32(sp)
 97a:	6a42                	ld	s4,16(sp)
 97c:	6aa2                	ld	s5,8(sp)
 97e:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 980:	fae48de3          	beq	s1,a4,93a <malloc+0x78>
        p->s.size -= nunits;
 984:	4137073b          	subw	a4,a4,s3
 988:	c798                	sw	a4,8(a5)
        p += p->s.size;
 98a:	02071693          	slli	a3,a4,0x20
 98e:	01c6d713          	srli	a4,a3,0x1c
 992:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 994:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 998:	00000717          	auipc	a4,0x0
 99c:	66a73423          	sd	a0,1640(a4) # 1000 <freep>
      return (void*)(p + 1);
 9a0:	01078513          	addi	a0,a5,16
  }
}
 9a4:	70e2                	ld	ra,56(sp)
 9a6:	7442                	ld	s0,48(sp)
 9a8:	74a2                	ld	s1,40(sp)
 9aa:	69e2                	ld	s3,24(sp)
 9ac:	6121                	addi	sp,sp,64
 9ae:	8082                	ret
 9b0:	7902                	ld	s2,32(sp)
 9b2:	6a42                	ld	s4,16(sp)
 9b4:	6aa2                	ld	s5,8(sp)
 9b6:	6b02                	ld	s6,0(sp)
 9b8:	b7f5                	j	9a4 <malloc+0xe2>
