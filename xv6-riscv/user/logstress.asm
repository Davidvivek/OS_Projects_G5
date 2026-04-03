
user/_logstress:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
main(int argc, char **argv)
{
  int fd, n;
  enum { N = 250, SZ=2000 };
  
  for (int i = 1; i < argc; i++){
   0:	4785                	li	a5,1
   2:	0ea7df63          	bge	a5,a0,100 <main+0x100>
{
   6:	7139                	addi	sp,sp,-64
   8:	fc06                	sd	ra,56(sp)
   a:	f822                	sd	s0,48(sp)
   c:	f426                	sd	s1,40(sp)
   e:	f04a                	sd	s2,32(sp)
  10:	ec4e                	sd	s3,24(sp)
  12:	0080                	addi	s0,sp,64
  14:	892a                	mv	s2,a0
  16:	89ae                	mv	s3,a1
  for (int i = 1; i < argc; i++){
  18:	4485                	li	s1,1
  1a:	a011                	j	1e <main+0x1e>
  1c:	84be                	mv	s1,a5
    int pid1 = fork();
  1e:	402000ef          	jal	420 <fork>
    if(pid1 < 0){
  22:	00054963          	bltz	a0,34 <main+0x34>
      printf("%s: fork failed\n", argv[0]);
      exit(1);
    }
    if(pid1 == 0) {
  26:	c11d                	beqz	a0,4c <main+0x4c>
  for (int i = 1; i < argc; i++){
  28:	0014879b          	addiw	a5,s1,1
  2c:	fef918e3          	bne	s2,a5,1c <main+0x1c>
      }
      exit(0);
    }
  }
  int xstatus;
  for(int i = 1; i < argc; i++){
  30:	4905                	li	s2,1
  32:	a04d                	j	d4 <main+0xd4>
  34:	e852                	sd	s4,16(sp)
      printf("%s: fork failed\n", argv[0]);
  36:	0009b583          	ld	a1,0(s3)
  3a:	00001517          	auipc	a0,0x1
  3e:	a0650513          	addi	a0,a0,-1530 # a40 <malloc+0x104>
  42:	047000ef          	jal	888 <printf>
      exit(1);
  46:	4505                	li	a0,1
  48:	3e0000ef          	jal	428 <exit>
  4c:	e852                	sd	s4,16(sp)
      fd = open(argv[i], O_CREATE | O_RDWR);
  4e:	00349a13          	slli	s4,s1,0x3
  52:	9a4e                	add	s4,s4,s3
  54:	20200593          	li	a1,514
  58:	000a3503          	ld	a0,0(s4)
  5c:	40c000ef          	jal	468 <open>
  60:	892a                	mv	s2,a0
      if(fd < 0){
  62:	04054163          	bltz	a0,a4 <main+0xa4>
      memset(buf, '0'+i, SZ);
  66:	7d000613          	li	a2,2000
  6a:	0304859b          	addiw	a1,s1,48
  6e:	00001517          	auipc	a0,0x1
  72:	fa250513          	addi	a0,a0,-94 # 1010 <buf>
  76:	110000ef          	jal	186 <memset>
  7a:	0fa00493          	li	s1,250
        if((n = write(fd, buf, SZ)) != SZ){
  7e:	00001997          	auipc	s3,0x1
  82:	f9298993          	addi	s3,s3,-110 # 1010 <buf>
  86:	7d000613          	li	a2,2000
  8a:	85ce                	mv	a1,s3
  8c:	854a                	mv	a0,s2
  8e:	3ba000ef          	jal	448 <write>
  92:	7d000793          	li	a5,2000
  96:	02f51463          	bne	a0,a5,be <main+0xbe>
      for(i = 0; i < N; i++){
  9a:	34fd                	addiw	s1,s1,-1
  9c:	f4ed                	bnez	s1,86 <main+0x86>
      exit(0);
  9e:	4501                	li	a0,0
  a0:	388000ef          	jal	428 <exit>
        printf("%s: create %s failed\n", argv[0], argv[i]);
  a4:	000a3603          	ld	a2,0(s4)
  a8:	0009b583          	ld	a1,0(s3)
  ac:	00001517          	auipc	a0,0x1
  b0:	9ac50513          	addi	a0,a0,-1620 # a58 <malloc+0x11c>
  b4:	7d4000ef          	jal	888 <printf>
        exit(1);
  b8:	4505                	li	a0,1
  ba:	36e000ef          	jal	428 <exit>
          printf("write failed %d\n", n);
  be:	85aa                	mv	a1,a0
  c0:	00001517          	auipc	a0,0x1
  c4:	9b050513          	addi	a0,a0,-1616 # a70 <malloc+0x134>
  c8:	7c0000ef          	jal	888 <printf>
          exit(1);
  cc:	4505                	li	a0,1
  ce:	35a000ef          	jal	428 <exit>
  d2:	893e                	mv	s2,a5
    wait(&xstatus);
  d4:	fcc40513          	addi	a0,s0,-52
  d8:	358000ef          	jal	430 <wait>
    if(xstatus != 0)
  dc:	fcc42503          	lw	a0,-52(s0)
  e0:	ed09                	bnez	a0,fa <main+0xfa>
  for(int i = 1; i < argc; i++){
  e2:	0019079b          	addiw	a5,s2,1
  e6:	ff2496e3          	bne	s1,s2,d2 <main+0xd2>
      exit(xstatus);
  }
  return 0;
}
  ea:	4501                	li	a0,0
  ec:	70e2                	ld	ra,56(sp)
  ee:	7442                	ld	s0,48(sp)
  f0:	74a2                	ld	s1,40(sp)
  f2:	7902                	ld	s2,32(sp)
  f4:	69e2                	ld	s3,24(sp)
  f6:	6121                	addi	sp,sp,64
  f8:	8082                	ret
  fa:	e852                	sd	s4,16(sp)
      exit(xstatus);
  fc:	32c000ef          	jal	428 <exit>
}
 100:	4501                	li	a0,0
 102:	8082                	ret

0000000000000104 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
 104:	1141                	addi	sp,sp,-16
 106:	e406                	sd	ra,8(sp)
 108:	e022                	sd	s0,0(sp)
 10a:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
 10c:	ef5ff0ef          	jal	0 <main>
  exit(r);
 110:	318000ef          	jal	428 <exit>

0000000000000114 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 114:	1141                	addi	sp,sp,-16
 116:	e422                	sd	s0,8(sp)
 118:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 11a:	87aa                	mv	a5,a0
 11c:	0585                	addi	a1,a1,1
 11e:	0785                	addi	a5,a5,1
 120:	fff5c703          	lbu	a4,-1(a1)
 124:	fee78fa3          	sb	a4,-1(a5)
 128:	fb75                	bnez	a4,11c <strcpy+0x8>
    ;
  return os;
}
 12a:	6422                	ld	s0,8(sp)
 12c:	0141                	addi	sp,sp,16
 12e:	8082                	ret

0000000000000130 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 130:	1141                	addi	sp,sp,-16
 132:	e422                	sd	s0,8(sp)
 134:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 136:	00054783          	lbu	a5,0(a0)
 13a:	cb91                	beqz	a5,14e <strcmp+0x1e>
 13c:	0005c703          	lbu	a4,0(a1)
 140:	00f71763          	bne	a4,a5,14e <strcmp+0x1e>
    p++, q++;
 144:	0505                	addi	a0,a0,1
 146:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 148:	00054783          	lbu	a5,0(a0)
 14c:	fbe5                	bnez	a5,13c <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 14e:	0005c503          	lbu	a0,0(a1)
}
 152:	40a7853b          	subw	a0,a5,a0
 156:	6422                	ld	s0,8(sp)
 158:	0141                	addi	sp,sp,16
 15a:	8082                	ret

000000000000015c <strlen>:

uint
strlen(const char *s)
{
 15c:	1141                	addi	sp,sp,-16
 15e:	e422                	sd	s0,8(sp)
 160:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 162:	00054783          	lbu	a5,0(a0)
 166:	cf91                	beqz	a5,182 <strlen+0x26>
 168:	0505                	addi	a0,a0,1
 16a:	87aa                	mv	a5,a0
 16c:	86be                	mv	a3,a5
 16e:	0785                	addi	a5,a5,1
 170:	fff7c703          	lbu	a4,-1(a5)
 174:	ff65                	bnez	a4,16c <strlen+0x10>
 176:	40a6853b          	subw	a0,a3,a0
 17a:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 17c:	6422                	ld	s0,8(sp)
 17e:	0141                	addi	sp,sp,16
 180:	8082                	ret
  for(n = 0; s[n]; n++)
 182:	4501                	li	a0,0
 184:	bfe5                	j	17c <strlen+0x20>

0000000000000186 <memset>:

void*
memset(void *dst, int c, uint n)
{
 186:	1141                	addi	sp,sp,-16
 188:	e422                	sd	s0,8(sp)
 18a:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 18c:	ca19                	beqz	a2,1a2 <memset+0x1c>
 18e:	87aa                	mv	a5,a0
 190:	1602                	slli	a2,a2,0x20
 192:	9201                	srli	a2,a2,0x20
 194:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 198:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 19c:	0785                	addi	a5,a5,1
 19e:	fee79de3          	bne	a5,a4,198 <memset+0x12>
  }
  return dst;
}
 1a2:	6422                	ld	s0,8(sp)
 1a4:	0141                	addi	sp,sp,16
 1a6:	8082                	ret

00000000000001a8 <strchr>:

char*
strchr(const char *s, char c)
{
 1a8:	1141                	addi	sp,sp,-16
 1aa:	e422                	sd	s0,8(sp)
 1ac:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1ae:	00054783          	lbu	a5,0(a0)
 1b2:	cb99                	beqz	a5,1c8 <strchr+0x20>
    if(*s == c)
 1b4:	00f58763          	beq	a1,a5,1c2 <strchr+0x1a>
  for(; *s; s++)
 1b8:	0505                	addi	a0,a0,1
 1ba:	00054783          	lbu	a5,0(a0)
 1be:	fbfd                	bnez	a5,1b4 <strchr+0xc>
      return (char*)s;
  return 0;
 1c0:	4501                	li	a0,0
}
 1c2:	6422                	ld	s0,8(sp)
 1c4:	0141                	addi	sp,sp,16
 1c6:	8082                	ret
  return 0;
 1c8:	4501                	li	a0,0
 1ca:	bfe5                	j	1c2 <strchr+0x1a>

00000000000001cc <gets>:

char*
gets(char *buf, int max)
{
 1cc:	711d                	addi	sp,sp,-96
 1ce:	ec86                	sd	ra,88(sp)
 1d0:	e8a2                	sd	s0,80(sp)
 1d2:	e4a6                	sd	s1,72(sp)
 1d4:	e0ca                	sd	s2,64(sp)
 1d6:	fc4e                	sd	s3,56(sp)
 1d8:	f852                	sd	s4,48(sp)
 1da:	f456                	sd	s5,40(sp)
 1dc:	f05a                	sd	s6,32(sp)
 1de:	ec5e                	sd	s7,24(sp)
 1e0:	1080                	addi	s0,sp,96
 1e2:	8baa                	mv	s7,a0
 1e4:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1e6:	892a                	mv	s2,a0
 1e8:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1ea:	4aa9                	li	s5,10
 1ec:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1ee:	89a6                	mv	s3,s1
 1f0:	2485                	addiw	s1,s1,1
 1f2:	0344d663          	bge	s1,s4,21e <gets+0x52>
    cc = read(0, &c, 1);
 1f6:	4605                	li	a2,1
 1f8:	faf40593          	addi	a1,s0,-81
 1fc:	4501                	li	a0,0
 1fe:	242000ef          	jal	440 <read>
    if(cc < 1)
 202:	00a05e63          	blez	a0,21e <gets+0x52>
    buf[i++] = c;
 206:	faf44783          	lbu	a5,-81(s0)
 20a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 20e:	01578763          	beq	a5,s5,21c <gets+0x50>
 212:	0905                	addi	s2,s2,1
 214:	fd679de3          	bne	a5,s6,1ee <gets+0x22>
    buf[i++] = c;
 218:	89a6                	mv	s3,s1
 21a:	a011                	j	21e <gets+0x52>
 21c:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 21e:	99de                	add	s3,s3,s7
 220:	00098023          	sb	zero,0(s3)
  return buf;
}
 224:	855e                	mv	a0,s7
 226:	60e6                	ld	ra,88(sp)
 228:	6446                	ld	s0,80(sp)
 22a:	64a6                	ld	s1,72(sp)
 22c:	6906                	ld	s2,64(sp)
 22e:	79e2                	ld	s3,56(sp)
 230:	7a42                	ld	s4,48(sp)
 232:	7aa2                	ld	s5,40(sp)
 234:	7b02                	ld	s6,32(sp)
 236:	6be2                	ld	s7,24(sp)
 238:	6125                	addi	sp,sp,96
 23a:	8082                	ret

000000000000023c <stat>:

int
stat(const char *n, struct stat *st)
{
 23c:	1101                	addi	sp,sp,-32
 23e:	ec06                	sd	ra,24(sp)
 240:	e822                	sd	s0,16(sp)
 242:	e04a                	sd	s2,0(sp)
 244:	1000                	addi	s0,sp,32
 246:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 248:	4581                	li	a1,0
 24a:	21e000ef          	jal	468 <open>
  if(fd < 0)
 24e:	02054263          	bltz	a0,272 <stat+0x36>
 252:	e426                	sd	s1,8(sp)
 254:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 256:	85ca                	mv	a1,s2
 258:	228000ef          	jal	480 <fstat>
 25c:	892a                	mv	s2,a0
  close(fd);
 25e:	8526                	mv	a0,s1
 260:	1f0000ef          	jal	450 <close>
  return r;
 264:	64a2                	ld	s1,8(sp)
}
 266:	854a                	mv	a0,s2
 268:	60e2                	ld	ra,24(sp)
 26a:	6442                	ld	s0,16(sp)
 26c:	6902                	ld	s2,0(sp)
 26e:	6105                	addi	sp,sp,32
 270:	8082                	ret
    return -1;
 272:	597d                	li	s2,-1
 274:	bfcd                	j	266 <stat+0x2a>

0000000000000276 <atoi>:

int
atoi(const char *s)
{
 276:	1141                	addi	sp,sp,-16
 278:	e422                	sd	s0,8(sp)
 27a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 27c:	00054683          	lbu	a3,0(a0)
 280:	fd06879b          	addiw	a5,a3,-48
 284:	0ff7f793          	zext.b	a5,a5
 288:	4625                	li	a2,9
 28a:	02f66863          	bltu	a2,a5,2ba <atoi+0x44>
 28e:	872a                	mv	a4,a0
  n = 0;
 290:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 292:	0705                	addi	a4,a4,1
 294:	0025179b          	slliw	a5,a0,0x2
 298:	9fa9                	addw	a5,a5,a0
 29a:	0017979b          	slliw	a5,a5,0x1
 29e:	9fb5                	addw	a5,a5,a3
 2a0:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2a4:	00074683          	lbu	a3,0(a4)
 2a8:	fd06879b          	addiw	a5,a3,-48
 2ac:	0ff7f793          	zext.b	a5,a5
 2b0:	fef671e3          	bgeu	a2,a5,292 <atoi+0x1c>
  return n;
}
 2b4:	6422                	ld	s0,8(sp)
 2b6:	0141                	addi	sp,sp,16
 2b8:	8082                	ret
  n = 0;
 2ba:	4501                	li	a0,0
 2bc:	bfe5                	j	2b4 <atoi+0x3e>

00000000000002be <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2be:	1141                	addi	sp,sp,-16
 2c0:	e422                	sd	s0,8(sp)
 2c2:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2c4:	02b57463          	bgeu	a0,a1,2ec <memmove+0x2e>
    while(n-- > 0)
 2c8:	00c05f63          	blez	a2,2e6 <memmove+0x28>
 2cc:	1602                	slli	a2,a2,0x20
 2ce:	9201                	srli	a2,a2,0x20
 2d0:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2d4:	872a                	mv	a4,a0
      *dst++ = *src++;
 2d6:	0585                	addi	a1,a1,1
 2d8:	0705                	addi	a4,a4,1
 2da:	fff5c683          	lbu	a3,-1(a1)
 2de:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2e2:	fef71ae3          	bne	a4,a5,2d6 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2e6:	6422                	ld	s0,8(sp)
 2e8:	0141                	addi	sp,sp,16
 2ea:	8082                	ret
    dst += n;
 2ec:	00c50733          	add	a4,a0,a2
    src += n;
 2f0:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2f2:	fec05ae3          	blez	a2,2e6 <memmove+0x28>
 2f6:	fff6079b          	addiw	a5,a2,-1
 2fa:	1782                	slli	a5,a5,0x20
 2fc:	9381                	srli	a5,a5,0x20
 2fe:	fff7c793          	not	a5,a5
 302:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 304:	15fd                	addi	a1,a1,-1
 306:	177d                	addi	a4,a4,-1
 308:	0005c683          	lbu	a3,0(a1)
 30c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 310:	fee79ae3          	bne	a5,a4,304 <memmove+0x46>
 314:	bfc9                	j	2e6 <memmove+0x28>

0000000000000316 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 316:	1141                	addi	sp,sp,-16
 318:	e422                	sd	s0,8(sp)
 31a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 31c:	ca05                	beqz	a2,34c <memcmp+0x36>
 31e:	fff6069b          	addiw	a3,a2,-1
 322:	1682                	slli	a3,a3,0x20
 324:	9281                	srli	a3,a3,0x20
 326:	0685                	addi	a3,a3,1
 328:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 32a:	00054783          	lbu	a5,0(a0)
 32e:	0005c703          	lbu	a4,0(a1)
 332:	00e79863          	bne	a5,a4,342 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 336:	0505                	addi	a0,a0,1
    p2++;
 338:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 33a:	fed518e3          	bne	a0,a3,32a <memcmp+0x14>
  }
  return 0;
 33e:	4501                	li	a0,0
 340:	a019                	j	346 <memcmp+0x30>
      return *p1 - *p2;
 342:	40e7853b          	subw	a0,a5,a4
}
 346:	6422                	ld	s0,8(sp)
 348:	0141                	addi	sp,sp,16
 34a:	8082                	ret
  return 0;
 34c:	4501                	li	a0,0
 34e:	bfe5                	j	346 <memcmp+0x30>

0000000000000350 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 350:	1141                	addi	sp,sp,-16
 352:	e406                	sd	ra,8(sp)
 354:	e022                	sd	s0,0(sp)
 356:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 358:	f67ff0ef          	jal	2be <memmove>
}
 35c:	60a2                	ld	ra,8(sp)
 35e:	6402                	ld	s0,0(sp)
 360:	0141                	addi	sp,sp,16
 362:	8082                	ret

0000000000000364 <sbrk>:

char *
sbrk(int n) {
 364:	1141                	addi	sp,sp,-16
 366:	e406                	sd	ra,8(sp)
 368:	e022                	sd	s0,0(sp)
 36a:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 36c:	4585                	li	a1,1
 36e:	142000ef          	jal	4b0 <sys_sbrk>
}
 372:	60a2                	ld	ra,8(sp)
 374:	6402                	ld	s0,0(sp)
 376:	0141                	addi	sp,sp,16
 378:	8082                	ret

000000000000037a <sbrklazy>:

char *
sbrklazy(int n) {
 37a:	1141                	addi	sp,sp,-16
 37c:	e406                	sd	ra,8(sp)
 37e:	e022                	sd	s0,0(sp)
 380:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 382:	4589                	li	a1,2
 384:	12c000ef          	jal	4b0 <sys_sbrk>
}
 388:	60a2                	ld	ra,8(sp)
 38a:	6402                	ld	s0,0(sp)
 38c:	0141                	addi	sp,sp,16
 38e:	8082                	ret

0000000000000390 <thread_create>:
// thread_create allocates a page-sized stack, calls clone(fn, arg, stacktop).
// Returns the new thread's pid, or -1 on error.
// The stack is passed back via *stack so the caller can free it after join.
int
thread_create(void(*fn)(void*), void *arg, void **stack)
{
 390:	7179                	addi	sp,sp,-48
 392:	f406                	sd	ra,40(sp)
 394:	f022                	sd	s0,32(sp)
 396:	e84a                	sd	s2,16(sp)
 398:	e44e                	sd	s3,8(sp)
 39a:	e052                	sd	s4,0(sp)
 39c:	1800                	addi	s0,sp,48
 39e:	89aa                	mv	s3,a0
 3a0:	8a2e                	mv	s4,a1
 3a2:	8932                	mv	s2,a2
  char *s = malloc(PGSIZE);
 3a4:	6505                	lui	a0,0x1
 3a6:	596000ef          	jal	93c <malloc>
  if(s == 0)
 3aa:	cd0d                	beqz	a0,3e4 <thread_create+0x54>
 3ac:	ec26                	sd	s1,24(sp)
 3ae:	84aa                	mv	s1,a0
    return -1;
  *stack = s;
 3b0:	00a93023          	sd	a0,0(s2)
  // Stack grows downward: pass the top of the allocated region.
  int pid = clone(fn, arg, s + PGSIZE);
 3b4:	6605                	lui	a2,0x1
 3b6:	962a                	add	a2,a2,a0
 3b8:	85d2                	mv	a1,s4
 3ba:	854e                	mv	a0,s3
 3bc:	134000ef          	jal	4f0 <clone>
  if(pid < 0){
 3c0:	00054a63          	bltz	a0,3d4 <thread_create+0x44>
 3c4:	64e2                	ld	s1,24(sp)
    free(s);
    *stack = 0;
    return -1;
  }
  return pid;
}
 3c6:	70a2                	ld	ra,40(sp)
 3c8:	7402                	ld	s0,32(sp)
 3ca:	6942                	ld	s2,16(sp)
 3cc:	69a2                	ld	s3,8(sp)
 3ce:	6a02                	ld	s4,0(sp)
 3d0:	6145                	addi	sp,sp,48
 3d2:	8082                	ret
    free(s);
 3d4:	8526                	mv	a0,s1
 3d6:	4e4000ef          	jal	8ba <free>
    *stack = 0;
 3da:	00093023          	sd	zero,0(s2)
    return -1;
 3de:	557d                	li	a0,-1
 3e0:	64e2                	ld	s1,24(sp)
 3e2:	b7d5                	j	3c6 <thread_create+0x36>
    return -1;
 3e4:	557d                	li	a0,-1
 3e6:	b7c5                	j	3c6 <thread_create+0x36>

00000000000003e8 <thread_join>:
// Wait for any child thread to exit.
// If stack is non-null, frees the memory pointed to by *stack and clears it.
// Returns the joined thread's pid, or -1 on error.
int
thread_join(void **stack)
{
 3e8:	1101                	addi	sp,sp,-32
 3ea:	ec06                	sd	ra,24(sp)
 3ec:	e822                	sd	s0,16(sp)
 3ee:	e426                	sd	s1,8(sp)
 3f0:	e04a                	sd	s2,0(sp)
 3f2:	1000                	addi	s0,sp,32
 3f4:	84aa                	mv	s1,a0
  int pid = join();
 3f6:	102000ef          	jal	4f8 <join>
  if(pid < 0)
 3fa:	02054163          	bltz	a0,41c <thread_join+0x34>
 3fe:	892a                	mv	s2,a0
    return -1;
  if(stack && *stack){
 400:	c499                	beqz	s1,40e <thread_join+0x26>
 402:	6088                	ld	a0,0(s1)
 404:	c509                	beqz	a0,40e <thread_join+0x26>
    free(*stack);
 406:	4b4000ef          	jal	8ba <free>
    *stack = 0;
 40a:	0004b023          	sd	zero,0(s1)
  }
  return pid;
}
 40e:	854a                	mv	a0,s2
 410:	60e2                	ld	ra,24(sp)
 412:	6442                	ld	s0,16(sp)
 414:	64a2                	ld	s1,8(sp)
 416:	6902                	ld	s2,0(sp)
 418:	6105                	addi	sp,sp,32
 41a:	8082                	ret
    return -1;
 41c:	597d                	li	s2,-1
 41e:	bfc5                	j	40e <thread_join+0x26>

0000000000000420 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 420:	4885                	li	a7,1
 ecall
 422:	00000073          	ecall
 ret
 426:	8082                	ret

0000000000000428 <exit>:
.global exit
exit:
 li a7, SYS_exit
 428:	4889                	li	a7,2
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <wait>:
.global wait
wait:
 li a7, SYS_wait
 430:	488d                	li	a7,3
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 438:	4891                	li	a7,4
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <read>:
.global read
read:
 li a7, SYS_read
 440:	4895                	li	a7,5
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <write>:
.global write
write:
 li a7, SYS_write
 448:	48c1                	li	a7,16
 ecall
 44a:	00000073          	ecall
 ret
 44e:	8082                	ret

0000000000000450 <close>:
.global close
close:
 li a7, SYS_close
 450:	48d5                	li	a7,21
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <kill>:
.global kill
kill:
 li a7, SYS_kill
 458:	4899                	li	a7,6
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <exec>:
.global exec
exec:
 li a7, SYS_exec
 460:	489d                	li	a7,7
 ecall
 462:	00000073          	ecall
 ret
 466:	8082                	ret

0000000000000468 <open>:
.global open
open:
 li a7, SYS_open
 468:	48bd                	li	a7,15
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 470:	48c5                	li	a7,17
 ecall
 472:	00000073          	ecall
 ret
 476:	8082                	ret

0000000000000478 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 478:	48c9                	li	a7,18
 ecall
 47a:	00000073          	ecall
 ret
 47e:	8082                	ret

0000000000000480 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 480:	48a1                	li	a7,8
 ecall
 482:	00000073          	ecall
 ret
 486:	8082                	ret

0000000000000488 <link>:
.global link
link:
 li a7, SYS_link
 488:	48cd                	li	a7,19
 ecall
 48a:	00000073          	ecall
 ret
 48e:	8082                	ret

0000000000000490 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 490:	48d1                	li	a7,20
 ecall
 492:	00000073          	ecall
 ret
 496:	8082                	ret

0000000000000498 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 498:	48a5                	li	a7,9
 ecall
 49a:	00000073          	ecall
 ret
 49e:	8082                	ret

00000000000004a0 <dup>:
.global dup
dup:
 li a7, SYS_dup
 4a0:	48a9                	li	a7,10
 ecall
 4a2:	00000073          	ecall
 ret
 4a6:	8082                	ret

00000000000004a8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4a8:	48ad                	li	a7,11
 ecall
 4aa:	00000073          	ecall
 ret
 4ae:	8082                	ret

00000000000004b0 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 4b0:	48b1                	li	a7,12
 ecall
 4b2:	00000073          	ecall
 ret
 4b6:	8082                	ret

00000000000004b8 <pause>:
.global pause
pause:
 li a7, SYS_pause
 4b8:	48b5                	li	a7,13
 ecall
 4ba:	00000073          	ecall
 ret
 4be:	8082                	ret

00000000000004c0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4c0:	48b9                	li	a7,14
 ecall
 4c2:	00000073          	ecall
 ret
 4c6:	8082                	ret

00000000000004c8 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 4c8:	48d9                	li	a7,22
 ecall
 4ca:	00000073          	ecall
 ret
 4ce:	8082                	ret

00000000000004d0 <lock_create>:
.global lock_create
lock_create:
 li a7, SYS_lock_create
 4d0:	48dd                	li	a7,23
 ecall
 4d2:	00000073          	ecall
 ret
 4d6:	8082                	ret

00000000000004d8 <lock_acquire>:
.global lock_acquire
lock_acquire:
 li a7, SYS_lock_acquire
 4d8:	48e1                	li	a7,24
 ecall
 4da:	00000073          	ecall
 ret
 4de:	8082                	ret

00000000000004e0 <lock_release>:
.global lock_release
lock_release:
 li a7, SYS_lock_release
 4e0:	48e5                	li	a7,25
 ecall
 4e2:	00000073          	ecall
 ret
 4e6:	8082                	ret

00000000000004e8 <lock_destroy>:
.global lock_destroy
lock_destroy:
 li a7, SYS_lock_destroy
 4e8:	48e9                	li	a7,26
 ecall
 4ea:	00000073          	ecall
 ret
 4ee:	8082                	ret

00000000000004f0 <clone>:
.global clone
clone:
 li a7, SYS_clone
 4f0:	48ed                	li	a7,27
 ecall
 4f2:	00000073          	ecall
 ret
 4f6:	8082                	ret

00000000000004f8 <join>:
.global join
join:
 li a7, SYS_join
 4f8:	48f1                	li	a7,28
 ecall
 4fa:	00000073          	ecall
 ret
 4fe:	8082                	ret

0000000000000500 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 500:	1101                	addi	sp,sp,-32
 502:	ec06                	sd	ra,24(sp)
 504:	e822                	sd	s0,16(sp)
 506:	1000                	addi	s0,sp,32
 508:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 50c:	4605                	li	a2,1
 50e:	fef40593          	addi	a1,s0,-17
 512:	f37ff0ef          	jal	448 <write>
}
 516:	60e2                	ld	ra,24(sp)
 518:	6442                	ld	s0,16(sp)
 51a:	6105                	addi	sp,sp,32
 51c:	8082                	ret

000000000000051e <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 51e:	715d                	addi	sp,sp,-80
 520:	e486                	sd	ra,72(sp)
 522:	e0a2                	sd	s0,64(sp)
 524:	f84a                	sd	s2,48(sp)
 526:	0880                	addi	s0,sp,80
 528:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 52a:	c299                	beqz	a3,530 <printint+0x12>
 52c:	0805c363          	bltz	a1,5b2 <printint+0x94>
  neg = 0;
 530:	4881                	li	a7,0
 532:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 536:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 538:	00000517          	auipc	a0,0x0
 53c:	55850513          	addi	a0,a0,1368 # a90 <digits>
 540:	883e                	mv	a6,a5
 542:	2785                	addiw	a5,a5,1
 544:	02c5f733          	remu	a4,a1,a2
 548:	972a                	add	a4,a4,a0
 54a:	00074703          	lbu	a4,0(a4)
 54e:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 552:	872e                	mv	a4,a1
 554:	02c5d5b3          	divu	a1,a1,a2
 558:	0685                	addi	a3,a3,1
 55a:	fec773e3          	bgeu	a4,a2,540 <printint+0x22>
  if(neg)
 55e:	00088b63          	beqz	a7,574 <printint+0x56>
    buf[i++] = '-';
 562:	fd078793          	addi	a5,a5,-48
 566:	97a2                	add	a5,a5,s0
 568:	02d00713          	li	a4,45
 56c:	fee78423          	sb	a4,-24(a5)
 570:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 574:	02f05a63          	blez	a5,5a8 <printint+0x8a>
 578:	fc26                	sd	s1,56(sp)
 57a:	f44e                	sd	s3,40(sp)
 57c:	fb840713          	addi	a4,s0,-72
 580:	00f704b3          	add	s1,a4,a5
 584:	fff70993          	addi	s3,a4,-1
 588:	99be                	add	s3,s3,a5
 58a:	37fd                	addiw	a5,a5,-1
 58c:	1782                	slli	a5,a5,0x20
 58e:	9381                	srli	a5,a5,0x20
 590:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 594:	fff4c583          	lbu	a1,-1(s1)
 598:	854a                	mv	a0,s2
 59a:	f67ff0ef          	jal	500 <putc>
  while(--i >= 0)
 59e:	14fd                	addi	s1,s1,-1
 5a0:	ff349ae3          	bne	s1,s3,594 <printint+0x76>
 5a4:	74e2                	ld	s1,56(sp)
 5a6:	79a2                	ld	s3,40(sp)
}
 5a8:	60a6                	ld	ra,72(sp)
 5aa:	6406                	ld	s0,64(sp)
 5ac:	7942                	ld	s2,48(sp)
 5ae:	6161                	addi	sp,sp,80
 5b0:	8082                	ret
    x = -xx;
 5b2:	40b005b3          	neg	a1,a1
    neg = 1;
 5b6:	4885                	li	a7,1
    x = -xx;
 5b8:	bfad                	j	532 <printint+0x14>

00000000000005ba <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5ba:	711d                	addi	sp,sp,-96
 5bc:	ec86                	sd	ra,88(sp)
 5be:	e8a2                	sd	s0,80(sp)
 5c0:	e0ca                	sd	s2,64(sp)
 5c2:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5c4:	0005c903          	lbu	s2,0(a1)
 5c8:	28090663          	beqz	s2,854 <vprintf+0x29a>
 5cc:	e4a6                	sd	s1,72(sp)
 5ce:	fc4e                	sd	s3,56(sp)
 5d0:	f852                	sd	s4,48(sp)
 5d2:	f456                	sd	s5,40(sp)
 5d4:	f05a                	sd	s6,32(sp)
 5d6:	ec5e                	sd	s7,24(sp)
 5d8:	e862                	sd	s8,16(sp)
 5da:	e466                	sd	s9,8(sp)
 5dc:	8b2a                	mv	s6,a0
 5de:	8a2e                	mv	s4,a1
 5e0:	8bb2                	mv	s7,a2
  state = 0;
 5e2:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 5e4:	4481                	li	s1,0
 5e6:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 5e8:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 5ec:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 5f0:	06c00c93          	li	s9,108
 5f4:	a005                	j	614 <vprintf+0x5a>
        putc(fd, c0);
 5f6:	85ca                	mv	a1,s2
 5f8:	855a                	mv	a0,s6
 5fa:	f07ff0ef          	jal	500 <putc>
 5fe:	a019                	j	604 <vprintf+0x4a>
    } else if(state == '%'){
 600:	03598263          	beq	s3,s5,624 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 604:	2485                	addiw	s1,s1,1
 606:	8726                	mv	a4,s1
 608:	009a07b3          	add	a5,s4,s1
 60c:	0007c903          	lbu	s2,0(a5)
 610:	22090a63          	beqz	s2,844 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 614:	0009079b          	sext.w	a5,s2
    if(state == 0){
 618:	fe0994e3          	bnez	s3,600 <vprintf+0x46>
      if(c0 == '%'){
 61c:	fd579de3          	bne	a5,s5,5f6 <vprintf+0x3c>
        state = '%';
 620:	89be                	mv	s3,a5
 622:	b7cd                	j	604 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 624:	00ea06b3          	add	a3,s4,a4
 628:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 62c:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 62e:	c681                	beqz	a3,636 <vprintf+0x7c>
 630:	9752                	add	a4,a4,s4
 632:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 636:	05878363          	beq	a5,s8,67c <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 63a:	05978d63          	beq	a5,s9,694 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 63e:	07500713          	li	a4,117
 642:	0ee78763          	beq	a5,a4,730 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 646:	07800713          	li	a4,120
 64a:	12e78963          	beq	a5,a4,77c <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 64e:	07000713          	li	a4,112
 652:	14e78e63          	beq	a5,a4,7ae <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 656:	06300713          	li	a4,99
 65a:	18e78e63          	beq	a5,a4,7f6 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 65e:	07300713          	li	a4,115
 662:	1ae78463          	beq	a5,a4,80a <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 666:	02500713          	li	a4,37
 66a:	04e79563          	bne	a5,a4,6b4 <vprintf+0xfa>
        putc(fd, '%');
 66e:	02500593          	li	a1,37
 672:	855a                	mv	a0,s6
 674:	e8dff0ef          	jal	500 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 678:	4981                	li	s3,0
 67a:	b769                	j	604 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 67c:	008b8913          	addi	s2,s7,8
 680:	4685                	li	a3,1
 682:	4629                	li	a2,10
 684:	000ba583          	lw	a1,0(s7)
 688:	855a                	mv	a0,s6
 68a:	e95ff0ef          	jal	51e <printint>
 68e:	8bca                	mv	s7,s2
      state = 0;
 690:	4981                	li	s3,0
 692:	bf8d                	j	604 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 694:	06400793          	li	a5,100
 698:	02f68963          	beq	a3,a5,6ca <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 69c:	06c00793          	li	a5,108
 6a0:	04f68263          	beq	a3,a5,6e4 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 6a4:	07500793          	li	a5,117
 6a8:	0af68063          	beq	a3,a5,748 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 6ac:	07800793          	li	a5,120
 6b0:	0ef68263          	beq	a3,a5,794 <vprintf+0x1da>
        putc(fd, '%');
 6b4:	02500593          	li	a1,37
 6b8:	855a                	mv	a0,s6
 6ba:	e47ff0ef          	jal	500 <putc>
        putc(fd, c0);
 6be:	85ca                	mv	a1,s2
 6c0:	855a                	mv	a0,s6
 6c2:	e3fff0ef          	jal	500 <putc>
      state = 0;
 6c6:	4981                	li	s3,0
 6c8:	bf35                	j	604 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6ca:	008b8913          	addi	s2,s7,8
 6ce:	4685                	li	a3,1
 6d0:	4629                	li	a2,10
 6d2:	000bb583          	ld	a1,0(s7)
 6d6:	855a                	mv	a0,s6
 6d8:	e47ff0ef          	jal	51e <printint>
        i += 1;
 6dc:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 6de:	8bca                	mv	s7,s2
      state = 0;
 6e0:	4981                	li	s3,0
        i += 1;
 6e2:	b70d                	j	604 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6e4:	06400793          	li	a5,100
 6e8:	02f60763          	beq	a2,a5,716 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 6ec:	07500793          	li	a5,117
 6f0:	06f60963          	beq	a2,a5,762 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 6f4:	07800793          	li	a5,120
 6f8:	faf61ee3          	bne	a2,a5,6b4 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6fc:	008b8913          	addi	s2,s7,8
 700:	4681                	li	a3,0
 702:	4641                	li	a2,16
 704:	000bb583          	ld	a1,0(s7)
 708:	855a                	mv	a0,s6
 70a:	e15ff0ef          	jal	51e <printint>
        i += 2;
 70e:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 710:	8bca                	mv	s7,s2
      state = 0;
 712:	4981                	li	s3,0
        i += 2;
 714:	bdc5                	j	604 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 716:	008b8913          	addi	s2,s7,8
 71a:	4685                	li	a3,1
 71c:	4629                	li	a2,10
 71e:	000bb583          	ld	a1,0(s7)
 722:	855a                	mv	a0,s6
 724:	dfbff0ef          	jal	51e <printint>
        i += 2;
 728:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 72a:	8bca                	mv	s7,s2
      state = 0;
 72c:	4981                	li	s3,0
        i += 2;
 72e:	bdd9                	j	604 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 730:	008b8913          	addi	s2,s7,8
 734:	4681                	li	a3,0
 736:	4629                	li	a2,10
 738:	000be583          	lwu	a1,0(s7)
 73c:	855a                	mv	a0,s6
 73e:	de1ff0ef          	jal	51e <printint>
 742:	8bca                	mv	s7,s2
      state = 0;
 744:	4981                	li	s3,0
 746:	bd7d                	j	604 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 748:	008b8913          	addi	s2,s7,8
 74c:	4681                	li	a3,0
 74e:	4629                	li	a2,10
 750:	000bb583          	ld	a1,0(s7)
 754:	855a                	mv	a0,s6
 756:	dc9ff0ef          	jal	51e <printint>
        i += 1;
 75a:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 75c:	8bca                	mv	s7,s2
      state = 0;
 75e:	4981                	li	s3,0
        i += 1;
 760:	b555                	j	604 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 762:	008b8913          	addi	s2,s7,8
 766:	4681                	li	a3,0
 768:	4629                	li	a2,10
 76a:	000bb583          	ld	a1,0(s7)
 76e:	855a                	mv	a0,s6
 770:	dafff0ef          	jal	51e <printint>
        i += 2;
 774:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 776:	8bca                	mv	s7,s2
      state = 0;
 778:	4981                	li	s3,0
        i += 2;
 77a:	b569                	j	604 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 77c:	008b8913          	addi	s2,s7,8
 780:	4681                	li	a3,0
 782:	4641                	li	a2,16
 784:	000be583          	lwu	a1,0(s7)
 788:	855a                	mv	a0,s6
 78a:	d95ff0ef          	jal	51e <printint>
 78e:	8bca                	mv	s7,s2
      state = 0;
 790:	4981                	li	s3,0
 792:	bd8d                	j	604 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 794:	008b8913          	addi	s2,s7,8
 798:	4681                	li	a3,0
 79a:	4641                	li	a2,16
 79c:	000bb583          	ld	a1,0(s7)
 7a0:	855a                	mv	a0,s6
 7a2:	d7dff0ef          	jal	51e <printint>
        i += 1;
 7a6:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 7a8:	8bca                	mv	s7,s2
      state = 0;
 7aa:	4981                	li	s3,0
        i += 1;
 7ac:	bda1                	j	604 <vprintf+0x4a>
 7ae:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 7b0:	008b8d13          	addi	s10,s7,8
 7b4:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 7b8:	03000593          	li	a1,48
 7bc:	855a                	mv	a0,s6
 7be:	d43ff0ef          	jal	500 <putc>
  putc(fd, 'x');
 7c2:	07800593          	li	a1,120
 7c6:	855a                	mv	a0,s6
 7c8:	d39ff0ef          	jal	500 <putc>
 7cc:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7ce:	00000b97          	auipc	s7,0x0
 7d2:	2c2b8b93          	addi	s7,s7,706 # a90 <digits>
 7d6:	03c9d793          	srli	a5,s3,0x3c
 7da:	97de                	add	a5,a5,s7
 7dc:	0007c583          	lbu	a1,0(a5)
 7e0:	855a                	mv	a0,s6
 7e2:	d1fff0ef          	jal	500 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7e6:	0992                	slli	s3,s3,0x4
 7e8:	397d                	addiw	s2,s2,-1
 7ea:	fe0916e3          	bnez	s2,7d6 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 7ee:	8bea                	mv	s7,s10
      state = 0;
 7f0:	4981                	li	s3,0
 7f2:	6d02                	ld	s10,0(sp)
 7f4:	bd01                	j	604 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 7f6:	008b8913          	addi	s2,s7,8
 7fa:	000bc583          	lbu	a1,0(s7)
 7fe:	855a                	mv	a0,s6
 800:	d01ff0ef          	jal	500 <putc>
 804:	8bca                	mv	s7,s2
      state = 0;
 806:	4981                	li	s3,0
 808:	bbf5                	j	604 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 80a:	008b8993          	addi	s3,s7,8
 80e:	000bb903          	ld	s2,0(s7)
 812:	00090f63          	beqz	s2,830 <vprintf+0x276>
        for(; *s; s++)
 816:	00094583          	lbu	a1,0(s2)
 81a:	c195                	beqz	a1,83e <vprintf+0x284>
          putc(fd, *s);
 81c:	855a                	mv	a0,s6
 81e:	ce3ff0ef          	jal	500 <putc>
        for(; *s; s++)
 822:	0905                	addi	s2,s2,1
 824:	00094583          	lbu	a1,0(s2)
 828:	f9f5                	bnez	a1,81c <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 82a:	8bce                	mv	s7,s3
      state = 0;
 82c:	4981                	li	s3,0
 82e:	bbd9                	j	604 <vprintf+0x4a>
          s = "(null)";
 830:	00000917          	auipc	s2,0x0
 834:	25890913          	addi	s2,s2,600 # a88 <malloc+0x14c>
        for(; *s; s++)
 838:	02800593          	li	a1,40
 83c:	b7c5                	j	81c <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 83e:	8bce                	mv	s7,s3
      state = 0;
 840:	4981                	li	s3,0
 842:	b3c9                	j	604 <vprintf+0x4a>
 844:	64a6                	ld	s1,72(sp)
 846:	79e2                	ld	s3,56(sp)
 848:	7a42                	ld	s4,48(sp)
 84a:	7aa2                	ld	s5,40(sp)
 84c:	7b02                	ld	s6,32(sp)
 84e:	6be2                	ld	s7,24(sp)
 850:	6c42                	ld	s8,16(sp)
 852:	6ca2                	ld	s9,8(sp)
    }
  }
}
 854:	60e6                	ld	ra,88(sp)
 856:	6446                	ld	s0,80(sp)
 858:	6906                	ld	s2,64(sp)
 85a:	6125                	addi	sp,sp,96
 85c:	8082                	ret

000000000000085e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 85e:	715d                	addi	sp,sp,-80
 860:	ec06                	sd	ra,24(sp)
 862:	e822                	sd	s0,16(sp)
 864:	1000                	addi	s0,sp,32
 866:	e010                	sd	a2,0(s0)
 868:	e414                	sd	a3,8(s0)
 86a:	e818                	sd	a4,16(s0)
 86c:	ec1c                	sd	a5,24(s0)
 86e:	03043023          	sd	a6,32(s0)
 872:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 876:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 87a:	8622                	mv	a2,s0
 87c:	d3fff0ef          	jal	5ba <vprintf>
}
 880:	60e2                	ld	ra,24(sp)
 882:	6442                	ld	s0,16(sp)
 884:	6161                	addi	sp,sp,80
 886:	8082                	ret

0000000000000888 <printf>:

void
printf(const char *fmt, ...)
{
 888:	711d                	addi	sp,sp,-96
 88a:	ec06                	sd	ra,24(sp)
 88c:	e822                	sd	s0,16(sp)
 88e:	1000                	addi	s0,sp,32
 890:	e40c                	sd	a1,8(s0)
 892:	e810                	sd	a2,16(s0)
 894:	ec14                	sd	a3,24(s0)
 896:	f018                	sd	a4,32(s0)
 898:	f41c                	sd	a5,40(s0)
 89a:	03043823          	sd	a6,48(s0)
 89e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8a2:	00840613          	addi	a2,s0,8
 8a6:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8aa:	85aa                	mv	a1,a0
 8ac:	4505                	li	a0,1
 8ae:	d0dff0ef          	jal	5ba <vprintf>
}
 8b2:	60e2                	ld	ra,24(sp)
 8b4:	6442                	ld	s0,16(sp)
 8b6:	6125                	addi	sp,sp,96
 8b8:	8082                	ret

00000000000008ba <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8ba:	1141                	addi	sp,sp,-16
 8bc:	e422                	sd	s0,8(sp)
 8be:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8c0:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8c4:	00000797          	auipc	a5,0x0
 8c8:	73c7b783          	ld	a5,1852(a5) # 1000 <freep>
 8cc:	a02d                	j	8f6 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8ce:	4618                	lw	a4,8(a2)
 8d0:	9f2d                	addw	a4,a4,a1
 8d2:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8d6:	6398                	ld	a4,0(a5)
 8d8:	6310                	ld	a2,0(a4)
 8da:	a83d                	j	918 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8dc:	ff852703          	lw	a4,-8(a0)
 8e0:	9f31                	addw	a4,a4,a2
 8e2:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8e4:	ff053683          	ld	a3,-16(a0)
 8e8:	a091                	j	92c <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8ea:	6398                	ld	a4,0(a5)
 8ec:	00e7e463          	bltu	a5,a4,8f4 <free+0x3a>
 8f0:	00e6ea63          	bltu	a3,a4,904 <free+0x4a>
{
 8f4:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8f6:	fed7fae3          	bgeu	a5,a3,8ea <free+0x30>
 8fa:	6398                	ld	a4,0(a5)
 8fc:	00e6e463          	bltu	a3,a4,904 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 900:	fee7eae3          	bltu	a5,a4,8f4 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 904:	ff852583          	lw	a1,-8(a0)
 908:	6390                	ld	a2,0(a5)
 90a:	02059813          	slli	a6,a1,0x20
 90e:	01c85713          	srli	a4,a6,0x1c
 912:	9736                	add	a4,a4,a3
 914:	fae60de3          	beq	a2,a4,8ce <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 918:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 91c:	4790                	lw	a2,8(a5)
 91e:	02061593          	slli	a1,a2,0x20
 922:	01c5d713          	srli	a4,a1,0x1c
 926:	973e                	add	a4,a4,a5
 928:	fae68ae3          	beq	a3,a4,8dc <free+0x22>
    p->s.ptr = bp->s.ptr;
 92c:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 92e:	00000717          	auipc	a4,0x0
 932:	6cf73923          	sd	a5,1746(a4) # 1000 <freep>
}
 936:	6422                	ld	s0,8(sp)
 938:	0141                	addi	sp,sp,16
 93a:	8082                	ret

000000000000093c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 93c:	7139                	addi	sp,sp,-64
 93e:	fc06                	sd	ra,56(sp)
 940:	f822                	sd	s0,48(sp)
 942:	f426                	sd	s1,40(sp)
 944:	ec4e                	sd	s3,24(sp)
 946:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 948:	02051493          	slli	s1,a0,0x20
 94c:	9081                	srli	s1,s1,0x20
 94e:	04bd                	addi	s1,s1,15
 950:	8091                	srli	s1,s1,0x4
 952:	0014899b          	addiw	s3,s1,1
 956:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 958:	00000517          	auipc	a0,0x0
 95c:	6a853503          	ld	a0,1704(a0) # 1000 <freep>
 960:	c915                	beqz	a0,994 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 962:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 964:	4798                	lw	a4,8(a5)
 966:	08977a63          	bgeu	a4,s1,9fa <malloc+0xbe>
 96a:	f04a                	sd	s2,32(sp)
 96c:	e852                	sd	s4,16(sp)
 96e:	e456                	sd	s5,8(sp)
 970:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 972:	8a4e                	mv	s4,s3
 974:	0009871b          	sext.w	a4,s3
 978:	6685                	lui	a3,0x1
 97a:	00d77363          	bgeu	a4,a3,980 <malloc+0x44>
 97e:	6a05                	lui	s4,0x1
 980:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 984:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 988:	00000917          	auipc	s2,0x0
 98c:	67890913          	addi	s2,s2,1656 # 1000 <freep>
  if(p == SBRK_ERROR)
 990:	5afd                	li	s5,-1
 992:	a081                	j	9d2 <malloc+0x96>
 994:	f04a                	sd	s2,32(sp)
 996:	e852                	sd	s4,16(sp)
 998:	e456                	sd	s5,8(sp)
 99a:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 99c:	00001797          	auipc	a5,0x1
 9a0:	86c78793          	addi	a5,a5,-1940 # 1208 <base>
 9a4:	00000717          	auipc	a4,0x0
 9a8:	64f73e23          	sd	a5,1628(a4) # 1000 <freep>
 9ac:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9ae:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 9b2:	b7c1                	j	972 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 9b4:	6398                	ld	a4,0(a5)
 9b6:	e118                	sd	a4,0(a0)
 9b8:	a8a9                	j	a12 <malloc+0xd6>
  hp->s.size = nu;
 9ba:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 9be:	0541                	addi	a0,a0,16
 9c0:	efbff0ef          	jal	8ba <free>
  return freep;
 9c4:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9c8:	c12d                	beqz	a0,a2a <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9ca:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9cc:	4798                	lw	a4,8(a5)
 9ce:	02977263          	bgeu	a4,s1,9f2 <malloc+0xb6>
    if(p == freep)
 9d2:	00093703          	ld	a4,0(s2)
 9d6:	853e                	mv	a0,a5
 9d8:	fef719e3          	bne	a4,a5,9ca <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 9dc:	8552                	mv	a0,s4
 9de:	987ff0ef          	jal	364 <sbrk>
  if(p == SBRK_ERROR)
 9e2:	fd551ce3          	bne	a0,s5,9ba <malloc+0x7e>
        return 0;
 9e6:	4501                	li	a0,0
 9e8:	7902                	ld	s2,32(sp)
 9ea:	6a42                	ld	s4,16(sp)
 9ec:	6aa2                	ld	s5,8(sp)
 9ee:	6b02                	ld	s6,0(sp)
 9f0:	a03d                	j	a1e <malloc+0xe2>
 9f2:	7902                	ld	s2,32(sp)
 9f4:	6a42                	ld	s4,16(sp)
 9f6:	6aa2                	ld	s5,8(sp)
 9f8:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 9fa:	fae48de3          	beq	s1,a4,9b4 <malloc+0x78>
        p->s.size -= nunits;
 9fe:	4137073b          	subw	a4,a4,s3
 a02:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a04:	02071693          	slli	a3,a4,0x20
 a08:	01c6d713          	srli	a4,a3,0x1c
 a0c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a0e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a12:	00000717          	auipc	a4,0x0
 a16:	5ea73723          	sd	a0,1518(a4) # 1000 <freep>
      return (void*)(p + 1);
 a1a:	01078513          	addi	a0,a5,16
  }
}
 a1e:	70e2                	ld	ra,56(sp)
 a20:	7442                	ld	s0,48(sp)
 a22:	74a2                	ld	s1,40(sp)
 a24:	69e2                	ld	s3,24(sp)
 a26:	6121                	addi	sp,sp,64
 a28:	8082                	ret
 a2a:	7902                	ld	s2,32(sp)
 a2c:	6a42                	ld	s4,16(sp)
 a2e:	6aa2                	ld	s5,8(sp)
 a30:	6b02                	ld	s6,0(sp)
 a32:	b7f5                	j	a1e <malloc+0xe2>
