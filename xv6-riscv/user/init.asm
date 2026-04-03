
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
  12:	9e250513          	addi	a0,a0,-1566 # 9f0 <malloc+0xfc>
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
  2e:	9ce90913          	addi	s2,s2,-1586 # 9f8 <malloc+0x104>
  32:	854a                	mv	a0,s2
  34:	00d000ef          	jal	840 <printf>
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
  56:	9f650513          	addi	a0,a0,-1546 # a48 <malloc+0x154>
  5a:	7e6000ef          	jal	840 <printf>
        exit(1);
  5e:	4505                	li	a0,1
  60:	380000ef          	jal	3e0 <exit>
    mknod("console", CONSOLE, 0);
  64:	4601                	li	a2,0
  66:	4585                	li	a1,1
  68:	00001517          	auipc	a0,0x1
  6c:	98850513          	addi	a0,a0,-1656 # 9f0 <malloc+0xfc>
  70:	3b8000ef          	jal	428 <mknod>
    open("console", O_RDWR);
  74:	4589                	li	a1,2
  76:	00001517          	auipc	a0,0x1
  7a:	97a50513          	addi	a0,a0,-1670 # 9f0 <malloc+0xfc>
  7e:	3a2000ef          	jal	420 <open>
  82:	bf71                	j	1e <main+0x1e>
      printf("init: fork failed\n");
  84:	00001517          	auipc	a0,0x1
  88:	98c50513          	addi	a0,a0,-1652 # a10 <malloc+0x11c>
  8c:	7b4000ef          	jal	840 <printf>
      exit(1);
  90:	4505                	li	a0,1
  92:	34e000ef          	jal	3e0 <exit>
      exec("sh", argv);
  96:	00001597          	auipc	a1,0x1
  9a:	f6a58593          	addi	a1,a1,-150 # 1000 <argv>
  9e:	00001517          	auipc	a0,0x1
  a2:	98a50513          	addi	a0,a0,-1654 # a28 <malloc+0x134>
  a6:	372000ef          	jal	418 <exec>
      printf("init: exec sh failed\n");
  aa:	00001517          	auipc	a0,0x1
  ae:	98650513          	addi	a0,a0,-1658 # a30 <malloc+0x13c>
  b2:	78e000ef          	jal	840 <printf>
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
 35e:	596000ef          	jal	8f4 <malloc>
  if(s == 0)
 362:	cd0d                	beqz	a0,39c <thread_create+0x54>
 364:	ec26                	sd	s1,24(sp)
 366:	84aa                	mv	s1,a0
    return -1;
  *stack = s;
 368:	00a93023          	sd	a0,0(s2)
  // Stack grows downward: pass the top of the allocated region.
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
 38e:	4e4000ef          	jal	872 <free>
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
// Returns the joined thread's pid, or -1 on error.
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
 3be:	4b4000ef          	jal	872 <free>
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

00000000000004b8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4b8:	1101                	addi	sp,sp,-32
 4ba:	ec06                	sd	ra,24(sp)
 4bc:	e822                	sd	s0,16(sp)
 4be:	1000                	addi	s0,sp,32
 4c0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4c4:	4605                	li	a2,1
 4c6:	fef40593          	addi	a1,s0,-17
 4ca:	f37ff0ef          	jal	400 <write>
}
 4ce:	60e2                	ld	ra,24(sp)
 4d0:	6442                	ld	s0,16(sp)
 4d2:	6105                	addi	sp,sp,32
 4d4:	8082                	ret

00000000000004d6 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 4d6:	715d                	addi	sp,sp,-80
 4d8:	e486                	sd	ra,72(sp)
 4da:	e0a2                	sd	s0,64(sp)
 4dc:	f84a                	sd	s2,48(sp)
 4de:	0880                	addi	s0,sp,80
 4e0:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 4e2:	c299                	beqz	a3,4e8 <printint+0x12>
 4e4:	0805c363          	bltz	a1,56a <printint+0x94>
  neg = 0;
 4e8:	4881                	li	a7,0
 4ea:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 4ee:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 4f0:	00000517          	auipc	a0,0x0
 4f4:	58050513          	addi	a0,a0,1408 # a70 <digits>
 4f8:	883e                	mv	a6,a5
 4fa:	2785                	addiw	a5,a5,1
 4fc:	02c5f733          	remu	a4,a1,a2
 500:	972a                	add	a4,a4,a0
 502:	00074703          	lbu	a4,0(a4)
 506:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 50a:	872e                	mv	a4,a1
 50c:	02c5d5b3          	divu	a1,a1,a2
 510:	0685                	addi	a3,a3,1
 512:	fec773e3          	bgeu	a4,a2,4f8 <printint+0x22>
  if(neg)
 516:	00088b63          	beqz	a7,52c <printint+0x56>
    buf[i++] = '-';
 51a:	fd078793          	addi	a5,a5,-48
 51e:	97a2                	add	a5,a5,s0
 520:	02d00713          	li	a4,45
 524:	fee78423          	sb	a4,-24(a5)
 528:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 52c:	02f05a63          	blez	a5,560 <printint+0x8a>
 530:	fc26                	sd	s1,56(sp)
 532:	f44e                	sd	s3,40(sp)
 534:	fb840713          	addi	a4,s0,-72
 538:	00f704b3          	add	s1,a4,a5
 53c:	fff70993          	addi	s3,a4,-1
 540:	99be                	add	s3,s3,a5
 542:	37fd                	addiw	a5,a5,-1
 544:	1782                	slli	a5,a5,0x20
 546:	9381                	srli	a5,a5,0x20
 548:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 54c:	fff4c583          	lbu	a1,-1(s1)
 550:	854a                	mv	a0,s2
 552:	f67ff0ef          	jal	4b8 <putc>
  while(--i >= 0)
 556:	14fd                	addi	s1,s1,-1
 558:	ff349ae3          	bne	s1,s3,54c <printint+0x76>
 55c:	74e2                	ld	s1,56(sp)
 55e:	79a2                	ld	s3,40(sp)
}
 560:	60a6                	ld	ra,72(sp)
 562:	6406                	ld	s0,64(sp)
 564:	7942                	ld	s2,48(sp)
 566:	6161                	addi	sp,sp,80
 568:	8082                	ret
    x = -xx;
 56a:	40b005b3          	neg	a1,a1
    neg = 1;
 56e:	4885                	li	a7,1
    x = -xx;
 570:	bfad                	j	4ea <printint+0x14>

0000000000000572 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 572:	711d                	addi	sp,sp,-96
 574:	ec86                	sd	ra,88(sp)
 576:	e8a2                	sd	s0,80(sp)
 578:	e0ca                	sd	s2,64(sp)
 57a:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 57c:	0005c903          	lbu	s2,0(a1)
 580:	28090663          	beqz	s2,80c <vprintf+0x29a>
 584:	e4a6                	sd	s1,72(sp)
 586:	fc4e                	sd	s3,56(sp)
 588:	f852                	sd	s4,48(sp)
 58a:	f456                	sd	s5,40(sp)
 58c:	f05a                	sd	s6,32(sp)
 58e:	ec5e                	sd	s7,24(sp)
 590:	e862                	sd	s8,16(sp)
 592:	e466                	sd	s9,8(sp)
 594:	8b2a                	mv	s6,a0
 596:	8a2e                	mv	s4,a1
 598:	8bb2                	mv	s7,a2
  state = 0;
 59a:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 59c:	4481                	li	s1,0
 59e:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 5a0:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 5a4:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 5a8:	06c00c93          	li	s9,108
 5ac:	a005                	j	5cc <vprintf+0x5a>
        putc(fd, c0);
 5ae:	85ca                	mv	a1,s2
 5b0:	855a                	mv	a0,s6
 5b2:	f07ff0ef          	jal	4b8 <putc>
 5b6:	a019                	j	5bc <vprintf+0x4a>
    } else if(state == '%'){
 5b8:	03598263          	beq	s3,s5,5dc <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 5bc:	2485                	addiw	s1,s1,1
 5be:	8726                	mv	a4,s1
 5c0:	009a07b3          	add	a5,s4,s1
 5c4:	0007c903          	lbu	s2,0(a5)
 5c8:	22090a63          	beqz	s2,7fc <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 5cc:	0009079b          	sext.w	a5,s2
    if(state == 0){
 5d0:	fe0994e3          	bnez	s3,5b8 <vprintf+0x46>
      if(c0 == '%'){
 5d4:	fd579de3          	bne	a5,s5,5ae <vprintf+0x3c>
        state = '%';
 5d8:	89be                	mv	s3,a5
 5da:	b7cd                	j	5bc <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 5dc:	00ea06b3          	add	a3,s4,a4
 5e0:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 5e4:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 5e6:	c681                	beqz	a3,5ee <vprintf+0x7c>
 5e8:	9752                	add	a4,a4,s4
 5ea:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 5ee:	05878363          	beq	a5,s8,634 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 5f2:	05978d63          	beq	a5,s9,64c <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 5f6:	07500713          	li	a4,117
 5fa:	0ee78763          	beq	a5,a4,6e8 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 5fe:	07800713          	li	a4,120
 602:	12e78963          	beq	a5,a4,734 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 606:	07000713          	li	a4,112
 60a:	14e78e63          	beq	a5,a4,766 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 60e:	06300713          	li	a4,99
 612:	18e78e63          	beq	a5,a4,7ae <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 616:	07300713          	li	a4,115
 61a:	1ae78463          	beq	a5,a4,7c2 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 61e:	02500713          	li	a4,37
 622:	04e79563          	bne	a5,a4,66c <vprintf+0xfa>
        putc(fd, '%');
 626:	02500593          	li	a1,37
 62a:	855a                	mv	a0,s6
 62c:	e8dff0ef          	jal	4b8 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 630:	4981                	li	s3,0
 632:	b769                	j	5bc <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 634:	008b8913          	addi	s2,s7,8
 638:	4685                	li	a3,1
 63a:	4629                	li	a2,10
 63c:	000ba583          	lw	a1,0(s7)
 640:	855a                	mv	a0,s6
 642:	e95ff0ef          	jal	4d6 <printint>
 646:	8bca                	mv	s7,s2
      state = 0;
 648:	4981                	li	s3,0
 64a:	bf8d                	j	5bc <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 64c:	06400793          	li	a5,100
 650:	02f68963          	beq	a3,a5,682 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 654:	06c00793          	li	a5,108
 658:	04f68263          	beq	a3,a5,69c <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 65c:	07500793          	li	a5,117
 660:	0af68063          	beq	a3,a5,700 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 664:	07800793          	li	a5,120
 668:	0ef68263          	beq	a3,a5,74c <vprintf+0x1da>
        putc(fd, '%');
 66c:	02500593          	li	a1,37
 670:	855a                	mv	a0,s6
 672:	e47ff0ef          	jal	4b8 <putc>
        putc(fd, c0);
 676:	85ca                	mv	a1,s2
 678:	855a                	mv	a0,s6
 67a:	e3fff0ef          	jal	4b8 <putc>
      state = 0;
 67e:	4981                	li	s3,0
 680:	bf35                	j	5bc <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 682:	008b8913          	addi	s2,s7,8
 686:	4685                	li	a3,1
 688:	4629                	li	a2,10
 68a:	000bb583          	ld	a1,0(s7)
 68e:	855a                	mv	a0,s6
 690:	e47ff0ef          	jal	4d6 <printint>
        i += 1;
 694:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 696:	8bca                	mv	s7,s2
      state = 0;
 698:	4981                	li	s3,0
        i += 1;
 69a:	b70d                	j	5bc <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 69c:	06400793          	li	a5,100
 6a0:	02f60763          	beq	a2,a5,6ce <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 6a4:	07500793          	li	a5,117
 6a8:	06f60963          	beq	a2,a5,71a <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 6ac:	07800793          	li	a5,120
 6b0:	faf61ee3          	bne	a2,a5,66c <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6b4:	008b8913          	addi	s2,s7,8
 6b8:	4681                	li	a3,0
 6ba:	4641                	li	a2,16
 6bc:	000bb583          	ld	a1,0(s7)
 6c0:	855a                	mv	a0,s6
 6c2:	e15ff0ef          	jal	4d6 <printint>
        i += 2;
 6c6:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 6c8:	8bca                	mv	s7,s2
      state = 0;
 6ca:	4981                	li	s3,0
        i += 2;
 6cc:	bdc5                	j	5bc <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6ce:	008b8913          	addi	s2,s7,8
 6d2:	4685                	li	a3,1
 6d4:	4629                	li	a2,10
 6d6:	000bb583          	ld	a1,0(s7)
 6da:	855a                	mv	a0,s6
 6dc:	dfbff0ef          	jal	4d6 <printint>
        i += 2;
 6e0:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 6e2:	8bca                	mv	s7,s2
      state = 0;
 6e4:	4981                	li	s3,0
        i += 2;
 6e6:	bdd9                	j	5bc <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 6e8:	008b8913          	addi	s2,s7,8
 6ec:	4681                	li	a3,0
 6ee:	4629                	li	a2,10
 6f0:	000be583          	lwu	a1,0(s7)
 6f4:	855a                	mv	a0,s6
 6f6:	de1ff0ef          	jal	4d6 <printint>
 6fa:	8bca                	mv	s7,s2
      state = 0;
 6fc:	4981                	li	s3,0
 6fe:	bd7d                	j	5bc <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 700:	008b8913          	addi	s2,s7,8
 704:	4681                	li	a3,0
 706:	4629                	li	a2,10
 708:	000bb583          	ld	a1,0(s7)
 70c:	855a                	mv	a0,s6
 70e:	dc9ff0ef          	jal	4d6 <printint>
        i += 1;
 712:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 714:	8bca                	mv	s7,s2
      state = 0;
 716:	4981                	li	s3,0
        i += 1;
 718:	b555                	j	5bc <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 71a:	008b8913          	addi	s2,s7,8
 71e:	4681                	li	a3,0
 720:	4629                	li	a2,10
 722:	000bb583          	ld	a1,0(s7)
 726:	855a                	mv	a0,s6
 728:	dafff0ef          	jal	4d6 <printint>
        i += 2;
 72c:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 72e:	8bca                	mv	s7,s2
      state = 0;
 730:	4981                	li	s3,0
        i += 2;
 732:	b569                	j	5bc <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 734:	008b8913          	addi	s2,s7,8
 738:	4681                	li	a3,0
 73a:	4641                	li	a2,16
 73c:	000be583          	lwu	a1,0(s7)
 740:	855a                	mv	a0,s6
 742:	d95ff0ef          	jal	4d6 <printint>
 746:	8bca                	mv	s7,s2
      state = 0;
 748:	4981                	li	s3,0
 74a:	bd8d                	j	5bc <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 74c:	008b8913          	addi	s2,s7,8
 750:	4681                	li	a3,0
 752:	4641                	li	a2,16
 754:	000bb583          	ld	a1,0(s7)
 758:	855a                	mv	a0,s6
 75a:	d7dff0ef          	jal	4d6 <printint>
        i += 1;
 75e:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 760:	8bca                	mv	s7,s2
      state = 0;
 762:	4981                	li	s3,0
        i += 1;
 764:	bda1                	j	5bc <vprintf+0x4a>
 766:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 768:	008b8d13          	addi	s10,s7,8
 76c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 770:	03000593          	li	a1,48
 774:	855a                	mv	a0,s6
 776:	d43ff0ef          	jal	4b8 <putc>
  putc(fd, 'x');
 77a:	07800593          	li	a1,120
 77e:	855a                	mv	a0,s6
 780:	d39ff0ef          	jal	4b8 <putc>
 784:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 786:	00000b97          	auipc	s7,0x0
 78a:	2eab8b93          	addi	s7,s7,746 # a70 <digits>
 78e:	03c9d793          	srli	a5,s3,0x3c
 792:	97de                	add	a5,a5,s7
 794:	0007c583          	lbu	a1,0(a5)
 798:	855a                	mv	a0,s6
 79a:	d1fff0ef          	jal	4b8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 79e:	0992                	slli	s3,s3,0x4
 7a0:	397d                	addiw	s2,s2,-1
 7a2:	fe0916e3          	bnez	s2,78e <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 7a6:	8bea                	mv	s7,s10
      state = 0;
 7a8:	4981                	li	s3,0
 7aa:	6d02                	ld	s10,0(sp)
 7ac:	bd01                	j	5bc <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 7ae:	008b8913          	addi	s2,s7,8
 7b2:	000bc583          	lbu	a1,0(s7)
 7b6:	855a                	mv	a0,s6
 7b8:	d01ff0ef          	jal	4b8 <putc>
 7bc:	8bca                	mv	s7,s2
      state = 0;
 7be:	4981                	li	s3,0
 7c0:	bbf5                	j	5bc <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 7c2:	008b8993          	addi	s3,s7,8
 7c6:	000bb903          	ld	s2,0(s7)
 7ca:	00090f63          	beqz	s2,7e8 <vprintf+0x276>
        for(; *s; s++)
 7ce:	00094583          	lbu	a1,0(s2)
 7d2:	c195                	beqz	a1,7f6 <vprintf+0x284>
          putc(fd, *s);
 7d4:	855a                	mv	a0,s6
 7d6:	ce3ff0ef          	jal	4b8 <putc>
        for(; *s; s++)
 7da:	0905                	addi	s2,s2,1
 7dc:	00094583          	lbu	a1,0(s2)
 7e0:	f9f5                	bnez	a1,7d4 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 7e2:	8bce                	mv	s7,s3
      state = 0;
 7e4:	4981                	li	s3,0
 7e6:	bbd9                	j	5bc <vprintf+0x4a>
          s = "(null)";
 7e8:	00000917          	auipc	s2,0x0
 7ec:	28090913          	addi	s2,s2,640 # a68 <malloc+0x174>
        for(; *s; s++)
 7f0:	02800593          	li	a1,40
 7f4:	b7c5                	j	7d4 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 7f6:	8bce                	mv	s7,s3
      state = 0;
 7f8:	4981                	li	s3,0
 7fa:	b3c9                	j	5bc <vprintf+0x4a>
 7fc:	64a6                	ld	s1,72(sp)
 7fe:	79e2                	ld	s3,56(sp)
 800:	7a42                	ld	s4,48(sp)
 802:	7aa2                	ld	s5,40(sp)
 804:	7b02                	ld	s6,32(sp)
 806:	6be2                	ld	s7,24(sp)
 808:	6c42                	ld	s8,16(sp)
 80a:	6ca2                	ld	s9,8(sp)
    }
  }
}
 80c:	60e6                	ld	ra,88(sp)
 80e:	6446                	ld	s0,80(sp)
 810:	6906                	ld	s2,64(sp)
 812:	6125                	addi	sp,sp,96
 814:	8082                	ret

0000000000000816 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 816:	715d                	addi	sp,sp,-80
 818:	ec06                	sd	ra,24(sp)
 81a:	e822                	sd	s0,16(sp)
 81c:	1000                	addi	s0,sp,32
 81e:	e010                	sd	a2,0(s0)
 820:	e414                	sd	a3,8(s0)
 822:	e818                	sd	a4,16(s0)
 824:	ec1c                	sd	a5,24(s0)
 826:	03043023          	sd	a6,32(s0)
 82a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 82e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 832:	8622                	mv	a2,s0
 834:	d3fff0ef          	jal	572 <vprintf>
}
 838:	60e2                	ld	ra,24(sp)
 83a:	6442                	ld	s0,16(sp)
 83c:	6161                	addi	sp,sp,80
 83e:	8082                	ret

0000000000000840 <printf>:

void
printf(const char *fmt, ...)
{
 840:	711d                	addi	sp,sp,-96
 842:	ec06                	sd	ra,24(sp)
 844:	e822                	sd	s0,16(sp)
 846:	1000                	addi	s0,sp,32
 848:	e40c                	sd	a1,8(s0)
 84a:	e810                	sd	a2,16(s0)
 84c:	ec14                	sd	a3,24(s0)
 84e:	f018                	sd	a4,32(s0)
 850:	f41c                	sd	a5,40(s0)
 852:	03043823          	sd	a6,48(s0)
 856:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 85a:	00840613          	addi	a2,s0,8
 85e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 862:	85aa                	mv	a1,a0
 864:	4505                	li	a0,1
 866:	d0dff0ef          	jal	572 <vprintf>
}
 86a:	60e2                	ld	ra,24(sp)
 86c:	6442                	ld	s0,16(sp)
 86e:	6125                	addi	sp,sp,96
 870:	8082                	ret

0000000000000872 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 872:	1141                	addi	sp,sp,-16
 874:	e422                	sd	s0,8(sp)
 876:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 878:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 87c:	00000797          	auipc	a5,0x0
 880:	7947b783          	ld	a5,1940(a5) # 1010 <freep>
 884:	a02d                	j	8ae <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 886:	4618                	lw	a4,8(a2)
 888:	9f2d                	addw	a4,a4,a1
 88a:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 88e:	6398                	ld	a4,0(a5)
 890:	6310                	ld	a2,0(a4)
 892:	a83d                	j	8d0 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 894:	ff852703          	lw	a4,-8(a0)
 898:	9f31                	addw	a4,a4,a2
 89a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 89c:	ff053683          	ld	a3,-16(a0)
 8a0:	a091                	j	8e4 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8a2:	6398                	ld	a4,0(a5)
 8a4:	00e7e463          	bltu	a5,a4,8ac <free+0x3a>
 8a8:	00e6ea63          	bltu	a3,a4,8bc <free+0x4a>
{
 8ac:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8ae:	fed7fae3          	bgeu	a5,a3,8a2 <free+0x30>
 8b2:	6398                	ld	a4,0(a5)
 8b4:	00e6e463          	bltu	a3,a4,8bc <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8b8:	fee7eae3          	bltu	a5,a4,8ac <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 8bc:	ff852583          	lw	a1,-8(a0)
 8c0:	6390                	ld	a2,0(a5)
 8c2:	02059813          	slli	a6,a1,0x20
 8c6:	01c85713          	srli	a4,a6,0x1c
 8ca:	9736                	add	a4,a4,a3
 8cc:	fae60de3          	beq	a2,a4,886 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 8d0:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8d4:	4790                	lw	a2,8(a5)
 8d6:	02061593          	slli	a1,a2,0x20
 8da:	01c5d713          	srli	a4,a1,0x1c
 8de:	973e                	add	a4,a4,a5
 8e0:	fae68ae3          	beq	a3,a4,894 <free+0x22>
    p->s.ptr = bp->s.ptr;
 8e4:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 8e6:	00000717          	auipc	a4,0x0
 8ea:	72f73523          	sd	a5,1834(a4) # 1010 <freep>
}
 8ee:	6422                	ld	s0,8(sp)
 8f0:	0141                	addi	sp,sp,16
 8f2:	8082                	ret

00000000000008f4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8f4:	7139                	addi	sp,sp,-64
 8f6:	fc06                	sd	ra,56(sp)
 8f8:	f822                	sd	s0,48(sp)
 8fa:	f426                	sd	s1,40(sp)
 8fc:	ec4e                	sd	s3,24(sp)
 8fe:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 900:	02051493          	slli	s1,a0,0x20
 904:	9081                	srli	s1,s1,0x20
 906:	04bd                	addi	s1,s1,15
 908:	8091                	srli	s1,s1,0x4
 90a:	0014899b          	addiw	s3,s1,1
 90e:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 910:	00000517          	auipc	a0,0x0
 914:	70053503          	ld	a0,1792(a0) # 1010 <freep>
 918:	c915                	beqz	a0,94c <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 91a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 91c:	4798                	lw	a4,8(a5)
 91e:	08977a63          	bgeu	a4,s1,9b2 <malloc+0xbe>
 922:	f04a                	sd	s2,32(sp)
 924:	e852                	sd	s4,16(sp)
 926:	e456                	sd	s5,8(sp)
 928:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 92a:	8a4e                	mv	s4,s3
 92c:	0009871b          	sext.w	a4,s3
 930:	6685                	lui	a3,0x1
 932:	00d77363          	bgeu	a4,a3,938 <malloc+0x44>
 936:	6a05                	lui	s4,0x1
 938:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 93c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 940:	00000917          	auipc	s2,0x0
 944:	6d090913          	addi	s2,s2,1744 # 1010 <freep>
  if(p == SBRK_ERROR)
 948:	5afd                	li	s5,-1
 94a:	a081                	j	98a <malloc+0x96>
 94c:	f04a                	sd	s2,32(sp)
 94e:	e852                	sd	s4,16(sp)
 950:	e456                	sd	s5,8(sp)
 952:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 954:	00000797          	auipc	a5,0x0
 958:	6cc78793          	addi	a5,a5,1740 # 1020 <base>
 95c:	00000717          	auipc	a4,0x0
 960:	6af73a23          	sd	a5,1716(a4) # 1010 <freep>
 964:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 966:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 96a:	b7c1                	j	92a <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 96c:	6398                	ld	a4,0(a5)
 96e:	e118                	sd	a4,0(a0)
 970:	a8a9                	j	9ca <malloc+0xd6>
  hp->s.size = nu;
 972:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 976:	0541                	addi	a0,a0,16
 978:	efbff0ef          	jal	872 <free>
  return freep;
 97c:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 980:	c12d                	beqz	a0,9e2 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 982:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 984:	4798                	lw	a4,8(a5)
 986:	02977263          	bgeu	a4,s1,9aa <malloc+0xb6>
    if(p == freep)
 98a:	00093703          	ld	a4,0(s2)
 98e:	853e                	mv	a0,a5
 990:	fef719e3          	bne	a4,a5,982 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 994:	8552                	mv	a0,s4
 996:	987ff0ef          	jal	31c <sbrk>
  if(p == SBRK_ERROR)
 99a:	fd551ce3          	bne	a0,s5,972 <malloc+0x7e>
        return 0;
 99e:	4501                	li	a0,0
 9a0:	7902                	ld	s2,32(sp)
 9a2:	6a42                	ld	s4,16(sp)
 9a4:	6aa2                	ld	s5,8(sp)
 9a6:	6b02                	ld	s6,0(sp)
 9a8:	a03d                	j	9d6 <malloc+0xe2>
 9aa:	7902                	ld	s2,32(sp)
 9ac:	6a42                	ld	s4,16(sp)
 9ae:	6aa2                	ld	s5,8(sp)
 9b0:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 9b2:	fae48de3          	beq	s1,a4,96c <malloc+0x78>
        p->s.size -= nunits;
 9b6:	4137073b          	subw	a4,a4,s3
 9ba:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9bc:	02071693          	slli	a3,a4,0x20
 9c0:	01c6d713          	srli	a4,a3,0x1c
 9c4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9c6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9ca:	00000717          	auipc	a4,0x0
 9ce:	64a73323          	sd	a0,1606(a4) # 1010 <freep>
      return (void*)(p + 1);
 9d2:	01078513          	addi	a0,a5,16
  }
}
 9d6:	70e2                	ld	ra,56(sp)
 9d8:	7442                	ld	s0,48(sp)
 9da:	74a2                	ld	s1,40(sp)
 9dc:	69e2                	ld	s3,24(sp)
 9de:	6121                	addi	sp,sp,64
 9e0:	8082                	ret
 9e2:	7902                	ld	s2,32(sp)
 9e4:	6a42                	ld	s4,16(sp)
 9e6:	6aa2                	ld	s5,8(sp)
 9e8:	6b02                	ld	s6,0(sp)
 9ea:	b7f5                	j	9d6 <malloc+0xe2>
