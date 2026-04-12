
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
  1a:	a4a78793          	addi	a5,a5,-1462 # a60 <malloc+0x12e>
  1e:	6398                	ld	a4,0(a5)
  20:	fce43823          	sd	a4,-48(s0)
  24:	0087d783          	lhu	a5,8(a5)
  28:	fcf41c23          	sh	a5,-40(s0)
  char data[512];

  printf("stressfs starting\n");
  2c:	00001517          	auipc	a0,0x1
  30:	a0450513          	addi	a0,a0,-1532 # a30 <malloc+0xfe>
  34:	04b000ef          	jal	87e <printf>
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
  60:	9ec50513          	addi	a0,a0,-1556 # a48 <malloc+0x116>
  64:	01b000ef          	jal	87e <printf>

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
  9e:	9be50513          	addi	a0,a0,-1602 # a58 <malloc+0x126>
  a2:	7dc000ef          	jal	87e <printf>

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
 37a:	5b8000ef          	jal	932 <malloc>
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
 3aa:	506000ef          	jal	8b0 <free>
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
 3da:	4d6000ef          	jal	8b0 <free>
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

00000000000004dc <shmget>:
.global shmget
shmget:
 li a7, SYS_shmget
 4dc:	48f9                	li	a7,30
 ecall
 4de:	00000073          	ecall
 ret
 4e2:	8082                	ret

00000000000004e4 <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 4e4:	48fd                	li	a7,31
 ecall
 4e6:	00000073          	ecall
 ret
 4ea:	8082                	ret

00000000000004ec <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 4ec:	02000893          	li	a7,32
 ecall
 4f0:	00000073          	ecall
 ret
 4f4:	8082                	ret

00000000000004f6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4f6:	1101                	addi	sp,sp,-32
 4f8:	ec06                	sd	ra,24(sp)
 4fa:	e822                	sd	s0,16(sp)
 4fc:	1000                	addi	s0,sp,32
 4fe:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 502:	4605                	li	a2,1
 504:	fef40593          	addi	a1,s0,-17
 508:	f15ff0ef          	jal	41c <write>
}
 50c:	60e2                	ld	ra,24(sp)
 50e:	6442                	ld	s0,16(sp)
 510:	6105                	addi	sp,sp,32
 512:	8082                	ret

0000000000000514 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 514:	715d                	addi	sp,sp,-80
 516:	e486                	sd	ra,72(sp)
 518:	e0a2                	sd	s0,64(sp)
 51a:	f84a                	sd	s2,48(sp)
 51c:	0880                	addi	s0,sp,80
 51e:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 520:	c299                	beqz	a3,526 <printint+0x12>
 522:	0805c363          	bltz	a1,5a8 <printint+0x94>
  neg = 0;
 526:	4881                	li	a7,0
 528:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 52c:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 52e:	00000517          	auipc	a0,0x0
 532:	54a50513          	addi	a0,a0,1354 # a78 <digits>
 536:	883e                	mv	a6,a5
 538:	2785                	addiw	a5,a5,1
 53a:	02c5f733          	remu	a4,a1,a2
 53e:	972a                	add	a4,a4,a0
 540:	00074703          	lbu	a4,0(a4)
 544:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 548:	872e                	mv	a4,a1
 54a:	02c5d5b3          	divu	a1,a1,a2
 54e:	0685                	addi	a3,a3,1
 550:	fec773e3          	bgeu	a4,a2,536 <printint+0x22>
  if(neg)
 554:	00088b63          	beqz	a7,56a <printint+0x56>
    buf[i++] = '-';
 558:	fd078793          	addi	a5,a5,-48
 55c:	97a2                	add	a5,a5,s0
 55e:	02d00713          	li	a4,45
 562:	fee78423          	sb	a4,-24(a5)
 566:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 56a:	02f05a63          	blez	a5,59e <printint+0x8a>
 56e:	fc26                	sd	s1,56(sp)
 570:	f44e                	sd	s3,40(sp)
 572:	fb840713          	addi	a4,s0,-72
 576:	00f704b3          	add	s1,a4,a5
 57a:	fff70993          	addi	s3,a4,-1
 57e:	99be                	add	s3,s3,a5
 580:	37fd                	addiw	a5,a5,-1
 582:	1782                	slli	a5,a5,0x20
 584:	9381                	srli	a5,a5,0x20
 586:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 58a:	fff4c583          	lbu	a1,-1(s1)
 58e:	854a                	mv	a0,s2
 590:	f67ff0ef          	jal	4f6 <putc>
  while(--i >= 0)
 594:	14fd                	addi	s1,s1,-1
 596:	ff349ae3          	bne	s1,s3,58a <printint+0x76>
 59a:	74e2                	ld	s1,56(sp)
 59c:	79a2                	ld	s3,40(sp)
}
 59e:	60a6                	ld	ra,72(sp)
 5a0:	6406                	ld	s0,64(sp)
 5a2:	7942                	ld	s2,48(sp)
 5a4:	6161                	addi	sp,sp,80
 5a6:	8082                	ret
    x = -xx;
 5a8:	40b005b3          	neg	a1,a1
    neg = 1;
 5ac:	4885                	li	a7,1
    x = -xx;
 5ae:	bfad                	j	528 <printint+0x14>

00000000000005b0 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5b0:	711d                	addi	sp,sp,-96
 5b2:	ec86                	sd	ra,88(sp)
 5b4:	e8a2                	sd	s0,80(sp)
 5b6:	e0ca                	sd	s2,64(sp)
 5b8:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5ba:	0005c903          	lbu	s2,0(a1)
 5be:	28090663          	beqz	s2,84a <vprintf+0x29a>
 5c2:	e4a6                	sd	s1,72(sp)
 5c4:	fc4e                	sd	s3,56(sp)
 5c6:	f852                	sd	s4,48(sp)
 5c8:	f456                	sd	s5,40(sp)
 5ca:	f05a                	sd	s6,32(sp)
 5cc:	ec5e                	sd	s7,24(sp)
 5ce:	e862                	sd	s8,16(sp)
 5d0:	e466                	sd	s9,8(sp)
 5d2:	8b2a                	mv	s6,a0
 5d4:	8a2e                	mv	s4,a1
 5d6:	8bb2                	mv	s7,a2
  state = 0;
 5d8:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 5da:	4481                	li	s1,0
 5dc:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 5de:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 5e2:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 5e6:	06c00c93          	li	s9,108
 5ea:	a005                	j	60a <vprintf+0x5a>
        putc(fd, c0);
 5ec:	85ca                	mv	a1,s2
 5ee:	855a                	mv	a0,s6
 5f0:	f07ff0ef          	jal	4f6 <putc>
 5f4:	a019                	j	5fa <vprintf+0x4a>
    } else if(state == '%'){
 5f6:	03598263          	beq	s3,s5,61a <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 5fa:	2485                	addiw	s1,s1,1
 5fc:	8726                	mv	a4,s1
 5fe:	009a07b3          	add	a5,s4,s1
 602:	0007c903          	lbu	s2,0(a5)
 606:	22090a63          	beqz	s2,83a <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 60a:	0009079b          	sext.w	a5,s2
    if(state == 0){
 60e:	fe0994e3          	bnez	s3,5f6 <vprintf+0x46>
      if(c0 == '%'){
 612:	fd579de3          	bne	a5,s5,5ec <vprintf+0x3c>
        state = '%';
 616:	89be                	mv	s3,a5
 618:	b7cd                	j	5fa <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 61a:	00ea06b3          	add	a3,s4,a4
 61e:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 622:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 624:	c681                	beqz	a3,62c <vprintf+0x7c>
 626:	9752                	add	a4,a4,s4
 628:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 62c:	05878363          	beq	a5,s8,672 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 630:	05978d63          	beq	a5,s9,68a <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 634:	07500713          	li	a4,117
 638:	0ee78763          	beq	a5,a4,726 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 63c:	07800713          	li	a4,120
 640:	12e78963          	beq	a5,a4,772 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 644:	07000713          	li	a4,112
 648:	14e78e63          	beq	a5,a4,7a4 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 64c:	06300713          	li	a4,99
 650:	18e78e63          	beq	a5,a4,7ec <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 654:	07300713          	li	a4,115
 658:	1ae78463          	beq	a5,a4,800 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 65c:	02500713          	li	a4,37
 660:	04e79563          	bne	a5,a4,6aa <vprintf+0xfa>
        putc(fd, '%');
 664:	02500593          	li	a1,37
 668:	855a                	mv	a0,s6
 66a:	e8dff0ef          	jal	4f6 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 66e:	4981                	li	s3,0
 670:	b769                	j	5fa <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 672:	008b8913          	addi	s2,s7,8
 676:	4685                	li	a3,1
 678:	4629                	li	a2,10
 67a:	000ba583          	lw	a1,0(s7)
 67e:	855a                	mv	a0,s6
 680:	e95ff0ef          	jal	514 <printint>
 684:	8bca                	mv	s7,s2
      state = 0;
 686:	4981                	li	s3,0
 688:	bf8d                	j	5fa <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 68a:	06400793          	li	a5,100
 68e:	02f68963          	beq	a3,a5,6c0 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 692:	06c00793          	li	a5,108
 696:	04f68263          	beq	a3,a5,6da <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 69a:	07500793          	li	a5,117
 69e:	0af68063          	beq	a3,a5,73e <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 6a2:	07800793          	li	a5,120
 6a6:	0ef68263          	beq	a3,a5,78a <vprintf+0x1da>
        putc(fd, '%');
 6aa:	02500593          	li	a1,37
 6ae:	855a                	mv	a0,s6
 6b0:	e47ff0ef          	jal	4f6 <putc>
        putc(fd, c0);
 6b4:	85ca                	mv	a1,s2
 6b6:	855a                	mv	a0,s6
 6b8:	e3fff0ef          	jal	4f6 <putc>
      state = 0;
 6bc:	4981                	li	s3,0
 6be:	bf35                	j	5fa <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6c0:	008b8913          	addi	s2,s7,8
 6c4:	4685                	li	a3,1
 6c6:	4629                	li	a2,10
 6c8:	000bb583          	ld	a1,0(s7)
 6cc:	855a                	mv	a0,s6
 6ce:	e47ff0ef          	jal	514 <printint>
        i += 1;
 6d2:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 6d4:	8bca                	mv	s7,s2
      state = 0;
 6d6:	4981                	li	s3,0
        i += 1;
 6d8:	b70d                	j	5fa <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6da:	06400793          	li	a5,100
 6de:	02f60763          	beq	a2,a5,70c <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 6e2:	07500793          	li	a5,117
 6e6:	06f60963          	beq	a2,a5,758 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 6ea:	07800793          	li	a5,120
 6ee:	faf61ee3          	bne	a2,a5,6aa <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6f2:	008b8913          	addi	s2,s7,8
 6f6:	4681                	li	a3,0
 6f8:	4641                	li	a2,16
 6fa:	000bb583          	ld	a1,0(s7)
 6fe:	855a                	mv	a0,s6
 700:	e15ff0ef          	jal	514 <printint>
        i += 2;
 704:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 706:	8bca                	mv	s7,s2
      state = 0;
 708:	4981                	li	s3,0
        i += 2;
 70a:	bdc5                	j	5fa <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 70c:	008b8913          	addi	s2,s7,8
 710:	4685                	li	a3,1
 712:	4629                	li	a2,10
 714:	000bb583          	ld	a1,0(s7)
 718:	855a                	mv	a0,s6
 71a:	dfbff0ef          	jal	514 <printint>
        i += 2;
 71e:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 720:	8bca                	mv	s7,s2
      state = 0;
 722:	4981                	li	s3,0
        i += 2;
 724:	bdd9                	j	5fa <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 726:	008b8913          	addi	s2,s7,8
 72a:	4681                	li	a3,0
 72c:	4629                	li	a2,10
 72e:	000be583          	lwu	a1,0(s7)
 732:	855a                	mv	a0,s6
 734:	de1ff0ef          	jal	514 <printint>
 738:	8bca                	mv	s7,s2
      state = 0;
 73a:	4981                	li	s3,0
 73c:	bd7d                	j	5fa <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 73e:	008b8913          	addi	s2,s7,8
 742:	4681                	li	a3,0
 744:	4629                	li	a2,10
 746:	000bb583          	ld	a1,0(s7)
 74a:	855a                	mv	a0,s6
 74c:	dc9ff0ef          	jal	514 <printint>
        i += 1;
 750:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 752:	8bca                	mv	s7,s2
      state = 0;
 754:	4981                	li	s3,0
        i += 1;
 756:	b555                	j	5fa <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 758:	008b8913          	addi	s2,s7,8
 75c:	4681                	li	a3,0
 75e:	4629                	li	a2,10
 760:	000bb583          	ld	a1,0(s7)
 764:	855a                	mv	a0,s6
 766:	dafff0ef          	jal	514 <printint>
        i += 2;
 76a:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 76c:	8bca                	mv	s7,s2
      state = 0;
 76e:	4981                	li	s3,0
        i += 2;
 770:	b569                	j	5fa <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 772:	008b8913          	addi	s2,s7,8
 776:	4681                	li	a3,0
 778:	4641                	li	a2,16
 77a:	000be583          	lwu	a1,0(s7)
 77e:	855a                	mv	a0,s6
 780:	d95ff0ef          	jal	514 <printint>
 784:	8bca                	mv	s7,s2
      state = 0;
 786:	4981                	li	s3,0
 788:	bd8d                	j	5fa <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 78a:	008b8913          	addi	s2,s7,8
 78e:	4681                	li	a3,0
 790:	4641                	li	a2,16
 792:	000bb583          	ld	a1,0(s7)
 796:	855a                	mv	a0,s6
 798:	d7dff0ef          	jal	514 <printint>
        i += 1;
 79c:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 79e:	8bca                	mv	s7,s2
      state = 0;
 7a0:	4981                	li	s3,0
        i += 1;
 7a2:	bda1                	j	5fa <vprintf+0x4a>
 7a4:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 7a6:	008b8d13          	addi	s10,s7,8
 7aa:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 7ae:	03000593          	li	a1,48
 7b2:	855a                	mv	a0,s6
 7b4:	d43ff0ef          	jal	4f6 <putc>
  putc(fd, 'x');
 7b8:	07800593          	li	a1,120
 7bc:	855a                	mv	a0,s6
 7be:	d39ff0ef          	jal	4f6 <putc>
 7c2:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7c4:	00000b97          	auipc	s7,0x0
 7c8:	2b4b8b93          	addi	s7,s7,692 # a78 <digits>
 7cc:	03c9d793          	srli	a5,s3,0x3c
 7d0:	97de                	add	a5,a5,s7
 7d2:	0007c583          	lbu	a1,0(a5)
 7d6:	855a                	mv	a0,s6
 7d8:	d1fff0ef          	jal	4f6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7dc:	0992                	slli	s3,s3,0x4
 7de:	397d                	addiw	s2,s2,-1
 7e0:	fe0916e3          	bnez	s2,7cc <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 7e4:	8bea                	mv	s7,s10
      state = 0;
 7e6:	4981                	li	s3,0
 7e8:	6d02                	ld	s10,0(sp)
 7ea:	bd01                	j	5fa <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 7ec:	008b8913          	addi	s2,s7,8
 7f0:	000bc583          	lbu	a1,0(s7)
 7f4:	855a                	mv	a0,s6
 7f6:	d01ff0ef          	jal	4f6 <putc>
 7fa:	8bca                	mv	s7,s2
      state = 0;
 7fc:	4981                	li	s3,0
 7fe:	bbf5                	j	5fa <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 800:	008b8993          	addi	s3,s7,8
 804:	000bb903          	ld	s2,0(s7)
 808:	00090f63          	beqz	s2,826 <vprintf+0x276>
        for(; *s; s++)
 80c:	00094583          	lbu	a1,0(s2)
 810:	c195                	beqz	a1,834 <vprintf+0x284>
          putc(fd, *s);
 812:	855a                	mv	a0,s6
 814:	ce3ff0ef          	jal	4f6 <putc>
        for(; *s; s++)
 818:	0905                	addi	s2,s2,1
 81a:	00094583          	lbu	a1,0(s2)
 81e:	f9f5                	bnez	a1,812 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 820:	8bce                	mv	s7,s3
      state = 0;
 822:	4981                	li	s3,0
 824:	bbd9                	j	5fa <vprintf+0x4a>
          s = "(null)";
 826:	00000917          	auipc	s2,0x0
 82a:	24a90913          	addi	s2,s2,586 # a70 <malloc+0x13e>
        for(; *s; s++)
 82e:	02800593          	li	a1,40
 832:	b7c5                	j	812 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 834:	8bce                	mv	s7,s3
      state = 0;
 836:	4981                	li	s3,0
 838:	b3c9                	j	5fa <vprintf+0x4a>
 83a:	64a6                	ld	s1,72(sp)
 83c:	79e2                	ld	s3,56(sp)
 83e:	7a42                	ld	s4,48(sp)
 840:	7aa2                	ld	s5,40(sp)
 842:	7b02                	ld	s6,32(sp)
 844:	6be2                	ld	s7,24(sp)
 846:	6c42                	ld	s8,16(sp)
 848:	6ca2                	ld	s9,8(sp)
    }
  }
}
 84a:	60e6                	ld	ra,88(sp)
 84c:	6446                	ld	s0,80(sp)
 84e:	6906                	ld	s2,64(sp)
 850:	6125                	addi	sp,sp,96
 852:	8082                	ret

0000000000000854 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 854:	715d                	addi	sp,sp,-80
 856:	ec06                	sd	ra,24(sp)
 858:	e822                	sd	s0,16(sp)
 85a:	1000                	addi	s0,sp,32
 85c:	e010                	sd	a2,0(s0)
 85e:	e414                	sd	a3,8(s0)
 860:	e818                	sd	a4,16(s0)
 862:	ec1c                	sd	a5,24(s0)
 864:	03043023          	sd	a6,32(s0)
 868:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 86c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 870:	8622                	mv	a2,s0
 872:	d3fff0ef          	jal	5b0 <vprintf>
}
 876:	60e2                	ld	ra,24(sp)
 878:	6442                	ld	s0,16(sp)
 87a:	6161                	addi	sp,sp,80
 87c:	8082                	ret

000000000000087e <printf>:

void
printf(const char *fmt, ...)
{
 87e:	711d                	addi	sp,sp,-96
 880:	ec06                	sd	ra,24(sp)
 882:	e822                	sd	s0,16(sp)
 884:	1000                	addi	s0,sp,32
 886:	e40c                	sd	a1,8(s0)
 888:	e810                	sd	a2,16(s0)
 88a:	ec14                	sd	a3,24(s0)
 88c:	f018                	sd	a4,32(s0)
 88e:	f41c                	sd	a5,40(s0)
 890:	03043823          	sd	a6,48(s0)
 894:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 898:	00840613          	addi	a2,s0,8
 89c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8a0:	85aa                	mv	a1,a0
 8a2:	4505                	li	a0,1
 8a4:	d0dff0ef          	jal	5b0 <vprintf>
}
 8a8:	60e2                	ld	ra,24(sp)
 8aa:	6442                	ld	s0,16(sp)
 8ac:	6125                	addi	sp,sp,96
 8ae:	8082                	ret

00000000000008b0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8b0:	1141                	addi	sp,sp,-16
 8b2:	e422                	sd	s0,8(sp)
 8b4:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8b6:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8ba:	00000797          	auipc	a5,0x0
 8be:	7467b783          	ld	a5,1862(a5) # 1000 <freep>
 8c2:	a02d                	j	8ec <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8c4:	4618                	lw	a4,8(a2)
 8c6:	9f2d                	addw	a4,a4,a1
 8c8:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8cc:	6398                	ld	a4,0(a5)
 8ce:	6310                	ld	a2,0(a4)
 8d0:	a83d                	j	90e <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8d2:	ff852703          	lw	a4,-8(a0)
 8d6:	9f31                	addw	a4,a4,a2
 8d8:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8da:	ff053683          	ld	a3,-16(a0)
 8de:	a091                	j	922 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8e0:	6398                	ld	a4,0(a5)
 8e2:	00e7e463          	bltu	a5,a4,8ea <free+0x3a>
 8e6:	00e6ea63          	bltu	a3,a4,8fa <free+0x4a>
{
 8ea:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8ec:	fed7fae3          	bgeu	a5,a3,8e0 <free+0x30>
 8f0:	6398                	ld	a4,0(a5)
 8f2:	00e6e463          	bltu	a3,a4,8fa <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8f6:	fee7eae3          	bltu	a5,a4,8ea <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 8fa:	ff852583          	lw	a1,-8(a0)
 8fe:	6390                	ld	a2,0(a5)
 900:	02059813          	slli	a6,a1,0x20
 904:	01c85713          	srli	a4,a6,0x1c
 908:	9736                	add	a4,a4,a3
 90a:	fae60de3          	beq	a2,a4,8c4 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 90e:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 912:	4790                	lw	a2,8(a5)
 914:	02061593          	slli	a1,a2,0x20
 918:	01c5d713          	srli	a4,a1,0x1c
 91c:	973e                	add	a4,a4,a5
 91e:	fae68ae3          	beq	a3,a4,8d2 <free+0x22>
    p->s.ptr = bp->s.ptr;
 922:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 924:	00000717          	auipc	a4,0x0
 928:	6cf73e23          	sd	a5,1756(a4) # 1000 <freep>
}
 92c:	6422                	ld	s0,8(sp)
 92e:	0141                	addi	sp,sp,16
 930:	8082                	ret

0000000000000932 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 932:	7139                	addi	sp,sp,-64
 934:	fc06                	sd	ra,56(sp)
 936:	f822                	sd	s0,48(sp)
 938:	f426                	sd	s1,40(sp)
 93a:	ec4e                	sd	s3,24(sp)
 93c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 93e:	02051493          	slli	s1,a0,0x20
 942:	9081                	srli	s1,s1,0x20
 944:	04bd                	addi	s1,s1,15
 946:	8091                	srli	s1,s1,0x4
 948:	0014899b          	addiw	s3,s1,1
 94c:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 94e:	00000517          	auipc	a0,0x0
 952:	6b253503          	ld	a0,1714(a0) # 1000 <freep>
 956:	c915                	beqz	a0,98a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 958:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 95a:	4798                	lw	a4,8(a5)
 95c:	08977a63          	bgeu	a4,s1,9f0 <malloc+0xbe>
 960:	f04a                	sd	s2,32(sp)
 962:	e852                	sd	s4,16(sp)
 964:	e456                	sd	s5,8(sp)
 966:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 968:	8a4e                	mv	s4,s3
 96a:	0009871b          	sext.w	a4,s3
 96e:	6685                	lui	a3,0x1
 970:	00d77363          	bgeu	a4,a3,976 <malloc+0x44>
 974:	6a05                	lui	s4,0x1
 976:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 97a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 97e:	00000917          	auipc	s2,0x0
 982:	68290913          	addi	s2,s2,1666 # 1000 <freep>
  if(p == SBRK_ERROR)
 986:	5afd                	li	s5,-1
 988:	a081                	j	9c8 <malloc+0x96>
 98a:	f04a                	sd	s2,32(sp)
 98c:	e852                	sd	s4,16(sp)
 98e:	e456                	sd	s5,8(sp)
 990:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 992:	00000797          	auipc	a5,0x0
 996:	67e78793          	addi	a5,a5,1662 # 1010 <base>
 99a:	00000717          	auipc	a4,0x0
 99e:	66f73323          	sd	a5,1638(a4) # 1000 <freep>
 9a2:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9a4:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 9a8:	b7c1                	j	968 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 9aa:	6398                	ld	a4,0(a5)
 9ac:	e118                	sd	a4,0(a0)
 9ae:	a8a9                	j	a08 <malloc+0xd6>
  hp->s.size = nu;
 9b0:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 9b4:	0541                	addi	a0,a0,16
 9b6:	efbff0ef          	jal	8b0 <free>
  return freep;
 9ba:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9be:	c12d                	beqz	a0,a20 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9c0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9c2:	4798                	lw	a4,8(a5)
 9c4:	02977263          	bgeu	a4,s1,9e8 <malloc+0xb6>
    if(p == freep)
 9c8:	00093703          	ld	a4,0(s2)
 9cc:	853e                	mv	a0,a5
 9ce:	fef719e3          	bne	a4,a5,9c0 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 9d2:	8552                	mv	a0,s4
 9d4:	965ff0ef          	jal	338 <sbrk>
  if(p == SBRK_ERROR)
 9d8:	fd551ce3          	bne	a0,s5,9b0 <malloc+0x7e>
        return 0;
 9dc:	4501                	li	a0,0
 9de:	7902                	ld	s2,32(sp)
 9e0:	6a42                	ld	s4,16(sp)
 9e2:	6aa2                	ld	s5,8(sp)
 9e4:	6b02                	ld	s6,0(sp)
 9e6:	a03d                	j	a14 <malloc+0xe2>
 9e8:	7902                	ld	s2,32(sp)
 9ea:	6a42                	ld	s4,16(sp)
 9ec:	6aa2                	ld	s5,8(sp)
 9ee:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 9f0:	fae48de3          	beq	s1,a4,9aa <malloc+0x78>
        p->s.size -= nunits;
 9f4:	4137073b          	subw	a4,a4,s3
 9f8:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9fa:	02071693          	slli	a3,a4,0x20
 9fe:	01c6d713          	srli	a4,a3,0x1c
 a02:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a04:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a08:	00000717          	auipc	a4,0x0
 a0c:	5ea73c23          	sd	a0,1528(a4) # 1000 <freep>
      return (void*)(p + 1);
 a10:	01078513          	addi	a0,a5,16
  }
}
 a14:	70e2                	ld	ra,56(sp)
 a16:	7442                	ld	s0,48(sp)
 a18:	74a2                	ld	s1,40(sp)
 a1a:	69e2                	ld	s3,24(sp)
 a1c:	6121                	addi	sp,sp,64
 a1e:	8082                	ret
 a20:	7902                	ld	s2,32(sp)
 a22:	6a42                	ld	s4,16(sp)
 a24:	6aa2                	ld	s5,8(sp)
 a26:	6b02                	ld	s6,0(sp)
 a28:	b7f5                	j	a14 <malloc+0xe2>
