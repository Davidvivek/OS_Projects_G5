
user/_forphan:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char buf[BUFSZ];

int
main(int argc, char **argv)
{
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	0080                	addi	s0,sp,64
  int fd = 0;
  char *s = argv[0];
   a:	6184                	ld	s1,0(a1)
  struct stat st;
  char *ff = "file0";
  
  if ((fd = open(ff, O_CREATE|O_WRONLY)) < 0) {
   c:	20100593          	li	a1,513
  10:	00001517          	auipc	a0,0x1
  14:	9f050513          	addi	a0,a0,-1552 # a00 <malloc+0xfc>
  18:	410000ef          	jal	428 <open>
  1c:	04054463          	bltz	a0,64 <main+0x64>
    printf("%s: open failed\n", s);
    exit(1);
  }
  if(fstat(fd, &st) < 0){
  20:	fc840593          	addi	a1,s0,-56
  24:	41c000ef          	jal	440 <fstat>
  28:	04054863          	bltz	a0,78 <main+0x78>
    fprintf(2, "%s: cannot stat %s\n", s, "ff");
    exit(1);
  }
  if (unlink(ff) < 0) {
  2c:	00001517          	auipc	a0,0x1
  30:	9d450513          	addi	a0,a0,-1580 # a00 <malloc+0xfc>
  34:	404000ef          	jal	438 <unlink>
  38:	04054f63          	bltz	a0,96 <main+0x96>
    printf("%s: unlink failed\n", s);
    exit(1);
  }
  if (open(ff, O_RDONLY) != -1) {
  3c:	4581                	li	a1,0
  3e:	00001517          	auipc	a0,0x1
  42:	9c250513          	addi	a0,a0,-1598 # a00 <malloc+0xfc>
  46:	3e2000ef          	jal	428 <open>
  4a:	57fd                	li	a5,-1
  4c:	04f50f63          	beq	a0,a5,aa <main+0xaa>
    printf("%s: open successed\n", s);
  50:	85a6                	mv	a1,s1
  52:	00001517          	auipc	a0,0x1
  56:	a0e50513          	addi	a0,a0,-1522 # a60 <malloc+0x15c>
  5a:	7f6000ef          	jal	850 <printf>
    exit(1);
  5e:	4505                	li	a0,1
  60:	388000ef          	jal	3e8 <exit>
    printf("%s: open failed\n", s);
  64:	85a6                	mv	a1,s1
  66:	00001517          	auipc	a0,0x1
  6a:	9aa50513          	addi	a0,a0,-1622 # a10 <malloc+0x10c>
  6e:	7e2000ef          	jal	850 <printf>
    exit(1);
  72:	4505                	li	a0,1
  74:	374000ef          	jal	3e8 <exit>
    fprintf(2, "%s: cannot stat %s\n", s, "ff");
  78:	00001697          	auipc	a3,0x1
  7c:	9b068693          	addi	a3,a3,-1616 # a28 <malloc+0x124>
  80:	8626                	mv	a2,s1
  82:	00001597          	auipc	a1,0x1
  86:	9ae58593          	addi	a1,a1,-1618 # a30 <malloc+0x12c>
  8a:	4509                	li	a0,2
  8c:	79a000ef          	jal	826 <fprintf>
    exit(1);
  90:	4505                	li	a0,1
  92:	356000ef          	jal	3e8 <exit>
    printf("%s: unlink failed\n", s);
  96:	85a6                	mv	a1,s1
  98:	00001517          	auipc	a0,0x1
  9c:	9b050513          	addi	a0,a0,-1616 # a48 <malloc+0x144>
  a0:	7b0000ef          	jal	850 <printf>
    exit(1);
  a4:	4505                	li	a0,1
  a6:	342000ef          	jal	3e8 <exit>
  }
  printf("wait for kill and reclaim %d\n", st.ino);
  aa:	fcc42583          	lw	a1,-52(s0)
  ae:	00001517          	auipc	a0,0x1
  b2:	9ca50513          	addi	a0,a0,-1590 # a78 <malloc+0x174>
  b6:	79a000ef          	jal	850 <printf>
  // sit around until killed
  for(;;) pause(1000);
  ba:	3e800513          	li	a0,1000
  be:	3ba000ef          	jal	478 <pause>
  c2:	bfe5                	j	ba <main+0xba>

00000000000000c4 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  c4:	1141                	addi	sp,sp,-16
  c6:	e406                	sd	ra,8(sp)
  c8:	e022                	sd	s0,0(sp)
  ca:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  cc:	f35ff0ef          	jal	0 <main>
  exit(r);
  d0:	318000ef          	jal	3e8 <exit>

00000000000000d4 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  d4:	1141                	addi	sp,sp,-16
  d6:	e422                	sd	s0,8(sp)
  d8:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  da:	87aa                	mv	a5,a0
  dc:	0585                	addi	a1,a1,1
  de:	0785                	addi	a5,a5,1
  e0:	fff5c703          	lbu	a4,-1(a1)
  e4:	fee78fa3          	sb	a4,-1(a5)
  e8:	fb75                	bnez	a4,dc <strcpy+0x8>
    ;
  return os;
}
  ea:	6422                	ld	s0,8(sp)
  ec:	0141                	addi	sp,sp,16
  ee:	8082                	ret

00000000000000f0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  f0:	1141                	addi	sp,sp,-16
  f2:	e422                	sd	s0,8(sp)
  f4:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  f6:	00054783          	lbu	a5,0(a0)
  fa:	cb91                	beqz	a5,10e <strcmp+0x1e>
  fc:	0005c703          	lbu	a4,0(a1)
 100:	00f71763          	bne	a4,a5,10e <strcmp+0x1e>
    p++, q++;
 104:	0505                	addi	a0,a0,1
 106:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 108:	00054783          	lbu	a5,0(a0)
 10c:	fbe5                	bnez	a5,fc <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 10e:	0005c503          	lbu	a0,0(a1)
}
 112:	40a7853b          	subw	a0,a5,a0
 116:	6422                	ld	s0,8(sp)
 118:	0141                	addi	sp,sp,16
 11a:	8082                	ret

000000000000011c <strlen>:

uint
strlen(const char *s)
{
 11c:	1141                	addi	sp,sp,-16
 11e:	e422                	sd	s0,8(sp)
 120:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 122:	00054783          	lbu	a5,0(a0)
 126:	cf91                	beqz	a5,142 <strlen+0x26>
 128:	0505                	addi	a0,a0,1
 12a:	87aa                	mv	a5,a0
 12c:	86be                	mv	a3,a5
 12e:	0785                	addi	a5,a5,1
 130:	fff7c703          	lbu	a4,-1(a5)
 134:	ff65                	bnez	a4,12c <strlen+0x10>
 136:	40a6853b          	subw	a0,a3,a0
 13a:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 13c:	6422                	ld	s0,8(sp)
 13e:	0141                	addi	sp,sp,16
 140:	8082                	ret
  for(n = 0; s[n]; n++)
 142:	4501                	li	a0,0
 144:	bfe5                	j	13c <strlen+0x20>

0000000000000146 <memset>:

void*
memset(void *dst, int c, uint n)
{
 146:	1141                	addi	sp,sp,-16
 148:	e422                	sd	s0,8(sp)
 14a:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 14c:	ca19                	beqz	a2,162 <memset+0x1c>
 14e:	87aa                	mv	a5,a0
 150:	1602                	slli	a2,a2,0x20
 152:	9201                	srli	a2,a2,0x20
 154:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 158:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 15c:	0785                	addi	a5,a5,1
 15e:	fee79de3          	bne	a5,a4,158 <memset+0x12>
  }
  return dst;
}
 162:	6422                	ld	s0,8(sp)
 164:	0141                	addi	sp,sp,16
 166:	8082                	ret

0000000000000168 <strchr>:

char*
strchr(const char *s, char c)
{
 168:	1141                	addi	sp,sp,-16
 16a:	e422                	sd	s0,8(sp)
 16c:	0800                	addi	s0,sp,16
  for(; *s; s++)
 16e:	00054783          	lbu	a5,0(a0)
 172:	cb99                	beqz	a5,188 <strchr+0x20>
    if(*s == c)
 174:	00f58763          	beq	a1,a5,182 <strchr+0x1a>
  for(; *s; s++)
 178:	0505                	addi	a0,a0,1
 17a:	00054783          	lbu	a5,0(a0)
 17e:	fbfd                	bnez	a5,174 <strchr+0xc>
      return (char*)s;
  return 0;
 180:	4501                	li	a0,0
}
 182:	6422                	ld	s0,8(sp)
 184:	0141                	addi	sp,sp,16
 186:	8082                	ret
  return 0;
 188:	4501                	li	a0,0
 18a:	bfe5                	j	182 <strchr+0x1a>

000000000000018c <gets>:

char*
gets(char *buf, int max)
{
 18c:	711d                	addi	sp,sp,-96
 18e:	ec86                	sd	ra,88(sp)
 190:	e8a2                	sd	s0,80(sp)
 192:	e4a6                	sd	s1,72(sp)
 194:	e0ca                	sd	s2,64(sp)
 196:	fc4e                	sd	s3,56(sp)
 198:	f852                	sd	s4,48(sp)
 19a:	f456                	sd	s5,40(sp)
 19c:	f05a                	sd	s6,32(sp)
 19e:	ec5e                	sd	s7,24(sp)
 1a0:	1080                	addi	s0,sp,96
 1a2:	8baa                	mv	s7,a0
 1a4:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1a6:	892a                	mv	s2,a0
 1a8:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1aa:	4aa9                	li	s5,10
 1ac:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1ae:	89a6                	mv	s3,s1
 1b0:	2485                	addiw	s1,s1,1
 1b2:	0344d663          	bge	s1,s4,1de <gets+0x52>
    cc = read(0, &c, 1);
 1b6:	4605                	li	a2,1
 1b8:	faf40593          	addi	a1,s0,-81
 1bc:	4501                	li	a0,0
 1be:	242000ef          	jal	400 <read>
    if(cc < 1)
 1c2:	00a05e63          	blez	a0,1de <gets+0x52>
    buf[i++] = c;
 1c6:	faf44783          	lbu	a5,-81(s0)
 1ca:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1ce:	01578763          	beq	a5,s5,1dc <gets+0x50>
 1d2:	0905                	addi	s2,s2,1
 1d4:	fd679de3          	bne	a5,s6,1ae <gets+0x22>
    buf[i++] = c;
 1d8:	89a6                	mv	s3,s1
 1da:	a011                	j	1de <gets+0x52>
 1dc:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1de:	99de                	add	s3,s3,s7
 1e0:	00098023          	sb	zero,0(s3)
  return buf;
}
 1e4:	855e                	mv	a0,s7
 1e6:	60e6                	ld	ra,88(sp)
 1e8:	6446                	ld	s0,80(sp)
 1ea:	64a6                	ld	s1,72(sp)
 1ec:	6906                	ld	s2,64(sp)
 1ee:	79e2                	ld	s3,56(sp)
 1f0:	7a42                	ld	s4,48(sp)
 1f2:	7aa2                	ld	s5,40(sp)
 1f4:	7b02                	ld	s6,32(sp)
 1f6:	6be2                	ld	s7,24(sp)
 1f8:	6125                	addi	sp,sp,96
 1fa:	8082                	ret

00000000000001fc <stat>:

int
stat(const char *n, struct stat *st)
{
 1fc:	1101                	addi	sp,sp,-32
 1fe:	ec06                	sd	ra,24(sp)
 200:	e822                	sd	s0,16(sp)
 202:	e04a                	sd	s2,0(sp)
 204:	1000                	addi	s0,sp,32
 206:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 208:	4581                	li	a1,0
 20a:	21e000ef          	jal	428 <open>
  if(fd < 0)
 20e:	02054263          	bltz	a0,232 <stat+0x36>
 212:	e426                	sd	s1,8(sp)
 214:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 216:	85ca                	mv	a1,s2
 218:	228000ef          	jal	440 <fstat>
 21c:	892a                	mv	s2,a0
  close(fd);
 21e:	8526                	mv	a0,s1
 220:	1f0000ef          	jal	410 <close>
  return r;
 224:	64a2                	ld	s1,8(sp)
}
 226:	854a                	mv	a0,s2
 228:	60e2                	ld	ra,24(sp)
 22a:	6442                	ld	s0,16(sp)
 22c:	6902                	ld	s2,0(sp)
 22e:	6105                	addi	sp,sp,32
 230:	8082                	ret
    return -1;
 232:	597d                	li	s2,-1
 234:	bfcd                	j	226 <stat+0x2a>

0000000000000236 <atoi>:

int
atoi(const char *s)
{
 236:	1141                	addi	sp,sp,-16
 238:	e422                	sd	s0,8(sp)
 23a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 23c:	00054683          	lbu	a3,0(a0)
 240:	fd06879b          	addiw	a5,a3,-48
 244:	0ff7f793          	zext.b	a5,a5
 248:	4625                	li	a2,9
 24a:	02f66863          	bltu	a2,a5,27a <atoi+0x44>
 24e:	872a                	mv	a4,a0
  n = 0;
 250:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 252:	0705                	addi	a4,a4,1
 254:	0025179b          	slliw	a5,a0,0x2
 258:	9fa9                	addw	a5,a5,a0
 25a:	0017979b          	slliw	a5,a5,0x1
 25e:	9fb5                	addw	a5,a5,a3
 260:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 264:	00074683          	lbu	a3,0(a4)
 268:	fd06879b          	addiw	a5,a3,-48
 26c:	0ff7f793          	zext.b	a5,a5
 270:	fef671e3          	bgeu	a2,a5,252 <atoi+0x1c>
  return n;
}
 274:	6422                	ld	s0,8(sp)
 276:	0141                	addi	sp,sp,16
 278:	8082                	ret
  n = 0;
 27a:	4501                	li	a0,0
 27c:	bfe5                	j	274 <atoi+0x3e>

000000000000027e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 27e:	1141                	addi	sp,sp,-16
 280:	e422                	sd	s0,8(sp)
 282:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 284:	02b57463          	bgeu	a0,a1,2ac <memmove+0x2e>
    while(n-- > 0)
 288:	00c05f63          	blez	a2,2a6 <memmove+0x28>
 28c:	1602                	slli	a2,a2,0x20
 28e:	9201                	srli	a2,a2,0x20
 290:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 294:	872a                	mv	a4,a0
      *dst++ = *src++;
 296:	0585                	addi	a1,a1,1
 298:	0705                	addi	a4,a4,1
 29a:	fff5c683          	lbu	a3,-1(a1)
 29e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2a2:	fef71ae3          	bne	a4,a5,296 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2a6:	6422                	ld	s0,8(sp)
 2a8:	0141                	addi	sp,sp,16
 2aa:	8082                	ret
    dst += n;
 2ac:	00c50733          	add	a4,a0,a2
    src += n;
 2b0:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2b2:	fec05ae3          	blez	a2,2a6 <memmove+0x28>
 2b6:	fff6079b          	addiw	a5,a2,-1
 2ba:	1782                	slli	a5,a5,0x20
 2bc:	9381                	srli	a5,a5,0x20
 2be:	fff7c793          	not	a5,a5
 2c2:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2c4:	15fd                	addi	a1,a1,-1
 2c6:	177d                	addi	a4,a4,-1
 2c8:	0005c683          	lbu	a3,0(a1)
 2cc:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2d0:	fee79ae3          	bne	a5,a4,2c4 <memmove+0x46>
 2d4:	bfc9                	j	2a6 <memmove+0x28>

00000000000002d6 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2d6:	1141                	addi	sp,sp,-16
 2d8:	e422                	sd	s0,8(sp)
 2da:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2dc:	ca05                	beqz	a2,30c <memcmp+0x36>
 2de:	fff6069b          	addiw	a3,a2,-1
 2e2:	1682                	slli	a3,a3,0x20
 2e4:	9281                	srli	a3,a3,0x20
 2e6:	0685                	addi	a3,a3,1
 2e8:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2ea:	00054783          	lbu	a5,0(a0)
 2ee:	0005c703          	lbu	a4,0(a1)
 2f2:	00e79863          	bne	a5,a4,302 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2f6:	0505                	addi	a0,a0,1
    p2++;
 2f8:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2fa:	fed518e3          	bne	a0,a3,2ea <memcmp+0x14>
  }
  return 0;
 2fe:	4501                	li	a0,0
 300:	a019                	j	306 <memcmp+0x30>
      return *p1 - *p2;
 302:	40e7853b          	subw	a0,a5,a4
}
 306:	6422                	ld	s0,8(sp)
 308:	0141                	addi	sp,sp,16
 30a:	8082                	ret
  return 0;
 30c:	4501                	li	a0,0
 30e:	bfe5                	j	306 <memcmp+0x30>

0000000000000310 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 310:	1141                	addi	sp,sp,-16
 312:	e406                	sd	ra,8(sp)
 314:	e022                	sd	s0,0(sp)
 316:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 318:	f67ff0ef          	jal	27e <memmove>
}
 31c:	60a2                	ld	ra,8(sp)
 31e:	6402                	ld	s0,0(sp)
 320:	0141                	addi	sp,sp,16
 322:	8082                	ret

0000000000000324 <sbrk>:

char *
sbrk(int n) {
 324:	1141                	addi	sp,sp,-16
 326:	e406                	sd	ra,8(sp)
 328:	e022                	sd	s0,0(sp)
 32a:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 32c:	4585                	li	a1,1
 32e:	142000ef          	jal	470 <sys_sbrk>
}
 332:	60a2                	ld	ra,8(sp)
 334:	6402                	ld	s0,0(sp)
 336:	0141                	addi	sp,sp,16
 338:	8082                	ret

000000000000033a <sbrklazy>:

char *
sbrklazy(int n) {
 33a:	1141                	addi	sp,sp,-16
 33c:	e406                	sd	ra,8(sp)
 33e:	e022                	sd	s0,0(sp)
 340:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 342:	4589                	li	a1,2
 344:	12c000ef          	jal	470 <sys_sbrk>
}
 348:	60a2                	ld	ra,8(sp)
 34a:	6402                	ld	s0,0(sp)
 34c:	0141                	addi	sp,sp,16
 34e:	8082                	ret

0000000000000350 <thread_create>:
// thread_create allocates a page-sized stack, calls clone(fn, arg, stacktop).
// Returns the new thread's pid, or -1 on error.
// The stack is passed back via *stack so the caller can free it after join.
int
thread_create(void(*fn)(void*), void *arg, void **stack)
{
 350:	7179                	addi	sp,sp,-48
 352:	f406                	sd	ra,40(sp)
 354:	f022                	sd	s0,32(sp)
 356:	e84a                	sd	s2,16(sp)
 358:	e44e                	sd	s3,8(sp)
 35a:	e052                	sd	s4,0(sp)
 35c:	1800                	addi	s0,sp,48
 35e:	89aa                	mv	s3,a0
 360:	8a2e                	mv	s4,a1
 362:	8932                	mv	s2,a2
  char *s = malloc(PGSIZE);
 364:	6505                	lui	a0,0x1
 366:	59e000ef          	jal	904 <malloc>
  if(s == 0)
 36a:	cd0d                	beqz	a0,3a4 <thread_create+0x54>
 36c:	ec26                	sd	s1,24(sp)
 36e:	84aa                	mv	s1,a0
    return -1;
  *stack = s;
 370:	00a93023          	sd	a0,0(s2)
  // Stack grows downward- pass the top of the allocated region.
  int pid = clone(fn, arg, s + PGSIZE);
 374:	6605                	lui	a2,0x1
 376:	962a                	add	a2,a2,a0
 378:	85d2                	mv	a1,s4
 37a:	854e                	mv	a0,s3
 37c:	134000ef          	jal	4b0 <clone>
  if(pid < 0){
 380:	00054a63          	bltz	a0,394 <thread_create+0x44>
 384:	64e2                	ld	s1,24(sp)
    free(s);
    *stack = 0;
    return -1;
  }
  return pid;
}
 386:	70a2                	ld	ra,40(sp)
 388:	7402                	ld	s0,32(sp)
 38a:	6942                	ld	s2,16(sp)
 38c:	69a2                	ld	s3,8(sp)
 38e:	6a02                	ld	s4,0(sp)
 390:	6145                	addi	sp,sp,48
 392:	8082                	ret
    free(s);
 394:	8526                	mv	a0,s1
 396:	4ec000ef          	jal	882 <free>
    *stack = 0;
 39a:	00093023          	sd	zero,0(s2)
    return -1;
 39e:	557d                	li	a0,-1
 3a0:	64e2                	ld	s1,24(sp)
 3a2:	b7d5                	j	386 <thread_create+0x36>
    return -1;
 3a4:	557d                	li	a0,-1
 3a6:	b7c5                	j	386 <thread_create+0x36>

00000000000003a8 <thread_join>:
// Wait for any child thread to exit.
// If stack is non-null, frees the memory pointed to by *stack and clears it.
// Returns the joined thread's pid, or -1 Son error.
int
thread_join(void **stack)
{
 3a8:	1101                	addi	sp,sp,-32
 3aa:	ec06                	sd	ra,24(sp)
 3ac:	e822                	sd	s0,16(sp)
 3ae:	e426                	sd	s1,8(sp)
 3b0:	e04a                	sd	s2,0(sp)
 3b2:	1000                	addi	s0,sp,32
 3b4:	84aa                	mv	s1,a0
  int pid = join();
 3b6:	102000ef          	jal	4b8 <join>
  if(pid < 0)
 3ba:	02054163          	bltz	a0,3dc <thread_join+0x34>
 3be:	892a                	mv	s2,a0
    return -1;
  if(stack && *stack){
 3c0:	c499                	beqz	s1,3ce <thread_join+0x26>
 3c2:	6088                	ld	a0,0(s1)
 3c4:	c509                	beqz	a0,3ce <thread_join+0x26>
    free(*stack);
 3c6:	4bc000ef          	jal	882 <free>
    *stack = 0;
 3ca:	0004b023          	sd	zero,0(s1)
  }
  return pid;
}
 3ce:	854a                	mv	a0,s2
 3d0:	60e2                	ld	ra,24(sp)
 3d2:	6442                	ld	s0,16(sp)
 3d4:	64a2                	ld	s1,8(sp)
 3d6:	6902                	ld	s2,0(sp)
 3d8:	6105                	addi	sp,sp,32
 3da:	8082                	ret
    return -1;
 3dc:	597d                	li	s2,-1
 3de:	bfc5                	j	3ce <thread_join+0x26>

00000000000003e0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3e0:	4885                	li	a7,1
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3e8:	4889                	li	a7,2
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3f0:	488d                	li	a7,3
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3f8:	4891                	li	a7,4
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <read>:
.global read
read:
 li a7, SYS_read
 400:	4895                	li	a7,5
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <write>:
.global write
write:
 li a7, SYS_write
 408:	48c1                	li	a7,16
 ecall
 40a:	00000073          	ecall
 ret
 40e:	8082                	ret

0000000000000410 <close>:
.global close
close:
 li a7, SYS_close
 410:	48d5                	li	a7,21
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <kill>:
.global kill
kill:
 li a7, SYS_kill
 418:	4899                	li	a7,6
 ecall
 41a:	00000073          	ecall
 ret
 41e:	8082                	ret

0000000000000420 <exec>:
.global exec
exec:
 li a7, SYS_exec
 420:	489d                	li	a7,7
 ecall
 422:	00000073          	ecall
 ret
 426:	8082                	ret

0000000000000428 <open>:
.global open
open:
 li a7, SYS_open
 428:	48bd                	li	a7,15
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 430:	48c5                	li	a7,17
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 438:	48c9                	li	a7,18
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 440:	48a1                	li	a7,8
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <link>:
.global link
link:
 li a7, SYS_link
 448:	48cd                	li	a7,19
 ecall
 44a:	00000073          	ecall
 ret
 44e:	8082                	ret

0000000000000450 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 450:	48d1                	li	a7,20
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 458:	48a5                	li	a7,9
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <dup>:
.global dup
dup:
 li a7, SYS_dup
 460:	48a9                	li	a7,10
 ecall
 462:	00000073          	ecall
 ret
 466:	8082                	ret

0000000000000468 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 468:	48ad                	li	a7,11
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 470:	48b1                	li	a7,12
 ecall
 472:	00000073          	ecall
 ret
 476:	8082                	ret

0000000000000478 <pause>:
.global pause
pause:
 li a7, SYS_pause
 478:	48b5                	li	a7,13
 ecall
 47a:	00000073          	ecall
 ret
 47e:	8082                	ret

0000000000000480 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 480:	48b9                	li	a7,14
 ecall
 482:	00000073          	ecall
 ret
 486:	8082                	ret

0000000000000488 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 488:	48d9                	li	a7,22
 ecall
 48a:	00000073          	ecall
 ret
 48e:	8082                	ret

0000000000000490 <lock_create>:
.global lock_create
lock_create:
 li a7, SYS_lock_create
 490:	48dd                	li	a7,23
 ecall
 492:	00000073          	ecall
 ret
 496:	8082                	ret

0000000000000498 <lock_acquire>:
.global lock_acquire
lock_acquire:
 li a7, SYS_lock_acquire
 498:	48e1                	li	a7,24
 ecall
 49a:	00000073          	ecall
 ret
 49e:	8082                	ret

00000000000004a0 <lock_release>:
.global lock_release
lock_release:
 li a7, SYS_lock_release
 4a0:	48e5                	li	a7,25
 ecall
 4a2:	00000073          	ecall
 ret
 4a6:	8082                	ret

00000000000004a8 <lock_destroy>:
.global lock_destroy
lock_destroy:
 li a7, SYS_lock_destroy
 4a8:	48e9                	li	a7,26
 ecall
 4aa:	00000073          	ecall
 ret
 4ae:	8082                	ret

00000000000004b0 <clone>:
.global clone
clone:
 li a7, SYS_clone
 4b0:	48ed                	li	a7,27
 ecall
 4b2:	00000073          	ecall
 ret
 4b6:	8082                	ret

00000000000004b8 <join>:
.global join
join:
 li a7, SYS_join
 4b8:	48f1                	li	a7,28
 ecall
 4ba:	00000073          	ecall
 ret
 4be:	8082                	ret

00000000000004c0 <getprocessinfo>:
.global getprocessinfo
getprocessinfo:
 li a7, SYS_getprocessinfo
 4c0:	48f5                	li	a7,29
 ecall
 4c2:	00000073          	ecall
 ret
 4c6:	8082                	ret

00000000000004c8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4c8:	1101                	addi	sp,sp,-32
 4ca:	ec06                	sd	ra,24(sp)
 4cc:	e822                	sd	s0,16(sp)
 4ce:	1000                	addi	s0,sp,32
 4d0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4d4:	4605                	li	a2,1
 4d6:	fef40593          	addi	a1,s0,-17
 4da:	f2fff0ef          	jal	408 <write>
}
 4de:	60e2                	ld	ra,24(sp)
 4e0:	6442                	ld	s0,16(sp)
 4e2:	6105                	addi	sp,sp,32
 4e4:	8082                	ret

00000000000004e6 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 4e6:	715d                	addi	sp,sp,-80
 4e8:	e486                	sd	ra,72(sp)
 4ea:	e0a2                	sd	s0,64(sp)
 4ec:	f84a                	sd	s2,48(sp)
 4ee:	0880                	addi	s0,sp,80
 4f0:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 4f2:	c299                	beqz	a3,4f8 <printint+0x12>
 4f4:	0805c363          	bltz	a1,57a <printint+0x94>
  neg = 0;
 4f8:	4881                	li	a7,0
 4fa:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 4fe:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 500:	00000517          	auipc	a0,0x0
 504:	5a050513          	addi	a0,a0,1440 # aa0 <digits>
 508:	883e                	mv	a6,a5
 50a:	2785                	addiw	a5,a5,1
 50c:	02c5f733          	remu	a4,a1,a2
 510:	972a                	add	a4,a4,a0
 512:	00074703          	lbu	a4,0(a4)
 516:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 51a:	872e                	mv	a4,a1
 51c:	02c5d5b3          	divu	a1,a1,a2
 520:	0685                	addi	a3,a3,1
 522:	fec773e3          	bgeu	a4,a2,508 <printint+0x22>
  if(neg)
 526:	00088b63          	beqz	a7,53c <printint+0x56>
    buf[i++] = '-';
 52a:	fd078793          	addi	a5,a5,-48
 52e:	97a2                	add	a5,a5,s0
 530:	02d00713          	li	a4,45
 534:	fee78423          	sb	a4,-24(a5)
 538:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 53c:	02f05a63          	blez	a5,570 <printint+0x8a>
 540:	fc26                	sd	s1,56(sp)
 542:	f44e                	sd	s3,40(sp)
 544:	fb840713          	addi	a4,s0,-72
 548:	00f704b3          	add	s1,a4,a5
 54c:	fff70993          	addi	s3,a4,-1
 550:	99be                	add	s3,s3,a5
 552:	37fd                	addiw	a5,a5,-1
 554:	1782                	slli	a5,a5,0x20
 556:	9381                	srli	a5,a5,0x20
 558:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 55c:	fff4c583          	lbu	a1,-1(s1)
 560:	854a                	mv	a0,s2
 562:	f67ff0ef          	jal	4c8 <putc>
  while(--i >= 0)
 566:	14fd                	addi	s1,s1,-1
 568:	ff349ae3          	bne	s1,s3,55c <printint+0x76>
 56c:	74e2                	ld	s1,56(sp)
 56e:	79a2                	ld	s3,40(sp)
}
 570:	60a6                	ld	ra,72(sp)
 572:	6406                	ld	s0,64(sp)
 574:	7942                	ld	s2,48(sp)
 576:	6161                	addi	sp,sp,80
 578:	8082                	ret
    x = -xx;
 57a:	40b005b3          	neg	a1,a1
    neg = 1;
 57e:	4885                	li	a7,1
    x = -xx;
 580:	bfad                	j	4fa <printint+0x14>

0000000000000582 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 582:	711d                	addi	sp,sp,-96
 584:	ec86                	sd	ra,88(sp)
 586:	e8a2                	sd	s0,80(sp)
 588:	e0ca                	sd	s2,64(sp)
 58a:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 58c:	0005c903          	lbu	s2,0(a1)
 590:	28090663          	beqz	s2,81c <vprintf+0x29a>
 594:	e4a6                	sd	s1,72(sp)
 596:	fc4e                	sd	s3,56(sp)
 598:	f852                	sd	s4,48(sp)
 59a:	f456                	sd	s5,40(sp)
 59c:	f05a                	sd	s6,32(sp)
 59e:	ec5e                	sd	s7,24(sp)
 5a0:	e862                	sd	s8,16(sp)
 5a2:	e466                	sd	s9,8(sp)
 5a4:	8b2a                	mv	s6,a0
 5a6:	8a2e                	mv	s4,a1
 5a8:	8bb2                	mv	s7,a2
  state = 0;
 5aa:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 5ac:	4481                	li	s1,0
 5ae:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 5b0:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 5b4:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 5b8:	06c00c93          	li	s9,108
 5bc:	a005                	j	5dc <vprintf+0x5a>
        putc(fd, c0);
 5be:	85ca                	mv	a1,s2
 5c0:	855a                	mv	a0,s6
 5c2:	f07ff0ef          	jal	4c8 <putc>
 5c6:	a019                	j	5cc <vprintf+0x4a>
    } else if(state == '%'){
 5c8:	03598263          	beq	s3,s5,5ec <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 5cc:	2485                	addiw	s1,s1,1
 5ce:	8726                	mv	a4,s1
 5d0:	009a07b3          	add	a5,s4,s1
 5d4:	0007c903          	lbu	s2,0(a5)
 5d8:	22090a63          	beqz	s2,80c <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 5dc:	0009079b          	sext.w	a5,s2
    if(state == 0){
 5e0:	fe0994e3          	bnez	s3,5c8 <vprintf+0x46>
      if(c0 == '%'){
 5e4:	fd579de3          	bne	a5,s5,5be <vprintf+0x3c>
        state = '%';
 5e8:	89be                	mv	s3,a5
 5ea:	b7cd                	j	5cc <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 5ec:	00ea06b3          	add	a3,s4,a4
 5f0:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 5f4:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 5f6:	c681                	beqz	a3,5fe <vprintf+0x7c>
 5f8:	9752                	add	a4,a4,s4
 5fa:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 5fe:	05878363          	beq	a5,s8,644 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 602:	05978d63          	beq	a5,s9,65c <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 606:	07500713          	li	a4,117
 60a:	0ee78763          	beq	a5,a4,6f8 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 60e:	07800713          	li	a4,120
 612:	12e78963          	beq	a5,a4,744 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 616:	07000713          	li	a4,112
 61a:	14e78e63          	beq	a5,a4,776 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 61e:	06300713          	li	a4,99
 622:	18e78e63          	beq	a5,a4,7be <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 626:	07300713          	li	a4,115
 62a:	1ae78463          	beq	a5,a4,7d2 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 62e:	02500713          	li	a4,37
 632:	04e79563          	bne	a5,a4,67c <vprintf+0xfa>
        putc(fd, '%');
 636:	02500593          	li	a1,37
 63a:	855a                	mv	a0,s6
 63c:	e8dff0ef          	jal	4c8 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 640:	4981                	li	s3,0
 642:	b769                	j	5cc <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 644:	008b8913          	addi	s2,s7,8
 648:	4685                	li	a3,1
 64a:	4629                	li	a2,10
 64c:	000ba583          	lw	a1,0(s7)
 650:	855a                	mv	a0,s6
 652:	e95ff0ef          	jal	4e6 <printint>
 656:	8bca                	mv	s7,s2
      state = 0;
 658:	4981                	li	s3,0
 65a:	bf8d                	j	5cc <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 65c:	06400793          	li	a5,100
 660:	02f68963          	beq	a3,a5,692 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 664:	06c00793          	li	a5,108
 668:	04f68263          	beq	a3,a5,6ac <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 66c:	07500793          	li	a5,117
 670:	0af68063          	beq	a3,a5,710 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 674:	07800793          	li	a5,120
 678:	0ef68263          	beq	a3,a5,75c <vprintf+0x1da>
        putc(fd, '%');
 67c:	02500593          	li	a1,37
 680:	855a                	mv	a0,s6
 682:	e47ff0ef          	jal	4c8 <putc>
        putc(fd, c0);
 686:	85ca                	mv	a1,s2
 688:	855a                	mv	a0,s6
 68a:	e3fff0ef          	jal	4c8 <putc>
      state = 0;
 68e:	4981                	li	s3,0
 690:	bf35                	j	5cc <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 692:	008b8913          	addi	s2,s7,8
 696:	4685                	li	a3,1
 698:	4629                	li	a2,10
 69a:	000bb583          	ld	a1,0(s7)
 69e:	855a                	mv	a0,s6
 6a0:	e47ff0ef          	jal	4e6 <printint>
        i += 1;
 6a4:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 6a6:	8bca                	mv	s7,s2
      state = 0;
 6a8:	4981                	li	s3,0
        i += 1;
 6aa:	b70d                	j	5cc <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6ac:	06400793          	li	a5,100
 6b0:	02f60763          	beq	a2,a5,6de <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 6b4:	07500793          	li	a5,117
 6b8:	06f60963          	beq	a2,a5,72a <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 6bc:	07800793          	li	a5,120
 6c0:	faf61ee3          	bne	a2,a5,67c <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6c4:	008b8913          	addi	s2,s7,8
 6c8:	4681                	li	a3,0
 6ca:	4641                	li	a2,16
 6cc:	000bb583          	ld	a1,0(s7)
 6d0:	855a                	mv	a0,s6
 6d2:	e15ff0ef          	jal	4e6 <printint>
        i += 2;
 6d6:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 6d8:	8bca                	mv	s7,s2
      state = 0;
 6da:	4981                	li	s3,0
        i += 2;
 6dc:	bdc5                	j	5cc <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6de:	008b8913          	addi	s2,s7,8
 6e2:	4685                	li	a3,1
 6e4:	4629                	li	a2,10
 6e6:	000bb583          	ld	a1,0(s7)
 6ea:	855a                	mv	a0,s6
 6ec:	dfbff0ef          	jal	4e6 <printint>
        i += 2;
 6f0:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 6f2:	8bca                	mv	s7,s2
      state = 0;
 6f4:	4981                	li	s3,0
        i += 2;
 6f6:	bdd9                	j	5cc <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 6f8:	008b8913          	addi	s2,s7,8
 6fc:	4681                	li	a3,0
 6fe:	4629                	li	a2,10
 700:	000be583          	lwu	a1,0(s7)
 704:	855a                	mv	a0,s6
 706:	de1ff0ef          	jal	4e6 <printint>
 70a:	8bca                	mv	s7,s2
      state = 0;
 70c:	4981                	li	s3,0
 70e:	bd7d                	j	5cc <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 710:	008b8913          	addi	s2,s7,8
 714:	4681                	li	a3,0
 716:	4629                	li	a2,10
 718:	000bb583          	ld	a1,0(s7)
 71c:	855a                	mv	a0,s6
 71e:	dc9ff0ef          	jal	4e6 <printint>
        i += 1;
 722:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 724:	8bca                	mv	s7,s2
      state = 0;
 726:	4981                	li	s3,0
        i += 1;
 728:	b555                	j	5cc <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 72a:	008b8913          	addi	s2,s7,8
 72e:	4681                	li	a3,0
 730:	4629                	li	a2,10
 732:	000bb583          	ld	a1,0(s7)
 736:	855a                	mv	a0,s6
 738:	dafff0ef          	jal	4e6 <printint>
        i += 2;
 73c:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 73e:	8bca                	mv	s7,s2
      state = 0;
 740:	4981                	li	s3,0
        i += 2;
 742:	b569                	j	5cc <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 744:	008b8913          	addi	s2,s7,8
 748:	4681                	li	a3,0
 74a:	4641                	li	a2,16
 74c:	000be583          	lwu	a1,0(s7)
 750:	855a                	mv	a0,s6
 752:	d95ff0ef          	jal	4e6 <printint>
 756:	8bca                	mv	s7,s2
      state = 0;
 758:	4981                	li	s3,0
 75a:	bd8d                	j	5cc <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 75c:	008b8913          	addi	s2,s7,8
 760:	4681                	li	a3,0
 762:	4641                	li	a2,16
 764:	000bb583          	ld	a1,0(s7)
 768:	855a                	mv	a0,s6
 76a:	d7dff0ef          	jal	4e6 <printint>
        i += 1;
 76e:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 770:	8bca                	mv	s7,s2
      state = 0;
 772:	4981                	li	s3,0
        i += 1;
 774:	bda1                	j	5cc <vprintf+0x4a>
 776:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 778:	008b8d13          	addi	s10,s7,8
 77c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 780:	03000593          	li	a1,48
 784:	855a                	mv	a0,s6
 786:	d43ff0ef          	jal	4c8 <putc>
  putc(fd, 'x');
 78a:	07800593          	li	a1,120
 78e:	855a                	mv	a0,s6
 790:	d39ff0ef          	jal	4c8 <putc>
 794:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 796:	00000b97          	auipc	s7,0x0
 79a:	30ab8b93          	addi	s7,s7,778 # aa0 <digits>
 79e:	03c9d793          	srli	a5,s3,0x3c
 7a2:	97de                	add	a5,a5,s7
 7a4:	0007c583          	lbu	a1,0(a5)
 7a8:	855a                	mv	a0,s6
 7aa:	d1fff0ef          	jal	4c8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7ae:	0992                	slli	s3,s3,0x4
 7b0:	397d                	addiw	s2,s2,-1
 7b2:	fe0916e3          	bnez	s2,79e <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 7b6:	8bea                	mv	s7,s10
      state = 0;
 7b8:	4981                	li	s3,0
 7ba:	6d02                	ld	s10,0(sp)
 7bc:	bd01                	j	5cc <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 7be:	008b8913          	addi	s2,s7,8
 7c2:	000bc583          	lbu	a1,0(s7)
 7c6:	855a                	mv	a0,s6
 7c8:	d01ff0ef          	jal	4c8 <putc>
 7cc:	8bca                	mv	s7,s2
      state = 0;
 7ce:	4981                	li	s3,0
 7d0:	bbf5                	j	5cc <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 7d2:	008b8993          	addi	s3,s7,8
 7d6:	000bb903          	ld	s2,0(s7)
 7da:	00090f63          	beqz	s2,7f8 <vprintf+0x276>
        for(; *s; s++)
 7de:	00094583          	lbu	a1,0(s2)
 7e2:	c195                	beqz	a1,806 <vprintf+0x284>
          putc(fd, *s);
 7e4:	855a                	mv	a0,s6
 7e6:	ce3ff0ef          	jal	4c8 <putc>
        for(; *s; s++)
 7ea:	0905                	addi	s2,s2,1
 7ec:	00094583          	lbu	a1,0(s2)
 7f0:	f9f5                	bnez	a1,7e4 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 7f2:	8bce                	mv	s7,s3
      state = 0;
 7f4:	4981                	li	s3,0
 7f6:	bbd9                	j	5cc <vprintf+0x4a>
          s = "(null)";
 7f8:	00000917          	auipc	s2,0x0
 7fc:	2a090913          	addi	s2,s2,672 # a98 <malloc+0x194>
        for(; *s; s++)
 800:	02800593          	li	a1,40
 804:	b7c5                	j	7e4 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 806:	8bce                	mv	s7,s3
      state = 0;
 808:	4981                	li	s3,0
 80a:	b3c9                	j	5cc <vprintf+0x4a>
 80c:	64a6                	ld	s1,72(sp)
 80e:	79e2                	ld	s3,56(sp)
 810:	7a42                	ld	s4,48(sp)
 812:	7aa2                	ld	s5,40(sp)
 814:	7b02                	ld	s6,32(sp)
 816:	6be2                	ld	s7,24(sp)
 818:	6c42                	ld	s8,16(sp)
 81a:	6ca2                	ld	s9,8(sp)
    }
  }
}
 81c:	60e6                	ld	ra,88(sp)
 81e:	6446                	ld	s0,80(sp)
 820:	6906                	ld	s2,64(sp)
 822:	6125                	addi	sp,sp,96
 824:	8082                	ret

0000000000000826 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 826:	715d                	addi	sp,sp,-80
 828:	ec06                	sd	ra,24(sp)
 82a:	e822                	sd	s0,16(sp)
 82c:	1000                	addi	s0,sp,32
 82e:	e010                	sd	a2,0(s0)
 830:	e414                	sd	a3,8(s0)
 832:	e818                	sd	a4,16(s0)
 834:	ec1c                	sd	a5,24(s0)
 836:	03043023          	sd	a6,32(s0)
 83a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 83e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 842:	8622                	mv	a2,s0
 844:	d3fff0ef          	jal	582 <vprintf>
}
 848:	60e2                	ld	ra,24(sp)
 84a:	6442                	ld	s0,16(sp)
 84c:	6161                	addi	sp,sp,80
 84e:	8082                	ret

0000000000000850 <printf>:

void
printf(const char *fmt, ...)
{
 850:	711d                	addi	sp,sp,-96
 852:	ec06                	sd	ra,24(sp)
 854:	e822                	sd	s0,16(sp)
 856:	1000                	addi	s0,sp,32
 858:	e40c                	sd	a1,8(s0)
 85a:	e810                	sd	a2,16(s0)
 85c:	ec14                	sd	a3,24(s0)
 85e:	f018                	sd	a4,32(s0)
 860:	f41c                	sd	a5,40(s0)
 862:	03043823          	sd	a6,48(s0)
 866:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 86a:	00840613          	addi	a2,s0,8
 86e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 872:	85aa                	mv	a1,a0
 874:	4505                	li	a0,1
 876:	d0dff0ef          	jal	582 <vprintf>
}
 87a:	60e2                	ld	ra,24(sp)
 87c:	6442                	ld	s0,16(sp)
 87e:	6125                	addi	sp,sp,96
 880:	8082                	ret

0000000000000882 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 882:	1141                	addi	sp,sp,-16
 884:	e422                	sd	s0,8(sp)
 886:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 888:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 88c:	00000797          	auipc	a5,0x0
 890:	7747b783          	ld	a5,1908(a5) # 1000 <freep>
 894:	a02d                	j	8be <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 896:	4618                	lw	a4,8(a2)
 898:	9f2d                	addw	a4,a4,a1
 89a:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 89e:	6398                	ld	a4,0(a5)
 8a0:	6310                	ld	a2,0(a4)
 8a2:	a83d                	j	8e0 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8a4:	ff852703          	lw	a4,-8(a0)
 8a8:	9f31                	addw	a4,a4,a2
 8aa:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8ac:	ff053683          	ld	a3,-16(a0)
 8b0:	a091                	j	8f4 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8b2:	6398                	ld	a4,0(a5)
 8b4:	00e7e463          	bltu	a5,a4,8bc <free+0x3a>
 8b8:	00e6ea63          	bltu	a3,a4,8cc <free+0x4a>
{
 8bc:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8be:	fed7fae3          	bgeu	a5,a3,8b2 <free+0x30>
 8c2:	6398                	ld	a4,0(a5)
 8c4:	00e6e463          	bltu	a3,a4,8cc <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8c8:	fee7eae3          	bltu	a5,a4,8bc <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 8cc:	ff852583          	lw	a1,-8(a0)
 8d0:	6390                	ld	a2,0(a5)
 8d2:	02059813          	slli	a6,a1,0x20
 8d6:	01c85713          	srli	a4,a6,0x1c
 8da:	9736                	add	a4,a4,a3
 8dc:	fae60de3          	beq	a2,a4,896 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 8e0:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8e4:	4790                	lw	a2,8(a5)
 8e6:	02061593          	slli	a1,a2,0x20
 8ea:	01c5d713          	srli	a4,a1,0x1c
 8ee:	973e                	add	a4,a4,a5
 8f0:	fae68ae3          	beq	a3,a4,8a4 <free+0x22>
    p->s.ptr = bp->s.ptr;
 8f4:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 8f6:	00000717          	auipc	a4,0x0
 8fa:	70f73523          	sd	a5,1802(a4) # 1000 <freep>
}
 8fe:	6422                	ld	s0,8(sp)
 900:	0141                	addi	sp,sp,16
 902:	8082                	ret

0000000000000904 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 904:	7139                	addi	sp,sp,-64
 906:	fc06                	sd	ra,56(sp)
 908:	f822                	sd	s0,48(sp)
 90a:	f426                	sd	s1,40(sp)
 90c:	ec4e                	sd	s3,24(sp)
 90e:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 910:	02051493          	slli	s1,a0,0x20
 914:	9081                	srli	s1,s1,0x20
 916:	04bd                	addi	s1,s1,15
 918:	8091                	srli	s1,s1,0x4
 91a:	0014899b          	addiw	s3,s1,1
 91e:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 920:	00000517          	auipc	a0,0x0
 924:	6e053503          	ld	a0,1760(a0) # 1000 <freep>
 928:	c915                	beqz	a0,95c <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 92a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 92c:	4798                	lw	a4,8(a5)
 92e:	08977a63          	bgeu	a4,s1,9c2 <malloc+0xbe>
 932:	f04a                	sd	s2,32(sp)
 934:	e852                	sd	s4,16(sp)
 936:	e456                	sd	s5,8(sp)
 938:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 93a:	8a4e                	mv	s4,s3
 93c:	0009871b          	sext.w	a4,s3
 940:	6685                	lui	a3,0x1
 942:	00d77363          	bgeu	a4,a3,948 <malloc+0x44>
 946:	6a05                	lui	s4,0x1
 948:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 94c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 950:	00000917          	auipc	s2,0x0
 954:	6b090913          	addi	s2,s2,1712 # 1000 <freep>
  if(p == SBRK_ERROR)
 958:	5afd                	li	s5,-1
 95a:	a081                	j	99a <malloc+0x96>
 95c:	f04a                	sd	s2,32(sp)
 95e:	e852                	sd	s4,16(sp)
 960:	e456                	sd	s5,8(sp)
 962:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 964:	00001797          	auipc	a5,0x1
 968:	8a478793          	addi	a5,a5,-1884 # 1208 <base>
 96c:	00000717          	auipc	a4,0x0
 970:	68f73a23          	sd	a5,1684(a4) # 1000 <freep>
 974:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 976:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 97a:	b7c1                	j	93a <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 97c:	6398                	ld	a4,0(a5)
 97e:	e118                	sd	a4,0(a0)
 980:	a8a9                	j	9da <malloc+0xd6>
  hp->s.size = nu;
 982:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 986:	0541                	addi	a0,a0,16
 988:	efbff0ef          	jal	882 <free>
  return freep;
 98c:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 990:	c12d                	beqz	a0,9f2 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 992:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 994:	4798                	lw	a4,8(a5)
 996:	02977263          	bgeu	a4,s1,9ba <malloc+0xb6>
    if(p == freep)
 99a:	00093703          	ld	a4,0(s2)
 99e:	853e                	mv	a0,a5
 9a0:	fef719e3          	bne	a4,a5,992 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 9a4:	8552                	mv	a0,s4
 9a6:	97fff0ef          	jal	324 <sbrk>
  if(p == SBRK_ERROR)
 9aa:	fd551ce3          	bne	a0,s5,982 <malloc+0x7e>
        return 0;
 9ae:	4501                	li	a0,0
 9b0:	7902                	ld	s2,32(sp)
 9b2:	6a42                	ld	s4,16(sp)
 9b4:	6aa2                	ld	s5,8(sp)
 9b6:	6b02                	ld	s6,0(sp)
 9b8:	a03d                	j	9e6 <malloc+0xe2>
 9ba:	7902                	ld	s2,32(sp)
 9bc:	6a42                	ld	s4,16(sp)
 9be:	6aa2                	ld	s5,8(sp)
 9c0:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 9c2:	fae48de3          	beq	s1,a4,97c <malloc+0x78>
        p->s.size -= nunits;
 9c6:	4137073b          	subw	a4,a4,s3
 9ca:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9cc:	02071693          	slli	a3,a4,0x20
 9d0:	01c6d713          	srli	a4,a3,0x1c
 9d4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9d6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9da:	00000717          	auipc	a4,0x0
 9de:	62a73323          	sd	a0,1574(a4) # 1000 <freep>
      return (void*)(p + 1);
 9e2:	01078513          	addi	a0,a5,16
  }
}
 9e6:	70e2                	ld	ra,56(sp)
 9e8:	7442                	ld	s0,48(sp)
 9ea:	74a2                	ld	s1,40(sp)
 9ec:	69e2                	ld	s3,24(sp)
 9ee:	6121                	addi	sp,sp,64
 9f0:	8082                	ret
 9f2:	7902                	ld	s2,32(sp)
 9f4:	6a42                	ld	s4,16(sp)
 9f6:	6aa2                	ld	s5,8(sp)
 9f8:	6b02                	ld	s6,0(sp)
 9fa:	b7f5                	j	9e6 <malloc+0xe2>
