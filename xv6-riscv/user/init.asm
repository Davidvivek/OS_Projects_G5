
user/_init:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   c:	4589                	li	a1,2
   e:	00001517          	auipc	a0,0x1
  12:	9f250513          	addi	a0,a0,-1550 # a00 <malloc+0x104>
  16:	40a000ef          	jal	420 <open>
  1a:	04054563          	bltz	a0,64 <main+0x64>
    mknod("console", CONSOLE, 0);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  1e:	4501                	li	a0,0
  20:	438000ef          	jal	458 <dup>
  dup(0);  // stderr
  24:	4501                	li	a0,0
  26:	432000ef          	jal	458 <dup>

  for(;;){
    printf("init: starting sh\n");
  2a:	00001917          	auipc	s2,0x1
  2e:	9de90913          	addi	s2,s2,-1570 # a08 <malloc+0x10c>
  32:	854a                	mv	a0,s2
  34:	015000ef          	jal	848 <printf>
    pid = fork();
  38:	3a0000ef          	jal	3d8 <fork>
  3c:	84aa                	mv	s1,a0
    if(pid < 0){
  3e:	04054363          	bltz	a0,84 <main+0x84>
      printf("init: fork failed\n");
      exit(1);
    }
    if(pid == 0){
  42:	c931                	beqz	a0,96 <main+0x96>
    }

    for(;;){
      // this call to wait() returns if the shell exits,
      // or if a parentless process exits.
      wpid = wait((int *) 0);
  44:	4501                	li	a0,0
  46:	3a2000ef          	jal	3e8 <wait>
      if(wpid == pid){
  4a:	fea484e3          	beq	s1,a0,32 <main+0x32>
        // the shell exited; restart it.
        break;
      } else if(wpid < 0){
  4e:	fe055be3          	bgez	a0,44 <main+0x44>
        printf("init: wait returned an error\n");
  52:	00001517          	auipc	a0,0x1
  56:	a0650513          	addi	a0,a0,-1530 # a58 <malloc+0x15c>
  5a:	7ee000ef          	jal	848 <printf>
        exit(1);
  5e:	4505                	li	a0,1
  60:	380000ef          	jal	3e0 <exit>
    mknod("console", CONSOLE, 0);
  64:	4601                	li	a2,0
  66:	4585                	li	a1,1
  68:	00001517          	auipc	a0,0x1
  6c:	99850513          	addi	a0,a0,-1640 # a00 <malloc+0x104>
  70:	3b8000ef          	jal	428 <mknod>
    open("console", O_RDWR);
  74:	4589                	li	a1,2
  76:	00001517          	auipc	a0,0x1
  7a:	98a50513          	addi	a0,a0,-1654 # a00 <malloc+0x104>
  7e:	3a2000ef          	jal	420 <open>
  82:	bf71                	j	1e <main+0x1e>
      printf("init: fork failed\n");
  84:	00001517          	auipc	a0,0x1
  88:	99c50513          	addi	a0,a0,-1636 # a20 <malloc+0x124>
  8c:	7bc000ef          	jal	848 <printf>
      exit(1);
  90:	4505                	li	a0,1
  92:	34e000ef          	jal	3e0 <exit>
      exec("sh", argv);
  96:	00001597          	auipc	a1,0x1
  9a:	f6a58593          	addi	a1,a1,-150 # 1000 <argv>
  9e:	00001517          	auipc	a0,0x1
  a2:	99a50513          	addi	a0,a0,-1638 # a38 <malloc+0x13c>
  a6:	372000ef          	jal	418 <exec>
      printf("init: exec sh failed\n");
  aa:	00001517          	auipc	a0,0x1
  ae:	99650513          	addi	a0,a0,-1642 # a40 <malloc+0x144>
  b2:	796000ef          	jal	848 <printf>
      exit(1);
  b6:	4505                	li	a0,1
  b8:	328000ef          	jal	3e0 <exit>

00000000000000bc <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  bc:	1141                	addi	sp,sp,-16
  be:	e406                	sd	ra,8(sp)
  c0:	e022                	sd	s0,0(sp)
  c2:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  c4:	f3dff0ef          	jal	0 <main>
  exit(r);
  c8:	318000ef          	jal	3e0 <exit>

00000000000000cc <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  cc:	1141                	addi	sp,sp,-16
  ce:	e422                	sd	s0,8(sp)
  d0:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  d2:	87aa                	mv	a5,a0
  d4:	0585                	addi	a1,a1,1
  d6:	0785                	addi	a5,a5,1
  d8:	fff5c703          	lbu	a4,-1(a1)
  dc:	fee78fa3          	sb	a4,-1(a5)
  e0:	fb75                	bnez	a4,d4 <strcpy+0x8>
    ;
  return os;
}
  e2:	6422                	ld	s0,8(sp)
  e4:	0141                	addi	sp,sp,16
  e6:	8082                	ret

00000000000000e8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  e8:	1141                	addi	sp,sp,-16
  ea:	e422                	sd	s0,8(sp)
  ec:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  ee:	00054783          	lbu	a5,0(a0)
  f2:	cb91                	beqz	a5,106 <strcmp+0x1e>
  f4:	0005c703          	lbu	a4,0(a1)
  f8:	00f71763          	bne	a4,a5,106 <strcmp+0x1e>
    p++, q++;
  fc:	0505                	addi	a0,a0,1
  fe:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 100:	00054783          	lbu	a5,0(a0)
 104:	fbe5                	bnez	a5,f4 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 106:	0005c503          	lbu	a0,0(a1)
}
 10a:	40a7853b          	subw	a0,a5,a0
 10e:	6422                	ld	s0,8(sp)
 110:	0141                	addi	sp,sp,16
 112:	8082                	ret

0000000000000114 <strlen>:

uint
strlen(const char *s)
{
 114:	1141                	addi	sp,sp,-16
 116:	e422                	sd	s0,8(sp)
 118:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 11a:	00054783          	lbu	a5,0(a0)
 11e:	cf91                	beqz	a5,13a <strlen+0x26>
 120:	0505                	addi	a0,a0,1
 122:	87aa                	mv	a5,a0
 124:	86be                	mv	a3,a5
 126:	0785                	addi	a5,a5,1
 128:	fff7c703          	lbu	a4,-1(a5)
 12c:	ff65                	bnez	a4,124 <strlen+0x10>
 12e:	40a6853b          	subw	a0,a3,a0
 132:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 134:	6422                	ld	s0,8(sp)
 136:	0141                	addi	sp,sp,16
 138:	8082                	ret
  for(n = 0; s[n]; n++)
 13a:	4501                	li	a0,0
 13c:	bfe5                	j	134 <strlen+0x20>

000000000000013e <memset>:

void*
memset(void *dst, int c, uint n)
{
 13e:	1141                	addi	sp,sp,-16
 140:	e422                	sd	s0,8(sp)
 142:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 144:	ca19                	beqz	a2,15a <memset+0x1c>
 146:	87aa                	mv	a5,a0
 148:	1602                	slli	a2,a2,0x20
 14a:	9201                	srli	a2,a2,0x20
 14c:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 150:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 154:	0785                	addi	a5,a5,1
 156:	fee79de3          	bne	a5,a4,150 <memset+0x12>
  }
  return dst;
}
 15a:	6422                	ld	s0,8(sp)
 15c:	0141                	addi	sp,sp,16
 15e:	8082                	ret

0000000000000160 <strchr>:

char*
strchr(const char *s, char c)
{
 160:	1141                	addi	sp,sp,-16
 162:	e422                	sd	s0,8(sp)
 164:	0800                	addi	s0,sp,16
  for(; *s; s++)
 166:	00054783          	lbu	a5,0(a0)
 16a:	cb99                	beqz	a5,180 <strchr+0x20>
    if(*s == c)
 16c:	00f58763          	beq	a1,a5,17a <strchr+0x1a>
  for(; *s; s++)
 170:	0505                	addi	a0,a0,1
 172:	00054783          	lbu	a5,0(a0)
 176:	fbfd                	bnez	a5,16c <strchr+0xc>
      return (char*)s;
  return 0;
 178:	4501                	li	a0,0
}
 17a:	6422                	ld	s0,8(sp)
 17c:	0141                	addi	sp,sp,16
 17e:	8082                	ret
  return 0;
 180:	4501                	li	a0,0
 182:	bfe5                	j	17a <strchr+0x1a>

0000000000000184 <gets>:

char*
gets(char *buf, int max)
{
 184:	711d                	addi	sp,sp,-96
 186:	ec86                	sd	ra,88(sp)
 188:	e8a2                	sd	s0,80(sp)
 18a:	e4a6                	sd	s1,72(sp)
 18c:	e0ca                	sd	s2,64(sp)
 18e:	fc4e                	sd	s3,56(sp)
 190:	f852                	sd	s4,48(sp)
 192:	f456                	sd	s5,40(sp)
 194:	f05a                	sd	s6,32(sp)
 196:	ec5e                	sd	s7,24(sp)
 198:	1080                	addi	s0,sp,96
 19a:	8baa                	mv	s7,a0
 19c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 19e:	892a                	mv	s2,a0
 1a0:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1a2:	4aa9                	li	s5,10
 1a4:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1a6:	89a6                	mv	s3,s1
 1a8:	2485                	addiw	s1,s1,1
 1aa:	0344d663          	bge	s1,s4,1d6 <gets+0x52>
    cc = read(0, &c, 1);
 1ae:	4605                	li	a2,1
 1b0:	faf40593          	addi	a1,s0,-81
 1b4:	4501                	li	a0,0
 1b6:	242000ef          	jal	3f8 <read>
    if(cc < 1)
 1ba:	00a05e63          	blez	a0,1d6 <gets+0x52>
    buf[i++] = c;
 1be:	faf44783          	lbu	a5,-81(s0)
 1c2:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1c6:	01578763          	beq	a5,s5,1d4 <gets+0x50>
 1ca:	0905                	addi	s2,s2,1
 1cc:	fd679de3          	bne	a5,s6,1a6 <gets+0x22>
    buf[i++] = c;
 1d0:	89a6                	mv	s3,s1
 1d2:	a011                	j	1d6 <gets+0x52>
 1d4:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1d6:	99de                	add	s3,s3,s7
 1d8:	00098023          	sb	zero,0(s3)
  return buf;
}
 1dc:	855e                	mv	a0,s7
 1de:	60e6                	ld	ra,88(sp)
 1e0:	6446                	ld	s0,80(sp)
 1e2:	64a6                	ld	s1,72(sp)
 1e4:	6906                	ld	s2,64(sp)
 1e6:	79e2                	ld	s3,56(sp)
 1e8:	7a42                	ld	s4,48(sp)
 1ea:	7aa2                	ld	s5,40(sp)
 1ec:	7b02                	ld	s6,32(sp)
 1ee:	6be2                	ld	s7,24(sp)
 1f0:	6125                	addi	sp,sp,96
 1f2:	8082                	ret

00000000000001f4 <stat>:

int
stat(const char *n, struct stat *st)
{
 1f4:	1101                	addi	sp,sp,-32
 1f6:	ec06                	sd	ra,24(sp)
 1f8:	e822                	sd	s0,16(sp)
 1fa:	e04a                	sd	s2,0(sp)
 1fc:	1000                	addi	s0,sp,32
 1fe:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 200:	4581                	li	a1,0
 202:	21e000ef          	jal	420 <open>
  if(fd < 0)
 206:	02054263          	bltz	a0,22a <stat+0x36>
 20a:	e426                	sd	s1,8(sp)
 20c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 20e:	85ca                	mv	a1,s2
 210:	228000ef          	jal	438 <fstat>
 214:	892a                	mv	s2,a0
  close(fd);
 216:	8526                	mv	a0,s1
 218:	1f0000ef          	jal	408 <close>
  return r;
 21c:	64a2                	ld	s1,8(sp)
}
 21e:	854a                	mv	a0,s2
 220:	60e2                	ld	ra,24(sp)
 222:	6442                	ld	s0,16(sp)
 224:	6902                	ld	s2,0(sp)
 226:	6105                	addi	sp,sp,32
 228:	8082                	ret
    return -1;
 22a:	597d                	li	s2,-1
 22c:	bfcd                	j	21e <stat+0x2a>

000000000000022e <atoi>:

int
atoi(const char *s)
{
 22e:	1141                	addi	sp,sp,-16
 230:	e422                	sd	s0,8(sp)
 232:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 234:	00054683          	lbu	a3,0(a0)
 238:	fd06879b          	addiw	a5,a3,-48
 23c:	0ff7f793          	zext.b	a5,a5
 240:	4625                	li	a2,9
 242:	02f66863          	bltu	a2,a5,272 <atoi+0x44>
 246:	872a                	mv	a4,a0
  n = 0;
 248:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 24a:	0705                	addi	a4,a4,1
 24c:	0025179b          	slliw	a5,a0,0x2
 250:	9fa9                	addw	a5,a5,a0
 252:	0017979b          	slliw	a5,a5,0x1
 256:	9fb5                	addw	a5,a5,a3
 258:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 25c:	00074683          	lbu	a3,0(a4)
 260:	fd06879b          	addiw	a5,a3,-48
 264:	0ff7f793          	zext.b	a5,a5
 268:	fef671e3          	bgeu	a2,a5,24a <atoi+0x1c>
  return n;
}
 26c:	6422                	ld	s0,8(sp)
 26e:	0141                	addi	sp,sp,16
 270:	8082                	ret
  n = 0;
 272:	4501                	li	a0,0
 274:	bfe5                	j	26c <atoi+0x3e>

0000000000000276 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 276:	1141                	addi	sp,sp,-16
 278:	e422                	sd	s0,8(sp)
 27a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 27c:	02b57463          	bgeu	a0,a1,2a4 <memmove+0x2e>
    while(n-- > 0)
 280:	00c05f63          	blez	a2,29e <memmove+0x28>
 284:	1602                	slli	a2,a2,0x20
 286:	9201                	srli	a2,a2,0x20
 288:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 28c:	872a                	mv	a4,a0
      *dst++ = *src++;
 28e:	0585                	addi	a1,a1,1
 290:	0705                	addi	a4,a4,1
 292:	fff5c683          	lbu	a3,-1(a1)
 296:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 29a:	fef71ae3          	bne	a4,a5,28e <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 29e:	6422                	ld	s0,8(sp)
 2a0:	0141                	addi	sp,sp,16
 2a2:	8082                	ret
    dst += n;
 2a4:	00c50733          	add	a4,a0,a2
    src += n;
 2a8:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2aa:	fec05ae3          	blez	a2,29e <memmove+0x28>
 2ae:	fff6079b          	addiw	a5,a2,-1
 2b2:	1782                	slli	a5,a5,0x20
 2b4:	9381                	srli	a5,a5,0x20
 2b6:	fff7c793          	not	a5,a5
 2ba:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2bc:	15fd                	addi	a1,a1,-1
 2be:	177d                	addi	a4,a4,-1
 2c0:	0005c683          	lbu	a3,0(a1)
 2c4:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2c8:	fee79ae3          	bne	a5,a4,2bc <memmove+0x46>
 2cc:	bfc9                	j	29e <memmove+0x28>

00000000000002ce <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2ce:	1141                	addi	sp,sp,-16
 2d0:	e422                	sd	s0,8(sp)
 2d2:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2d4:	ca05                	beqz	a2,304 <memcmp+0x36>
 2d6:	fff6069b          	addiw	a3,a2,-1
 2da:	1682                	slli	a3,a3,0x20
 2dc:	9281                	srli	a3,a3,0x20
 2de:	0685                	addi	a3,a3,1
 2e0:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2e2:	00054783          	lbu	a5,0(a0)
 2e6:	0005c703          	lbu	a4,0(a1)
 2ea:	00e79863          	bne	a5,a4,2fa <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2ee:	0505                	addi	a0,a0,1
    p2++;
 2f0:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2f2:	fed518e3          	bne	a0,a3,2e2 <memcmp+0x14>
  }
  return 0;
 2f6:	4501                	li	a0,0
 2f8:	a019                	j	2fe <memcmp+0x30>
      return *p1 - *p2;
 2fa:	40e7853b          	subw	a0,a5,a4
}
 2fe:	6422                	ld	s0,8(sp)
 300:	0141                	addi	sp,sp,16
 302:	8082                	ret
  return 0;
 304:	4501                	li	a0,0
 306:	bfe5                	j	2fe <memcmp+0x30>

0000000000000308 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 308:	1141                	addi	sp,sp,-16
 30a:	e406                	sd	ra,8(sp)
 30c:	e022                	sd	s0,0(sp)
 30e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 310:	f67ff0ef          	jal	276 <memmove>
}
 314:	60a2                	ld	ra,8(sp)
 316:	6402                	ld	s0,0(sp)
 318:	0141                	addi	sp,sp,16
 31a:	8082                	ret

000000000000031c <sbrk>:

char *
sbrk(int n) {
 31c:	1141                	addi	sp,sp,-16
 31e:	e406                	sd	ra,8(sp)
 320:	e022                	sd	s0,0(sp)
 322:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 324:	4585                	li	a1,1
 326:	142000ef          	jal	468 <sys_sbrk>
}
 32a:	60a2                	ld	ra,8(sp)
 32c:	6402                	ld	s0,0(sp)
 32e:	0141                	addi	sp,sp,16
 330:	8082                	ret

0000000000000332 <sbrklazy>:

char *
sbrklazy(int n) {
 332:	1141                	addi	sp,sp,-16
 334:	e406                	sd	ra,8(sp)
 336:	e022                	sd	s0,0(sp)
 338:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 33a:	4589                	li	a1,2
 33c:	12c000ef          	jal	468 <sys_sbrk>
}
 340:	60a2                	ld	ra,8(sp)
 342:	6402                	ld	s0,0(sp)
 344:	0141                	addi	sp,sp,16
 346:	8082                	ret

0000000000000348 <thread_create>:
// thread_create allocates a page-sized stack, calls clone(fn, arg, stacktop).
// Returns the new thread's pid, or -1 on error.
// The stack is passed back via *stack so the caller can free it after join.
int
thread_create(void(*fn)(void*), void *arg, void **stack)
{
 348:	7179                	addi	sp,sp,-48
 34a:	f406                	sd	ra,40(sp)
 34c:	f022                	sd	s0,32(sp)
 34e:	e84a                	sd	s2,16(sp)
 350:	e44e                	sd	s3,8(sp)
 352:	e052                	sd	s4,0(sp)
 354:	1800                	addi	s0,sp,48
 356:	89aa                	mv	s3,a0
 358:	8a2e                	mv	s4,a1
 35a:	8932                	mv	s2,a2
  char *s = malloc(PGSIZE);
 35c:	6505                	lui	a0,0x1
 35e:	59e000ef          	jal	8fc <malloc>
  if(s == 0)
 362:	cd0d                	beqz	a0,39c <thread_create+0x54>
 364:	ec26                	sd	s1,24(sp)
 366:	84aa                	mv	s1,a0
    return -1;
  *stack = s;
 368:	00a93023          	sd	a0,0(s2)
  // Stack grows downward- pass the top of the allocated region.
  int pid = clone(fn, arg, s + PGSIZE);
 36c:	6605                	lui	a2,0x1
 36e:	962a                	add	a2,a2,a0
 370:	85d2                	mv	a1,s4
 372:	854e                	mv	a0,s3
 374:	134000ef          	jal	4a8 <clone>
  if(pid < 0){
 378:	00054a63          	bltz	a0,38c <thread_create+0x44>
 37c:	64e2                	ld	s1,24(sp)
    free(s);
    *stack = 0;
    return -1;
  }
  return pid;
}
 37e:	70a2                	ld	ra,40(sp)
 380:	7402                	ld	s0,32(sp)
 382:	6942                	ld	s2,16(sp)
 384:	69a2                	ld	s3,8(sp)
 386:	6a02                	ld	s4,0(sp)
 388:	6145                	addi	sp,sp,48
 38a:	8082                	ret
    free(s);
 38c:	8526                	mv	a0,s1
 38e:	4ec000ef          	jal	87a <free>
    *stack = 0;
 392:	00093023          	sd	zero,0(s2)
    return -1;
 396:	557d                	li	a0,-1
 398:	64e2                	ld	s1,24(sp)
 39a:	b7d5                	j	37e <thread_create+0x36>
    return -1;
 39c:	557d                	li	a0,-1
 39e:	b7c5                	j	37e <thread_create+0x36>

00000000000003a0 <thread_join>:
// Wait for any child thread to exit.
// If stack is non-null, frees the memory pointed to by *stack and clears it.
// Returns the joined thread's pid, or -1 Son error.
int
thread_join(void **stack)
{
 3a0:	1101                	addi	sp,sp,-32
 3a2:	ec06                	sd	ra,24(sp)
 3a4:	e822                	sd	s0,16(sp)
 3a6:	e426                	sd	s1,8(sp)
 3a8:	e04a                	sd	s2,0(sp)
 3aa:	1000                	addi	s0,sp,32
 3ac:	84aa                	mv	s1,a0
  int pid = join();
 3ae:	102000ef          	jal	4b0 <join>
  if(pid < 0)
 3b2:	02054163          	bltz	a0,3d4 <thread_join+0x34>
 3b6:	892a                	mv	s2,a0
    return -1;
  if(stack && *stack){
 3b8:	c499                	beqz	s1,3c6 <thread_join+0x26>
 3ba:	6088                	ld	a0,0(s1)
 3bc:	c509                	beqz	a0,3c6 <thread_join+0x26>
    free(*stack);
 3be:	4bc000ef          	jal	87a <free>
    *stack = 0;
 3c2:	0004b023          	sd	zero,0(s1)
  }
  return pid;
}
 3c6:	854a                	mv	a0,s2
 3c8:	60e2                	ld	ra,24(sp)
 3ca:	6442                	ld	s0,16(sp)
 3cc:	64a2                	ld	s1,8(sp)
 3ce:	6902                	ld	s2,0(sp)
 3d0:	6105                	addi	sp,sp,32
 3d2:	8082                	ret
    return -1;
 3d4:	597d                	li	s2,-1
 3d6:	bfc5                	j	3c6 <thread_join+0x26>

00000000000003d8 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3d8:	4885                	li	a7,1
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3e0:	4889                	li	a7,2
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3e8:	488d                	li	a7,3
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3f0:	4891                	li	a7,4
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <read>:
.global read
read:
 li a7, SYS_read
 3f8:	4895                	li	a7,5
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <write>:
.global write
write:
 li a7, SYS_write
 400:	48c1                	li	a7,16
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <close>:
.global close
close:
 li a7, SYS_close
 408:	48d5                	li	a7,21
 ecall
 40a:	00000073          	ecall
 ret
 40e:	8082                	ret

0000000000000410 <kill>:
.global kill
kill:
 li a7, SYS_kill
 410:	4899                	li	a7,6
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <exec>:
.global exec
exec:
 li a7, SYS_exec
 418:	489d                	li	a7,7
 ecall
 41a:	00000073          	ecall
 ret
 41e:	8082                	ret

0000000000000420 <open>:
.global open
open:
 li a7, SYS_open
 420:	48bd                	li	a7,15
 ecall
 422:	00000073          	ecall
 ret
 426:	8082                	ret

0000000000000428 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 428:	48c5                	li	a7,17
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 430:	48c9                	li	a7,18
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 438:	48a1                	li	a7,8
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <link>:
.global link
link:
 li a7, SYS_link
 440:	48cd                	li	a7,19
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 448:	48d1                	li	a7,20
 ecall
 44a:	00000073          	ecall
 ret
 44e:	8082                	ret

0000000000000450 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 450:	48a5                	li	a7,9
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <dup>:
.global dup
dup:
 li a7, SYS_dup
 458:	48a9                	li	a7,10
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 460:	48ad                	li	a7,11
 ecall
 462:	00000073          	ecall
 ret
 466:	8082                	ret

0000000000000468 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 468:	48b1                	li	a7,12
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <pause>:
.global pause
pause:
 li a7, SYS_pause
 470:	48b5                	li	a7,13
 ecall
 472:	00000073          	ecall
 ret
 476:	8082                	ret

0000000000000478 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 478:	48b9                	li	a7,14
 ecall
 47a:	00000073          	ecall
 ret
 47e:	8082                	ret

0000000000000480 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 480:	48d9                	li	a7,22
 ecall
 482:	00000073          	ecall
 ret
 486:	8082                	ret

0000000000000488 <lock_create>:
.global lock_create
lock_create:
 li a7, SYS_lock_create
 488:	48dd                	li	a7,23
 ecall
 48a:	00000073          	ecall
 ret
 48e:	8082                	ret

0000000000000490 <lock_acquire>:
.global lock_acquire
lock_acquire:
 li a7, SYS_lock_acquire
 490:	48e1                	li	a7,24
 ecall
 492:	00000073          	ecall
 ret
 496:	8082                	ret

0000000000000498 <lock_release>:
.global lock_release
lock_release:
 li a7, SYS_lock_release
 498:	48e5                	li	a7,25
 ecall
 49a:	00000073          	ecall
 ret
 49e:	8082                	ret

00000000000004a0 <lock_destroy>:
.global lock_destroy
lock_destroy:
 li a7, SYS_lock_destroy
 4a0:	48e9                	li	a7,26
 ecall
 4a2:	00000073          	ecall
 ret
 4a6:	8082                	ret

00000000000004a8 <clone>:
.global clone
clone:
 li a7, SYS_clone
 4a8:	48ed                	li	a7,27
 ecall
 4aa:	00000073          	ecall
 ret
 4ae:	8082                	ret

00000000000004b0 <join>:
.global join
join:
 li a7, SYS_join
 4b0:	48f1                	li	a7,28
 ecall
 4b2:	00000073          	ecall
 ret
 4b6:	8082                	ret

00000000000004b8 <getprocessinfo>:
.global getprocessinfo
getprocessinfo:
 li a7, SYS_getprocessinfo
 4b8:	48f5                	li	a7,29
 ecall
 4ba:	00000073          	ecall
 ret
 4be:	8082                	ret

00000000000004c0 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4c0:	1101                	addi	sp,sp,-32
 4c2:	ec06                	sd	ra,24(sp)
 4c4:	e822                	sd	s0,16(sp)
 4c6:	1000                	addi	s0,sp,32
 4c8:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4cc:	4605                	li	a2,1
 4ce:	fef40593          	addi	a1,s0,-17
 4d2:	f2fff0ef          	jal	400 <write>
}
 4d6:	60e2                	ld	ra,24(sp)
 4d8:	6442                	ld	s0,16(sp)
 4da:	6105                	addi	sp,sp,32
 4dc:	8082                	ret

00000000000004de <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 4de:	715d                	addi	sp,sp,-80
 4e0:	e486                	sd	ra,72(sp)
 4e2:	e0a2                	sd	s0,64(sp)
 4e4:	f84a                	sd	s2,48(sp)
 4e6:	0880                	addi	s0,sp,80
 4e8:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 4ea:	c299                	beqz	a3,4f0 <printint+0x12>
 4ec:	0805c363          	bltz	a1,572 <printint+0x94>
  neg = 0;
 4f0:	4881                	li	a7,0
 4f2:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 4f6:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 4f8:	00000517          	auipc	a0,0x0
 4fc:	58850513          	addi	a0,a0,1416 # a80 <digits>
 500:	883e                	mv	a6,a5
 502:	2785                	addiw	a5,a5,1
 504:	02c5f733          	remu	a4,a1,a2
 508:	972a                	add	a4,a4,a0
 50a:	00074703          	lbu	a4,0(a4)
 50e:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 512:	872e                	mv	a4,a1
 514:	02c5d5b3          	divu	a1,a1,a2
 518:	0685                	addi	a3,a3,1
 51a:	fec773e3          	bgeu	a4,a2,500 <printint+0x22>
  if(neg)
 51e:	00088b63          	beqz	a7,534 <printint+0x56>
    buf[i++] = '-';
 522:	fd078793          	addi	a5,a5,-48
 526:	97a2                	add	a5,a5,s0
 528:	02d00713          	li	a4,45
 52c:	fee78423          	sb	a4,-24(a5)
 530:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 534:	02f05a63          	blez	a5,568 <printint+0x8a>
 538:	fc26                	sd	s1,56(sp)
 53a:	f44e                	sd	s3,40(sp)
 53c:	fb840713          	addi	a4,s0,-72
 540:	00f704b3          	add	s1,a4,a5
 544:	fff70993          	addi	s3,a4,-1
 548:	99be                	add	s3,s3,a5
 54a:	37fd                	addiw	a5,a5,-1
 54c:	1782                	slli	a5,a5,0x20
 54e:	9381                	srli	a5,a5,0x20
 550:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 554:	fff4c583          	lbu	a1,-1(s1)
 558:	854a                	mv	a0,s2
 55a:	f67ff0ef          	jal	4c0 <putc>
  while(--i >= 0)
 55e:	14fd                	addi	s1,s1,-1
 560:	ff349ae3          	bne	s1,s3,554 <printint+0x76>
 564:	74e2                	ld	s1,56(sp)
 566:	79a2                	ld	s3,40(sp)
}
 568:	60a6                	ld	ra,72(sp)
 56a:	6406                	ld	s0,64(sp)
 56c:	7942                	ld	s2,48(sp)
 56e:	6161                	addi	sp,sp,80
 570:	8082                	ret
    x = -xx;
 572:	40b005b3          	neg	a1,a1
    neg = 1;
 576:	4885                	li	a7,1
    x = -xx;
 578:	bfad                	j	4f2 <printint+0x14>

000000000000057a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 57a:	711d                	addi	sp,sp,-96
 57c:	ec86                	sd	ra,88(sp)
 57e:	e8a2                	sd	s0,80(sp)
 580:	e0ca                	sd	s2,64(sp)
 582:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 584:	0005c903          	lbu	s2,0(a1)
 588:	28090663          	beqz	s2,814 <vprintf+0x29a>
 58c:	e4a6                	sd	s1,72(sp)
 58e:	fc4e                	sd	s3,56(sp)
 590:	f852                	sd	s4,48(sp)
 592:	f456                	sd	s5,40(sp)
 594:	f05a                	sd	s6,32(sp)
 596:	ec5e                	sd	s7,24(sp)
 598:	e862                	sd	s8,16(sp)
 59a:	e466                	sd	s9,8(sp)
 59c:	8b2a                	mv	s6,a0
 59e:	8a2e                	mv	s4,a1
 5a0:	8bb2                	mv	s7,a2
  state = 0;
 5a2:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 5a4:	4481                	li	s1,0
 5a6:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 5a8:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 5ac:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 5b0:	06c00c93          	li	s9,108
 5b4:	a005                	j	5d4 <vprintf+0x5a>
        putc(fd, c0);
 5b6:	85ca                	mv	a1,s2
 5b8:	855a                	mv	a0,s6
 5ba:	f07ff0ef          	jal	4c0 <putc>
 5be:	a019                	j	5c4 <vprintf+0x4a>
    } else if(state == '%'){
 5c0:	03598263          	beq	s3,s5,5e4 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 5c4:	2485                	addiw	s1,s1,1
 5c6:	8726                	mv	a4,s1
 5c8:	009a07b3          	add	a5,s4,s1
 5cc:	0007c903          	lbu	s2,0(a5)
 5d0:	22090a63          	beqz	s2,804 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 5d4:	0009079b          	sext.w	a5,s2
    if(state == 0){
 5d8:	fe0994e3          	bnez	s3,5c0 <vprintf+0x46>
      if(c0 == '%'){
 5dc:	fd579de3          	bne	a5,s5,5b6 <vprintf+0x3c>
        state = '%';
 5e0:	89be                	mv	s3,a5
 5e2:	b7cd                	j	5c4 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 5e4:	00ea06b3          	add	a3,s4,a4
 5e8:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 5ec:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 5ee:	c681                	beqz	a3,5f6 <vprintf+0x7c>
 5f0:	9752                	add	a4,a4,s4
 5f2:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 5f6:	05878363          	beq	a5,s8,63c <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 5fa:	05978d63          	beq	a5,s9,654 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 5fe:	07500713          	li	a4,117
 602:	0ee78763          	beq	a5,a4,6f0 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 606:	07800713          	li	a4,120
 60a:	12e78963          	beq	a5,a4,73c <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 60e:	07000713          	li	a4,112
 612:	14e78e63          	beq	a5,a4,76e <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 616:	06300713          	li	a4,99
 61a:	18e78e63          	beq	a5,a4,7b6 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 61e:	07300713          	li	a4,115
 622:	1ae78463          	beq	a5,a4,7ca <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 626:	02500713          	li	a4,37
 62a:	04e79563          	bne	a5,a4,674 <vprintf+0xfa>
        putc(fd, '%');
 62e:	02500593          	li	a1,37
 632:	855a                	mv	a0,s6
 634:	e8dff0ef          	jal	4c0 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 638:	4981                	li	s3,0
 63a:	b769                	j	5c4 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 63c:	008b8913          	addi	s2,s7,8
 640:	4685                	li	a3,1
 642:	4629                	li	a2,10
 644:	000ba583          	lw	a1,0(s7)
 648:	855a                	mv	a0,s6
 64a:	e95ff0ef          	jal	4de <printint>
 64e:	8bca                	mv	s7,s2
      state = 0;
 650:	4981                	li	s3,0
 652:	bf8d                	j	5c4 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 654:	06400793          	li	a5,100
 658:	02f68963          	beq	a3,a5,68a <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 65c:	06c00793          	li	a5,108
 660:	04f68263          	beq	a3,a5,6a4 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 664:	07500793          	li	a5,117
 668:	0af68063          	beq	a3,a5,708 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 66c:	07800793          	li	a5,120
 670:	0ef68263          	beq	a3,a5,754 <vprintf+0x1da>
        putc(fd, '%');
 674:	02500593          	li	a1,37
 678:	855a                	mv	a0,s6
 67a:	e47ff0ef          	jal	4c0 <putc>
        putc(fd, c0);
 67e:	85ca                	mv	a1,s2
 680:	855a                	mv	a0,s6
 682:	e3fff0ef          	jal	4c0 <putc>
      state = 0;
 686:	4981                	li	s3,0
 688:	bf35                	j	5c4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 68a:	008b8913          	addi	s2,s7,8
 68e:	4685                	li	a3,1
 690:	4629                	li	a2,10
 692:	000bb583          	ld	a1,0(s7)
 696:	855a                	mv	a0,s6
 698:	e47ff0ef          	jal	4de <printint>
        i += 1;
 69c:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 69e:	8bca                	mv	s7,s2
      state = 0;
 6a0:	4981                	li	s3,0
        i += 1;
 6a2:	b70d                	j	5c4 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6a4:	06400793          	li	a5,100
 6a8:	02f60763          	beq	a2,a5,6d6 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 6ac:	07500793          	li	a5,117
 6b0:	06f60963          	beq	a2,a5,722 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 6b4:	07800793          	li	a5,120
 6b8:	faf61ee3          	bne	a2,a5,674 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6bc:	008b8913          	addi	s2,s7,8
 6c0:	4681                	li	a3,0
 6c2:	4641                	li	a2,16
 6c4:	000bb583          	ld	a1,0(s7)
 6c8:	855a                	mv	a0,s6
 6ca:	e15ff0ef          	jal	4de <printint>
        i += 2;
 6ce:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 6d0:	8bca                	mv	s7,s2
      state = 0;
 6d2:	4981                	li	s3,0
        i += 2;
 6d4:	bdc5                	j	5c4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6d6:	008b8913          	addi	s2,s7,8
 6da:	4685                	li	a3,1
 6dc:	4629                	li	a2,10
 6de:	000bb583          	ld	a1,0(s7)
 6e2:	855a                	mv	a0,s6
 6e4:	dfbff0ef          	jal	4de <printint>
        i += 2;
 6e8:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 6ea:	8bca                	mv	s7,s2
      state = 0;
 6ec:	4981                	li	s3,0
        i += 2;
 6ee:	bdd9                	j	5c4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 6f0:	008b8913          	addi	s2,s7,8
 6f4:	4681                	li	a3,0
 6f6:	4629                	li	a2,10
 6f8:	000be583          	lwu	a1,0(s7)
 6fc:	855a                	mv	a0,s6
 6fe:	de1ff0ef          	jal	4de <printint>
 702:	8bca                	mv	s7,s2
      state = 0;
 704:	4981                	li	s3,0
 706:	bd7d                	j	5c4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 708:	008b8913          	addi	s2,s7,8
 70c:	4681                	li	a3,0
 70e:	4629                	li	a2,10
 710:	000bb583          	ld	a1,0(s7)
 714:	855a                	mv	a0,s6
 716:	dc9ff0ef          	jal	4de <printint>
        i += 1;
 71a:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 71c:	8bca                	mv	s7,s2
      state = 0;
 71e:	4981                	li	s3,0
        i += 1;
 720:	b555                	j	5c4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 722:	008b8913          	addi	s2,s7,8
 726:	4681                	li	a3,0
 728:	4629                	li	a2,10
 72a:	000bb583          	ld	a1,0(s7)
 72e:	855a                	mv	a0,s6
 730:	dafff0ef          	jal	4de <printint>
        i += 2;
 734:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 736:	8bca                	mv	s7,s2
      state = 0;
 738:	4981                	li	s3,0
        i += 2;
 73a:	b569                	j	5c4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 73c:	008b8913          	addi	s2,s7,8
 740:	4681                	li	a3,0
 742:	4641                	li	a2,16
 744:	000be583          	lwu	a1,0(s7)
 748:	855a                	mv	a0,s6
 74a:	d95ff0ef          	jal	4de <printint>
 74e:	8bca                	mv	s7,s2
      state = 0;
 750:	4981                	li	s3,0
 752:	bd8d                	j	5c4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 754:	008b8913          	addi	s2,s7,8
 758:	4681                	li	a3,0
 75a:	4641                	li	a2,16
 75c:	000bb583          	ld	a1,0(s7)
 760:	855a                	mv	a0,s6
 762:	d7dff0ef          	jal	4de <printint>
        i += 1;
 766:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 768:	8bca                	mv	s7,s2
      state = 0;
 76a:	4981                	li	s3,0
        i += 1;
 76c:	bda1                	j	5c4 <vprintf+0x4a>
 76e:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 770:	008b8d13          	addi	s10,s7,8
 774:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 778:	03000593          	li	a1,48
 77c:	855a                	mv	a0,s6
 77e:	d43ff0ef          	jal	4c0 <putc>
  putc(fd, 'x');
 782:	07800593          	li	a1,120
 786:	855a                	mv	a0,s6
 788:	d39ff0ef          	jal	4c0 <putc>
 78c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 78e:	00000b97          	auipc	s7,0x0
 792:	2f2b8b93          	addi	s7,s7,754 # a80 <digits>
 796:	03c9d793          	srli	a5,s3,0x3c
 79a:	97de                	add	a5,a5,s7
 79c:	0007c583          	lbu	a1,0(a5)
 7a0:	855a                	mv	a0,s6
 7a2:	d1fff0ef          	jal	4c0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7a6:	0992                	slli	s3,s3,0x4
 7a8:	397d                	addiw	s2,s2,-1
 7aa:	fe0916e3          	bnez	s2,796 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 7ae:	8bea                	mv	s7,s10
      state = 0;
 7b0:	4981                	li	s3,0
 7b2:	6d02                	ld	s10,0(sp)
 7b4:	bd01                	j	5c4 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 7b6:	008b8913          	addi	s2,s7,8
 7ba:	000bc583          	lbu	a1,0(s7)
 7be:	855a                	mv	a0,s6
 7c0:	d01ff0ef          	jal	4c0 <putc>
 7c4:	8bca                	mv	s7,s2
      state = 0;
 7c6:	4981                	li	s3,0
 7c8:	bbf5                	j	5c4 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 7ca:	008b8993          	addi	s3,s7,8
 7ce:	000bb903          	ld	s2,0(s7)
 7d2:	00090f63          	beqz	s2,7f0 <vprintf+0x276>
        for(; *s; s++)
 7d6:	00094583          	lbu	a1,0(s2)
 7da:	c195                	beqz	a1,7fe <vprintf+0x284>
          putc(fd, *s);
 7dc:	855a                	mv	a0,s6
 7de:	ce3ff0ef          	jal	4c0 <putc>
        for(; *s; s++)
 7e2:	0905                	addi	s2,s2,1
 7e4:	00094583          	lbu	a1,0(s2)
 7e8:	f9f5                	bnez	a1,7dc <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 7ea:	8bce                	mv	s7,s3
      state = 0;
 7ec:	4981                	li	s3,0
 7ee:	bbd9                	j	5c4 <vprintf+0x4a>
          s = "(null)";
 7f0:	00000917          	auipc	s2,0x0
 7f4:	28890913          	addi	s2,s2,648 # a78 <malloc+0x17c>
        for(; *s; s++)
 7f8:	02800593          	li	a1,40
 7fc:	b7c5                	j	7dc <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 7fe:	8bce                	mv	s7,s3
      state = 0;
 800:	4981                	li	s3,0
 802:	b3c9                	j	5c4 <vprintf+0x4a>
 804:	64a6                	ld	s1,72(sp)
 806:	79e2                	ld	s3,56(sp)
 808:	7a42                	ld	s4,48(sp)
 80a:	7aa2                	ld	s5,40(sp)
 80c:	7b02                	ld	s6,32(sp)
 80e:	6be2                	ld	s7,24(sp)
 810:	6c42                	ld	s8,16(sp)
 812:	6ca2                	ld	s9,8(sp)
    }
  }
}
 814:	60e6                	ld	ra,88(sp)
 816:	6446                	ld	s0,80(sp)
 818:	6906                	ld	s2,64(sp)
 81a:	6125                	addi	sp,sp,96
 81c:	8082                	ret

000000000000081e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 81e:	715d                	addi	sp,sp,-80
 820:	ec06                	sd	ra,24(sp)
 822:	e822                	sd	s0,16(sp)
 824:	1000                	addi	s0,sp,32
 826:	e010                	sd	a2,0(s0)
 828:	e414                	sd	a3,8(s0)
 82a:	e818                	sd	a4,16(s0)
 82c:	ec1c                	sd	a5,24(s0)
 82e:	03043023          	sd	a6,32(s0)
 832:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 836:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 83a:	8622                	mv	a2,s0
 83c:	d3fff0ef          	jal	57a <vprintf>
}
 840:	60e2                	ld	ra,24(sp)
 842:	6442                	ld	s0,16(sp)
 844:	6161                	addi	sp,sp,80
 846:	8082                	ret

0000000000000848 <printf>:

void
printf(const char *fmt, ...)
{
 848:	711d                	addi	sp,sp,-96
 84a:	ec06                	sd	ra,24(sp)
 84c:	e822                	sd	s0,16(sp)
 84e:	1000                	addi	s0,sp,32
 850:	e40c                	sd	a1,8(s0)
 852:	e810                	sd	a2,16(s0)
 854:	ec14                	sd	a3,24(s0)
 856:	f018                	sd	a4,32(s0)
 858:	f41c                	sd	a5,40(s0)
 85a:	03043823          	sd	a6,48(s0)
 85e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 862:	00840613          	addi	a2,s0,8
 866:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 86a:	85aa                	mv	a1,a0
 86c:	4505                	li	a0,1
 86e:	d0dff0ef          	jal	57a <vprintf>
}
 872:	60e2                	ld	ra,24(sp)
 874:	6442                	ld	s0,16(sp)
 876:	6125                	addi	sp,sp,96
 878:	8082                	ret

000000000000087a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 87a:	1141                	addi	sp,sp,-16
 87c:	e422                	sd	s0,8(sp)
 87e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 880:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 884:	00000797          	auipc	a5,0x0
 888:	78c7b783          	ld	a5,1932(a5) # 1010 <freep>
 88c:	a02d                	j	8b6 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 88e:	4618                	lw	a4,8(a2)
 890:	9f2d                	addw	a4,a4,a1
 892:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 896:	6398                	ld	a4,0(a5)
 898:	6310                	ld	a2,0(a4)
 89a:	a83d                	j	8d8 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 89c:	ff852703          	lw	a4,-8(a0)
 8a0:	9f31                	addw	a4,a4,a2
 8a2:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8a4:	ff053683          	ld	a3,-16(a0)
 8a8:	a091                	j	8ec <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8aa:	6398                	ld	a4,0(a5)
 8ac:	00e7e463          	bltu	a5,a4,8b4 <free+0x3a>
 8b0:	00e6ea63          	bltu	a3,a4,8c4 <free+0x4a>
{
 8b4:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8b6:	fed7fae3          	bgeu	a5,a3,8aa <free+0x30>
 8ba:	6398                	ld	a4,0(a5)
 8bc:	00e6e463          	bltu	a3,a4,8c4 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8c0:	fee7eae3          	bltu	a5,a4,8b4 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 8c4:	ff852583          	lw	a1,-8(a0)
 8c8:	6390                	ld	a2,0(a5)
 8ca:	02059813          	slli	a6,a1,0x20
 8ce:	01c85713          	srli	a4,a6,0x1c
 8d2:	9736                	add	a4,a4,a3
 8d4:	fae60de3          	beq	a2,a4,88e <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 8d8:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8dc:	4790                	lw	a2,8(a5)
 8de:	02061593          	slli	a1,a2,0x20
 8e2:	01c5d713          	srli	a4,a1,0x1c
 8e6:	973e                	add	a4,a4,a5
 8e8:	fae68ae3          	beq	a3,a4,89c <free+0x22>
    p->s.ptr = bp->s.ptr;
 8ec:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 8ee:	00000717          	auipc	a4,0x0
 8f2:	72f73123          	sd	a5,1826(a4) # 1010 <freep>
}
 8f6:	6422                	ld	s0,8(sp)
 8f8:	0141                	addi	sp,sp,16
 8fa:	8082                	ret

00000000000008fc <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8fc:	7139                	addi	sp,sp,-64
 8fe:	fc06                	sd	ra,56(sp)
 900:	f822                	sd	s0,48(sp)
 902:	f426                	sd	s1,40(sp)
 904:	ec4e                	sd	s3,24(sp)
 906:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 908:	02051493          	slli	s1,a0,0x20
 90c:	9081                	srli	s1,s1,0x20
 90e:	04bd                	addi	s1,s1,15
 910:	8091                	srli	s1,s1,0x4
 912:	0014899b          	addiw	s3,s1,1
 916:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 918:	00000517          	auipc	a0,0x0
 91c:	6f853503          	ld	a0,1784(a0) # 1010 <freep>
 920:	c915                	beqz	a0,954 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 922:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 924:	4798                	lw	a4,8(a5)
 926:	08977a63          	bgeu	a4,s1,9ba <malloc+0xbe>
 92a:	f04a                	sd	s2,32(sp)
 92c:	e852                	sd	s4,16(sp)
 92e:	e456                	sd	s5,8(sp)
 930:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 932:	8a4e                	mv	s4,s3
 934:	0009871b          	sext.w	a4,s3
 938:	6685                	lui	a3,0x1
 93a:	00d77363          	bgeu	a4,a3,940 <malloc+0x44>
 93e:	6a05                	lui	s4,0x1
 940:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 944:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 948:	00000917          	auipc	s2,0x0
 94c:	6c890913          	addi	s2,s2,1736 # 1010 <freep>
  if(p == SBRK_ERROR)
 950:	5afd                	li	s5,-1
 952:	a081                	j	992 <malloc+0x96>
 954:	f04a                	sd	s2,32(sp)
 956:	e852                	sd	s4,16(sp)
 958:	e456                	sd	s5,8(sp)
 95a:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 95c:	00000797          	auipc	a5,0x0
 960:	6c478793          	addi	a5,a5,1732 # 1020 <base>
 964:	00000717          	auipc	a4,0x0
 968:	6af73623          	sd	a5,1708(a4) # 1010 <freep>
 96c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 96e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 972:	b7c1                	j	932 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 974:	6398                	ld	a4,0(a5)
 976:	e118                	sd	a4,0(a0)
 978:	a8a9                	j	9d2 <malloc+0xd6>
  hp->s.size = nu;
 97a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 97e:	0541                	addi	a0,a0,16
 980:	efbff0ef          	jal	87a <free>
  return freep;
 984:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 988:	c12d                	beqz	a0,9ea <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 98a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 98c:	4798                	lw	a4,8(a5)
 98e:	02977263          	bgeu	a4,s1,9b2 <malloc+0xb6>
    if(p == freep)
 992:	00093703          	ld	a4,0(s2)
 996:	853e                	mv	a0,a5
 998:	fef719e3          	bne	a4,a5,98a <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 99c:	8552                	mv	a0,s4
 99e:	97fff0ef          	jal	31c <sbrk>
  if(p == SBRK_ERROR)
 9a2:	fd551ce3          	bne	a0,s5,97a <malloc+0x7e>
        return 0;
 9a6:	4501                	li	a0,0
 9a8:	7902                	ld	s2,32(sp)
 9aa:	6a42                	ld	s4,16(sp)
 9ac:	6aa2                	ld	s5,8(sp)
 9ae:	6b02                	ld	s6,0(sp)
 9b0:	a03d                	j	9de <malloc+0xe2>
 9b2:	7902                	ld	s2,32(sp)
 9b4:	6a42                	ld	s4,16(sp)
 9b6:	6aa2                	ld	s5,8(sp)
 9b8:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 9ba:	fae48de3          	beq	s1,a4,974 <malloc+0x78>
        p->s.size -= nunits;
 9be:	4137073b          	subw	a4,a4,s3
 9c2:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9c4:	02071693          	slli	a3,a4,0x20
 9c8:	01c6d713          	srli	a4,a3,0x1c
 9cc:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9ce:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9d2:	00000717          	auipc	a4,0x0
 9d6:	62a73f23          	sd	a0,1598(a4) # 1010 <freep>
      return (void*)(p + 1);
 9da:	01078513          	addi	a0,a5,16
  }
}
 9de:	70e2                	ld	ra,56(sp)
 9e0:	7442                	ld	s0,48(sp)
 9e2:	74a2                	ld	s1,40(sp)
 9e4:	69e2                	ld	s3,24(sp)
 9e6:	6121                	addi	sp,sp,64
 9e8:	8082                	ret
 9ea:	7902                	ld	s2,32(sp)
 9ec:	6a42                	ld	s4,16(sp)
 9ee:	6aa2                	ld	s5,8(sp)
 9f0:	6b02                	ld	s6,0(sp)
 9f2:	b7f5                	j	9de <malloc+0xe2>
