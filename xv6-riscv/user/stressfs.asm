
user/_stressfs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

int
main(int argc, char *argv[])
{
   0:	dd010113          	addi	sp,sp,-560
   4:	22113423          	sd	ra,552(sp)
   8:	22813023          	sd	s0,544(sp)
   c:	20913c23          	sd	s1,536(sp)
  10:	21213823          	sd	s2,528(sp)
  14:	1c00                	addi	s0,sp,560
  int fd, i;
  char path[] = "stressfs0";
  16:	00001797          	auipc	a5,0x1
  1a:	a2a78793          	addi	a5,a5,-1494 # a40 <malloc+0x130>
  1e:	6398                	ld	a4,0(a5)
  20:	fce43823          	sd	a4,-48(s0)
  24:	0087d783          	lhu	a5,8(a5)
  28:	fcf41c23          	sh	a5,-40(s0)
  char data[512];

  printf("stressfs starting\n");
  2c:	00001517          	auipc	a0,0x1
  30:	9e450513          	addi	a0,a0,-1564 # a10 <malloc+0x100>
  34:	029000ef          	jal	85c <printf>
  memset(data, 'a', sizeof(data));
  38:	20000613          	li	a2,512
  3c:	06100593          	li	a1,97
  40:	dd040513          	addi	a0,s0,-560
  44:	116000ef          	jal	15a <memset>

  for(i = 0; i < 4; i++)
  48:	4481                	li	s1,0
  4a:	4911                	li	s2,4
    if(fork() > 0)
  4c:	3a8000ef          	jal	3f4 <fork>
  50:	00a04563          	bgtz	a0,5a <main+0x5a>
  for(i = 0; i < 4; i++)
  54:	2485                	addiw	s1,s1,1
  56:	ff249be3          	bne	s1,s2,4c <main+0x4c>
      break;

  printf("write %d\n", i);
  5a:	85a6                	mv	a1,s1
  5c:	00001517          	auipc	a0,0x1
  60:	9cc50513          	addi	a0,a0,-1588 # a28 <malloc+0x118>
  64:	7f8000ef          	jal	85c <printf>

  path[8] += i;
  68:	fd844783          	lbu	a5,-40(s0)
  6c:	9fa5                	addw	a5,a5,s1
  6e:	fcf40c23          	sb	a5,-40(s0)
  fd = open(path, O_CREATE | O_RDWR);
  72:	20200593          	li	a1,514
  76:	fd040513          	addi	a0,s0,-48
  7a:	3c2000ef          	jal	43c <open>
  7e:	892a                	mv	s2,a0
  80:	44d1                	li	s1,20
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  82:	20000613          	li	a2,512
  86:	dd040593          	addi	a1,s0,-560
  8a:	854a                	mv	a0,s2
  8c:	390000ef          	jal	41c <write>
  for(i = 0; i < 20; i++)
  90:	34fd                	addiw	s1,s1,-1
  92:	f8e5                	bnez	s1,82 <main+0x82>
  close(fd);
  94:	854a                	mv	a0,s2
  96:	38e000ef          	jal	424 <close>

  printf("read\n");
  9a:	00001517          	auipc	a0,0x1
  9e:	99e50513          	addi	a0,a0,-1634 # a38 <malloc+0x128>
  a2:	7ba000ef          	jal	85c <printf>

  fd = open(path, O_RDONLY);
  a6:	4581                	li	a1,0
  a8:	fd040513          	addi	a0,s0,-48
  ac:	390000ef          	jal	43c <open>
  b0:	892a                	mv	s2,a0
  b2:	44d1                	li	s1,20
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
  b4:	20000613          	li	a2,512
  b8:	dd040593          	addi	a1,s0,-560
  bc:	854a                	mv	a0,s2
  be:	356000ef          	jal	414 <read>
  for (i = 0; i < 20; i++)
  c2:	34fd                	addiw	s1,s1,-1
  c4:	f8e5                	bnez	s1,b4 <main+0xb4>
  close(fd);
  c6:	854a                	mv	a0,s2
  c8:	35c000ef          	jal	424 <close>

  wait(0);
  cc:	4501                	li	a0,0
  ce:	336000ef          	jal	404 <wait>

  exit(0);
  d2:	4501                	li	a0,0
  d4:	328000ef          	jal	3fc <exit>

00000000000000d8 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  d8:	1141                	addi	sp,sp,-16
  da:	e406                	sd	ra,8(sp)
  dc:	e022                	sd	s0,0(sp)
  de:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  e0:	f21ff0ef          	jal	0 <main>
  exit(r);
  e4:	318000ef          	jal	3fc <exit>

00000000000000e8 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  e8:	1141                	addi	sp,sp,-16
  ea:	e422                	sd	s0,8(sp)
  ec:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  ee:	87aa                	mv	a5,a0
  f0:	0585                	addi	a1,a1,1
  f2:	0785                	addi	a5,a5,1
  f4:	fff5c703          	lbu	a4,-1(a1)
  f8:	fee78fa3          	sb	a4,-1(a5)
  fc:	fb75                	bnez	a4,f0 <strcpy+0x8>
    ;
  return os;
}
  fe:	6422                	ld	s0,8(sp)
 100:	0141                	addi	sp,sp,16
 102:	8082                	ret

0000000000000104 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 104:	1141                	addi	sp,sp,-16
 106:	e422                	sd	s0,8(sp)
 108:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 10a:	00054783          	lbu	a5,0(a0)
 10e:	cb91                	beqz	a5,122 <strcmp+0x1e>
 110:	0005c703          	lbu	a4,0(a1)
 114:	00f71763          	bne	a4,a5,122 <strcmp+0x1e>
    p++, q++;
 118:	0505                	addi	a0,a0,1
 11a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 11c:	00054783          	lbu	a5,0(a0)
 120:	fbe5                	bnez	a5,110 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 122:	0005c503          	lbu	a0,0(a1)
}
 126:	40a7853b          	subw	a0,a5,a0
 12a:	6422                	ld	s0,8(sp)
 12c:	0141                	addi	sp,sp,16
 12e:	8082                	ret

0000000000000130 <strlen>:

uint
strlen(const char *s)
{
 130:	1141                	addi	sp,sp,-16
 132:	e422                	sd	s0,8(sp)
 134:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 136:	00054783          	lbu	a5,0(a0)
 13a:	cf91                	beqz	a5,156 <strlen+0x26>
 13c:	0505                	addi	a0,a0,1
 13e:	87aa                	mv	a5,a0
 140:	86be                	mv	a3,a5
 142:	0785                	addi	a5,a5,1
 144:	fff7c703          	lbu	a4,-1(a5)
 148:	ff65                	bnez	a4,140 <strlen+0x10>
 14a:	40a6853b          	subw	a0,a3,a0
 14e:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 150:	6422                	ld	s0,8(sp)
 152:	0141                	addi	sp,sp,16
 154:	8082                	ret
  for(n = 0; s[n]; n++)
 156:	4501                	li	a0,0
 158:	bfe5                	j	150 <strlen+0x20>

000000000000015a <memset>:

void*
memset(void *dst, int c, uint n)
{
 15a:	1141                	addi	sp,sp,-16
 15c:	e422                	sd	s0,8(sp)
 15e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 160:	ca19                	beqz	a2,176 <memset+0x1c>
 162:	87aa                	mv	a5,a0
 164:	1602                	slli	a2,a2,0x20
 166:	9201                	srli	a2,a2,0x20
 168:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 16c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 170:	0785                	addi	a5,a5,1
 172:	fee79de3          	bne	a5,a4,16c <memset+0x12>
  }
  return dst;
}
 176:	6422                	ld	s0,8(sp)
 178:	0141                	addi	sp,sp,16
 17a:	8082                	ret

000000000000017c <strchr>:

char*
strchr(const char *s, char c)
{
 17c:	1141                	addi	sp,sp,-16
 17e:	e422                	sd	s0,8(sp)
 180:	0800                	addi	s0,sp,16
  for(; *s; s++)
 182:	00054783          	lbu	a5,0(a0)
 186:	cb99                	beqz	a5,19c <strchr+0x20>
    if(*s == c)
 188:	00f58763          	beq	a1,a5,196 <strchr+0x1a>
  for(; *s; s++)
 18c:	0505                	addi	a0,a0,1
 18e:	00054783          	lbu	a5,0(a0)
 192:	fbfd                	bnez	a5,188 <strchr+0xc>
      return (char*)s;
  return 0;
 194:	4501                	li	a0,0
}
 196:	6422                	ld	s0,8(sp)
 198:	0141                	addi	sp,sp,16
 19a:	8082                	ret
  return 0;
 19c:	4501                	li	a0,0
 19e:	bfe5                	j	196 <strchr+0x1a>

00000000000001a0 <gets>:

char*
gets(char *buf, int max)
{
 1a0:	711d                	addi	sp,sp,-96
 1a2:	ec86                	sd	ra,88(sp)
 1a4:	e8a2                	sd	s0,80(sp)
 1a6:	e4a6                	sd	s1,72(sp)
 1a8:	e0ca                	sd	s2,64(sp)
 1aa:	fc4e                	sd	s3,56(sp)
 1ac:	f852                	sd	s4,48(sp)
 1ae:	f456                	sd	s5,40(sp)
 1b0:	f05a                	sd	s6,32(sp)
 1b2:	ec5e                	sd	s7,24(sp)
 1b4:	1080                	addi	s0,sp,96
 1b6:	8baa                	mv	s7,a0
 1b8:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1ba:	892a                	mv	s2,a0
 1bc:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1be:	4aa9                	li	s5,10
 1c0:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1c2:	89a6                	mv	s3,s1
 1c4:	2485                	addiw	s1,s1,1
 1c6:	0344d663          	bge	s1,s4,1f2 <gets+0x52>
    cc = read(0, &c, 1);
 1ca:	4605                	li	a2,1
 1cc:	faf40593          	addi	a1,s0,-81
 1d0:	4501                	li	a0,0
 1d2:	242000ef          	jal	414 <read>
    if(cc < 1)
 1d6:	00a05e63          	blez	a0,1f2 <gets+0x52>
    buf[i++] = c;
 1da:	faf44783          	lbu	a5,-81(s0)
 1de:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1e2:	01578763          	beq	a5,s5,1f0 <gets+0x50>
 1e6:	0905                	addi	s2,s2,1
 1e8:	fd679de3          	bne	a5,s6,1c2 <gets+0x22>
    buf[i++] = c;
 1ec:	89a6                	mv	s3,s1
 1ee:	a011                	j	1f2 <gets+0x52>
 1f0:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1f2:	99de                	add	s3,s3,s7
 1f4:	00098023          	sb	zero,0(s3)
  return buf;
}
 1f8:	855e                	mv	a0,s7
 1fa:	60e6                	ld	ra,88(sp)
 1fc:	6446                	ld	s0,80(sp)
 1fe:	64a6                	ld	s1,72(sp)
 200:	6906                	ld	s2,64(sp)
 202:	79e2                	ld	s3,56(sp)
 204:	7a42                	ld	s4,48(sp)
 206:	7aa2                	ld	s5,40(sp)
 208:	7b02                	ld	s6,32(sp)
 20a:	6be2                	ld	s7,24(sp)
 20c:	6125                	addi	sp,sp,96
 20e:	8082                	ret

0000000000000210 <stat>:

int
stat(const char *n, struct stat *st)
{
 210:	1101                	addi	sp,sp,-32
 212:	ec06                	sd	ra,24(sp)
 214:	e822                	sd	s0,16(sp)
 216:	e04a                	sd	s2,0(sp)
 218:	1000                	addi	s0,sp,32
 21a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 21c:	4581                	li	a1,0
 21e:	21e000ef          	jal	43c <open>
  if(fd < 0)
 222:	02054263          	bltz	a0,246 <stat+0x36>
 226:	e426                	sd	s1,8(sp)
 228:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 22a:	85ca                	mv	a1,s2
 22c:	228000ef          	jal	454 <fstat>
 230:	892a                	mv	s2,a0
  close(fd);
 232:	8526                	mv	a0,s1
 234:	1f0000ef          	jal	424 <close>
  return r;
 238:	64a2                	ld	s1,8(sp)
}
 23a:	854a                	mv	a0,s2
 23c:	60e2                	ld	ra,24(sp)
 23e:	6442                	ld	s0,16(sp)
 240:	6902                	ld	s2,0(sp)
 242:	6105                	addi	sp,sp,32
 244:	8082                	ret
    return -1;
 246:	597d                	li	s2,-1
 248:	bfcd                	j	23a <stat+0x2a>

000000000000024a <atoi>:

int
atoi(const char *s)
{
 24a:	1141                	addi	sp,sp,-16
 24c:	e422                	sd	s0,8(sp)
 24e:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 250:	00054683          	lbu	a3,0(a0)
 254:	fd06879b          	addiw	a5,a3,-48
 258:	0ff7f793          	zext.b	a5,a5
 25c:	4625                	li	a2,9
 25e:	02f66863          	bltu	a2,a5,28e <atoi+0x44>
 262:	872a                	mv	a4,a0
  n = 0;
 264:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 266:	0705                	addi	a4,a4,1
 268:	0025179b          	slliw	a5,a0,0x2
 26c:	9fa9                	addw	a5,a5,a0
 26e:	0017979b          	slliw	a5,a5,0x1
 272:	9fb5                	addw	a5,a5,a3
 274:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 278:	00074683          	lbu	a3,0(a4)
 27c:	fd06879b          	addiw	a5,a3,-48
 280:	0ff7f793          	zext.b	a5,a5
 284:	fef671e3          	bgeu	a2,a5,266 <atoi+0x1c>
  return n;
}
 288:	6422                	ld	s0,8(sp)
 28a:	0141                	addi	sp,sp,16
 28c:	8082                	ret
  n = 0;
 28e:	4501                	li	a0,0
 290:	bfe5                	j	288 <atoi+0x3e>

0000000000000292 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 292:	1141                	addi	sp,sp,-16
 294:	e422                	sd	s0,8(sp)
 296:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 298:	02b57463          	bgeu	a0,a1,2c0 <memmove+0x2e>
    while(n-- > 0)
 29c:	00c05f63          	blez	a2,2ba <memmove+0x28>
 2a0:	1602                	slli	a2,a2,0x20
 2a2:	9201                	srli	a2,a2,0x20
 2a4:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2a8:	872a                	mv	a4,a0
      *dst++ = *src++;
 2aa:	0585                	addi	a1,a1,1
 2ac:	0705                	addi	a4,a4,1
 2ae:	fff5c683          	lbu	a3,-1(a1)
 2b2:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2b6:	fef71ae3          	bne	a4,a5,2aa <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2ba:	6422                	ld	s0,8(sp)
 2bc:	0141                	addi	sp,sp,16
 2be:	8082                	ret
    dst += n;
 2c0:	00c50733          	add	a4,a0,a2
    src += n;
 2c4:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2c6:	fec05ae3          	blez	a2,2ba <memmove+0x28>
 2ca:	fff6079b          	addiw	a5,a2,-1
 2ce:	1782                	slli	a5,a5,0x20
 2d0:	9381                	srli	a5,a5,0x20
 2d2:	fff7c793          	not	a5,a5
 2d6:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2d8:	15fd                	addi	a1,a1,-1
 2da:	177d                	addi	a4,a4,-1
 2dc:	0005c683          	lbu	a3,0(a1)
 2e0:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2e4:	fee79ae3          	bne	a5,a4,2d8 <memmove+0x46>
 2e8:	bfc9                	j	2ba <memmove+0x28>

00000000000002ea <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2ea:	1141                	addi	sp,sp,-16
 2ec:	e422                	sd	s0,8(sp)
 2ee:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2f0:	ca05                	beqz	a2,320 <memcmp+0x36>
 2f2:	fff6069b          	addiw	a3,a2,-1
 2f6:	1682                	slli	a3,a3,0x20
 2f8:	9281                	srli	a3,a3,0x20
 2fa:	0685                	addi	a3,a3,1
 2fc:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2fe:	00054783          	lbu	a5,0(a0)
 302:	0005c703          	lbu	a4,0(a1)
 306:	00e79863          	bne	a5,a4,316 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 30a:	0505                	addi	a0,a0,1
    p2++;
 30c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 30e:	fed518e3          	bne	a0,a3,2fe <memcmp+0x14>
  }
  return 0;
 312:	4501                	li	a0,0
 314:	a019                	j	31a <memcmp+0x30>
      return *p1 - *p2;
 316:	40e7853b          	subw	a0,a5,a4
}
 31a:	6422                	ld	s0,8(sp)
 31c:	0141                	addi	sp,sp,16
 31e:	8082                	ret
  return 0;
 320:	4501                	li	a0,0
 322:	bfe5                	j	31a <memcmp+0x30>

0000000000000324 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 324:	1141                	addi	sp,sp,-16
 326:	e406                	sd	ra,8(sp)
 328:	e022                	sd	s0,0(sp)
 32a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 32c:	f67ff0ef          	jal	292 <memmove>
}
 330:	60a2                	ld	ra,8(sp)
 332:	6402                	ld	s0,0(sp)
 334:	0141                	addi	sp,sp,16
 336:	8082                	ret

0000000000000338 <sbrk>:

char *
sbrk(int n) {
 338:	1141                	addi	sp,sp,-16
 33a:	e406                	sd	ra,8(sp)
 33c:	e022                	sd	s0,0(sp)
 33e:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 340:	4585                	li	a1,1
 342:	142000ef          	jal	484 <sys_sbrk>
}
 346:	60a2                	ld	ra,8(sp)
 348:	6402                	ld	s0,0(sp)
 34a:	0141                	addi	sp,sp,16
 34c:	8082                	ret

000000000000034e <sbrklazy>:

char *
sbrklazy(int n) {
 34e:	1141                	addi	sp,sp,-16
 350:	e406                	sd	ra,8(sp)
 352:	e022                	sd	s0,0(sp)
 354:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 356:	4589                	li	a1,2
 358:	12c000ef          	jal	484 <sys_sbrk>
}
 35c:	60a2                	ld	ra,8(sp)
 35e:	6402                	ld	s0,0(sp)
 360:	0141                	addi	sp,sp,16
 362:	8082                	ret

0000000000000364 <thread_create>:
// thread_create allocates a page-sized stack, calls clone(fn, arg, stacktop).
// Returns the new thread's pid, or -1 on error.
// The stack is passed back via *stack so the caller can free it after join.
int
thread_create(void(*fn)(void*), void *arg, void **stack)
{
 364:	7179                	addi	sp,sp,-48
 366:	f406                	sd	ra,40(sp)
 368:	f022                	sd	s0,32(sp)
 36a:	e84a                	sd	s2,16(sp)
 36c:	e44e                	sd	s3,8(sp)
 36e:	e052                	sd	s4,0(sp)
 370:	1800                	addi	s0,sp,48
 372:	89aa                	mv	s3,a0
 374:	8a2e                	mv	s4,a1
 376:	8932                	mv	s2,a2
  char *s = malloc(PGSIZE);
 378:	6505                	lui	a0,0x1
 37a:	596000ef          	jal	910 <malloc>
  if(s == 0)
 37e:	cd0d                	beqz	a0,3b8 <thread_create+0x54>
 380:	ec26                	sd	s1,24(sp)
 382:	84aa                	mv	s1,a0
    return -1;
  *stack = s;
 384:	00a93023          	sd	a0,0(s2)
  // Stack grows downward: pass the top of the allocated region.
  int pid = clone(fn, arg, s + PGSIZE);
 388:	6605                	lui	a2,0x1
 38a:	962a                	add	a2,a2,a0
 38c:	85d2                	mv	a1,s4
 38e:	854e                	mv	a0,s3
 390:	134000ef          	jal	4c4 <clone>
  if(pid < 0){
 394:	00054a63          	bltz	a0,3a8 <thread_create+0x44>
 398:	64e2                	ld	s1,24(sp)
    free(s);
    *stack = 0;
    return -1;
  }
  return pid;
}
 39a:	70a2                	ld	ra,40(sp)
 39c:	7402                	ld	s0,32(sp)
 39e:	6942                	ld	s2,16(sp)
 3a0:	69a2                	ld	s3,8(sp)
 3a2:	6a02                	ld	s4,0(sp)
 3a4:	6145                	addi	sp,sp,48
 3a6:	8082                	ret
    free(s);
 3a8:	8526                	mv	a0,s1
 3aa:	4e4000ef          	jal	88e <free>
    *stack = 0;
 3ae:	00093023          	sd	zero,0(s2)
    return -1;
 3b2:	557d                	li	a0,-1
 3b4:	64e2                	ld	s1,24(sp)
 3b6:	b7d5                	j	39a <thread_create+0x36>
    return -1;
 3b8:	557d                	li	a0,-1
 3ba:	b7c5                	j	39a <thread_create+0x36>

00000000000003bc <thread_join>:
// Wait for any child thread to exit.
// If stack is non-null, frees the memory pointed to by *stack and clears it.
// Returns the joined thread's pid, or -1 on error.
int
thread_join(void **stack)
{
 3bc:	1101                	addi	sp,sp,-32
 3be:	ec06                	sd	ra,24(sp)
 3c0:	e822                	sd	s0,16(sp)
 3c2:	e426                	sd	s1,8(sp)
 3c4:	e04a                	sd	s2,0(sp)
 3c6:	1000                	addi	s0,sp,32
 3c8:	84aa                	mv	s1,a0
  int pid = join();
 3ca:	102000ef          	jal	4cc <join>
  if(pid < 0)
 3ce:	02054163          	bltz	a0,3f0 <thread_join+0x34>
 3d2:	892a                	mv	s2,a0
    return -1;
  if(stack && *stack){
 3d4:	c499                	beqz	s1,3e2 <thread_join+0x26>
 3d6:	6088                	ld	a0,0(s1)
 3d8:	c509                	beqz	a0,3e2 <thread_join+0x26>
    free(*stack);
 3da:	4b4000ef          	jal	88e <free>
    *stack = 0;
 3de:	0004b023          	sd	zero,0(s1)
  }
  return pid;
}
 3e2:	854a                	mv	a0,s2
 3e4:	60e2                	ld	ra,24(sp)
 3e6:	6442                	ld	s0,16(sp)
 3e8:	64a2                	ld	s1,8(sp)
 3ea:	6902                	ld	s2,0(sp)
 3ec:	6105                	addi	sp,sp,32
 3ee:	8082                	ret
    return -1;
 3f0:	597d                	li	s2,-1
 3f2:	bfc5                	j	3e2 <thread_join+0x26>

00000000000003f4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3f4:	4885                	li	a7,1
 ecall
 3f6:	00000073          	ecall
 ret
 3fa:	8082                	ret

00000000000003fc <exit>:
.global exit
exit:
 li a7, SYS_exit
 3fc:	4889                	li	a7,2
 ecall
 3fe:	00000073          	ecall
 ret
 402:	8082                	ret

0000000000000404 <wait>:
.global wait
wait:
 li a7, SYS_wait
 404:	488d                	li	a7,3
 ecall
 406:	00000073          	ecall
 ret
 40a:	8082                	ret

000000000000040c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 40c:	4891                	li	a7,4
 ecall
 40e:	00000073          	ecall
 ret
 412:	8082                	ret

0000000000000414 <read>:
.global read
read:
 li a7, SYS_read
 414:	4895                	li	a7,5
 ecall
 416:	00000073          	ecall
 ret
 41a:	8082                	ret

000000000000041c <write>:
.global write
write:
 li a7, SYS_write
 41c:	48c1                	li	a7,16
 ecall
 41e:	00000073          	ecall
 ret
 422:	8082                	ret

0000000000000424 <close>:
.global close
close:
 li a7, SYS_close
 424:	48d5                	li	a7,21
 ecall
 426:	00000073          	ecall
 ret
 42a:	8082                	ret

000000000000042c <kill>:
.global kill
kill:
 li a7, SYS_kill
 42c:	4899                	li	a7,6
 ecall
 42e:	00000073          	ecall
 ret
 432:	8082                	ret

0000000000000434 <exec>:
.global exec
exec:
 li a7, SYS_exec
 434:	489d                	li	a7,7
 ecall
 436:	00000073          	ecall
 ret
 43a:	8082                	ret

000000000000043c <open>:
.global open
open:
 li a7, SYS_open
 43c:	48bd                	li	a7,15
 ecall
 43e:	00000073          	ecall
 ret
 442:	8082                	ret

0000000000000444 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 444:	48c5                	li	a7,17
 ecall
 446:	00000073          	ecall
 ret
 44a:	8082                	ret

000000000000044c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 44c:	48c9                	li	a7,18
 ecall
 44e:	00000073          	ecall
 ret
 452:	8082                	ret

0000000000000454 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 454:	48a1                	li	a7,8
 ecall
 456:	00000073          	ecall
 ret
 45a:	8082                	ret

000000000000045c <link>:
.global link
link:
 li a7, SYS_link
 45c:	48cd                	li	a7,19
 ecall
 45e:	00000073          	ecall
 ret
 462:	8082                	ret

0000000000000464 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 464:	48d1                	li	a7,20
 ecall
 466:	00000073          	ecall
 ret
 46a:	8082                	ret

000000000000046c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 46c:	48a5                	li	a7,9
 ecall
 46e:	00000073          	ecall
 ret
 472:	8082                	ret

0000000000000474 <dup>:
.global dup
dup:
 li a7, SYS_dup
 474:	48a9                	li	a7,10
 ecall
 476:	00000073          	ecall
 ret
 47a:	8082                	ret

000000000000047c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 47c:	48ad                	li	a7,11
 ecall
 47e:	00000073          	ecall
 ret
 482:	8082                	ret

0000000000000484 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 484:	48b1                	li	a7,12
 ecall
 486:	00000073          	ecall
 ret
 48a:	8082                	ret

000000000000048c <pause>:
.global pause
pause:
 li a7, SYS_pause
 48c:	48b5                	li	a7,13
 ecall
 48e:	00000073          	ecall
 ret
 492:	8082                	ret

0000000000000494 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 494:	48b9                	li	a7,14
 ecall
 496:	00000073          	ecall
 ret
 49a:	8082                	ret

000000000000049c <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 49c:	48d9                	li	a7,22
 ecall
 49e:	00000073          	ecall
 ret
 4a2:	8082                	ret

00000000000004a4 <lock_create>:
.global lock_create
lock_create:
 li a7, SYS_lock_create
 4a4:	48dd                	li	a7,23
 ecall
 4a6:	00000073          	ecall
 ret
 4aa:	8082                	ret

00000000000004ac <lock_acquire>:
.global lock_acquire
lock_acquire:
 li a7, SYS_lock_acquire
 4ac:	48e1                	li	a7,24
 ecall
 4ae:	00000073          	ecall
 ret
 4b2:	8082                	ret

00000000000004b4 <lock_release>:
.global lock_release
lock_release:
 li a7, SYS_lock_release
 4b4:	48e5                	li	a7,25
 ecall
 4b6:	00000073          	ecall
 ret
 4ba:	8082                	ret

00000000000004bc <lock_destroy>:
.global lock_destroy
lock_destroy:
 li a7, SYS_lock_destroy
 4bc:	48e9                	li	a7,26
 ecall
 4be:	00000073          	ecall
 ret
 4c2:	8082                	ret

00000000000004c4 <clone>:
.global clone
clone:
 li a7, SYS_clone
 4c4:	48ed                	li	a7,27
 ecall
 4c6:	00000073          	ecall
 ret
 4ca:	8082                	ret

00000000000004cc <join>:
.global join
join:
 li a7, SYS_join
 4cc:	48f1                	li	a7,28
 ecall
 4ce:	00000073          	ecall
 ret
 4d2:	8082                	ret

00000000000004d4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4d4:	1101                	addi	sp,sp,-32
 4d6:	ec06                	sd	ra,24(sp)
 4d8:	e822                	sd	s0,16(sp)
 4da:	1000                	addi	s0,sp,32
 4dc:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4e0:	4605                	li	a2,1
 4e2:	fef40593          	addi	a1,s0,-17
 4e6:	f37ff0ef          	jal	41c <write>
}
 4ea:	60e2                	ld	ra,24(sp)
 4ec:	6442                	ld	s0,16(sp)
 4ee:	6105                	addi	sp,sp,32
 4f0:	8082                	ret

00000000000004f2 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 4f2:	715d                	addi	sp,sp,-80
 4f4:	e486                	sd	ra,72(sp)
 4f6:	e0a2                	sd	s0,64(sp)
 4f8:	f84a                	sd	s2,48(sp)
 4fa:	0880                	addi	s0,sp,80
 4fc:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 4fe:	c299                	beqz	a3,504 <printint+0x12>
 500:	0805c363          	bltz	a1,586 <printint+0x94>
  neg = 0;
 504:	4881                	li	a7,0
 506:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 50a:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 50c:	00000517          	auipc	a0,0x0
 510:	54c50513          	addi	a0,a0,1356 # a58 <digits>
 514:	883e                	mv	a6,a5
 516:	2785                	addiw	a5,a5,1
 518:	02c5f733          	remu	a4,a1,a2
 51c:	972a                	add	a4,a4,a0
 51e:	00074703          	lbu	a4,0(a4)
 522:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 526:	872e                	mv	a4,a1
 528:	02c5d5b3          	divu	a1,a1,a2
 52c:	0685                	addi	a3,a3,1
 52e:	fec773e3          	bgeu	a4,a2,514 <printint+0x22>
  if(neg)
 532:	00088b63          	beqz	a7,548 <printint+0x56>
    buf[i++] = '-';
 536:	fd078793          	addi	a5,a5,-48
 53a:	97a2                	add	a5,a5,s0
 53c:	02d00713          	li	a4,45
 540:	fee78423          	sb	a4,-24(a5)
 544:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 548:	02f05a63          	blez	a5,57c <printint+0x8a>
 54c:	fc26                	sd	s1,56(sp)
 54e:	f44e                	sd	s3,40(sp)
 550:	fb840713          	addi	a4,s0,-72
 554:	00f704b3          	add	s1,a4,a5
 558:	fff70993          	addi	s3,a4,-1
 55c:	99be                	add	s3,s3,a5
 55e:	37fd                	addiw	a5,a5,-1
 560:	1782                	slli	a5,a5,0x20
 562:	9381                	srli	a5,a5,0x20
 564:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 568:	fff4c583          	lbu	a1,-1(s1)
 56c:	854a                	mv	a0,s2
 56e:	f67ff0ef          	jal	4d4 <putc>
  while(--i >= 0)
 572:	14fd                	addi	s1,s1,-1
 574:	ff349ae3          	bne	s1,s3,568 <printint+0x76>
 578:	74e2                	ld	s1,56(sp)
 57a:	79a2                	ld	s3,40(sp)
}
 57c:	60a6                	ld	ra,72(sp)
 57e:	6406                	ld	s0,64(sp)
 580:	7942                	ld	s2,48(sp)
 582:	6161                	addi	sp,sp,80
 584:	8082                	ret
    x = -xx;
 586:	40b005b3          	neg	a1,a1
    neg = 1;
 58a:	4885                	li	a7,1
    x = -xx;
 58c:	bfad                	j	506 <printint+0x14>

000000000000058e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 58e:	711d                	addi	sp,sp,-96
 590:	ec86                	sd	ra,88(sp)
 592:	e8a2                	sd	s0,80(sp)
 594:	e0ca                	sd	s2,64(sp)
 596:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 598:	0005c903          	lbu	s2,0(a1)
 59c:	28090663          	beqz	s2,828 <vprintf+0x29a>
 5a0:	e4a6                	sd	s1,72(sp)
 5a2:	fc4e                	sd	s3,56(sp)
 5a4:	f852                	sd	s4,48(sp)
 5a6:	f456                	sd	s5,40(sp)
 5a8:	f05a                	sd	s6,32(sp)
 5aa:	ec5e                	sd	s7,24(sp)
 5ac:	e862                	sd	s8,16(sp)
 5ae:	e466                	sd	s9,8(sp)
 5b0:	8b2a                	mv	s6,a0
 5b2:	8a2e                	mv	s4,a1
 5b4:	8bb2                	mv	s7,a2
  state = 0;
 5b6:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 5b8:	4481                	li	s1,0
 5ba:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 5bc:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 5c0:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 5c4:	06c00c93          	li	s9,108
 5c8:	a005                	j	5e8 <vprintf+0x5a>
        putc(fd, c0);
 5ca:	85ca                	mv	a1,s2
 5cc:	855a                	mv	a0,s6
 5ce:	f07ff0ef          	jal	4d4 <putc>
 5d2:	a019                	j	5d8 <vprintf+0x4a>
    } else if(state == '%'){
 5d4:	03598263          	beq	s3,s5,5f8 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 5d8:	2485                	addiw	s1,s1,1
 5da:	8726                	mv	a4,s1
 5dc:	009a07b3          	add	a5,s4,s1
 5e0:	0007c903          	lbu	s2,0(a5)
 5e4:	22090a63          	beqz	s2,818 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 5e8:	0009079b          	sext.w	a5,s2
    if(state == 0){
 5ec:	fe0994e3          	bnez	s3,5d4 <vprintf+0x46>
      if(c0 == '%'){
 5f0:	fd579de3          	bne	a5,s5,5ca <vprintf+0x3c>
        state = '%';
 5f4:	89be                	mv	s3,a5
 5f6:	b7cd                	j	5d8 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 5f8:	00ea06b3          	add	a3,s4,a4
 5fc:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 600:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 602:	c681                	beqz	a3,60a <vprintf+0x7c>
 604:	9752                	add	a4,a4,s4
 606:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 60a:	05878363          	beq	a5,s8,650 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 60e:	05978d63          	beq	a5,s9,668 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 612:	07500713          	li	a4,117
 616:	0ee78763          	beq	a5,a4,704 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 61a:	07800713          	li	a4,120
 61e:	12e78963          	beq	a5,a4,750 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 622:	07000713          	li	a4,112
 626:	14e78e63          	beq	a5,a4,782 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 62a:	06300713          	li	a4,99
 62e:	18e78e63          	beq	a5,a4,7ca <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 632:	07300713          	li	a4,115
 636:	1ae78463          	beq	a5,a4,7de <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 63a:	02500713          	li	a4,37
 63e:	04e79563          	bne	a5,a4,688 <vprintf+0xfa>
        putc(fd, '%');
 642:	02500593          	li	a1,37
 646:	855a                	mv	a0,s6
 648:	e8dff0ef          	jal	4d4 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 64c:	4981                	li	s3,0
 64e:	b769                	j	5d8 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 650:	008b8913          	addi	s2,s7,8
 654:	4685                	li	a3,1
 656:	4629                	li	a2,10
 658:	000ba583          	lw	a1,0(s7)
 65c:	855a                	mv	a0,s6
 65e:	e95ff0ef          	jal	4f2 <printint>
 662:	8bca                	mv	s7,s2
      state = 0;
 664:	4981                	li	s3,0
 666:	bf8d                	j	5d8 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 668:	06400793          	li	a5,100
 66c:	02f68963          	beq	a3,a5,69e <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 670:	06c00793          	li	a5,108
 674:	04f68263          	beq	a3,a5,6b8 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 678:	07500793          	li	a5,117
 67c:	0af68063          	beq	a3,a5,71c <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 680:	07800793          	li	a5,120
 684:	0ef68263          	beq	a3,a5,768 <vprintf+0x1da>
        putc(fd, '%');
 688:	02500593          	li	a1,37
 68c:	855a                	mv	a0,s6
 68e:	e47ff0ef          	jal	4d4 <putc>
        putc(fd, c0);
 692:	85ca                	mv	a1,s2
 694:	855a                	mv	a0,s6
 696:	e3fff0ef          	jal	4d4 <putc>
      state = 0;
 69a:	4981                	li	s3,0
 69c:	bf35                	j	5d8 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 69e:	008b8913          	addi	s2,s7,8
 6a2:	4685                	li	a3,1
 6a4:	4629                	li	a2,10
 6a6:	000bb583          	ld	a1,0(s7)
 6aa:	855a                	mv	a0,s6
 6ac:	e47ff0ef          	jal	4f2 <printint>
        i += 1;
 6b0:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 6b2:	8bca                	mv	s7,s2
      state = 0;
 6b4:	4981                	li	s3,0
        i += 1;
 6b6:	b70d                	j	5d8 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6b8:	06400793          	li	a5,100
 6bc:	02f60763          	beq	a2,a5,6ea <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 6c0:	07500793          	li	a5,117
 6c4:	06f60963          	beq	a2,a5,736 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 6c8:	07800793          	li	a5,120
 6cc:	faf61ee3          	bne	a2,a5,688 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6d0:	008b8913          	addi	s2,s7,8
 6d4:	4681                	li	a3,0
 6d6:	4641                	li	a2,16
 6d8:	000bb583          	ld	a1,0(s7)
 6dc:	855a                	mv	a0,s6
 6de:	e15ff0ef          	jal	4f2 <printint>
        i += 2;
 6e2:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 6e4:	8bca                	mv	s7,s2
      state = 0;
 6e6:	4981                	li	s3,0
        i += 2;
 6e8:	bdc5                	j	5d8 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6ea:	008b8913          	addi	s2,s7,8
 6ee:	4685                	li	a3,1
 6f0:	4629                	li	a2,10
 6f2:	000bb583          	ld	a1,0(s7)
 6f6:	855a                	mv	a0,s6
 6f8:	dfbff0ef          	jal	4f2 <printint>
        i += 2;
 6fc:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 6fe:	8bca                	mv	s7,s2
      state = 0;
 700:	4981                	li	s3,0
        i += 2;
 702:	bdd9                	j	5d8 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 704:	008b8913          	addi	s2,s7,8
 708:	4681                	li	a3,0
 70a:	4629                	li	a2,10
 70c:	000be583          	lwu	a1,0(s7)
 710:	855a                	mv	a0,s6
 712:	de1ff0ef          	jal	4f2 <printint>
 716:	8bca                	mv	s7,s2
      state = 0;
 718:	4981                	li	s3,0
 71a:	bd7d                	j	5d8 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 71c:	008b8913          	addi	s2,s7,8
 720:	4681                	li	a3,0
 722:	4629                	li	a2,10
 724:	000bb583          	ld	a1,0(s7)
 728:	855a                	mv	a0,s6
 72a:	dc9ff0ef          	jal	4f2 <printint>
        i += 1;
 72e:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 730:	8bca                	mv	s7,s2
      state = 0;
 732:	4981                	li	s3,0
        i += 1;
 734:	b555                	j	5d8 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 736:	008b8913          	addi	s2,s7,8
 73a:	4681                	li	a3,0
 73c:	4629                	li	a2,10
 73e:	000bb583          	ld	a1,0(s7)
 742:	855a                	mv	a0,s6
 744:	dafff0ef          	jal	4f2 <printint>
        i += 2;
 748:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 74a:	8bca                	mv	s7,s2
      state = 0;
 74c:	4981                	li	s3,0
        i += 2;
 74e:	b569                	j	5d8 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 750:	008b8913          	addi	s2,s7,8
 754:	4681                	li	a3,0
 756:	4641                	li	a2,16
 758:	000be583          	lwu	a1,0(s7)
 75c:	855a                	mv	a0,s6
 75e:	d95ff0ef          	jal	4f2 <printint>
 762:	8bca                	mv	s7,s2
      state = 0;
 764:	4981                	li	s3,0
 766:	bd8d                	j	5d8 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 768:	008b8913          	addi	s2,s7,8
 76c:	4681                	li	a3,0
 76e:	4641                	li	a2,16
 770:	000bb583          	ld	a1,0(s7)
 774:	855a                	mv	a0,s6
 776:	d7dff0ef          	jal	4f2 <printint>
        i += 1;
 77a:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 77c:	8bca                	mv	s7,s2
      state = 0;
 77e:	4981                	li	s3,0
        i += 1;
 780:	bda1                	j	5d8 <vprintf+0x4a>
 782:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 784:	008b8d13          	addi	s10,s7,8
 788:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 78c:	03000593          	li	a1,48
 790:	855a                	mv	a0,s6
 792:	d43ff0ef          	jal	4d4 <putc>
  putc(fd, 'x');
 796:	07800593          	li	a1,120
 79a:	855a                	mv	a0,s6
 79c:	d39ff0ef          	jal	4d4 <putc>
 7a0:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7a2:	00000b97          	auipc	s7,0x0
 7a6:	2b6b8b93          	addi	s7,s7,694 # a58 <digits>
 7aa:	03c9d793          	srli	a5,s3,0x3c
 7ae:	97de                	add	a5,a5,s7
 7b0:	0007c583          	lbu	a1,0(a5)
 7b4:	855a                	mv	a0,s6
 7b6:	d1fff0ef          	jal	4d4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7ba:	0992                	slli	s3,s3,0x4
 7bc:	397d                	addiw	s2,s2,-1
 7be:	fe0916e3          	bnez	s2,7aa <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 7c2:	8bea                	mv	s7,s10
      state = 0;
 7c4:	4981                	li	s3,0
 7c6:	6d02                	ld	s10,0(sp)
 7c8:	bd01                	j	5d8 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 7ca:	008b8913          	addi	s2,s7,8
 7ce:	000bc583          	lbu	a1,0(s7)
 7d2:	855a                	mv	a0,s6
 7d4:	d01ff0ef          	jal	4d4 <putc>
 7d8:	8bca                	mv	s7,s2
      state = 0;
 7da:	4981                	li	s3,0
 7dc:	bbf5                	j	5d8 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 7de:	008b8993          	addi	s3,s7,8
 7e2:	000bb903          	ld	s2,0(s7)
 7e6:	00090f63          	beqz	s2,804 <vprintf+0x276>
        for(; *s; s++)
 7ea:	00094583          	lbu	a1,0(s2)
 7ee:	c195                	beqz	a1,812 <vprintf+0x284>
          putc(fd, *s);
 7f0:	855a                	mv	a0,s6
 7f2:	ce3ff0ef          	jal	4d4 <putc>
        for(; *s; s++)
 7f6:	0905                	addi	s2,s2,1
 7f8:	00094583          	lbu	a1,0(s2)
 7fc:	f9f5                	bnez	a1,7f0 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 7fe:	8bce                	mv	s7,s3
      state = 0;
 800:	4981                	li	s3,0
 802:	bbd9                	j	5d8 <vprintf+0x4a>
          s = "(null)";
 804:	00000917          	auipc	s2,0x0
 808:	24c90913          	addi	s2,s2,588 # a50 <malloc+0x140>
        for(; *s; s++)
 80c:	02800593          	li	a1,40
 810:	b7c5                	j	7f0 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 812:	8bce                	mv	s7,s3
      state = 0;
 814:	4981                	li	s3,0
 816:	b3c9                	j	5d8 <vprintf+0x4a>
 818:	64a6                	ld	s1,72(sp)
 81a:	79e2                	ld	s3,56(sp)
 81c:	7a42                	ld	s4,48(sp)
 81e:	7aa2                	ld	s5,40(sp)
 820:	7b02                	ld	s6,32(sp)
 822:	6be2                	ld	s7,24(sp)
 824:	6c42                	ld	s8,16(sp)
 826:	6ca2                	ld	s9,8(sp)
    }
  }
}
 828:	60e6                	ld	ra,88(sp)
 82a:	6446                	ld	s0,80(sp)
 82c:	6906                	ld	s2,64(sp)
 82e:	6125                	addi	sp,sp,96
 830:	8082                	ret

0000000000000832 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 832:	715d                	addi	sp,sp,-80
 834:	ec06                	sd	ra,24(sp)
 836:	e822                	sd	s0,16(sp)
 838:	1000                	addi	s0,sp,32
 83a:	e010                	sd	a2,0(s0)
 83c:	e414                	sd	a3,8(s0)
 83e:	e818                	sd	a4,16(s0)
 840:	ec1c                	sd	a5,24(s0)
 842:	03043023          	sd	a6,32(s0)
 846:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 84a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 84e:	8622                	mv	a2,s0
 850:	d3fff0ef          	jal	58e <vprintf>
}
 854:	60e2                	ld	ra,24(sp)
 856:	6442                	ld	s0,16(sp)
 858:	6161                	addi	sp,sp,80
 85a:	8082                	ret

000000000000085c <printf>:

void
printf(const char *fmt, ...)
{
 85c:	711d                	addi	sp,sp,-96
 85e:	ec06                	sd	ra,24(sp)
 860:	e822                	sd	s0,16(sp)
 862:	1000                	addi	s0,sp,32
 864:	e40c                	sd	a1,8(s0)
 866:	e810                	sd	a2,16(s0)
 868:	ec14                	sd	a3,24(s0)
 86a:	f018                	sd	a4,32(s0)
 86c:	f41c                	sd	a5,40(s0)
 86e:	03043823          	sd	a6,48(s0)
 872:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 876:	00840613          	addi	a2,s0,8
 87a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 87e:	85aa                	mv	a1,a0
 880:	4505                	li	a0,1
 882:	d0dff0ef          	jal	58e <vprintf>
}
 886:	60e2                	ld	ra,24(sp)
 888:	6442                	ld	s0,16(sp)
 88a:	6125                	addi	sp,sp,96
 88c:	8082                	ret

000000000000088e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 88e:	1141                	addi	sp,sp,-16
 890:	e422                	sd	s0,8(sp)
 892:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 894:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 898:	00000797          	auipc	a5,0x0
 89c:	7687b783          	ld	a5,1896(a5) # 1000 <freep>
 8a0:	a02d                	j	8ca <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8a2:	4618                	lw	a4,8(a2)
 8a4:	9f2d                	addw	a4,a4,a1
 8a6:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8aa:	6398                	ld	a4,0(a5)
 8ac:	6310                	ld	a2,0(a4)
 8ae:	a83d                	j	8ec <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8b0:	ff852703          	lw	a4,-8(a0)
 8b4:	9f31                	addw	a4,a4,a2
 8b6:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8b8:	ff053683          	ld	a3,-16(a0)
 8bc:	a091                	j	900 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8be:	6398                	ld	a4,0(a5)
 8c0:	00e7e463          	bltu	a5,a4,8c8 <free+0x3a>
 8c4:	00e6ea63          	bltu	a3,a4,8d8 <free+0x4a>
{
 8c8:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8ca:	fed7fae3          	bgeu	a5,a3,8be <free+0x30>
 8ce:	6398                	ld	a4,0(a5)
 8d0:	00e6e463          	bltu	a3,a4,8d8 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8d4:	fee7eae3          	bltu	a5,a4,8c8 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 8d8:	ff852583          	lw	a1,-8(a0)
 8dc:	6390                	ld	a2,0(a5)
 8de:	02059813          	slli	a6,a1,0x20
 8e2:	01c85713          	srli	a4,a6,0x1c
 8e6:	9736                	add	a4,a4,a3
 8e8:	fae60de3          	beq	a2,a4,8a2 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 8ec:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8f0:	4790                	lw	a2,8(a5)
 8f2:	02061593          	slli	a1,a2,0x20
 8f6:	01c5d713          	srli	a4,a1,0x1c
 8fa:	973e                	add	a4,a4,a5
 8fc:	fae68ae3          	beq	a3,a4,8b0 <free+0x22>
    p->s.ptr = bp->s.ptr;
 900:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 902:	00000717          	auipc	a4,0x0
 906:	6ef73f23          	sd	a5,1790(a4) # 1000 <freep>
}
 90a:	6422                	ld	s0,8(sp)
 90c:	0141                	addi	sp,sp,16
 90e:	8082                	ret

0000000000000910 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 910:	7139                	addi	sp,sp,-64
 912:	fc06                	sd	ra,56(sp)
 914:	f822                	sd	s0,48(sp)
 916:	f426                	sd	s1,40(sp)
 918:	ec4e                	sd	s3,24(sp)
 91a:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 91c:	02051493          	slli	s1,a0,0x20
 920:	9081                	srli	s1,s1,0x20
 922:	04bd                	addi	s1,s1,15
 924:	8091                	srli	s1,s1,0x4
 926:	0014899b          	addiw	s3,s1,1
 92a:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 92c:	00000517          	auipc	a0,0x0
 930:	6d453503          	ld	a0,1748(a0) # 1000 <freep>
 934:	c915                	beqz	a0,968 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 936:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 938:	4798                	lw	a4,8(a5)
 93a:	08977a63          	bgeu	a4,s1,9ce <malloc+0xbe>
 93e:	f04a                	sd	s2,32(sp)
 940:	e852                	sd	s4,16(sp)
 942:	e456                	sd	s5,8(sp)
 944:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 946:	8a4e                	mv	s4,s3
 948:	0009871b          	sext.w	a4,s3
 94c:	6685                	lui	a3,0x1
 94e:	00d77363          	bgeu	a4,a3,954 <malloc+0x44>
 952:	6a05                	lui	s4,0x1
 954:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 958:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 95c:	00000917          	auipc	s2,0x0
 960:	6a490913          	addi	s2,s2,1700 # 1000 <freep>
  if(p == SBRK_ERROR)
 964:	5afd                	li	s5,-1
 966:	a081                	j	9a6 <malloc+0x96>
 968:	f04a                	sd	s2,32(sp)
 96a:	e852                	sd	s4,16(sp)
 96c:	e456                	sd	s5,8(sp)
 96e:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 970:	00000797          	auipc	a5,0x0
 974:	6a078793          	addi	a5,a5,1696 # 1010 <base>
 978:	00000717          	auipc	a4,0x0
 97c:	68f73423          	sd	a5,1672(a4) # 1000 <freep>
 980:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 982:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 986:	b7c1                	j	946 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 988:	6398                	ld	a4,0(a5)
 98a:	e118                	sd	a4,0(a0)
 98c:	a8a9                	j	9e6 <malloc+0xd6>
  hp->s.size = nu;
 98e:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 992:	0541                	addi	a0,a0,16
 994:	efbff0ef          	jal	88e <free>
  return freep;
 998:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 99c:	c12d                	beqz	a0,9fe <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 99e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9a0:	4798                	lw	a4,8(a5)
 9a2:	02977263          	bgeu	a4,s1,9c6 <malloc+0xb6>
    if(p == freep)
 9a6:	00093703          	ld	a4,0(s2)
 9aa:	853e                	mv	a0,a5
 9ac:	fef719e3          	bne	a4,a5,99e <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 9b0:	8552                	mv	a0,s4
 9b2:	987ff0ef          	jal	338 <sbrk>
  if(p == SBRK_ERROR)
 9b6:	fd551ce3          	bne	a0,s5,98e <malloc+0x7e>
        return 0;
 9ba:	4501                	li	a0,0
 9bc:	7902                	ld	s2,32(sp)
 9be:	6a42                	ld	s4,16(sp)
 9c0:	6aa2                	ld	s5,8(sp)
 9c2:	6b02                	ld	s6,0(sp)
 9c4:	a03d                	j	9f2 <malloc+0xe2>
 9c6:	7902                	ld	s2,32(sp)
 9c8:	6a42                	ld	s4,16(sp)
 9ca:	6aa2                	ld	s5,8(sp)
 9cc:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 9ce:	fae48de3          	beq	s1,a4,988 <malloc+0x78>
        p->s.size -= nunits;
 9d2:	4137073b          	subw	a4,a4,s3
 9d6:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9d8:	02071693          	slli	a3,a4,0x20
 9dc:	01c6d713          	srli	a4,a3,0x1c
 9e0:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9e2:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9e6:	00000717          	auipc	a4,0x0
 9ea:	60a73d23          	sd	a0,1562(a4) # 1000 <freep>
      return (void*)(p + 1);
 9ee:	01078513          	addi	a0,a5,16
  }
}
 9f2:	70e2                	ld	ra,56(sp)
 9f4:	7442                	ld	s0,48(sp)
 9f6:	74a2                	ld	s1,40(sp)
 9f8:	69e2                	ld	s3,24(sp)
 9fa:	6121                	addi	sp,sp,64
 9fc:	8082                	ret
 9fe:	7902                	ld	s2,32(sp)
 a00:	6a42                	ld	s4,16(sp)
 a02:	6aa2                	ld	s5,8(sp)
 a04:	6b02                	ld	s6,0(sp)
 a06:	b7f5                	j	9f2 <malloc+0xe2>
