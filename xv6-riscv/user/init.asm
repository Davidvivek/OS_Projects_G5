
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
  12:	a0250513          	addi	a0,a0,-1534 # a10 <malloc+0xfa>
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
  2e:	9ee90913          	addi	s2,s2,-1554 # a18 <malloc+0x102>
  32:	854a                	mv	a0,s2
  34:	02f000ef          	jal	862 <printf>
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
  56:	a1650513          	addi	a0,a0,-1514 # a68 <malloc+0x152>
  5a:	009000ef          	jal	862 <printf>
        exit(1);
  5e:	4505                	li	a0,1
  60:	380000ef          	jal	3e0 <exit>
    mknod("console", CONSOLE, 0);
  64:	4601                	li	a2,0
  66:	4585                	li	a1,1
  68:	00001517          	auipc	a0,0x1
  6c:	9a850513          	addi	a0,a0,-1624 # a10 <malloc+0xfa>
  70:	3b8000ef          	jal	428 <mknod>
    open("console", O_RDWR);
  74:	4589                	li	a1,2
  76:	00001517          	auipc	a0,0x1
  7a:	99a50513          	addi	a0,a0,-1638 # a10 <malloc+0xfa>
  7e:	3a2000ef          	jal	420 <open>
  82:	bf71                	j	1e <main+0x1e>
      printf("init: fork failed\n");
  84:	00001517          	auipc	a0,0x1
  88:	9ac50513          	addi	a0,a0,-1620 # a30 <malloc+0x11a>
  8c:	7d6000ef          	jal	862 <printf>
      exit(1);
  90:	4505                	li	a0,1
  92:	34e000ef          	jal	3e0 <exit>
      exec("sh", argv);
  96:	00001597          	auipc	a1,0x1
  9a:	f6a58593          	addi	a1,a1,-150 # 1000 <argv>
  9e:	00001517          	auipc	a0,0x1
  a2:	9aa50513          	addi	a0,a0,-1622 # a48 <malloc+0x132>
  a6:	372000ef          	jal	418 <exec>
      printf("init: exec sh failed\n");
  aa:	00001517          	auipc	a0,0x1
  ae:	9a650513          	addi	a0,a0,-1626 # a50 <malloc+0x13a>
  b2:	7b0000ef          	jal	862 <printf>
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
 35e:	5b8000ef          	jal	916 <malloc>
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
 38e:	506000ef          	jal	894 <free>
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
 3be:	4d6000ef          	jal	894 <free>
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

00000000000004c0 <shmget>:
.global shmget
shmget:
 li a7, SYS_shmget
 4c0:	48f9                	li	a7,30
 ecall
 4c2:	00000073          	ecall
 ret
 4c6:	8082                	ret

00000000000004c8 <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 4c8:	48fd                	li	a7,31
 ecall
 4ca:	00000073          	ecall
 ret
 4ce:	8082                	ret

00000000000004d0 <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 4d0:	02000893          	li	a7,32
 ecall
 4d4:	00000073          	ecall
 ret
 4d8:	8082                	ret

00000000000004da <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4da:	1101                	addi	sp,sp,-32
 4dc:	ec06                	sd	ra,24(sp)
 4de:	e822                	sd	s0,16(sp)
 4e0:	1000                	addi	s0,sp,32
 4e2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4e6:	4605                	li	a2,1
 4e8:	fef40593          	addi	a1,s0,-17
 4ec:	f15ff0ef          	jal	400 <write>
}
 4f0:	60e2                	ld	ra,24(sp)
 4f2:	6442                	ld	s0,16(sp)
 4f4:	6105                	addi	sp,sp,32
 4f6:	8082                	ret

00000000000004f8 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 4f8:	715d                	addi	sp,sp,-80
 4fa:	e486                	sd	ra,72(sp)
 4fc:	e0a2                	sd	s0,64(sp)
 4fe:	f84a                	sd	s2,48(sp)
 500:	0880                	addi	s0,sp,80
 502:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 504:	c299                	beqz	a3,50a <printint+0x12>
 506:	0805c363          	bltz	a1,58c <printint+0x94>
  neg = 0;
 50a:	4881                	li	a7,0
 50c:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 510:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 512:	00000517          	auipc	a0,0x0
 516:	57e50513          	addi	a0,a0,1406 # a90 <digits>
 51a:	883e                	mv	a6,a5
 51c:	2785                	addiw	a5,a5,1
 51e:	02c5f733          	remu	a4,a1,a2
 522:	972a                	add	a4,a4,a0
 524:	00074703          	lbu	a4,0(a4)
 528:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 52c:	872e                	mv	a4,a1
 52e:	02c5d5b3          	divu	a1,a1,a2
 532:	0685                	addi	a3,a3,1
 534:	fec773e3          	bgeu	a4,a2,51a <printint+0x22>
  if(neg)
 538:	00088b63          	beqz	a7,54e <printint+0x56>
    buf[i++] = '-';
 53c:	fd078793          	addi	a5,a5,-48
 540:	97a2                	add	a5,a5,s0
 542:	02d00713          	li	a4,45
 546:	fee78423          	sb	a4,-24(a5)
 54a:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 54e:	02f05a63          	blez	a5,582 <printint+0x8a>
 552:	fc26                	sd	s1,56(sp)
 554:	f44e                	sd	s3,40(sp)
 556:	fb840713          	addi	a4,s0,-72
 55a:	00f704b3          	add	s1,a4,a5
 55e:	fff70993          	addi	s3,a4,-1
 562:	99be                	add	s3,s3,a5
 564:	37fd                	addiw	a5,a5,-1
 566:	1782                	slli	a5,a5,0x20
 568:	9381                	srli	a5,a5,0x20
 56a:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 56e:	fff4c583          	lbu	a1,-1(s1)
 572:	854a                	mv	a0,s2
 574:	f67ff0ef          	jal	4da <putc>
  while(--i >= 0)
 578:	14fd                	addi	s1,s1,-1
 57a:	ff349ae3          	bne	s1,s3,56e <printint+0x76>
 57e:	74e2                	ld	s1,56(sp)
 580:	79a2                	ld	s3,40(sp)
}
 582:	60a6                	ld	ra,72(sp)
 584:	6406                	ld	s0,64(sp)
 586:	7942                	ld	s2,48(sp)
 588:	6161                	addi	sp,sp,80
 58a:	8082                	ret
    x = -xx;
 58c:	40b005b3          	neg	a1,a1
    neg = 1;
 590:	4885                	li	a7,1
    x = -xx;
 592:	bfad                	j	50c <printint+0x14>

0000000000000594 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 594:	711d                	addi	sp,sp,-96
 596:	ec86                	sd	ra,88(sp)
 598:	e8a2                	sd	s0,80(sp)
 59a:	e0ca                	sd	s2,64(sp)
 59c:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 59e:	0005c903          	lbu	s2,0(a1)
 5a2:	28090663          	beqz	s2,82e <vprintf+0x29a>
 5a6:	e4a6                	sd	s1,72(sp)
 5a8:	fc4e                	sd	s3,56(sp)
 5aa:	f852                	sd	s4,48(sp)
 5ac:	f456                	sd	s5,40(sp)
 5ae:	f05a                	sd	s6,32(sp)
 5b0:	ec5e                	sd	s7,24(sp)
 5b2:	e862                	sd	s8,16(sp)
 5b4:	e466                	sd	s9,8(sp)
 5b6:	8b2a                	mv	s6,a0
 5b8:	8a2e                	mv	s4,a1
 5ba:	8bb2                	mv	s7,a2
  state = 0;
 5bc:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 5be:	4481                	li	s1,0
 5c0:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 5c2:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 5c6:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 5ca:	06c00c93          	li	s9,108
 5ce:	a005                	j	5ee <vprintf+0x5a>
        putc(fd, c0);
 5d0:	85ca                	mv	a1,s2
 5d2:	855a                	mv	a0,s6
 5d4:	f07ff0ef          	jal	4da <putc>
 5d8:	a019                	j	5de <vprintf+0x4a>
    } else if(state == '%'){
 5da:	03598263          	beq	s3,s5,5fe <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 5de:	2485                	addiw	s1,s1,1
 5e0:	8726                	mv	a4,s1
 5e2:	009a07b3          	add	a5,s4,s1
 5e6:	0007c903          	lbu	s2,0(a5)
 5ea:	22090a63          	beqz	s2,81e <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 5ee:	0009079b          	sext.w	a5,s2
    if(state == 0){
 5f2:	fe0994e3          	bnez	s3,5da <vprintf+0x46>
      if(c0 == '%'){
 5f6:	fd579de3          	bne	a5,s5,5d0 <vprintf+0x3c>
        state = '%';
 5fa:	89be                	mv	s3,a5
 5fc:	b7cd                	j	5de <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 5fe:	00ea06b3          	add	a3,s4,a4
 602:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 606:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 608:	c681                	beqz	a3,610 <vprintf+0x7c>
 60a:	9752                	add	a4,a4,s4
 60c:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 610:	05878363          	beq	a5,s8,656 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 614:	05978d63          	beq	a5,s9,66e <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 618:	07500713          	li	a4,117
 61c:	0ee78763          	beq	a5,a4,70a <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 620:	07800713          	li	a4,120
 624:	12e78963          	beq	a5,a4,756 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 628:	07000713          	li	a4,112
 62c:	14e78e63          	beq	a5,a4,788 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 630:	06300713          	li	a4,99
 634:	18e78e63          	beq	a5,a4,7d0 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 638:	07300713          	li	a4,115
 63c:	1ae78463          	beq	a5,a4,7e4 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 640:	02500713          	li	a4,37
 644:	04e79563          	bne	a5,a4,68e <vprintf+0xfa>
        putc(fd, '%');
 648:	02500593          	li	a1,37
 64c:	855a                	mv	a0,s6
 64e:	e8dff0ef          	jal	4da <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 652:	4981                	li	s3,0
 654:	b769                	j	5de <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 656:	008b8913          	addi	s2,s7,8
 65a:	4685                	li	a3,1
 65c:	4629                	li	a2,10
 65e:	000ba583          	lw	a1,0(s7)
 662:	855a                	mv	a0,s6
 664:	e95ff0ef          	jal	4f8 <printint>
 668:	8bca                	mv	s7,s2
      state = 0;
 66a:	4981                	li	s3,0
 66c:	bf8d                	j	5de <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 66e:	06400793          	li	a5,100
 672:	02f68963          	beq	a3,a5,6a4 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 676:	06c00793          	li	a5,108
 67a:	04f68263          	beq	a3,a5,6be <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 67e:	07500793          	li	a5,117
 682:	0af68063          	beq	a3,a5,722 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 686:	07800793          	li	a5,120
 68a:	0ef68263          	beq	a3,a5,76e <vprintf+0x1da>
        putc(fd, '%');
 68e:	02500593          	li	a1,37
 692:	855a                	mv	a0,s6
 694:	e47ff0ef          	jal	4da <putc>
        putc(fd, c0);
 698:	85ca                	mv	a1,s2
 69a:	855a                	mv	a0,s6
 69c:	e3fff0ef          	jal	4da <putc>
      state = 0;
 6a0:	4981                	li	s3,0
 6a2:	bf35                	j	5de <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6a4:	008b8913          	addi	s2,s7,8
 6a8:	4685                	li	a3,1
 6aa:	4629                	li	a2,10
 6ac:	000bb583          	ld	a1,0(s7)
 6b0:	855a                	mv	a0,s6
 6b2:	e47ff0ef          	jal	4f8 <printint>
        i += 1;
 6b6:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 6b8:	8bca                	mv	s7,s2
      state = 0;
 6ba:	4981                	li	s3,0
        i += 1;
 6bc:	b70d                	j	5de <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6be:	06400793          	li	a5,100
 6c2:	02f60763          	beq	a2,a5,6f0 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 6c6:	07500793          	li	a5,117
 6ca:	06f60963          	beq	a2,a5,73c <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 6ce:	07800793          	li	a5,120
 6d2:	faf61ee3          	bne	a2,a5,68e <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6d6:	008b8913          	addi	s2,s7,8
 6da:	4681                	li	a3,0
 6dc:	4641                	li	a2,16
 6de:	000bb583          	ld	a1,0(s7)
 6e2:	855a                	mv	a0,s6
 6e4:	e15ff0ef          	jal	4f8 <printint>
        i += 2;
 6e8:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 6ea:	8bca                	mv	s7,s2
      state = 0;
 6ec:	4981                	li	s3,0
        i += 2;
 6ee:	bdc5                	j	5de <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6f0:	008b8913          	addi	s2,s7,8
 6f4:	4685                	li	a3,1
 6f6:	4629                	li	a2,10
 6f8:	000bb583          	ld	a1,0(s7)
 6fc:	855a                	mv	a0,s6
 6fe:	dfbff0ef          	jal	4f8 <printint>
        i += 2;
 702:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 704:	8bca                	mv	s7,s2
      state = 0;
 706:	4981                	li	s3,0
        i += 2;
 708:	bdd9                	j	5de <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 70a:	008b8913          	addi	s2,s7,8
 70e:	4681                	li	a3,0
 710:	4629                	li	a2,10
 712:	000be583          	lwu	a1,0(s7)
 716:	855a                	mv	a0,s6
 718:	de1ff0ef          	jal	4f8 <printint>
 71c:	8bca                	mv	s7,s2
      state = 0;
 71e:	4981                	li	s3,0
 720:	bd7d                	j	5de <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 722:	008b8913          	addi	s2,s7,8
 726:	4681                	li	a3,0
 728:	4629                	li	a2,10
 72a:	000bb583          	ld	a1,0(s7)
 72e:	855a                	mv	a0,s6
 730:	dc9ff0ef          	jal	4f8 <printint>
        i += 1;
 734:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 736:	8bca                	mv	s7,s2
      state = 0;
 738:	4981                	li	s3,0
        i += 1;
 73a:	b555                	j	5de <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 73c:	008b8913          	addi	s2,s7,8
 740:	4681                	li	a3,0
 742:	4629                	li	a2,10
 744:	000bb583          	ld	a1,0(s7)
 748:	855a                	mv	a0,s6
 74a:	dafff0ef          	jal	4f8 <printint>
        i += 2;
 74e:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 750:	8bca                	mv	s7,s2
      state = 0;
 752:	4981                	li	s3,0
        i += 2;
 754:	b569                	j	5de <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 756:	008b8913          	addi	s2,s7,8
 75a:	4681                	li	a3,0
 75c:	4641                	li	a2,16
 75e:	000be583          	lwu	a1,0(s7)
 762:	855a                	mv	a0,s6
 764:	d95ff0ef          	jal	4f8 <printint>
 768:	8bca                	mv	s7,s2
      state = 0;
 76a:	4981                	li	s3,0
 76c:	bd8d                	j	5de <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 76e:	008b8913          	addi	s2,s7,8
 772:	4681                	li	a3,0
 774:	4641                	li	a2,16
 776:	000bb583          	ld	a1,0(s7)
 77a:	855a                	mv	a0,s6
 77c:	d7dff0ef          	jal	4f8 <printint>
        i += 1;
 780:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 782:	8bca                	mv	s7,s2
      state = 0;
 784:	4981                	li	s3,0
        i += 1;
 786:	bda1                	j	5de <vprintf+0x4a>
 788:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 78a:	008b8d13          	addi	s10,s7,8
 78e:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 792:	03000593          	li	a1,48
 796:	855a                	mv	a0,s6
 798:	d43ff0ef          	jal	4da <putc>
  putc(fd, 'x');
 79c:	07800593          	li	a1,120
 7a0:	855a                	mv	a0,s6
 7a2:	d39ff0ef          	jal	4da <putc>
 7a6:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7a8:	00000b97          	auipc	s7,0x0
 7ac:	2e8b8b93          	addi	s7,s7,744 # a90 <digits>
 7b0:	03c9d793          	srli	a5,s3,0x3c
 7b4:	97de                	add	a5,a5,s7
 7b6:	0007c583          	lbu	a1,0(a5)
 7ba:	855a                	mv	a0,s6
 7bc:	d1fff0ef          	jal	4da <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7c0:	0992                	slli	s3,s3,0x4
 7c2:	397d                	addiw	s2,s2,-1
 7c4:	fe0916e3          	bnez	s2,7b0 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 7c8:	8bea                	mv	s7,s10
      state = 0;
 7ca:	4981                	li	s3,0
 7cc:	6d02                	ld	s10,0(sp)
 7ce:	bd01                	j	5de <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 7d0:	008b8913          	addi	s2,s7,8
 7d4:	000bc583          	lbu	a1,0(s7)
 7d8:	855a                	mv	a0,s6
 7da:	d01ff0ef          	jal	4da <putc>
 7de:	8bca                	mv	s7,s2
      state = 0;
 7e0:	4981                	li	s3,0
 7e2:	bbf5                	j	5de <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 7e4:	008b8993          	addi	s3,s7,8
 7e8:	000bb903          	ld	s2,0(s7)
 7ec:	00090f63          	beqz	s2,80a <vprintf+0x276>
        for(; *s; s++)
 7f0:	00094583          	lbu	a1,0(s2)
 7f4:	c195                	beqz	a1,818 <vprintf+0x284>
          putc(fd, *s);
 7f6:	855a                	mv	a0,s6
 7f8:	ce3ff0ef          	jal	4da <putc>
        for(; *s; s++)
 7fc:	0905                	addi	s2,s2,1
 7fe:	00094583          	lbu	a1,0(s2)
 802:	f9f5                	bnez	a1,7f6 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 804:	8bce                	mv	s7,s3
      state = 0;
 806:	4981                	li	s3,0
 808:	bbd9                	j	5de <vprintf+0x4a>
          s = "(null)";
 80a:	00000917          	auipc	s2,0x0
 80e:	27e90913          	addi	s2,s2,638 # a88 <malloc+0x172>
        for(; *s; s++)
 812:	02800593          	li	a1,40
 816:	b7c5                	j	7f6 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 818:	8bce                	mv	s7,s3
      state = 0;
 81a:	4981                	li	s3,0
 81c:	b3c9                	j	5de <vprintf+0x4a>
 81e:	64a6                	ld	s1,72(sp)
 820:	79e2                	ld	s3,56(sp)
 822:	7a42                	ld	s4,48(sp)
 824:	7aa2                	ld	s5,40(sp)
 826:	7b02                	ld	s6,32(sp)
 828:	6be2                	ld	s7,24(sp)
 82a:	6c42                	ld	s8,16(sp)
 82c:	6ca2                	ld	s9,8(sp)
    }
  }
}
 82e:	60e6                	ld	ra,88(sp)
 830:	6446                	ld	s0,80(sp)
 832:	6906                	ld	s2,64(sp)
 834:	6125                	addi	sp,sp,96
 836:	8082                	ret

0000000000000838 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 838:	715d                	addi	sp,sp,-80
 83a:	ec06                	sd	ra,24(sp)
 83c:	e822                	sd	s0,16(sp)
 83e:	1000                	addi	s0,sp,32
 840:	e010                	sd	a2,0(s0)
 842:	e414                	sd	a3,8(s0)
 844:	e818                	sd	a4,16(s0)
 846:	ec1c                	sd	a5,24(s0)
 848:	03043023          	sd	a6,32(s0)
 84c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 850:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 854:	8622                	mv	a2,s0
 856:	d3fff0ef          	jal	594 <vprintf>
}
 85a:	60e2                	ld	ra,24(sp)
 85c:	6442                	ld	s0,16(sp)
 85e:	6161                	addi	sp,sp,80
 860:	8082                	ret

0000000000000862 <printf>:

void
printf(const char *fmt, ...)
{
 862:	711d                	addi	sp,sp,-96
 864:	ec06                	sd	ra,24(sp)
 866:	e822                	sd	s0,16(sp)
 868:	1000                	addi	s0,sp,32
 86a:	e40c                	sd	a1,8(s0)
 86c:	e810                	sd	a2,16(s0)
 86e:	ec14                	sd	a3,24(s0)
 870:	f018                	sd	a4,32(s0)
 872:	f41c                	sd	a5,40(s0)
 874:	03043823          	sd	a6,48(s0)
 878:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 87c:	00840613          	addi	a2,s0,8
 880:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 884:	85aa                	mv	a1,a0
 886:	4505                	li	a0,1
 888:	d0dff0ef          	jal	594 <vprintf>
}
 88c:	60e2                	ld	ra,24(sp)
 88e:	6442                	ld	s0,16(sp)
 890:	6125                	addi	sp,sp,96
 892:	8082                	ret

0000000000000894 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 894:	1141                	addi	sp,sp,-16
 896:	e422                	sd	s0,8(sp)
 898:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 89a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 89e:	00000797          	auipc	a5,0x0
 8a2:	7727b783          	ld	a5,1906(a5) # 1010 <freep>
 8a6:	a02d                	j	8d0 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8a8:	4618                	lw	a4,8(a2)
 8aa:	9f2d                	addw	a4,a4,a1
 8ac:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8b0:	6398                	ld	a4,0(a5)
 8b2:	6310                	ld	a2,0(a4)
 8b4:	a83d                	j	8f2 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8b6:	ff852703          	lw	a4,-8(a0)
 8ba:	9f31                	addw	a4,a4,a2
 8bc:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8be:	ff053683          	ld	a3,-16(a0)
 8c2:	a091                	j	906 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8c4:	6398                	ld	a4,0(a5)
 8c6:	00e7e463          	bltu	a5,a4,8ce <free+0x3a>
 8ca:	00e6ea63          	bltu	a3,a4,8de <free+0x4a>
{
 8ce:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8d0:	fed7fae3          	bgeu	a5,a3,8c4 <free+0x30>
 8d4:	6398                	ld	a4,0(a5)
 8d6:	00e6e463          	bltu	a3,a4,8de <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8da:	fee7eae3          	bltu	a5,a4,8ce <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 8de:	ff852583          	lw	a1,-8(a0)
 8e2:	6390                	ld	a2,0(a5)
 8e4:	02059813          	slli	a6,a1,0x20
 8e8:	01c85713          	srli	a4,a6,0x1c
 8ec:	9736                	add	a4,a4,a3
 8ee:	fae60de3          	beq	a2,a4,8a8 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 8f2:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8f6:	4790                	lw	a2,8(a5)
 8f8:	02061593          	slli	a1,a2,0x20
 8fc:	01c5d713          	srli	a4,a1,0x1c
 900:	973e                	add	a4,a4,a5
 902:	fae68ae3          	beq	a3,a4,8b6 <free+0x22>
    p->s.ptr = bp->s.ptr;
 906:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 908:	00000717          	auipc	a4,0x0
 90c:	70f73423          	sd	a5,1800(a4) # 1010 <freep>
}
 910:	6422                	ld	s0,8(sp)
 912:	0141                	addi	sp,sp,16
 914:	8082                	ret

0000000000000916 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 916:	7139                	addi	sp,sp,-64
 918:	fc06                	sd	ra,56(sp)
 91a:	f822                	sd	s0,48(sp)
 91c:	f426                	sd	s1,40(sp)
 91e:	ec4e                	sd	s3,24(sp)
 920:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 922:	02051493          	slli	s1,a0,0x20
 926:	9081                	srli	s1,s1,0x20
 928:	04bd                	addi	s1,s1,15
 92a:	8091                	srli	s1,s1,0x4
 92c:	0014899b          	addiw	s3,s1,1
 930:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 932:	00000517          	auipc	a0,0x0
 936:	6de53503          	ld	a0,1758(a0) # 1010 <freep>
 93a:	c915                	beqz	a0,96e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 93c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 93e:	4798                	lw	a4,8(a5)
 940:	08977a63          	bgeu	a4,s1,9d4 <malloc+0xbe>
 944:	f04a                	sd	s2,32(sp)
 946:	e852                	sd	s4,16(sp)
 948:	e456                	sd	s5,8(sp)
 94a:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 94c:	8a4e                	mv	s4,s3
 94e:	0009871b          	sext.w	a4,s3
 952:	6685                	lui	a3,0x1
 954:	00d77363          	bgeu	a4,a3,95a <malloc+0x44>
 958:	6a05                	lui	s4,0x1
 95a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 95e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 962:	00000917          	auipc	s2,0x0
 966:	6ae90913          	addi	s2,s2,1710 # 1010 <freep>
  if(p == SBRK_ERROR)
 96a:	5afd                	li	s5,-1
 96c:	a081                	j	9ac <malloc+0x96>
 96e:	f04a                	sd	s2,32(sp)
 970:	e852                	sd	s4,16(sp)
 972:	e456                	sd	s5,8(sp)
 974:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 976:	00000797          	auipc	a5,0x0
 97a:	6aa78793          	addi	a5,a5,1706 # 1020 <base>
 97e:	00000717          	auipc	a4,0x0
 982:	68f73923          	sd	a5,1682(a4) # 1010 <freep>
 986:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 988:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 98c:	b7c1                	j	94c <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 98e:	6398                	ld	a4,0(a5)
 990:	e118                	sd	a4,0(a0)
 992:	a8a9                	j	9ec <malloc+0xd6>
  hp->s.size = nu;
 994:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 998:	0541                	addi	a0,a0,16
 99a:	efbff0ef          	jal	894 <free>
  return freep;
 99e:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9a2:	c12d                	beqz	a0,a04 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9a4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9a6:	4798                	lw	a4,8(a5)
 9a8:	02977263          	bgeu	a4,s1,9cc <malloc+0xb6>
    if(p == freep)
 9ac:	00093703          	ld	a4,0(s2)
 9b0:	853e                	mv	a0,a5
 9b2:	fef719e3          	bne	a4,a5,9a4 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 9b6:	8552                	mv	a0,s4
 9b8:	965ff0ef          	jal	31c <sbrk>
  if(p == SBRK_ERROR)
 9bc:	fd551ce3          	bne	a0,s5,994 <malloc+0x7e>
        return 0;
 9c0:	4501                	li	a0,0
 9c2:	7902                	ld	s2,32(sp)
 9c4:	6a42                	ld	s4,16(sp)
 9c6:	6aa2                	ld	s5,8(sp)
 9c8:	6b02                	ld	s6,0(sp)
 9ca:	a03d                	j	9f8 <malloc+0xe2>
 9cc:	7902                	ld	s2,32(sp)
 9ce:	6a42                	ld	s4,16(sp)
 9d0:	6aa2                	ld	s5,8(sp)
 9d2:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 9d4:	fae48de3          	beq	s1,a4,98e <malloc+0x78>
        p->s.size -= nunits;
 9d8:	4137073b          	subw	a4,a4,s3
 9dc:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9de:	02071693          	slli	a3,a4,0x20
 9e2:	01c6d713          	srli	a4,a3,0x1c
 9e6:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9e8:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9ec:	00000717          	auipc	a4,0x0
 9f0:	62a73223          	sd	a0,1572(a4) # 1010 <freep>
      return (void*)(p + 1);
 9f4:	01078513          	addi	a0,a5,16
  }
}
 9f8:	70e2                	ld	ra,56(sp)
 9fa:	7442                	ld	s0,48(sp)
 9fc:	74a2                	ld	s1,40(sp)
 9fe:	69e2                	ld	s3,24(sp)
 a00:	6121                	addi	sp,sp,64
 a02:	8082                	ret
 a04:	7902                	ld	s2,32(sp)
 a06:	6a42                	ld	s4,16(sp)
 a08:	6aa2                	ld	s5,8(sp)
 a0a:	6b02                	ld	s6,0(sp)
 a0c:	b7f5                	j	9f8 <malloc+0xe2>
