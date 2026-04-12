
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
  1a:	a2a78793          	addi	a5,a5,-1494 # a40 <malloc+0x128>
  1e:	6398                	ld	a4,0(a5)
  20:	fce43823          	sd	a4,-48(s0)
  24:	0087d783          	lhu	a5,8(a5)
  28:	fcf41c23          	sh	a5,-40(s0)
  char data[512];

  printf("stressfs starting\n");
  2c:	00001517          	auipc	a0,0x1
  30:	9e450513          	addi	a0,a0,-1564 # a10 <malloc+0xf8>
  34:	031000ef          	jal	864 <printf>
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
  60:	9cc50513          	addi	a0,a0,-1588 # a28 <malloc+0x110>
  64:	001000ef          	jal	864 <printf>

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
  9e:	99e50513          	addi	a0,a0,-1634 # a38 <malloc+0x120>
  a2:	7c2000ef          	jal	864 <printf>

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
 37a:	59e000ef          	jal	918 <malloc>
  if(s == 0)
 37e:	cd0d                	beqz	a0,3b8 <thread_create+0x54>
 380:	ec26                	sd	s1,24(sp)
 382:	84aa                	mv	s1,a0
    return -1;
  *stack = s;
 384:	00a93023          	sd	a0,0(s2)
  // Stack grows downward- pass the top of the allocated region.
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
 3aa:	4ec000ef          	jal	896 <free>
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
// Returns the joined thread's pid, or -1 Son error.
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
 3da:	4bc000ef          	jal	896 <free>
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

00000000000004d4 <getprocessinfo>:
.global getprocessinfo
getprocessinfo:
 li a7, SYS_getprocessinfo
 4d4:	48f5                	li	a7,29
 ecall
 4d6:	00000073          	ecall
 ret
 4da:	8082                	ret

00000000000004dc <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4dc:	1101                	addi	sp,sp,-32
 4de:	ec06                	sd	ra,24(sp)
 4e0:	e822                	sd	s0,16(sp)
 4e2:	1000                	addi	s0,sp,32
 4e4:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4e8:	4605                	li	a2,1
 4ea:	fef40593          	addi	a1,s0,-17
 4ee:	f2fff0ef          	jal	41c <write>
}
 4f2:	60e2                	ld	ra,24(sp)
 4f4:	6442                	ld	s0,16(sp)
 4f6:	6105                	addi	sp,sp,32
 4f8:	8082                	ret

00000000000004fa <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 4fa:	715d                	addi	sp,sp,-80
 4fc:	e486                	sd	ra,72(sp)
 4fe:	e0a2                	sd	s0,64(sp)
 500:	f84a                	sd	s2,48(sp)
 502:	0880                	addi	s0,sp,80
 504:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 506:	c299                	beqz	a3,50c <printint+0x12>
 508:	0805c363          	bltz	a1,58e <printint+0x94>
  neg = 0;
 50c:	4881                	li	a7,0
 50e:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 512:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 514:	00000517          	auipc	a0,0x0
 518:	54450513          	addi	a0,a0,1348 # a58 <digits>
 51c:	883e                	mv	a6,a5
 51e:	2785                	addiw	a5,a5,1
 520:	02c5f733          	remu	a4,a1,a2
 524:	972a                	add	a4,a4,a0
 526:	00074703          	lbu	a4,0(a4)
 52a:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 52e:	872e                	mv	a4,a1
 530:	02c5d5b3          	divu	a1,a1,a2
 534:	0685                	addi	a3,a3,1
 536:	fec773e3          	bgeu	a4,a2,51c <printint+0x22>
  if(neg)
 53a:	00088b63          	beqz	a7,550 <printint+0x56>
    buf[i++] = '-';
 53e:	fd078793          	addi	a5,a5,-48
 542:	97a2                	add	a5,a5,s0
 544:	02d00713          	li	a4,45
 548:	fee78423          	sb	a4,-24(a5)
 54c:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 550:	02f05a63          	blez	a5,584 <printint+0x8a>
 554:	fc26                	sd	s1,56(sp)
 556:	f44e                	sd	s3,40(sp)
 558:	fb840713          	addi	a4,s0,-72
 55c:	00f704b3          	add	s1,a4,a5
 560:	fff70993          	addi	s3,a4,-1
 564:	99be                	add	s3,s3,a5
 566:	37fd                	addiw	a5,a5,-1
 568:	1782                	slli	a5,a5,0x20
 56a:	9381                	srli	a5,a5,0x20
 56c:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 570:	fff4c583          	lbu	a1,-1(s1)
 574:	854a                	mv	a0,s2
 576:	f67ff0ef          	jal	4dc <putc>
  while(--i >= 0)
 57a:	14fd                	addi	s1,s1,-1
 57c:	ff349ae3          	bne	s1,s3,570 <printint+0x76>
 580:	74e2                	ld	s1,56(sp)
 582:	79a2                	ld	s3,40(sp)
}
 584:	60a6                	ld	ra,72(sp)
 586:	6406                	ld	s0,64(sp)
 588:	7942                	ld	s2,48(sp)
 58a:	6161                	addi	sp,sp,80
 58c:	8082                	ret
    x = -xx;
 58e:	40b005b3          	neg	a1,a1
    neg = 1;
 592:	4885                	li	a7,1
    x = -xx;
 594:	bfad                	j	50e <printint+0x14>

0000000000000596 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 596:	711d                	addi	sp,sp,-96
 598:	ec86                	sd	ra,88(sp)
 59a:	e8a2                	sd	s0,80(sp)
 59c:	e0ca                	sd	s2,64(sp)
 59e:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5a0:	0005c903          	lbu	s2,0(a1)
 5a4:	28090663          	beqz	s2,830 <vprintf+0x29a>
 5a8:	e4a6                	sd	s1,72(sp)
 5aa:	fc4e                	sd	s3,56(sp)
 5ac:	f852                	sd	s4,48(sp)
 5ae:	f456                	sd	s5,40(sp)
 5b0:	f05a                	sd	s6,32(sp)
 5b2:	ec5e                	sd	s7,24(sp)
 5b4:	e862                	sd	s8,16(sp)
 5b6:	e466                	sd	s9,8(sp)
 5b8:	8b2a                	mv	s6,a0
 5ba:	8a2e                	mv	s4,a1
 5bc:	8bb2                	mv	s7,a2
  state = 0;
 5be:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 5c0:	4481                	li	s1,0
 5c2:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 5c4:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 5c8:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 5cc:	06c00c93          	li	s9,108
 5d0:	a005                	j	5f0 <vprintf+0x5a>
        putc(fd, c0);
 5d2:	85ca                	mv	a1,s2
 5d4:	855a                	mv	a0,s6
 5d6:	f07ff0ef          	jal	4dc <putc>
 5da:	a019                	j	5e0 <vprintf+0x4a>
    } else if(state == '%'){
 5dc:	03598263          	beq	s3,s5,600 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 5e0:	2485                	addiw	s1,s1,1
 5e2:	8726                	mv	a4,s1
 5e4:	009a07b3          	add	a5,s4,s1
 5e8:	0007c903          	lbu	s2,0(a5)
 5ec:	22090a63          	beqz	s2,820 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 5f0:	0009079b          	sext.w	a5,s2
    if(state == 0){
 5f4:	fe0994e3          	bnez	s3,5dc <vprintf+0x46>
      if(c0 == '%'){
 5f8:	fd579de3          	bne	a5,s5,5d2 <vprintf+0x3c>
        state = '%';
 5fc:	89be                	mv	s3,a5
 5fe:	b7cd                	j	5e0 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 600:	00ea06b3          	add	a3,s4,a4
 604:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 608:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 60a:	c681                	beqz	a3,612 <vprintf+0x7c>
 60c:	9752                	add	a4,a4,s4
 60e:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 612:	05878363          	beq	a5,s8,658 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 616:	05978d63          	beq	a5,s9,670 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 61a:	07500713          	li	a4,117
 61e:	0ee78763          	beq	a5,a4,70c <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 622:	07800713          	li	a4,120
 626:	12e78963          	beq	a5,a4,758 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 62a:	07000713          	li	a4,112
 62e:	14e78e63          	beq	a5,a4,78a <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 632:	06300713          	li	a4,99
 636:	18e78e63          	beq	a5,a4,7d2 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 63a:	07300713          	li	a4,115
 63e:	1ae78463          	beq	a5,a4,7e6 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 642:	02500713          	li	a4,37
 646:	04e79563          	bne	a5,a4,690 <vprintf+0xfa>
        putc(fd, '%');
 64a:	02500593          	li	a1,37
 64e:	855a                	mv	a0,s6
 650:	e8dff0ef          	jal	4dc <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 654:	4981                	li	s3,0
 656:	b769                	j	5e0 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 658:	008b8913          	addi	s2,s7,8
 65c:	4685                	li	a3,1
 65e:	4629                	li	a2,10
 660:	000ba583          	lw	a1,0(s7)
 664:	855a                	mv	a0,s6
 666:	e95ff0ef          	jal	4fa <printint>
 66a:	8bca                	mv	s7,s2
      state = 0;
 66c:	4981                	li	s3,0
 66e:	bf8d                	j	5e0 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 670:	06400793          	li	a5,100
 674:	02f68963          	beq	a3,a5,6a6 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 678:	06c00793          	li	a5,108
 67c:	04f68263          	beq	a3,a5,6c0 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 680:	07500793          	li	a5,117
 684:	0af68063          	beq	a3,a5,724 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 688:	07800793          	li	a5,120
 68c:	0ef68263          	beq	a3,a5,770 <vprintf+0x1da>
        putc(fd, '%');
 690:	02500593          	li	a1,37
 694:	855a                	mv	a0,s6
 696:	e47ff0ef          	jal	4dc <putc>
        putc(fd, c0);
 69a:	85ca                	mv	a1,s2
 69c:	855a                	mv	a0,s6
 69e:	e3fff0ef          	jal	4dc <putc>
      state = 0;
 6a2:	4981                	li	s3,0
 6a4:	bf35                	j	5e0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6a6:	008b8913          	addi	s2,s7,8
 6aa:	4685                	li	a3,1
 6ac:	4629                	li	a2,10
 6ae:	000bb583          	ld	a1,0(s7)
 6b2:	855a                	mv	a0,s6
 6b4:	e47ff0ef          	jal	4fa <printint>
        i += 1;
 6b8:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 6ba:	8bca                	mv	s7,s2
      state = 0;
 6bc:	4981                	li	s3,0
        i += 1;
 6be:	b70d                	j	5e0 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6c0:	06400793          	li	a5,100
 6c4:	02f60763          	beq	a2,a5,6f2 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 6c8:	07500793          	li	a5,117
 6cc:	06f60963          	beq	a2,a5,73e <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 6d0:	07800793          	li	a5,120
 6d4:	faf61ee3          	bne	a2,a5,690 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6d8:	008b8913          	addi	s2,s7,8
 6dc:	4681                	li	a3,0
 6de:	4641                	li	a2,16
 6e0:	000bb583          	ld	a1,0(s7)
 6e4:	855a                	mv	a0,s6
 6e6:	e15ff0ef          	jal	4fa <printint>
        i += 2;
 6ea:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 6ec:	8bca                	mv	s7,s2
      state = 0;
 6ee:	4981                	li	s3,0
        i += 2;
 6f0:	bdc5                	j	5e0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6f2:	008b8913          	addi	s2,s7,8
 6f6:	4685                	li	a3,1
 6f8:	4629                	li	a2,10
 6fa:	000bb583          	ld	a1,0(s7)
 6fe:	855a                	mv	a0,s6
 700:	dfbff0ef          	jal	4fa <printint>
        i += 2;
 704:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 706:	8bca                	mv	s7,s2
      state = 0;
 708:	4981                	li	s3,0
        i += 2;
 70a:	bdd9                	j	5e0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 70c:	008b8913          	addi	s2,s7,8
 710:	4681                	li	a3,0
 712:	4629                	li	a2,10
 714:	000be583          	lwu	a1,0(s7)
 718:	855a                	mv	a0,s6
 71a:	de1ff0ef          	jal	4fa <printint>
 71e:	8bca                	mv	s7,s2
      state = 0;
 720:	4981                	li	s3,0
 722:	bd7d                	j	5e0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 724:	008b8913          	addi	s2,s7,8
 728:	4681                	li	a3,0
 72a:	4629                	li	a2,10
 72c:	000bb583          	ld	a1,0(s7)
 730:	855a                	mv	a0,s6
 732:	dc9ff0ef          	jal	4fa <printint>
        i += 1;
 736:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 738:	8bca                	mv	s7,s2
      state = 0;
 73a:	4981                	li	s3,0
        i += 1;
 73c:	b555                	j	5e0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 73e:	008b8913          	addi	s2,s7,8
 742:	4681                	li	a3,0
 744:	4629                	li	a2,10
 746:	000bb583          	ld	a1,0(s7)
 74a:	855a                	mv	a0,s6
 74c:	dafff0ef          	jal	4fa <printint>
        i += 2;
 750:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 752:	8bca                	mv	s7,s2
      state = 0;
 754:	4981                	li	s3,0
        i += 2;
 756:	b569                	j	5e0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 758:	008b8913          	addi	s2,s7,8
 75c:	4681                	li	a3,0
 75e:	4641                	li	a2,16
 760:	000be583          	lwu	a1,0(s7)
 764:	855a                	mv	a0,s6
 766:	d95ff0ef          	jal	4fa <printint>
 76a:	8bca                	mv	s7,s2
      state = 0;
 76c:	4981                	li	s3,0
 76e:	bd8d                	j	5e0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 770:	008b8913          	addi	s2,s7,8
 774:	4681                	li	a3,0
 776:	4641                	li	a2,16
 778:	000bb583          	ld	a1,0(s7)
 77c:	855a                	mv	a0,s6
 77e:	d7dff0ef          	jal	4fa <printint>
        i += 1;
 782:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 784:	8bca                	mv	s7,s2
      state = 0;
 786:	4981                	li	s3,0
        i += 1;
 788:	bda1                	j	5e0 <vprintf+0x4a>
 78a:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 78c:	008b8d13          	addi	s10,s7,8
 790:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 794:	03000593          	li	a1,48
 798:	855a                	mv	a0,s6
 79a:	d43ff0ef          	jal	4dc <putc>
  putc(fd, 'x');
 79e:	07800593          	li	a1,120
 7a2:	855a                	mv	a0,s6
 7a4:	d39ff0ef          	jal	4dc <putc>
 7a8:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7aa:	00000b97          	auipc	s7,0x0
 7ae:	2aeb8b93          	addi	s7,s7,686 # a58 <digits>
 7b2:	03c9d793          	srli	a5,s3,0x3c
 7b6:	97de                	add	a5,a5,s7
 7b8:	0007c583          	lbu	a1,0(a5)
 7bc:	855a                	mv	a0,s6
 7be:	d1fff0ef          	jal	4dc <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7c2:	0992                	slli	s3,s3,0x4
 7c4:	397d                	addiw	s2,s2,-1
 7c6:	fe0916e3          	bnez	s2,7b2 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 7ca:	8bea                	mv	s7,s10
      state = 0;
 7cc:	4981                	li	s3,0
 7ce:	6d02                	ld	s10,0(sp)
 7d0:	bd01                	j	5e0 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 7d2:	008b8913          	addi	s2,s7,8
 7d6:	000bc583          	lbu	a1,0(s7)
 7da:	855a                	mv	a0,s6
 7dc:	d01ff0ef          	jal	4dc <putc>
 7e0:	8bca                	mv	s7,s2
      state = 0;
 7e2:	4981                	li	s3,0
 7e4:	bbf5                	j	5e0 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 7e6:	008b8993          	addi	s3,s7,8
 7ea:	000bb903          	ld	s2,0(s7)
 7ee:	00090f63          	beqz	s2,80c <vprintf+0x276>
        for(; *s; s++)
 7f2:	00094583          	lbu	a1,0(s2)
 7f6:	c195                	beqz	a1,81a <vprintf+0x284>
          putc(fd, *s);
 7f8:	855a                	mv	a0,s6
 7fa:	ce3ff0ef          	jal	4dc <putc>
        for(; *s; s++)
 7fe:	0905                	addi	s2,s2,1
 800:	00094583          	lbu	a1,0(s2)
 804:	f9f5                	bnez	a1,7f8 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 806:	8bce                	mv	s7,s3
      state = 0;
 808:	4981                	li	s3,0
 80a:	bbd9                	j	5e0 <vprintf+0x4a>
          s = "(null)";
 80c:	00000917          	auipc	s2,0x0
 810:	24490913          	addi	s2,s2,580 # a50 <malloc+0x138>
        for(; *s; s++)
 814:	02800593          	li	a1,40
 818:	b7c5                	j	7f8 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 81a:	8bce                	mv	s7,s3
      state = 0;
 81c:	4981                	li	s3,0
 81e:	b3c9                	j	5e0 <vprintf+0x4a>
 820:	64a6                	ld	s1,72(sp)
 822:	79e2                	ld	s3,56(sp)
 824:	7a42                	ld	s4,48(sp)
 826:	7aa2                	ld	s5,40(sp)
 828:	7b02                	ld	s6,32(sp)
 82a:	6be2                	ld	s7,24(sp)
 82c:	6c42                	ld	s8,16(sp)
 82e:	6ca2                	ld	s9,8(sp)
    }
  }
}
 830:	60e6                	ld	ra,88(sp)
 832:	6446                	ld	s0,80(sp)
 834:	6906                	ld	s2,64(sp)
 836:	6125                	addi	sp,sp,96
 838:	8082                	ret

000000000000083a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 83a:	715d                	addi	sp,sp,-80
 83c:	ec06                	sd	ra,24(sp)
 83e:	e822                	sd	s0,16(sp)
 840:	1000                	addi	s0,sp,32
 842:	e010                	sd	a2,0(s0)
 844:	e414                	sd	a3,8(s0)
 846:	e818                	sd	a4,16(s0)
 848:	ec1c                	sd	a5,24(s0)
 84a:	03043023          	sd	a6,32(s0)
 84e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 852:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 856:	8622                	mv	a2,s0
 858:	d3fff0ef          	jal	596 <vprintf>
}
 85c:	60e2                	ld	ra,24(sp)
 85e:	6442                	ld	s0,16(sp)
 860:	6161                	addi	sp,sp,80
 862:	8082                	ret

0000000000000864 <printf>:

void
printf(const char *fmt, ...)
{
 864:	711d                	addi	sp,sp,-96
 866:	ec06                	sd	ra,24(sp)
 868:	e822                	sd	s0,16(sp)
 86a:	1000                	addi	s0,sp,32
 86c:	e40c                	sd	a1,8(s0)
 86e:	e810                	sd	a2,16(s0)
 870:	ec14                	sd	a3,24(s0)
 872:	f018                	sd	a4,32(s0)
 874:	f41c                	sd	a5,40(s0)
 876:	03043823          	sd	a6,48(s0)
 87a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 87e:	00840613          	addi	a2,s0,8
 882:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 886:	85aa                	mv	a1,a0
 888:	4505                	li	a0,1
 88a:	d0dff0ef          	jal	596 <vprintf>
}
 88e:	60e2                	ld	ra,24(sp)
 890:	6442                	ld	s0,16(sp)
 892:	6125                	addi	sp,sp,96
 894:	8082                	ret

0000000000000896 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 896:	1141                	addi	sp,sp,-16
 898:	e422                	sd	s0,8(sp)
 89a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 89c:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8a0:	00000797          	auipc	a5,0x0
 8a4:	7607b783          	ld	a5,1888(a5) # 1000 <freep>
 8a8:	a02d                	j	8d2 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8aa:	4618                	lw	a4,8(a2)
 8ac:	9f2d                	addw	a4,a4,a1
 8ae:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8b2:	6398                	ld	a4,0(a5)
 8b4:	6310                	ld	a2,0(a4)
 8b6:	a83d                	j	8f4 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8b8:	ff852703          	lw	a4,-8(a0)
 8bc:	9f31                	addw	a4,a4,a2
 8be:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8c0:	ff053683          	ld	a3,-16(a0)
 8c4:	a091                	j	908 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8c6:	6398                	ld	a4,0(a5)
 8c8:	00e7e463          	bltu	a5,a4,8d0 <free+0x3a>
 8cc:	00e6ea63          	bltu	a3,a4,8e0 <free+0x4a>
{
 8d0:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8d2:	fed7fae3          	bgeu	a5,a3,8c6 <free+0x30>
 8d6:	6398                	ld	a4,0(a5)
 8d8:	00e6e463          	bltu	a3,a4,8e0 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8dc:	fee7eae3          	bltu	a5,a4,8d0 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 8e0:	ff852583          	lw	a1,-8(a0)
 8e4:	6390                	ld	a2,0(a5)
 8e6:	02059813          	slli	a6,a1,0x20
 8ea:	01c85713          	srli	a4,a6,0x1c
 8ee:	9736                	add	a4,a4,a3
 8f0:	fae60de3          	beq	a2,a4,8aa <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 8f4:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8f8:	4790                	lw	a2,8(a5)
 8fa:	02061593          	slli	a1,a2,0x20
 8fe:	01c5d713          	srli	a4,a1,0x1c
 902:	973e                	add	a4,a4,a5
 904:	fae68ae3          	beq	a3,a4,8b8 <free+0x22>
    p->s.ptr = bp->s.ptr;
 908:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 90a:	00000717          	auipc	a4,0x0
 90e:	6ef73b23          	sd	a5,1782(a4) # 1000 <freep>
}
 912:	6422                	ld	s0,8(sp)
 914:	0141                	addi	sp,sp,16
 916:	8082                	ret

0000000000000918 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 918:	7139                	addi	sp,sp,-64
 91a:	fc06                	sd	ra,56(sp)
 91c:	f822                	sd	s0,48(sp)
 91e:	f426                	sd	s1,40(sp)
 920:	ec4e                	sd	s3,24(sp)
 922:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 924:	02051493          	slli	s1,a0,0x20
 928:	9081                	srli	s1,s1,0x20
 92a:	04bd                	addi	s1,s1,15
 92c:	8091                	srli	s1,s1,0x4
 92e:	0014899b          	addiw	s3,s1,1
 932:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 934:	00000517          	auipc	a0,0x0
 938:	6cc53503          	ld	a0,1740(a0) # 1000 <freep>
 93c:	c915                	beqz	a0,970 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 93e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 940:	4798                	lw	a4,8(a5)
 942:	08977a63          	bgeu	a4,s1,9d6 <malloc+0xbe>
 946:	f04a                	sd	s2,32(sp)
 948:	e852                	sd	s4,16(sp)
 94a:	e456                	sd	s5,8(sp)
 94c:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 94e:	8a4e                	mv	s4,s3
 950:	0009871b          	sext.w	a4,s3
 954:	6685                	lui	a3,0x1
 956:	00d77363          	bgeu	a4,a3,95c <malloc+0x44>
 95a:	6a05                	lui	s4,0x1
 95c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 960:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 964:	00000917          	auipc	s2,0x0
 968:	69c90913          	addi	s2,s2,1692 # 1000 <freep>
  if(p == SBRK_ERROR)
 96c:	5afd                	li	s5,-1
 96e:	a081                	j	9ae <malloc+0x96>
 970:	f04a                	sd	s2,32(sp)
 972:	e852                	sd	s4,16(sp)
 974:	e456                	sd	s5,8(sp)
 976:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 978:	00000797          	auipc	a5,0x0
 97c:	69878793          	addi	a5,a5,1688 # 1010 <base>
 980:	00000717          	auipc	a4,0x0
 984:	68f73023          	sd	a5,1664(a4) # 1000 <freep>
 988:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 98a:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 98e:	b7c1                	j	94e <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 990:	6398                	ld	a4,0(a5)
 992:	e118                	sd	a4,0(a0)
 994:	a8a9                	j	9ee <malloc+0xd6>
  hp->s.size = nu;
 996:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 99a:	0541                	addi	a0,a0,16
 99c:	efbff0ef          	jal	896 <free>
  return freep;
 9a0:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9a4:	c12d                	beqz	a0,a06 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9a6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9a8:	4798                	lw	a4,8(a5)
 9aa:	02977263          	bgeu	a4,s1,9ce <malloc+0xb6>
    if(p == freep)
 9ae:	00093703          	ld	a4,0(s2)
 9b2:	853e                	mv	a0,a5
 9b4:	fef719e3          	bne	a4,a5,9a6 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 9b8:	8552                	mv	a0,s4
 9ba:	97fff0ef          	jal	338 <sbrk>
  if(p == SBRK_ERROR)
 9be:	fd551ce3          	bne	a0,s5,996 <malloc+0x7e>
        return 0;
 9c2:	4501                	li	a0,0
 9c4:	7902                	ld	s2,32(sp)
 9c6:	6a42                	ld	s4,16(sp)
 9c8:	6aa2                	ld	s5,8(sp)
 9ca:	6b02                	ld	s6,0(sp)
 9cc:	a03d                	j	9fa <malloc+0xe2>
 9ce:	7902                	ld	s2,32(sp)
 9d0:	6a42                	ld	s4,16(sp)
 9d2:	6aa2                	ld	s5,8(sp)
 9d4:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 9d6:	fae48de3          	beq	s1,a4,990 <malloc+0x78>
        p->s.size -= nunits;
 9da:	4137073b          	subw	a4,a4,s3
 9de:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9e0:	02071693          	slli	a3,a4,0x20
 9e4:	01c6d713          	srli	a4,a3,0x1c
 9e8:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9ea:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9ee:	00000717          	auipc	a4,0x0
 9f2:	60a73923          	sd	a0,1554(a4) # 1000 <freep>
      return (void*)(p + 1);
 9f6:	01078513          	addi	a0,a5,16
  }
}
 9fa:	70e2                	ld	ra,56(sp)
 9fc:	7442                	ld	s0,48(sp)
 9fe:	74a2                	ld	s1,40(sp)
 a00:	69e2                	ld	s3,24(sp)
 a02:	6121                	addi	sp,sp,64
 a04:	8082                	ret
 a06:	7902                	ld	s2,32(sp)
 a08:	6a42                	ld	s4,16(sp)
 a0a:	6aa2                	ld	s5,8(sp)
 a0c:	6b02                	ld	s6,0(sp)
 a0e:	b7f5                	j	9fa <malloc+0xe2>
