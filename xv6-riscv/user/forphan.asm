
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
  14:	a1050513          	addi	a0,a0,-1520 # a20 <malloc+0x102>
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
  30:	9f450513          	addi	a0,a0,-1548 # a20 <malloc+0x102>
  34:	404000ef          	jal	438 <unlink>
  38:	04054f63          	bltz	a0,96 <main+0x96>
    printf("%s: unlink failed\n", s);
    exit(1);
  }
  if (open(ff, O_RDONLY) != -1) {
  3c:	4581                	li	a1,0
  3e:	00001517          	auipc	a0,0x1
  42:	9e250513          	addi	a0,a0,-1566 # a20 <malloc+0x102>
  46:	3e2000ef          	jal	428 <open>
  4a:	57fd                	li	a5,-1
  4c:	04f50f63          	beq	a0,a5,aa <main+0xaa>
    printf("%s: open successed\n", s);
  50:	85a6                	mv	a1,s1
  52:	00001517          	auipc	a0,0x1
  56:	a2e50513          	addi	a0,a0,-1490 # a80 <malloc+0x162>
  5a:	011000ef          	jal	86a <printf>
    exit(1);
  5e:	4505                	li	a0,1
  60:	388000ef          	jal	3e8 <exit>
    printf("%s: open failed\n", s);
  64:	85a6                	mv	a1,s1
  66:	00001517          	auipc	a0,0x1
  6a:	9ca50513          	addi	a0,a0,-1590 # a30 <malloc+0x112>
  6e:	7fc000ef          	jal	86a <printf>
    exit(1);
  72:	4505                	li	a0,1
  74:	374000ef          	jal	3e8 <exit>
    fprintf(2, "%s: cannot stat %s\n", s, "ff");
  78:	00001697          	auipc	a3,0x1
  7c:	9d068693          	addi	a3,a3,-1584 # a48 <malloc+0x12a>
  80:	8626                	mv	a2,s1
  82:	00001597          	auipc	a1,0x1
  86:	9ce58593          	addi	a1,a1,-1586 # a50 <malloc+0x132>
  8a:	4509                	li	a0,2
  8c:	7b4000ef          	jal	840 <fprintf>
    exit(1);
  90:	4505                	li	a0,1
  92:	356000ef          	jal	3e8 <exit>
    printf("%s: unlink failed\n", s);
  96:	85a6                	mv	a1,s1
  98:	00001517          	auipc	a0,0x1
  9c:	9d050513          	addi	a0,a0,-1584 # a68 <malloc+0x14a>
  a0:	7ca000ef          	jal	86a <printf>
    exit(1);
  a4:	4505                	li	a0,1
  a6:	342000ef          	jal	3e8 <exit>
  }
  printf("wait for kill and reclaim %d\n", st.ino);
  aa:	fcc42583          	lw	a1,-52(s0)
  ae:	00001517          	auipc	a0,0x1
  b2:	9ea50513          	addi	a0,a0,-1558 # a98 <malloc+0x17a>
  b6:	7b4000ef          	jal	86a <printf>
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
 366:	5b8000ef          	jal	91e <malloc>
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
 396:	506000ef          	jal	89c <free>
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
 3c6:	4d6000ef          	jal	89c <free>
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

00000000000004c8 <shmget>:
.global shmget
shmget:
 li a7, SYS_shmget
 4c8:	48f9                	li	a7,30
 ecall
 4ca:	00000073          	ecall
 ret
 4ce:	8082                	ret

00000000000004d0 <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 4d0:	48fd                	li	a7,31
 ecall
 4d2:	00000073          	ecall
 ret
 4d6:	8082                	ret

00000000000004d8 <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 4d8:	02000893          	li	a7,32
 ecall
 4dc:	00000073          	ecall
 ret
 4e0:	8082                	ret

00000000000004e2 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4e2:	1101                	addi	sp,sp,-32
 4e4:	ec06                	sd	ra,24(sp)
 4e6:	e822                	sd	s0,16(sp)
 4e8:	1000                	addi	s0,sp,32
 4ea:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4ee:	4605                	li	a2,1
 4f0:	fef40593          	addi	a1,s0,-17
 4f4:	f15ff0ef          	jal	408 <write>
}
 4f8:	60e2                	ld	ra,24(sp)
 4fa:	6442                	ld	s0,16(sp)
 4fc:	6105                	addi	sp,sp,32
 4fe:	8082                	ret

0000000000000500 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 500:	715d                	addi	sp,sp,-80
 502:	e486                	sd	ra,72(sp)
 504:	e0a2                	sd	s0,64(sp)
 506:	f84a                	sd	s2,48(sp)
 508:	0880                	addi	s0,sp,80
 50a:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 50c:	c299                	beqz	a3,512 <printint+0x12>
 50e:	0805c363          	bltz	a1,594 <printint+0x94>
  neg = 0;
 512:	4881                	li	a7,0
 514:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 518:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 51a:	00000517          	auipc	a0,0x0
 51e:	5a650513          	addi	a0,a0,1446 # ac0 <digits>
 522:	883e                	mv	a6,a5
 524:	2785                	addiw	a5,a5,1
 526:	02c5f733          	remu	a4,a1,a2
 52a:	972a                	add	a4,a4,a0
 52c:	00074703          	lbu	a4,0(a4)
 530:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 534:	872e                	mv	a4,a1
 536:	02c5d5b3          	divu	a1,a1,a2
 53a:	0685                	addi	a3,a3,1
 53c:	fec773e3          	bgeu	a4,a2,522 <printint+0x22>
  if(neg)
 540:	00088b63          	beqz	a7,556 <printint+0x56>
    buf[i++] = '-';
 544:	fd078793          	addi	a5,a5,-48
 548:	97a2                	add	a5,a5,s0
 54a:	02d00713          	li	a4,45
 54e:	fee78423          	sb	a4,-24(a5)
 552:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 556:	02f05a63          	blez	a5,58a <printint+0x8a>
 55a:	fc26                	sd	s1,56(sp)
 55c:	f44e                	sd	s3,40(sp)
 55e:	fb840713          	addi	a4,s0,-72
 562:	00f704b3          	add	s1,a4,a5
 566:	fff70993          	addi	s3,a4,-1
 56a:	99be                	add	s3,s3,a5
 56c:	37fd                	addiw	a5,a5,-1
 56e:	1782                	slli	a5,a5,0x20
 570:	9381                	srli	a5,a5,0x20
 572:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 576:	fff4c583          	lbu	a1,-1(s1)
 57a:	854a                	mv	a0,s2
 57c:	f67ff0ef          	jal	4e2 <putc>
  while(--i >= 0)
 580:	14fd                	addi	s1,s1,-1
 582:	ff349ae3          	bne	s1,s3,576 <printint+0x76>
 586:	74e2                	ld	s1,56(sp)
 588:	79a2                	ld	s3,40(sp)
}
 58a:	60a6                	ld	ra,72(sp)
 58c:	6406                	ld	s0,64(sp)
 58e:	7942                	ld	s2,48(sp)
 590:	6161                	addi	sp,sp,80
 592:	8082                	ret
    x = -xx;
 594:	40b005b3          	neg	a1,a1
    neg = 1;
 598:	4885                	li	a7,1
    x = -xx;
 59a:	bfad                	j	514 <printint+0x14>

000000000000059c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 59c:	711d                	addi	sp,sp,-96
 59e:	ec86                	sd	ra,88(sp)
 5a0:	e8a2                	sd	s0,80(sp)
 5a2:	e0ca                	sd	s2,64(sp)
 5a4:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5a6:	0005c903          	lbu	s2,0(a1)
 5aa:	28090663          	beqz	s2,836 <vprintf+0x29a>
 5ae:	e4a6                	sd	s1,72(sp)
 5b0:	fc4e                	sd	s3,56(sp)
 5b2:	f852                	sd	s4,48(sp)
 5b4:	f456                	sd	s5,40(sp)
 5b6:	f05a                	sd	s6,32(sp)
 5b8:	ec5e                	sd	s7,24(sp)
 5ba:	e862                	sd	s8,16(sp)
 5bc:	e466                	sd	s9,8(sp)
 5be:	8b2a                	mv	s6,a0
 5c0:	8a2e                	mv	s4,a1
 5c2:	8bb2                	mv	s7,a2
  state = 0;
 5c4:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 5c6:	4481                	li	s1,0
 5c8:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 5ca:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 5ce:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 5d2:	06c00c93          	li	s9,108
 5d6:	a005                	j	5f6 <vprintf+0x5a>
        putc(fd, c0);
 5d8:	85ca                	mv	a1,s2
 5da:	855a                	mv	a0,s6
 5dc:	f07ff0ef          	jal	4e2 <putc>
 5e0:	a019                	j	5e6 <vprintf+0x4a>
    } else if(state == '%'){
 5e2:	03598263          	beq	s3,s5,606 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 5e6:	2485                	addiw	s1,s1,1
 5e8:	8726                	mv	a4,s1
 5ea:	009a07b3          	add	a5,s4,s1
 5ee:	0007c903          	lbu	s2,0(a5)
 5f2:	22090a63          	beqz	s2,826 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 5f6:	0009079b          	sext.w	a5,s2
    if(state == 0){
 5fa:	fe0994e3          	bnez	s3,5e2 <vprintf+0x46>
      if(c0 == '%'){
 5fe:	fd579de3          	bne	a5,s5,5d8 <vprintf+0x3c>
        state = '%';
 602:	89be                	mv	s3,a5
 604:	b7cd                	j	5e6 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 606:	00ea06b3          	add	a3,s4,a4
 60a:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 60e:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 610:	c681                	beqz	a3,618 <vprintf+0x7c>
 612:	9752                	add	a4,a4,s4
 614:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 618:	05878363          	beq	a5,s8,65e <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 61c:	05978d63          	beq	a5,s9,676 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 620:	07500713          	li	a4,117
 624:	0ee78763          	beq	a5,a4,712 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 628:	07800713          	li	a4,120
 62c:	12e78963          	beq	a5,a4,75e <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 630:	07000713          	li	a4,112
 634:	14e78e63          	beq	a5,a4,790 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 638:	06300713          	li	a4,99
 63c:	18e78e63          	beq	a5,a4,7d8 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 640:	07300713          	li	a4,115
 644:	1ae78463          	beq	a5,a4,7ec <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 648:	02500713          	li	a4,37
 64c:	04e79563          	bne	a5,a4,696 <vprintf+0xfa>
        putc(fd, '%');
 650:	02500593          	li	a1,37
 654:	855a                	mv	a0,s6
 656:	e8dff0ef          	jal	4e2 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 65a:	4981                	li	s3,0
 65c:	b769                	j	5e6 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 65e:	008b8913          	addi	s2,s7,8
 662:	4685                	li	a3,1
 664:	4629                	li	a2,10
 666:	000ba583          	lw	a1,0(s7)
 66a:	855a                	mv	a0,s6
 66c:	e95ff0ef          	jal	500 <printint>
 670:	8bca                	mv	s7,s2
      state = 0;
 672:	4981                	li	s3,0
 674:	bf8d                	j	5e6 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 676:	06400793          	li	a5,100
 67a:	02f68963          	beq	a3,a5,6ac <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 67e:	06c00793          	li	a5,108
 682:	04f68263          	beq	a3,a5,6c6 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 686:	07500793          	li	a5,117
 68a:	0af68063          	beq	a3,a5,72a <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 68e:	07800793          	li	a5,120
 692:	0ef68263          	beq	a3,a5,776 <vprintf+0x1da>
        putc(fd, '%');
 696:	02500593          	li	a1,37
 69a:	855a                	mv	a0,s6
 69c:	e47ff0ef          	jal	4e2 <putc>
        putc(fd, c0);
 6a0:	85ca                	mv	a1,s2
 6a2:	855a                	mv	a0,s6
 6a4:	e3fff0ef          	jal	4e2 <putc>
      state = 0;
 6a8:	4981                	li	s3,0
 6aa:	bf35                	j	5e6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6ac:	008b8913          	addi	s2,s7,8
 6b0:	4685                	li	a3,1
 6b2:	4629                	li	a2,10
 6b4:	000bb583          	ld	a1,0(s7)
 6b8:	855a                	mv	a0,s6
 6ba:	e47ff0ef          	jal	500 <printint>
        i += 1;
 6be:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 6c0:	8bca                	mv	s7,s2
      state = 0;
 6c2:	4981                	li	s3,0
        i += 1;
 6c4:	b70d                	j	5e6 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6c6:	06400793          	li	a5,100
 6ca:	02f60763          	beq	a2,a5,6f8 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 6ce:	07500793          	li	a5,117
 6d2:	06f60963          	beq	a2,a5,744 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 6d6:	07800793          	li	a5,120
 6da:	faf61ee3          	bne	a2,a5,696 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6de:	008b8913          	addi	s2,s7,8
 6e2:	4681                	li	a3,0
 6e4:	4641                	li	a2,16
 6e6:	000bb583          	ld	a1,0(s7)
 6ea:	855a                	mv	a0,s6
 6ec:	e15ff0ef          	jal	500 <printint>
        i += 2;
 6f0:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 6f2:	8bca                	mv	s7,s2
      state = 0;
 6f4:	4981                	li	s3,0
        i += 2;
 6f6:	bdc5                	j	5e6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6f8:	008b8913          	addi	s2,s7,8
 6fc:	4685                	li	a3,1
 6fe:	4629                	li	a2,10
 700:	000bb583          	ld	a1,0(s7)
 704:	855a                	mv	a0,s6
 706:	dfbff0ef          	jal	500 <printint>
        i += 2;
 70a:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 70c:	8bca                	mv	s7,s2
      state = 0;
 70e:	4981                	li	s3,0
        i += 2;
 710:	bdd9                	j	5e6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 712:	008b8913          	addi	s2,s7,8
 716:	4681                	li	a3,0
 718:	4629                	li	a2,10
 71a:	000be583          	lwu	a1,0(s7)
 71e:	855a                	mv	a0,s6
 720:	de1ff0ef          	jal	500 <printint>
 724:	8bca                	mv	s7,s2
      state = 0;
 726:	4981                	li	s3,0
 728:	bd7d                	j	5e6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 72a:	008b8913          	addi	s2,s7,8
 72e:	4681                	li	a3,0
 730:	4629                	li	a2,10
 732:	000bb583          	ld	a1,0(s7)
 736:	855a                	mv	a0,s6
 738:	dc9ff0ef          	jal	500 <printint>
        i += 1;
 73c:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 73e:	8bca                	mv	s7,s2
      state = 0;
 740:	4981                	li	s3,0
        i += 1;
 742:	b555                	j	5e6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 744:	008b8913          	addi	s2,s7,8
 748:	4681                	li	a3,0
 74a:	4629                	li	a2,10
 74c:	000bb583          	ld	a1,0(s7)
 750:	855a                	mv	a0,s6
 752:	dafff0ef          	jal	500 <printint>
        i += 2;
 756:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 758:	8bca                	mv	s7,s2
      state = 0;
 75a:	4981                	li	s3,0
        i += 2;
 75c:	b569                	j	5e6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 75e:	008b8913          	addi	s2,s7,8
 762:	4681                	li	a3,0
 764:	4641                	li	a2,16
 766:	000be583          	lwu	a1,0(s7)
 76a:	855a                	mv	a0,s6
 76c:	d95ff0ef          	jal	500 <printint>
 770:	8bca                	mv	s7,s2
      state = 0;
 772:	4981                	li	s3,0
 774:	bd8d                	j	5e6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 776:	008b8913          	addi	s2,s7,8
 77a:	4681                	li	a3,0
 77c:	4641                	li	a2,16
 77e:	000bb583          	ld	a1,0(s7)
 782:	855a                	mv	a0,s6
 784:	d7dff0ef          	jal	500 <printint>
        i += 1;
 788:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 78a:	8bca                	mv	s7,s2
      state = 0;
 78c:	4981                	li	s3,0
        i += 1;
 78e:	bda1                	j	5e6 <vprintf+0x4a>
 790:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 792:	008b8d13          	addi	s10,s7,8
 796:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 79a:	03000593          	li	a1,48
 79e:	855a                	mv	a0,s6
 7a0:	d43ff0ef          	jal	4e2 <putc>
  putc(fd, 'x');
 7a4:	07800593          	li	a1,120
 7a8:	855a                	mv	a0,s6
 7aa:	d39ff0ef          	jal	4e2 <putc>
 7ae:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7b0:	00000b97          	auipc	s7,0x0
 7b4:	310b8b93          	addi	s7,s7,784 # ac0 <digits>
 7b8:	03c9d793          	srli	a5,s3,0x3c
 7bc:	97de                	add	a5,a5,s7
 7be:	0007c583          	lbu	a1,0(a5)
 7c2:	855a                	mv	a0,s6
 7c4:	d1fff0ef          	jal	4e2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7c8:	0992                	slli	s3,s3,0x4
 7ca:	397d                	addiw	s2,s2,-1
 7cc:	fe0916e3          	bnez	s2,7b8 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 7d0:	8bea                	mv	s7,s10
      state = 0;
 7d2:	4981                	li	s3,0
 7d4:	6d02                	ld	s10,0(sp)
 7d6:	bd01                	j	5e6 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 7d8:	008b8913          	addi	s2,s7,8
 7dc:	000bc583          	lbu	a1,0(s7)
 7e0:	855a                	mv	a0,s6
 7e2:	d01ff0ef          	jal	4e2 <putc>
 7e6:	8bca                	mv	s7,s2
      state = 0;
 7e8:	4981                	li	s3,0
 7ea:	bbf5                	j	5e6 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 7ec:	008b8993          	addi	s3,s7,8
 7f0:	000bb903          	ld	s2,0(s7)
 7f4:	00090f63          	beqz	s2,812 <vprintf+0x276>
        for(; *s; s++)
 7f8:	00094583          	lbu	a1,0(s2)
 7fc:	c195                	beqz	a1,820 <vprintf+0x284>
          putc(fd, *s);
 7fe:	855a                	mv	a0,s6
 800:	ce3ff0ef          	jal	4e2 <putc>
        for(; *s; s++)
 804:	0905                	addi	s2,s2,1
 806:	00094583          	lbu	a1,0(s2)
 80a:	f9f5                	bnez	a1,7fe <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 80c:	8bce                	mv	s7,s3
      state = 0;
 80e:	4981                	li	s3,0
 810:	bbd9                	j	5e6 <vprintf+0x4a>
          s = "(null)";
 812:	00000917          	auipc	s2,0x0
 816:	2a690913          	addi	s2,s2,678 # ab8 <malloc+0x19a>
        for(; *s; s++)
 81a:	02800593          	li	a1,40
 81e:	b7c5                	j	7fe <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 820:	8bce                	mv	s7,s3
      state = 0;
 822:	4981                	li	s3,0
 824:	b3c9                	j	5e6 <vprintf+0x4a>
 826:	64a6                	ld	s1,72(sp)
 828:	79e2                	ld	s3,56(sp)
 82a:	7a42                	ld	s4,48(sp)
 82c:	7aa2                	ld	s5,40(sp)
 82e:	7b02                	ld	s6,32(sp)
 830:	6be2                	ld	s7,24(sp)
 832:	6c42                	ld	s8,16(sp)
 834:	6ca2                	ld	s9,8(sp)
    }
  }
}
 836:	60e6                	ld	ra,88(sp)
 838:	6446                	ld	s0,80(sp)
 83a:	6906                	ld	s2,64(sp)
 83c:	6125                	addi	sp,sp,96
 83e:	8082                	ret

0000000000000840 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 840:	715d                	addi	sp,sp,-80
 842:	ec06                	sd	ra,24(sp)
 844:	e822                	sd	s0,16(sp)
 846:	1000                	addi	s0,sp,32
 848:	e010                	sd	a2,0(s0)
 84a:	e414                	sd	a3,8(s0)
 84c:	e818                	sd	a4,16(s0)
 84e:	ec1c                	sd	a5,24(s0)
 850:	03043023          	sd	a6,32(s0)
 854:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 858:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 85c:	8622                	mv	a2,s0
 85e:	d3fff0ef          	jal	59c <vprintf>
}
 862:	60e2                	ld	ra,24(sp)
 864:	6442                	ld	s0,16(sp)
 866:	6161                	addi	sp,sp,80
 868:	8082                	ret

000000000000086a <printf>:

void
printf(const char *fmt, ...)
{
 86a:	711d                	addi	sp,sp,-96
 86c:	ec06                	sd	ra,24(sp)
 86e:	e822                	sd	s0,16(sp)
 870:	1000                	addi	s0,sp,32
 872:	e40c                	sd	a1,8(s0)
 874:	e810                	sd	a2,16(s0)
 876:	ec14                	sd	a3,24(s0)
 878:	f018                	sd	a4,32(s0)
 87a:	f41c                	sd	a5,40(s0)
 87c:	03043823          	sd	a6,48(s0)
 880:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 884:	00840613          	addi	a2,s0,8
 888:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 88c:	85aa                	mv	a1,a0
 88e:	4505                	li	a0,1
 890:	d0dff0ef          	jal	59c <vprintf>
}
 894:	60e2                	ld	ra,24(sp)
 896:	6442                	ld	s0,16(sp)
 898:	6125                	addi	sp,sp,96
 89a:	8082                	ret

000000000000089c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 89c:	1141                	addi	sp,sp,-16
 89e:	e422                	sd	s0,8(sp)
 8a0:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8a2:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8a6:	00000797          	auipc	a5,0x0
 8aa:	75a7b783          	ld	a5,1882(a5) # 1000 <freep>
 8ae:	a02d                	j	8d8 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8b0:	4618                	lw	a4,8(a2)
 8b2:	9f2d                	addw	a4,a4,a1
 8b4:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8b8:	6398                	ld	a4,0(a5)
 8ba:	6310                	ld	a2,0(a4)
 8bc:	a83d                	j	8fa <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8be:	ff852703          	lw	a4,-8(a0)
 8c2:	9f31                	addw	a4,a4,a2
 8c4:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8c6:	ff053683          	ld	a3,-16(a0)
 8ca:	a091                	j	90e <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8cc:	6398                	ld	a4,0(a5)
 8ce:	00e7e463          	bltu	a5,a4,8d6 <free+0x3a>
 8d2:	00e6ea63          	bltu	a3,a4,8e6 <free+0x4a>
{
 8d6:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8d8:	fed7fae3          	bgeu	a5,a3,8cc <free+0x30>
 8dc:	6398                	ld	a4,0(a5)
 8de:	00e6e463          	bltu	a3,a4,8e6 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8e2:	fee7eae3          	bltu	a5,a4,8d6 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 8e6:	ff852583          	lw	a1,-8(a0)
 8ea:	6390                	ld	a2,0(a5)
 8ec:	02059813          	slli	a6,a1,0x20
 8f0:	01c85713          	srli	a4,a6,0x1c
 8f4:	9736                	add	a4,a4,a3
 8f6:	fae60de3          	beq	a2,a4,8b0 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 8fa:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8fe:	4790                	lw	a2,8(a5)
 900:	02061593          	slli	a1,a2,0x20
 904:	01c5d713          	srli	a4,a1,0x1c
 908:	973e                	add	a4,a4,a5
 90a:	fae68ae3          	beq	a3,a4,8be <free+0x22>
    p->s.ptr = bp->s.ptr;
 90e:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 910:	00000717          	auipc	a4,0x0
 914:	6ef73823          	sd	a5,1776(a4) # 1000 <freep>
}
 918:	6422                	ld	s0,8(sp)
 91a:	0141                	addi	sp,sp,16
 91c:	8082                	ret

000000000000091e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 91e:	7139                	addi	sp,sp,-64
 920:	fc06                	sd	ra,56(sp)
 922:	f822                	sd	s0,48(sp)
 924:	f426                	sd	s1,40(sp)
 926:	ec4e                	sd	s3,24(sp)
 928:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 92a:	02051493          	slli	s1,a0,0x20
 92e:	9081                	srli	s1,s1,0x20
 930:	04bd                	addi	s1,s1,15
 932:	8091                	srli	s1,s1,0x4
 934:	0014899b          	addiw	s3,s1,1
 938:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 93a:	00000517          	auipc	a0,0x0
 93e:	6c653503          	ld	a0,1734(a0) # 1000 <freep>
 942:	c915                	beqz	a0,976 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 944:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 946:	4798                	lw	a4,8(a5)
 948:	08977a63          	bgeu	a4,s1,9dc <malloc+0xbe>
 94c:	f04a                	sd	s2,32(sp)
 94e:	e852                	sd	s4,16(sp)
 950:	e456                	sd	s5,8(sp)
 952:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 954:	8a4e                	mv	s4,s3
 956:	0009871b          	sext.w	a4,s3
 95a:	6685                	lui	a3,0x1
 95c:	00d77363          	bgeu	a4,a3,962 <malloc+0x44>
 960:	6a05                	lui	s4,0x1
 962:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 966:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 96a:	00000917          	auipc	s2,0x0
 96e:	69690913          	addi	s2,s2,1686 # 1000 <freep>
  if(p == SBRK_ERROR)
 972:	5afd                	li	s5,-1
 974:	a081                	j	9b4 <malloc+0x96>
 976:	f04a                	sd	s2,32(sp)
 978:	e852                	sd	s4,16(sp)
 97a:	e456                	sd	s5,8(sp)
 97c:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 97e:	00001797          	auipc	a5,0x1
 982:	88a78793          	addi	a5,a5,-1910 # 1208 <base>
 986:	00000717          	auipc	a4,0x0
 98a:	66f73d23          	sd	a5,1658(a4) # 1000 <freep>
 98e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 990:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 994:	b7c1                	j	954 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 996:	6398                	ld	a4,0(a5)
 998:	e118                	sd	a4,0(a0)
 99a:	a8a9                	j	9f4 <malloc+0xd6>
  hp->s.size = nu;
 99c:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 9a0:	0541                	addi	a0,a0,16
 9a2:	efbff0ef          	jal	89c <free>
  return freep;
 9a6:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9aa:	c12d                	beqz	a0,a0c <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9ac:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9ae:	4798                	lw	a4,8(a5)
 9b0:	02977263          	bgeu	a4,s1,9d4 <malloc+0xb6>
    if(p == freep)
 9b4:	00093703          	ld	a4,0(s2)
 9b8:	853e                	mv	a0,a5
 9ba:	fef719e3          	bne	a4,a5,9ac <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 9be:	8552                	mv	a0,s4
 9c0:	965ff0ef          	jal	324 <sbrk>
  if(p == SBRK_ERROR)
 9c4:	fd551ce3          	bne	a0,s5,99c <malloc+0x7e>
        return 0;
 9c8:	4501                	li	a0,0
 9ca:	7902                	ld	s2,32(sp)
 9cc:	6a42                	ld	s4,16(sp)
 9ce:	6aa2                	ld	s5,8(sp)
 9d0:	6b02                	ld	s6,0(sp)
 9d2:	a03d                	j	a00 <malloc+0xe2>
 9d4:	7902                	ld	s2,32(sp)
 9d6:	6a42                	ld	s4,16(sp)
 9d8:	6aa2                	ld	s5,8(sp)
 9da:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 9dc:	fae48de3          	beq	s1,a4,996 <malloc+0x78>
        p->s.size -= nunits;
 9e0:	4137073b          	subw	a4,a4,s3
 9e4:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9e6:	02071693          	slli	a3,a4,0x20
 9ea:	01c6d713          	srli	a4,a3,0x1c
 9ee:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9f0:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9f4:	00000717          	auipc	a4,0x0
 9f8:	60a73623          	sd	a0,1548(a4) # 1000 <freep>
      return (void*)(p + 1);
 9fc:	01078513          	addi	a0,a5,16
  }
}
 a00:	70e2                	ld	ra,56(sp)
 a02:	7442                	ld	s0,48(sp)
 a04:	74a2                	ld	s1,40(sp)
 a06:	69e2                	ld	s3,24(sp)
 a08:	6121                	addi	sp,sp,64
 a0a:	8082                	ret
 a0c:	7902                	ld	s2,32(sp)
 a0e:	6a42                	ld	s4,16(sp)
 a10:	6aa2                	ld	s5,8(sp)
 a12:	6b02                	ld	s6,0(sp)
 a14:	b7f5                	j	a00 <malloc+0xe2>
