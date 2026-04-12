
user/_wc:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <wc>:
   0:	7119                	addi	sp,sp,-128
   2:	fc86                	sd	ra,120(sp)
   4:	f8a2                	sd	s0,112(sp)
   6:	f4a6                	sd	s1,104(sp)
   8:	f0ca                	sd	s2,96(sp)
   a:	ecce                	sd	s3,88(sp)
   c:	e8d2                	sd	s4,80(sp)
   e:	e4d6                	sd	s5,72(sp)
  10:	e0da                	sd	s6,64(sp)
  12:	fc5e                	sd	s7,56(sp)
  14:	f862                	sd	s8,48(sp)
  16:	f466                	sd	s9,40(sp)
  18:	f06a                	sd	s10,32(sp)
  1a:	ec6e                	sd	s11,24(sp)
  1c:	0100                	addi	s0,sp,128
  1e:	f8a43423          	sd	a0,-120(s0)
  22:	f8b43023          	sd	a1,-128(s0)
  26:	4901                	li	s2,0
  28:	4d01                	li	s10,0
  2a:	4c81                	li	s9,0
  2c:	4c01                	li	s8,0
  2e:	00002d97          	auipc	s11,0x2
  32:	fe2d8d93          	addi	s11,s11,-30 # 2010 <buf>
  36:	4aa9                	li	s5,10
  38:	00001a17          	auipc	s4,0x1
  3c:	a78a0a13          	addi	s4,s4,-1416 # ab0 <malloc+0xfa>
  40:	4b81                	li	s7,0
  42:	a035                	j	6e <wc+0x6e>
  44:	8552                	mv	a0,s4
  46:	1ba000ef          	jal	200 <strchr>
  4a:	c919                	beqz	a0,60 <wc+0x60>
  4c:	895e                	mv	s2,s7
  4e:	0485                	addi	s1,s1,1
  50:	01348d63          	beq	s1,s3,6a <wc+0x6a>
  54:	0004c583          	lbu	a1,0(s1)
  58:	ff5596e3          	bne	a1,s5,44 <wc+0x44>
  5c:	2c05                	addiw	s8,s8,1
  5e:	b7dd                	j	44 <wc+0x44>
  60:	fe0917e3          	bnez	s2,4e <wc+0x4e>
  64:	2c85                	addiw	s9,s9,1
  66:	4905                	li	s2,1
  68:	b7dd                	j	4e <wc+0x4e>
  6a:	01ab0d3b          	addw	s10,s6,s10
  6e:	20000613          	li	a2,512
  72:	85ee                	mv	a1,s11
  74:	f8843503          	ld	a0,-120(s0)
  78:	420000ef          	jal	498 <read>
  7c:	8b2a                	mv	s6,a0
  7e:	00a05963          	blez	a0,90 <wc+0x90>
  82:	00002497          	auipc	s1,0x2
  86:	f8e48493          	addi	s1,s1,-114 # 2010 <buf>
  8a:	009509b3          	add	s3,a0,s1
  8e:	b7d9                	j	54 <wc+0x54>
  90:	02054c63          	bltz	a0,c8 <wc+0xc8>
  94:	f8043703          	ld	a4,-128(s0)
  98:	86ea                	mv	a3,s10
  9a:	8666                	mv	a2,s9
  9c:	85e2                	mv	a1,s8
  9e:	00001517          	auipc	a0,0x1
  a2:	a3250513          	addi	a0,a0,-1486 # ad0 <malloc+0x11a>
  a6:	05d000ef          	jal	902 <printf>
  aa:	70e6                	ld	ra,120(sp)
  ac:	7446                	ld	s0,112(sp)
  ae:	74a6                	ld	s1,104(sp)
  b0:	7906                	ld	s2,96(sp)
  b2:	69e6                	ld	s3,88(sp)
  b4:	6a46                	ld	s4,80(sp)
  b6:	6aa6                	ld	s5,72(sp)
  b8:	6b06                	ld	s6,64(sp)
  ba:	7be2                	ld	s7,56(sp)
  bc:	7c42                	ld	s8,48(sp)
  be:	7ca2                	ld	s9,40(sp)
  c0:	7d02                	ld	s10,32(sp)
  c2:	6de2                	ld	s11,24(sp)
  c4:	6109                	addi	sp,sp,128
  c6:	8082                	ret
  c8:	00001517          	auipc	a0,0x1
  cc:	9f850513          	addi	a0,a0,-1544 # ac0 <malloc+0x10a>
  d0:	033000ef          	jal	902 <printf>
  d4:	4505                	li	a0,1
  d6:	3aa000ef          	jal	480 <exit>

00000000000000da <main>:
  da:	7179                	addi	sp,sp,-48
  dc:	f406                	sd	ra,40(sp)
  de:	f022                	sd	s0,32(sp)
  e0:	1800                	addi	s0,sp,48
  e2:	4785                	li	a5,1
  e4:	04a7d463          	bge	a5,a0,12c <main+0x52>
  e8:	ec26                	sd	s1,24(sp)
  ea:	e84a                	sd	s2,16(sp)
  ec:	e44e                	sd	s3,8(sp)
  ee:	00858913          	addi	s2,a1,8
  f2:	ffe5099b          	addiw	s3,a0,-2
  f6:	02099793          	slli	a5,s3,0x20
  fa:	01d7d993          	srli	s3,a5,0x1d
  fe:	05c1                	addi	a1,a1,16
 100:	99ae                	add	s3,s3,a1
 102:	4581                	li	a1,0
 104:	00093503          	ld	a0,0(s2)
 108:	3b8000ef          	jal	4c0 <open>
 10c:	84aa                	mv	s1,a0
 10e:	02054c63          	bltz	a0,146 <main+0x6c>
 112:	00093583          	ld	a1,0(s2)
 116:	eebff0ef          	jal	0 <wc>
 11a:	8526                	mv	a0,s1
 11c:	38c000ef          	jal	4a8 <close>
 120:	0921                	addi	s2,s2,8
 122:	ff3910e3          	bne	s2,s3,102 <main+0x28>
 126:	4501                	li	a0,0
 128:	358000ef          	jal	480 <exit>
 12c:	ec26                	sd	s1,24(sp)
 12e:	e84a                	sd	s2,16(sp)
 130:	e44e                	sd	s3,8(sp)
 132:	00001597          	auipc	a1,0x1
 136:	98658593          	addi	a1,a1,-1658 # ab8 <malloc+0x102>
 13a:	4501                	li	a0,0
 13c:	ec5ff0ef          	jal	0 <wc>
 140:	4501                	li	a0,0
 142:	33e000ef          	jal	480 <exit>
 146:	00093583          	ld	a1,0(s2)
 14a:	00001517          	auipc	a0,0x1
 14e:	99650513          	addi	a0,a0,-1642 # ae0 <malloc+0x12a>
 152:	7b0000ef          	jal	902 <printf>
 156:	4505                	li	a0,1
 158:	328000ef          	jal	480 <exit>

000000000000015c <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
 15c:	1141                	addi	sp,sp,-16
 15e:	e406                	sd	ra,8(sp)
 160:	e022                	sd	s0,0(sp)
 162:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
 164:	f77ff0ef          	jal	da <main>
  exit(r);
 168:	318000ef          	jal	480 <exit>

000000000000016c <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 16c:	1141                	addi	sp,sp,-16
 16e:	e422                	sd	s0,8(sp)
 170:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 172:	87aa                	mv	a5,a0
 174:	0585                	addi	a1,a1,1
 176:	0785                	addi	a5,a5,1
 178:	fff5c703          	lbu	a4,-1(a1)
 17c:	fee78fa3          	sb	a4,-1(a5)
 180:	fb75                	bnez	a4,174 <strcpy+0x8>
    ;
  return os;
}
 182:	6422                	ld	s0,8(sp)
 184:	0141                	addi	sp,sp,16
 186:	8082                	ret

0000000000000188 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 188:	1141                	addi	sp,sp,-16
 18a:	e422                	sd	s0,8(sp)
 18c:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 18e:	00054783          	lbu	a5,0(a0)
 192:	cb91                	beqz	a5,1a6 <strcmp+0x1e>
 194:	0005c703          	lbu	a4,0(a1)
 198:	00f71763          	bne	a4,a5,1a6 <strcmp+0x1e>
    p++, q++;
 19c:	0505                	addi	a0,a0,1
 19e:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 1a0:	00054783          	lbu	a5,0(a0)
 1a4:	fbe5                	bnez	a5,194 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1a6:	0005c503          	lbu	a0,0(a1)
}
 1aa:	40a7853b          	subw	a0,a5,a0
 1ae:	6422                	ld	s0,8(sp)
 1b0:	0141                	addi	sp,sp,16
 1b2:	8082                	ret

00000000000001b4 <strlen>:

uint
strlen(const char *s)
{
 1b4:	1141                	addi	sp,sp,-16
 1b6:	e422                	sd	s0,8(sp)
 1b8:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1ba:	00054783          	lbu	a5,0(a0)
 1be:	cf91                	beqz	a5,1da <strlen+0x26>
 1c0:	0505                	addi	a0,a0,1
 1c2:	87aa                	mv	a5,a0
 1c4:	86be                	mv	a3,a5
 1c6:	0785                	addi	a5,a5,1
 1c8:	fff7c703          	lbu	a4,-1(a5)
 1cc:	ff65                	bnez	a4,1c4 <strlen+0x10>
 1ce:	40a6853b          	subw	a0,a3,a0
 1d2:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 1d4:	6422                	ld	s0,8(sp)
 1d6:	0141                	addi	sp,sp,16
 1d8:	8082                	ret
  for(n = 0; s[n]; n++)
 1da:	4501                	li	a0,0
 1dc:	bfe5                	j	1d4 <strlen+0x20>

00000000000001de <memset>:

void*
memset(void *dst, int c, uint n)
{
 1de:	1141                	addi	sp,sp,-16
 1e0:	e422                	sd	s0,8(sp)
 1e2:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1e4:	ca19                	beqz	a2,1fa <memset+0x1c>
 1e6:	87aa                	mv	a5,a0
 1e8:	1602                	slli	a2,a2,0x20
 1ea:	9201                	srli	a2,a2,0x20
 1ec:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1f0:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1f4:	0785                	addi	a5,a5,1
 1f6:	fee79de3          	bne	a5,a4,1f0 <memset+0x12>
  }
  return dst;
}
 1fa:	6422                	ld	s0,8(sp)
 1fc:	0141                	addi	sp,sp,16
 1fe:	8082                	ret

0000000000000200 <strchr>:

char*
strchr(const char *s, char c)
{
 200:	1141                	addi	sp,sp,-16
 202:	e422                	sd	s0,8(sp)
 204:	0800                	addi	s0,sp,16
  for(; *s; s++)
 206:	00054783          	lbu	a5,0(a0)
 20a:	cb99                	beqz	a5,220 <strchr+0x20>
    if(*s == c)
 20c:	00f58763          	beq	a1,a5,21a <strchr+0x1a>
  for(; *s; s++)
 210:	0505                	addi	a0,a0,1
 212:	00054783          	lbu	a5,0(a0)
 216:	fbfd                	bnez	a5,20c <strchr+0xc>
      return (char*)s;
  return 0;
 218:	4501                	li	a0,0
}
 21a:	6422                	ld	s0,8(sp)
 21c:	0141                	addi	sp,sp,16
 21e:	8082                	ret
  return 0;
 220:	4501                	li	a0,0
 222:	bfe5                	j	21a <strchr+0x1a>

0000000000000224 <gets>:

char*
gets(char *buf, int max)
{
 224:	711d                	addi	sp,sp,-96
 226:	ec86                	sd	ra,88(sp)
 228:	e8a2                	sd	s0,80(sp)
 22a:	e4a6                	sd	s1,72(sp)
 22c:	e0ca                	sd	s2,64(sp)
 22e:	fc4e                	sd	s3,56(sp)
 230:	f852                	sd	s4,48(sp)
 232:	f456                	sd	s5,40(sp)
 234:	f05a                	sd	s6,32(sp)
 236:	ec5e                	sd	s7,24(sp)
 238:	1080                	addi	s0,sp,96
 23a:	8baa                	mv	s7,a0
 23c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 23e:	892a                	mv	s2,a0
 240:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 242:	4aa9                	li	s5,10
 244:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 246:	89a6                	mv	s3,s1
 248:	2485                	addiw	s1,s1,1
 24a:	0344d663          	bge	s1,s4,276 <gets+0x52>
    cc = read(0, &c, 1);
 24e:	4605                	li	a2,1
 250:	faf40593          	addi	a1,s0,-81
 254:	4501                	li	a0,0
 256:	242000ef          	jal	498 <read>
    if(cc < 1)
 25a:	00a05e63          	blez	a0,276 <gets+0x52>
    buf[i++] = c;
 25e:	faf44783          	lbu	a5,-81(s0)
 262:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 266:	01578763          	beq	a5,s5,274 <gets+0x50>
 26a:	0905                	addi	s2,s2,1
 26c:	fd679de3          	bne	a5,s6,246 <gets+0x22>
    buf[i++] = c;
 270:	89a6                	mv	s3,s1
 272:	a011                	j	276 <gets+0x52>
 274:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 276:	99de                	add	s3,s3,s7
 278:	00098023          	sb	zero,0(s3)
  return buf;
}
 27c:	855e                	mv	a0,s7
 27e:	60e6                	ld	ra,88(sp)
 280:	6446                	ld	s0,80(sp)
 282:	64a6                	ld	s1,72(sp)
 284:	6906                	ld	s2,64(sp)
 286:	79e2                	ld	s3,56(sp)
 288:	7a42                	ld	s4,48(sp)
 28a:	7aa2                	ld	s5,40(sp)
 28c:	7b02                	ld	s6,32(sp)
 28e:	6be2                	ld	s7,24(sp)
 290:	6125                	addi	sp,sp,96
 292:	8082                	ret

0000000000000294 <stat>:

int
stat(const char *n, struct stat *st)
{
 294:	1101                	addi	sp,sp,-32
 296:	ec06                	sd	ra,24(sp)
 298:	e822                	sd	s0,16(sp)
 29a:	e04a                	sd	s2,0(sp)
 29c:	1000                	addi	s0,sp,32
 29e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2a0:	4581                	li	a1,0
 2a2:	21e000ef          	jal	4c0 <open>
  if(fd < 0)
 2a6:	02054263          	bltz	a0,2ca <stat+0x36>
 2aa:	e426                	sd	s1,8(sp)
 2ac:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2ae:	85ca                	mv	a1,s2
 2b0:	228000ef          	jal	4d8 <fstat>
 2b4:	892a                	mv	s2,a0
  close(fd);
 2b6:	8526                	mv	a0,s1
 2b8:	1f0000ef          	jal	4a8 <close>
  return r;
 2bc:	64a2                	ld	s1,8(sp)
}
 2be:	854a                	mv	a0,s2
 2c0:	60e2                	ld	ra,24(sp)
 2c2:	6442                	ld	s0,16(sp)
 2c4:	6902                	ld	s2,0(sp)
 2c6:	6105                	addi	sp,sp,32
 2c8:	8082                	ret
    return -1;
 2ca:	597d                	li	s2,-1
 2cc:	bfcd                	j	2be <stat+0x2a>

00000000000002ce <atoi>:

int
atoi(const char *s)
{
 2ce:	1141                	addi	sp,sp,-16
 2d0:	e422                	sd	s0,8(sp)
 2d2:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2d4:	00054683          	lbu	a3,0(a0)
 2d8:	fd06879b          	addiw	a5,a3,-48
 2dc:	0ff7f793          	zext.b	a5,a5
 2e0:	4625                	li	a2,9
 2e2:	02f66863          	bltu	a2,a5,312 <atoi+0x44>
 2e6:	872a                	mv	a4,a0
  n = 0;
 2e8:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2ea:	0705                	addi	a4,a4,1
 2ec:	0025179b          	slliw	a5,a0,0x2
 2f0:	9fa9                	addw	a5,a5,a0
 2f2:	0017979b          	slliw	a5,a5,0x1
 2f6:	9fb5                	addw	a5,a5,a3
 2f8:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2fc:	00074683          	lbu	a3,0(a4)
 300:	fd06879b          	addiw	a5,a3,-48
 304:	0ff7f793          	zext.b	a5,a5
 308:	fef671e3          	bgeu	a2,a5,2ea <atoi+0x1c>
  return n;
}
 30c:	6422                	ld	s0,8(sp)
 30e:	0141                	addi	sp,sp,16
 310:	8082                	ret
  n = 0;
 312:	4501                	li	a0,0
 314:	bfe5                	j	30c <atoi+0x3e>

0000000000000316 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 316:	1141                	addi	sp,sp,-16
 318:	e422                	sd	s0,8(sp)
 31a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 31c:	02b57463          	bgeu	a0,a1,344 <memmove+0x2e>
    while(n-- > 0)
 320:	00c05f63          	blez	a2,33e <memmove+0x28>
 324:	1602                	slli	a2,a2,0x20
 326:	9201                	srli	a2,a2,0x20
 328:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 32c:	872a                	mv	a4,a0
      *dst++ = *src++;
 32e:	0585                	addi	a1,a1,1
 330:	0705                	addi	a4,a4,1
 332:	fff5c683          	lbu	a3,-1(a1)
 336:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 33a:	fef71ae3          	bne	a4,a5,32e <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 33e:	6422                	ld	s0,8(sp)
 340:	0141                	addi	sp,sp,16
 342:	8082                	ret
    dst += n;
 344:	00c50733          	add	a4,a0,a2
    src += n;
 348:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 34a:	fec05ae3          	blez	a2,33e <memmove+0x28>
 34e:	fff6079b          	addiw	a5,a2,-1
 352:	1782                	slli	a5,a5,0x20
 354:	9381                	srli	a5,a5,0x20
 356:	fff7c793          	not	a5,a5
 35a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 35c:	15fd                	addi	a1,a1,-1
 35e:	177d                	addi	a4,a4,-1
 360:	0005c683          	lbu	a3,0(a1)
 364:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 368:	fee79ae3          	bne	a5,a4,35c <memmove+0x46>
 36c:	bfc9                	j	33e <memmove+0x28>

000000000000036e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 36e:	1141                	addi	sp,sp,-16
 370:	e422                	sd	s0,8(sp)
 372:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 374:	ca05                	beqz	a2,3a4 <memcmp+0x36>
 376:	fff6069b          	addiw	a3,a2,-1
 37a:	1682                	slli	a3,a3,0x20
 37c:	9281                	srli	a3,a3,0x20
 37e:	0685                	addi	a3,a3,1
 380:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 382:	00054783          	lbu	a5,0(a0)
 386:	0005c703          	lbu	a4,0(a1)
 38a:	00e79863          	bne	a5,a4,39a <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 38e:	0505                	addi	a0,a0,1
    p2++;
 390:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 392:	fed518e3          	bne	a0,a3,382 <memcmp+0x14>
  }
  return 0;
 396:	4501                	li	a0,0
 398:	a019                	j	39e <memcmp+0x30>
      return *p1 - *p2;
 39a:	40e7853b          	subw	a0,a5,a4
}
 39e:	6422                	ld	s0,8(sp)
 3a0:	0141                	addi	sp,sp,16
 3a2:	8082                	ret
  return 0;
 3a4:	4501                	li	a0,0
 3a6:	bfe5                	j	39e <memcmp+0x30>

00000000000003a8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3a8:	1141                	addi	sp,sp,-16
 3aa:	e406                	sd	ra,8(sp)
 3ac:	e022                	sd	s0,0(sp)
 3ae:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 3b0:	f67ff0ef          	jal	316 <memmove>
}
 3b4:	60a2                	ld	ra,8(sp)
 3b6:	6402                	ld	s0,0(sp)
 3b8:	0141                	addi	sp,sp,16
 3ba:	8082                	ret

00000000000003bc <sbrk>:

char *
sbrk(int n) {
 3bc:	1141                	addi	sp,sp,-16
 3be:	e406                	sd	ra,8(sp)
 3c0:	e022                	sd	s0,0(sp)
 3c2:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 3c4:	4585                	li	a1,1
 3c6:	142000ef          	jal	508 <sys_sbrk>
}
 3ca:	60a2                	ld	ra,8(sp)
 3cc:	6402                	ld	s0,0(sp)
 3ce:	0141                	addi	sp,sp,16
 3d0:	8082                	ret

00000000000003d2 <sbrklazy>:

char *
sbrklazy(int n) {
 3d2:	1141                	addi	sp,sp,-16
 3d4:	e406                	sd	ra,8(sp)
 3d6:	e022                	sd	s0,0(sp)
 3d8:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 3da:	4589                	li	a1,2
 3dc:	12c000ef          	jal	508 <sys_sbrk>
}
 3e0:	60a2                	ld	ra,8(sp)
 3e2:	6402                	ld	s0,0(sp)
 3e4:	0141                	addi	sp,sp,16
 3e6:	8082                	ret

00000000000003e8 <thread_create>:
// thread_create allocates a page-sized stack, calls clone(fn, arg, stacktop).
// Returns the new thread's pid, or -1 on error.
// The stack is passed back via *stack so the caller can free it after join.
int
thread_create(void(*fn)(void*), void *arg, void **stack)
{
 3e8:	7179                	addi	sp,sp,-48
 3ea:	f406                	sd	ra,40(sp)
 3ec:	f022                	sd	s0,32(sp)
 3ee:	e84a                	sd	s2,16(sp)
 3f0:	e44e                	sd	s3,8(sp)
 3f2:	e052                	sd	s4,0(sp)
 3f4:	1800                	addi	s0,sp,48
 3f6:	89aa                	mv	s3,a0
 3f8:	8a2e                	mv	s4,a1
 3fa:	8932                	mv	s2,a2
  char *s = malloc(PGSIZE);
 3fc:	6505                	lui	a0,0x1
 3fe:	5b8000ef          	jal	9b6 <malloc>
  if(s == 0)
 402:	cd0d                	beqz	a0,43c <thread_create+0x54>
 404:	ec26                	sd	s1,24(sp)
 406:	84aa                	mv	s1,a0
    return -1;
  *stack = s;
 408:	00a93023          	sd	a0,0(s2)
  // Stack grows downward- pass the top of the allocated region.
  int pid = clone(fn, arg, s + PGSIZE);
 40c:	6605                	lui	a2,0x1
 40e:	962a                	add	a2,a2,a0
 410:	85d2                	mv	a1,s4
 412:	854e                	mv	a0,s3
 414:	134000ef          	jal	548 <clone>
  if(pid < 0){
 418:	00054a63          	bltz	a0,42c <thread_create+0x44>
 41c:	64e2                	ld	s1,24(sp)
    free(s);
    *stack = 0;
    return -1;
  }
  return pid;
}
 41e:	70a2                	ld	ra,40(sp)
 420:	7402                	ld	s0,32(sp)
 422:	6942                	ld	s2,16(sp)
 424:	69a2                	ld	s3,8(sp)
 426:	6a02                	ld	s4,0(sp)
 428:	6145                	addi	sp,sp,48
 42a:	8082                	ret
    free(s);
 42c:	8526                	mv	a0,s1
 42e:	506000ef          	jal	934 <free>
    *stack = 0;
 432:	00093023          	sd	zero,0(s2)
    return -1;
 436:	557d                	li	a0,-1
 438:	64e2                	ld	s1,24(sp)
 43a:	b7d5                	j	41e <thread_create+0x36>
    return -1;
 43c:	557d                	li	a0,-1
 43e:	b7c5                	j	41e <thread_create+0x36>

0000000000000440 <thread_join>:
// Wait for any child thread to exit.
// If stack is non-null, frees the memory pointed to by *stack and clears it.
// Returns the joined thread's pid, or -1 Son error.
int
thread_join(void **stack)
{
 440:	1101                	addi	sp,sp,-32
 442:	ec06                	sd	ra,24(sp)
 444:	e822                	sd	s0,16(sp)
 446:	e426                	sd	s1,8(sp)
 448:	e04a                	sd	s2,0(sp)
 44a:	1000                	addi	s0,sp,32
 44c:	84aa                	mv	s1,a0
  int pid = join();
 44e:	102000ef          	jal	550 <join>
  if(pid < 0)
 452:	02054163          	bltz	a0,474 <thread_join+0x34>
 456:	892a                	mv	s2,a0
    return -1;
  if(stack && *stack){
 458:	c499                	beqz	s1,466 <thread_join+0x26>
 45a:	6088                	ld	a0,0(s1)
 45c:	c509                	beqz	a0,466 <thread_join+0x26>
    free(*stack);
 45e:	4d6000ef          	jal	934 <free>
    *stack = 0;
 462:	0004b023          	sd	zero,0(s1)
  }
  return pid;
}
 466:	854a                	mv	a0,s2
 468:	60e2                	ld	ra,24(sp)
 46a:	6442                	ld	s0,16(sp)
 46c:	64a2                	ld	s1,8(sp)
 46e:	6902                	ld	s2,0(sp)
 470:	6105                	addi	sp,sp,32
 472:	8082                	ret
    return -1;
 474:	597d                	li	s2,-1
 476:	bfc5                	j	466 <thread_join+0x26>

0000000000000478 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 478:	4885                	li	a7,1
 ecall
 47a:	00000073          	ecall
 ret
 47e:	8082                	ret

0000000000000480 <exit>:
.global exit
exit:
 li a7, SYS_exit
 480:	4889                	li	a7,2
 ecall
 482:	00000073          	ecall
 ret
 486:	8082                	ret

0000000000000488 <wait>:
.global wait
wait:
 li a7, SYS_wait
 488:	488d                	li	a7,3
 ecall
 48a:	00000073          	ecall
 ret
 48e:	8082                	ret

0000000000000490 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 490:	4891                	li	a7,4
 ecall
 492:	00000073          	ecall
 ret
 496:	8082                	ret

0000000000000498 <read>:
.global read
read:
 li a7, SYS_read
 498:	4895                	li	a7,5
 ecall
 49a:	00000073          	ecall
 ret
 49e:	8082                	ret

00000000000004a0 <write>:
.global write
write:
 li a7, SYS_write
 4a0:	48c1                	li	a7,16
 ecall
 4a2:	00000073          	ecall
 ret
 4a6:	8082                	ret

00000000000004a8 <close>:
.global close
close:
 li a7, SYS_close
 4a8:	48d5                	li	a7,21
 ecall
 4aa:	00000073          	ecall
 ret
 4ae:	8082                	ret

00000000000004b0 <kill>:
.global kill
kill:
 li a7, SYS_kill
 4b0:	4899                	li	a7,6
 ecall
 4b2:	00000073          	ecall
 ret
 4b6:	8082                	ret

00000000000004b8 <exec>:
.global exec
exec:
 li a7, SYS_exec
 4b8:	489d                	li	a7,7
 ecall
 4ba:	00000073          	ecall
 ret
 4be:	8082                	ret

00000000000004c0 <open>:
.global open
open:
 li a7, SYS_open
 4c0:	48bd                	li	a7,15
 ecall
 4c2:	00000073          	ecall
 ret
 4c6:	8082                	ret

00000000000004c8 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 4c8:	48c5                	li	a7,17
 ecall
 4ca:	00000073          	ecall
 ret
 4ce:	8082                	ret

00000000000004d0 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 4d0:	48c9                	li	a7,18
 ecall
 4d2:	00000073          	ecall
 ret
 4d6:	8082                	ret

00000000000004d8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4d8:	48a1                	li	a7,8
 ecall
 4da:	00000073          	ecall
 ret
 4de:	8082                	ret

00000000000004e0 <link>:
.global link
link:
 li a7, SYS_link
 4e0:	48cd                	li	a7,19
 ecall
 4e2:	00000073          	ecall
 ret
 4e6:	8082                	ret

00000000000004e8 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4e8:	48d1                	li	a7,20
 ecall
 4ea:	00000073          	ecall
 ret
 4ee:	8082                	ret

00000000000004f0 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4f0:	48a5                	li	a7,9
 ecall
 4f2:	00000073          	ecall
 ret
 4f6:	8082                	ret

00000000000004f8 <dup>:
.global dup
dup:
 li a7, SYS_dup
 4f8:	48a9                	li	a7,10
 ecall
 4fa:	00000073          	ecall
 ret
 4fe:	8082                	ret

0000000000000500 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 500:	48ad                	li	a7,11
 ecall
 502:	00000073          	ecall
 ret
 506:	8082                	ret

0000000000000508 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 508:	48b1                	li	a7,12
 ecall
 50a:	00000073          	ecall
 ret
 50e:	8082                	ret

0000000000000510 <pause>:
.global pause
pause:
 li a7, SYS_pause
 510:	48b5                	li	a7,13
 ecall
 512:	00000073          	ecall
 ret
 516:	8082                	ret

0000000000000518 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 518:	48b9                	li	a7,14
 ecall
 51a:	00000073          	ecall
 ret
 51e:	8082                	ret

0000000000000520 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 520:	48d9                	li	a7,22
 ecall
 522:	00000073          	ecall
 ret
 526:	8082                	ret

0000000000000528 <lock_create>:
.global lock_create
lock_create:
 li a7, SYS_lock_create
 528:	48dd                	li	a7,23
 ecall
 52a:	00000073          	ecall
 ret
 52e:	8082                	ret

0000000000000530 <lock_acquire>:
.global lock_acquire
lock_acquire:
 li a7, SYS_lock_acquire
 530:	48e1                	li	a7,24
 ecall
 532:	00000073          	ecall
 ret
 536:	8082                	ret

0000000000000538 <lock_release>:
.global lock_release
lock_release:
 li a7, SYS_lock_release
 538:	48e5                	li	a7,25
 ecall
 53a:	00000073          	ecall
 ret
 53e:	8082                	ret

0000000000000540 <lock_destroy>:
.global lock_destroy
lock_destroy:
 li a7, SYS_lock_destroy
 540:	48e9                	li	a7,26
 ecall
 542:	00000073          	ecall
 ret
 546:	8082                	ret

0000000000000548 <clone>:
.global clone
clone:
 li a7, SYS_clone
 548:	48ed                	li	a7,27
 ecall
 54a:	00000073          	ecall
 ret
 54e:	8082                	ret

0000000000000550 <join>:
.global join
join:
 li a7, SYS_join
 550:	48f1                	li	a7,28
 ecall
 552:	00000073          	ecall
 ret
 556:	8082                	ret

0000000000000558 <getprocessinfo>:
.global getprocessinfo
getprocessinfo:
 li a7, SYS_getprocessinfo
 558:	48f5                	li	a7,29
 ecall
 55a:	00000073          	ecall
 ret
 55e:	8082                	ret

0000000000000560 <shmget>:
.global shmget
shmget:
 li a7, SYS_shmget
 560:	48f9                	li	a7,30
 ecall
 562:	00000073          	ecall
 ret
 566:	8082                	ret

0000000000000568 <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 568:	48fd                	li	a7,31
 ecall
 56a:	00000073          	ecall
 ret
 56e:	8082                	ret

0000000000000570 <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 570:	02000893          	li	a7,32
 ecall
 574:	00000073          	ecall
 ret
 578:	8082                	ret

000000000000057a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 57a:	1101                	addi	sp,sp,-32
 57c:	ec06                	sd	ra,24(sp)
 57e:	e822                	sd	s0,16(sp)
 580:	1000                	addi	s0,sp,32
 582:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 586:	4605                	li	a2,1
 588:	fef40593          	addi	a1,s0,-17
 58c:	f15ff0ef          	jal	4a0 <write>
}
 590:	60e2                	ld	ra,24(sp)
 592:	6442                	ld	s0,16(sp)
 594:	6105                	addi	sp,sp,32
 596:	8082                	ret

0000000000000598 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 598:	715d                	addi	sp,sp,-80
 59a:	e486                	sd	ra,72(sp)
 59c:	e0a2                	sd	s0,64(sp)
 59e:	f84a                	sd	s2,48(sp)
 5a0:	0880                	addi	s0,sp,80
 5a2:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 5a4:	c299                	beqz	a3,5aa <printint+0x12>
 5a6:	0805c363          	bltz	a1,62c <printint+0x94>
  neg = 0;
 5aa:	4881                	li	a7,0
 5ac:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 5b0:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 5b2:	00000517          	auipc	a0,0x0
 5b6:	54e50513          	addi	a0,a0,1358 # b00 <digits>
 5ba:	883e                	mv	a6,a5
 5bc:	2785                	addiw	a5,a5,1
 5be:	02c5f733          	remu	a4,a1,a2
 5c2:	972a                	add	a4,a4,a0
 5c4:	00074703          	lbu	a4,0(a4)
 5c8:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 5cc:	872e                	mv	a4,a1
 5ce:	02c5d5b3          	divu	a1,a1,a2
 5d2:	0685                	addi	a3,a3,1
 5d4:	fec773e3          	bgeu	a4,a2,5ba <printint+0x22>
  if(neg)
 5d8:	00088b63          	beqz	a7,5ee <printint+0x56>
    buf[i++] = '-';
 5dc:	fd078793          	addi	a5,a5,-48
 5e0:	97a2                	add	a5,a5,s0
 5e2:	02d00713          	li	a4,45
 5e6:	fee78423          	sb	a4,-24(a5)
 5ea:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 5ee:	02f05a63          	blez	a5,622 <printint+0x8a>
 5f2:	fc26                	sd	s1,56(sp)
 5f4:	f44e                	sd	s3,40(sp)
 5f6:	fb840713          	addi	a4,s0,-72
 5fa:	00f704b3          	add	s1,a4,a5
 5fe:	fff70993          	addi	s3,a4,-1
 602:	99be                	add	s3,s3,a5
 604:	37fd                	addiw	a5,a5,-1
 606:	1782                	slli	a5,a5,0x20
 608:	9381                	srli	a5,a5,0x20
 60a:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 60e:	fff4c583          	lbu	a1,-1(s1)
 612:	854a                	mv	a0,s2
 614:	f67ff0ef          	jal	57a <putc>
  while(--i >= 0)
 618:	14fd                	addi	s1,s1,-1
 61a:	ff349ae3          	bne	s1,s3,60e <printint+0x76>
 61e:	74e2                	ld	s1,56(sp)
 620:	79a2                	ld	s3,40(sp)
}
 622:	60a6                	ld	ra,72(sp)
 624:	6406                	ld	s0,64(sp)
 626:	7942                	ld	s2,48(sp)
 628:	6161                	addi	sp,sp,80
 62a:	8082                	ret
    x = -xx;
 62c:	40b005b3          	neg	a1,a1
    neg = 1;
 630:	4885                	li	a7,1
    x = -xx;
 632:	bfad                	j	5ac <printint+0x14>

0000000000000634 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 634:	711d                	addi	sp,sp,-96
 636:	ec86                	sd	ra,88(sp)
 638:	e8a2                	sd	s0,80(sp)
 63a:	e0ca                	sd	s2,64(sp)
 63c:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 63e:	0005c903          	lbu	s2,0(a1)
 642:	28090663          	beqz	s2,8ce <vprintf+0x29a>
 646:	e4a6                	sd	s1,72(sp)
 648:	fc4e                	sd	s3,56(sp)
 64a:	f852                	sd	s4,48(sp)
 64c:	f456                	sd	s5,40(sp)
 64e:	f05a                	sd	s6,32(sp)
 650:	ec5e                	sd	s7,24(sp)
 652:	e862                	sd	s8,16(sp)
 654:	e466                	sd	s9,8(sp)
 656:	8b2a                	mv	s6,a0
 658:	8a2e                	mv	s4,a1
 65a:	8bb2                	mv	s7,a2
  state = 0;
 65c:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 65e:	4481                	li	s1,0
 660:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 662:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 666:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 66a:	06c00c93          	li	s9,108
 66e:	a005                	j	68e <vprintf+0x5a>
        putc(fd, c0);
 670:	85ca                	mv	a1,s2
 672:	855a                	mv	a0,s6
 674:	f07ff0ef          	jal	57a <putc>
 678:	a019                	j	67e <vprintf+0x4a>
    } else if(state == '%'){
 67a:	03598263          	beq	s3,s5,69e <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 67e:	2485                	addiw	s1,s1,1
 680:	8726                	mv	a4,s1
 682:	009a07b3          	add	a5,s4,s1
 686:	0007c903          	lbu	s2,0(a5)
 68a:	22090a63          	beqz	s2,8be <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 68e:	0009079b          	sext.w	a5,s2
    if(state == 0){
 692:	fe0994e3          	bnez	s3,67a <vprintf+0x46>
      if(c0 == '%'){
 696:	fd579de3          	bne	a5,s5,670 <vprintf+0x3c>
        state = '%';
 69a:	89be                	mv	s3,a5
 69c:	b7cd                	j	67e <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 69e:	00ea06b3          	add	a3,s4,a4
 6a2:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 6a6:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 6a8:	c681                	beqz	a3,6b0 <vprintf+0x7c>
 6aa:	9752                	add	a4,a4,s4
 6ac:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 6b0:	05878363          	beq	a5,s8,6f6 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 6b4:	05978d63          	beq	a5,s9,70e <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 6b8:	07500713          	li	a4,117
 6bc:	0ee78763          	beq	a5,a4,7aa <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 6c0:	07800713          	li	a4,120
 6c4:	12e78963          	beq	a5,a4,7f6 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 6c8:	07000713          	li	a4,112
 6cc:	14e78e63          	beq	a5,a4,828 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 6d0:	06300713          	li	a4,99
 6d4:	18e78e63          	beq	a5,a4,870 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 6d8:	07300713          	li	a4,115
 6dc:	1ae78463          	beq	a5,a4,884 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 6e0:	02500713          	li	a4,37
 6e4:	04e79563          	bne	a5,a4,72e <vprintf+0xfa>
        putc(fd, '%');
 6e8:	02500593          	li	a1,37
 6ec:	855a                	mv	a0,s6
 6ee:	e8dff0ef          	jal	57a <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 6f2:	4981                	li	s3,0
 6f4:	b769                	j	67e <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 6f6:	008b8913          	addi	s2,s7,8
 6fa:	4685                	li	a3,1
 6fc:	4629                	li	a2,10
 6fe:	000ba583          	lw	a1,0(s7)
 702:	855a                	mv	a0,s6
 704:	e95ff0ef          	jal	598 <printint>
 708:	8bca                	mv	s7,s2
      state = 0;
 70a:	4981                	li	s3,0
 70c:	bf8d                	j	67e <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 70e:	06400793          	li	a5,100
 712:	02f68963          	beq	a3,a5,744 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 716:	06c00793          	li	a5,108
 71a:	04f68263          	beq	a3,a5,75e <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 71e:	07500793          	li	a5,117
 722:	0af68063          	beq	a3,a5,7c2 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 726:	07800793          	li	a5,120
 72a:	0ef68263          	beq	a3,a5,80e <vprintf+0x1da>
        putc(fd, '%');
 72e:	02500593          	li	a1,37
 732:	855a                	mv	a0,s6
 734:	e47ff0ef          	jal	57a <putc>
        putc(fd, c0);
 738:	85ca                	mv	a1,s2
 73a:	855a                	mv	a0,s6
 73c:	e3fff0ef          	jal	57a <putc>
      state = 0;
 740:	4981                	li	s3,0
 742:	bf35                	j	67e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 744:	008b8913          	addi	s2,s7,8
 748:	4685                	li	a3,1
 74a:	4629                	li	a2,10
 74c:	000bb583          	ld	a1,0(s7)
 750:	855a                	mv	a0,s6
 752:	e47ff0ef          	jal	598 <printint>
        i += 1;
 756:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 758:	8bca                	mv	s7,s2
      state = 0;
 75a:	4981                	li	s3,0
        i += 1;
 75c:	b70d                	j	67e <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 75e:	06400793          	li	a5,100
 762:	02f60763          	beq	a2,a5,790 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 766:	07500793          	li	a5,117
 76a:	06f60963          	beq	a2,a5,7dc <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 76e:	07800793          	li	a5,120
 772:	faf61ee3          	bne	a2,a5,72e <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 776:	008b8913          	addi	s2,s7,8
 77a:	4681                	li	a3,0
 77c:	4641                	li	a2,16
 77e:	000bb583          	ld	a1,0(s7)
 782:	855a                	mv	a0,s6
 784:	e15ff0ef          	jal	598 <printint>
        i += 2;
 788:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 78a:	8bca                	mv	s7,s2
      state = 0;
 78c:	4981                	li	s3,0
        i += 2;
 78e:	bdc5                	j	67e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 790:	008b8913          	addi	s2,s7,8
 794:	4685                	li	a3,1
 796:	4629                	li	a2,10
 798:	000bb583          	ld	a1,0(s7)
 79c:	855a                	mv	a0,s6
 79e:	dfbff0ef          	jal	598 <printint>
        i += 2;
 7a2:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 7a4:	8bca                	mv	s7,s2
      state = 0;
 7a6:	4981                	li	s3,0
        i += 2;
 7a8:	bdd9                	j	67e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 7aa:	008b8913          	addi	s2,s7,8
 7ae:	4681                	li	a3,0
 7b0:	4629                	li	a2,10
 7b2:	000be583          	lwu	a1,0(s7)
 7b6:	855a                	mv	a0,s6
 7b8:	de1ff0ef          	jal	598 <printint>
 7bc:	8bca                	mv	s7,s2
      state = 0;
 7be:	4981                	li	s3,0
 7c0:	bd7d                	j	67e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7c2:	008b8913          	addi	s2,s7,8
 7c6:	4681                	li	a3,0
 7c8:	4629                	li	a2,10
 7ca:	000bb583          	ld	a1,0(s7)
 7ce:	855a                	mv	a0,s6
 7d0:	dc9ff0ef          	jal	598 <printint>
        i += 1;
 7d4:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 7d6:	8bca                	mv	s7,s2
      state = 0;
 7d8:	4981                	li	s3,0
        i += 1;
 7da:	b555                	j	67e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7dc:	008b8913          	addi	s2,s7,8
 7e0:	4681                	li	a3,0
 7e2:	4629                	li	a2,10
 7e4:	000bb583          	ld	a1,0(s7)
 7e8:	855a                	mv	a0,s6
 7ea:	dafff0ef          	jal	598 <printint>
        i += 2;
 7ee:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 7f0:	8bca                	mv	s7,s2
      state = 0;
 7f2:	4981                	li	s3,0
        i += 2;
 7f4:	b569                	j	67e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 7f6:	008b8913          	addi	s2,s7,8
 7fa:	4681                	li	a3,0
 7fc:	4641                	li	a2,16
 7fe:	000be583          	lwu	a1,0(s7)
 802:	855a                	mv	a0,s6
 804:	d95ff0ef          	jal	598 <printint>
 808:	8bca                	mv	s7,s2
      state = 0;
 80a:	4981                	li	s3,0
 80c:	bd8d                	j	67e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 80e:	008b8913          	addi	s2,s7,8
 812:	4681                	li	a3,0
 814:	4641                	li	a2,16
 816:	000bb583          	ld	a1,0(s7)
 81a:	855a                	mv	a0,s6
 81c:	d7dff0ef          	jal	598 <printint>
        i += 1;
 820:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 822:	8bca                	mv	s7,s2
      state = 0;
 824:	4981                	li	s3,0
        i += 1;
 826:	bda1                	j	67e <vprintf+0x4a>
 828:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 82a:	008b8d13          	addi	s10,s7,8
 82e:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 832:	03000593          	li	a1,48
 836:	855a                	mv	a0,s6
 838:	d43ff0ef          	jal	57a <putc>
  putc(fd, 'x');
 83c:	07800593          	li	a1,120
 840:	855a                	mv	a0,s6
 842:	d39ff0ef          	jal	57a <putc>
 846:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 848:	00000b97          	auipc	s7,0x0
 84c:	2b8b8b93          	addi	s7,s7,696 # b00 <digits>
 850:	03c9d793          	srli	a5,s3,0x3c
 854:	97de                	add	a5,a5,s7
 856:	0007c583          	lbu	a1,0(a5)
 85a:	855a                	mv	a0,s6
 85c:	d1fff0ef          	jal	57a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 860:	0992                	slli	s3,s3,0x4
 862:	397d                	addiw	s2,s2,-1
 864:	fe0916e3          	bnez	s2,850 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 868:	8bea                	mv	s7,s10
      state = 0;
 86a:	4981                	li	s3,0
 86c:	6d02                	ld	s10,0(sp)
 86e:	bd01                	j	67e <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 870:	008b8913          	addi	s2,s7,8
 874:	000bc583          	lbu	a1,0(s7)
 878:	855a                	mv	a0,s6
 87a:	d01ff0ef          	jal	57a <putc>
 87e:	8bca                	mv	s7,s2
      state = 0;
 880:	4981                	li	s3,0
 882:	bbf5                	j	67e <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 884:	008b8993          	addi	s3,s7,8
 888:	000bb903          	ld	s2,0(s7)
 88c:	00090f63          	beqz	s2,8aa <vprintf+0x276>
        for(; *s; s++)
 890:	00094583          	lbu	a1,0(s2)
 894:	c195                	beqz	a1,8b8 <vprintf+0x284>
          putc(fd, *s);
 896:	855a                	mv	a0,s6
 898:	ce3ff0ef          	jal	57a <putc>
        for(; *s; s++)
 89c:	0905                	addi	s2,s2,1
 89e:	00094583          	lbu	a1,0(s2)
 8a2:	f9f5                	bnez	a1,896 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 8a4:	8bce                	mv	s7,s3
      state = 0;
 8a6:	4981                	li	s3,0
 8a8:	bbd9                	j	67e <vprintf+0x4a>
          s = "(null)";
 8aa:	00000917          	auipc	s2,0x0
 8ae:	24e90913          	addi	s2,s2,590 # af8 <malloc+0x142>
        for(; *s; s++)
 8b2:	02800593          	li	a1,40
 8b6:	b7c5                	j	896 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 8b8:	8bce                	mv	s7,s3
      state = 0;
 8ba:	4981                	li	s3,0
 8bc:	b3c9                	j	67e <vprintf+0x4a>
 8be:	64a6                	ld	s1,72(sp)
 8c0:	79e2                	ld	s3,56(sp)
 8c2:	7a42                	ld	s4,48(sp)
 8c4:	7aa2                	ld	s5,40(sp)
 8c6:	7b02                	ld	s6,32(sp)
 8c8:	6be2                	ld	s7,24(sp)
 8ca:	6c42                	ld	s8,16(sp)
 8cc:	6ca2                	ld	s9,8(sp)
    }
  }
}
 8ce:	60e6                	ld	ra,88(sp)
 8d0:	6446                	ld	s0,80(sp)
 8d2:	6906                	ld	s2,64(sp)
 8d4:	6125                	addi	sp,sp,96
 8d6:	8082                	ret

00000000000008d8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8d8:	715d                	addi	sp,sp,-80
 8da:	ec06                	sd	ra,24(sp)
 8dc:	e822                	sd	s0,16(sp)
 8de:	1000                	addi	s0,sp,32
 8e0:	e010                	sd	a2,0(s0)
 8e2:	e414                	sd	a3,8(s0)
 8e4:	e818                	sd	a4,16(s0)
 8e6:	ec1c                	sd	a5,24(s0)
 8e8:	03043023          	sd	a6,32(s0)
 8ec:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8f0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8f4:	8622                	mv	a2,s0
 8f6:	d3fff0ef          	jal	634 <vprintf>
}
 8fa:	60e2                	ld	ra,24(sp)
 8fc:	6442                	ld	s0,16(sp)
 8fe:	6161                	addi	sp,sp,80
 900:	8082                	ret

0000000000000902 <printf>:

void
printf(const char *fmt, ...)
{
 902:	711d                	addi	sp,sp,-96
 904:	ec06                	sd	ra,24(sp)
 906:	e822                	sd	s0,16(sp)
 908:	1000                	addi	s0,sp,32
 90a:	e40c                	sd	a1,8(s0)
 90c:	e810                	sd	a2,16(s0)
 90e:	ec14                	sd	a3,24(s0)
 910:	f018                	sd	a4,32(s0)
 912:	f41c                	sd	a5,40(s0)
 914:	03043823          	sd	a6,48(s0)
 918:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 91c:	00840613          	addi	a2,s0,8
 920:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 924:	85aa                	mv	a1,a0
 926:	4505                	li	a0,1
 928:	d0dff0ef          	jal	634 <vprintf>
}
 92c:	60e2                	ld	ra,24(sp)
 92e:	6442                	ld	s0,16(sp)
 930:	6125                	addi	sp,sp,96
 932:	8082                	ret

0000000000000934 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 934:	1141                	addi	sp,sp,-16
 936:	e422                	sd	s0,8(sp)
 938:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 93a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 93e:	00001797          	auipc	a5,0x1
 942:	6c27b783          	ld	a5,1730(a5) # 2000 <freep>
 946:	a02d                	j	970 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 948:	4618                	lw	a4,8(a2)
 94a:	9f2d                	addw	a4,a4,a1
 94c:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 950:	6398                	ld	a4,0(a5)
 952:	6310                	ld	a2,0(a4)
 954:	a83d                	j	992 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 956:	ff852703          	lw	a4,-8(a0)
 95a:	9f31                	addw	a4,a4,a2
 95c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 95e:	ff053683          	ld	a3,-16(a0)
 962:	a091                	j	9a6 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 964:	6398                	ld	a4,0(a5)
 966:	00e7e463          	bltu	a5,a4,96e <free+0x3a>
 96a:	00e6ea63          	bltu	a3,a4,97e <free+0x4a>
{
 96e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 970:	fed7fae3          	bgeu	a5,a3,964 <free+0x30>
 974:	6398                	ld	a4,0(a5)
 976:	00e6e463          	bltu	a3,a4,97e <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 97a:	fee7eae3          	bltu	a5,a4,96e <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 97e:	ff852583          	lw	a1,-8(a0)
 982:	6390                	ld	a2,0(a5)
 984:	02059813          	slli	a6,a1,0x20
 988:	01c85713          	srli	a4,a6,0x1c
 98c:	9736                	add	a4,a4,a3
 98e:	fae60de3          	beq	a2,a4,948 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 992:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 996:	4790                	lw	a2,8(a5)
 998:	02061593          	slli	a1,a2,0x20
 99c:	01c5d713          	srli	a4,a1,0x1c
 9a0:	973e                	add	a4,a4,a5
 9a2:	fae68ae3          	beq	a3,a4,956 <free+0x22>
    p->s.ptr = bp->s.ptr;
 9a6:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 9a8:	00001717          	auipc	a4,0x1
 9ac:	64f73c23          	sd	a5,1624(a4) # 2000 <freep>
}
 9b0:	6422                	ld	s0,8(sp)
 9b2:	0141                	addi	sp,sp,16
 9b4:	8082                	ret

00000000000009b6 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9b6:	7139                	addi	sp,sp,-64
 9b8:	fc06                	sd	ra,56(sp)
 9ba:	f822                	sd	s0,48(sp)
 9bc:	f426                	sd	s1,40(sp)
 9be:	ec4e                	sd	s3,24(sp)
 9c0:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9c2:	02051493          	slli	s1,a0,0x20
 9c6:	9081                	srli	s1,s1,0x20
 9c8:	04bd                	addi	s1,s1,15
 9ca:	8091                	srli	s1,s1,0x4
 9cc:	0014899b          	addiw	s3,s1,1
 9d0:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 9d2:	00001517          	auipc	a0,0x1
 9d6:	62e53503          	ld	a0,1582(a0) # 2000 <freep>
 9da:	c915                	beqz	a0,a0e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9dc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9de:	4798                	lw	a4,8(a5)
 9e0:	08977a63          	bgeu	a4,s1,a74 <malloc+0xbe>
 9e4:	f04a                	sd	s2,32(sp)
 9e6:	e852                	sd	s4,16(sp)
 9e8:	e456                	sd	s5,8(sp)
 9ea:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 9ec:	8a4e                	mv	s4,s3
 9ee:	0009871b          	sext.w	a4,s3
 9f2:	6685                	lui	a3,0x1
 9f4:	00d77363          	bgeu	a4,a3,9fa <malloc+0x44>
 9f8:	6a05                	lui	s4,0x1
 9fa:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 9fe:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a02:	00001917          	auipc	s2,0x1
 a06:	5fe90913          	addi	s2,s2,1534 # 2000 <freep>
  if(p == SBRK_ERROR)
 a0a:	5afd                	li	s5,-1
 a0c:	a081                	j	a4c <malloc+0x96>
 a0e:	f04a                	sd	s2,32(sp)
 a10:	e852                	sd	s4,16(sp)
 a12:	e456                	sd	s5,8(sp)
 a14:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 a16:	00001797          	auipc	a5,0x1
 a1a:	7fa78793          	addi	a5,a5,2042 # 2210 <base>
 a1e:	00001717          	auipc	a4,0x1
 a22:	5ef73123          	sd	a5,1506(a4) # 2000 <freep>
 a26:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a28:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a2c:	b7c1                	j	9ec <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 a2e:	6398                	ld	a4,0(a5)
 a30:	e118                	sd	a4,0(a0)
 a32:	a8a9                	j	a8c <malloc+0xd6>
  hp->s.size = nu;
 a34:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a38:	0541                	addi	a0,a0,16
 a3a:	efbff0ef          	jal	934 <free>
  return freep;
 a3e:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a42:	c12d                	beqz	a0,aa4 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a44:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a46:	4798                	lw	a4,8(a5)
 a48:	02977263          	bgeu	a4,s1,a6c <malloc+0xb6>
    if(p == freep)
 a4c:	00093703          	ld	a4,0(s2)
 a50:	853e                	mv	a0,a5
 a52:	fef719e3          	bne	a4,a5,a44 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 a56:	8552                	mv	a0,s4
 a58:	965ff0ef          	jal	3bc <sbrk>
  if(p == SBRK_ERROR)
 a5c:	fd551ce3          	bne	a0,s5,a34 <malloc+0x7e>
        return 0;
 a60:	4501                	li	a0,0
 a62:	7902                	ld	s2,32(sp)
 a64:	6a42                	ld	s4,16(sp)
 a66:	6aa2                	ld	s5,8(sp)
 a68:	6b02                	ld	s6,0(sp)
 a6a:	a03d                	j	a98 <malloc+0xe2>
 a6c:	7902                	ld	s2,32(sp)
 a6e:	6a42                	ld	s4,16(sp)
 a70:	6aa2                	ld	s5,8(sp)
 a72:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 a74:	fae48de3          	beq	s1,a4,a2e <malloc+0x78>
        p->s.size -= nunits;
 a78:	4137073b          	subw	a4,a4,s3
 a7c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a7e:	02071693          	slli	a3,a4,0x20
 a82:	01c6d713          	srli	a4,a3,0x1c
 a86:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a88:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a8c:	00001717          	auipc	a4,0x1
 a90:	56a73a23          	sd	a0,1396(a4) # 2000 <freep>
      return (void*)(p + 1);
 a94:	01078513          	addi	a0,a5,16
  }
}
 a98:	70e2                	ld	ra,56(sp)
 a9a:	7442                	ld	s0,48(sp)
 a9c:	74a2                	ld	s1,40(sp)
 a9e:	69e2                	ld	s3,24(sp)
 aa0:	6121                	addi	sp,sp,64
 aa2:	8082                	ret
 aa4:	7902                	ld	s2,32(sp)
 aa6:	6a42                	ld	s4,16(sp)
 aa8:	6aa2                	ld	s5,8(sp)
 aaa:	6b02                	ld	s6,0(sp)
 aac:	b7f5                	j	a98 <malloc+0xe2>
