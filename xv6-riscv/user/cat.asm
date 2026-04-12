
user/_cat:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
   e:	89aa                	mv	s3,a0
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
  10:	00001917          	auipc	s2,0x1
  14:	00090913          	mv	s2,s2
  18:	20000613          	li	a2,512
  1c:	85ca                	mv	a1,s2
  1e:	854e                	mv	a0,s3
  20:	406000ef          	jal	426 <read>
  24:	84aa                	mv	s1,a0
  26:	02a05363          	blez	a0,4c <cat+0x4c>
    if (write(1, buf, n) != n) {
  2a:	8626                	mv	a2,s1
  2c:	85ca                	mv	a1,s2
  2e:	4505                	li	a0,1
  30:	3fe000ef          	jal	42e <write>
  34:	fe9502e3          	beq	a0,s1,18 <cat+0x18>
      fprintf(2, "cat: write error\n");
  38:	00001597          	auipc	a1,0x1
  3c:	a0858593          	addi	a1,a1,-1528 # a40 <malloc+0xfc>
  40:	4509                	li	a0,2
  42:	025000ef          	jal	866 <fprintf>
      exit(1);
  46:	4505                	li	a0,1
  48:	3c6000ef          	jal	40e <exit>
    }
  }
  if(n < 0){
  4c:	00054963          	bltz	a0,5e <cat+0x5e>
    fprintf(2, "cat: read error\n");
    exit(1);
  }
}
  50:	70a2                	ld	ra,40(sp)
  52:	7402                	ld	s0,32(sp)
  54:	64e2                	ld	s1,24(sp)
  56:	6942                	ld	s2,16(sp)
  58:	69a2                	ld	s3,8(sp)
  5a:	6145                	addi	sp,sp,48
  5c:	8082                	ret
    fprintf(2, "cat: read error\n");
  5e:	00001597          	auipc	a1,0x1
  62:	9fa58593          	addi	a1,a1,-1542 # a58 <malloc+0x114>
  66:	4509                	li	a0,2
  68:	7fe000ef          	jal	866 <fprintf>
    exit(1);
  6c:	4505                	li	a0,1
  6e:	3a0000ef          	jal	40e <exit>

0000000000000072 <main>:

int
main(int argc, char *argv[])
{
  72:	7179                	addi	sp,sp,-48
  74:	f406                	sd	ra,40(sp)
  76:	f022                	sd	s0,32(sp)
  78:	1800                	addi	s0,sp,48
  int fd, i;

  if(argc <= 1){
  7a:	4785                	li	a5,1
  7c:	04a7d263          	bge	a5,a0,c0 <main+0x4e>
  80:	ec26                	sd	s1,24(sp)
  82:	e84a                	sd	s2,16(sp)
  84:	e44e                	sd	s3,8(sp)
  86:	00858913          	addi	s2,a1,8
  8a:	ffe5099b          	addiw	s3,a0,-2
  8e:	02099793          	slli	a5,s3,0x20
  92:	01d7d993          	srli	s3,a5,0x1d
  96:	05c1                	addi	a1,a1,16
  98:	99ae                	add	s3,s3,a1
    cat(0);
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], O_RDONLY)) < 0){
  9a:	4581                	li	a1,0
  9c:	00093503          	ld	a0,0(s2) # 1010 <buf>
  a0:	3ae000ef          	jal	44e <open>
  a4:	84aa                	mv	s1,a0
  a6:	02054663          	bltz	a0,d2 <main+0x60>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
      exit(1);
    }
    cat(fd);
  aa:	f57ff0ef          	jal	0 <cat>
    close(fd);
  ae:	8526                	mv	a0,s1
  b0:	386000ef          	jal	436 <close>
  for(i = 1; i < argc; i++){
  b4:	0921                	addi	s2,s2,8
  b6:	ff3912e3          	bne	s2,s3,9a <main+0x28>
  }
  exit(0);
  ba:	4501                	li	a0,0
  bc:	352000ef          	jal	40e <exit>
  c0:	ec26                	sd	s1,24(sp)
  c2:	e84a                	sd	s2,16(sp)
  c4:	e44e                	sd	s3,8(sp)
    cat(0);
  c6:	4501                	li	a0,0
  c8:	f39ff0ef          	jal	0 <cat>
    exit(0);
  cc:	4501                	li	a0,0
  ce:	340000ef          	jal	40e <exit>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
  d2:	00093603          	ld	a2,0(s2)
  d6:	00001597          	auipc	a1,0x1
  da:	99a58593          	addi	a1,a1,-1638 # a70 <malloc+0x12c>
  de:	4509                	li	a0,2
  e0:	786000ef          	jal	866 <fprintf>
      exit(1);
  e4:	4505                	li	a0,1
  e6:	328000ef          	jal	40e <exit>

00000000000000ea <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  ea:	1141                	addi	sp,sp,-16
  ec:	e406                	sd	ra,8(sp)
  ee:	e022                	sd	s0,0(sp)
  f0:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  f2:	f81ff0ef          	jal	72 <main>
  exit(r);
  f6:	318000ef          	jal	40e <exit>

00000000000000fa <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  fa:	1141                	addi	sp,sp,-16
  fc:	e422                	sd	s0,8(sp)
  fe:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 100:	87aa                	mv	a5,a0
 102:	0585                	addi	a1,a1,1
 104:	0785                	addi	a5,a5,1
 106:	fff5c703          	lbu	a4,-1(a1)
 10a:	fee78fa3          	sb	a4,-1(a5)
 10e:	fb75                	bnez	a4,102 <strcpy+0x8>
    ;
  return os;
}
 110:	6422                	ld	s0,8(sp)
 112:	0141                	addi	sp,sp,16
 114:	8082                	ret

0000000000000116 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 116:	1141                	addi	sp,sp,-16
 118:	e422                	sd	s0,8(sp)
 11a:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 11c:	00054783          	lbu	a5,0(a0)
 120:	cb91                	beqz	a5,134 <strcmp+0x1e>
 122:	0005c703          	lbu	a4,0(a1)
 126:	00f71763          	bne	a4,a5,134 <strcmp+0x1e>
    p++, q++;
 12a:	0505                	addi	a0,a0,1
 12c:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 12e:	00054783          	lbu	a5,0(a0)
 132:	fbe5                	bnez	a5,122 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 134:	0005c503          	lbu	a0,0(a1)
}
 138:	40a7853b          	subw	a0,a5,a0
 13c:	6422                	ld	s0,8(sp)
 13e:	0141                	addi	sp,sp,16
 140:	8082                	ret

0000000000000142 <strlen>:

uint
strlen(const char *s)
{
 142:	1141                	addi	sp,sp,-16
 144:	e422                	sd	s0,8(sp)
 146:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 148:	00054783          	lbu	a5,0(a0)
 14c:	cf91                	beqz	a5,168 <strlen+0x26>
 14e:	0505                	addi	a0,a0,1
 150:	87aa                	mv	a5,a0
 152:	86be                	mv	a3,a5
 154:	0785                	addi	a5,a5,1
 156:	fff7c703          	lbu	a4,-1(a5)
 15a:	ff65                	bnez	a4,152 <strlen+0x10>
 15c:	40a6853b          	subw	a0,a3,a0
 160:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 162:	6422                	ld	s0,8(sp)
 164:	0141                	addi	sp,sp,16
 166:	8082                	ret
  for(n = 0; s[n]; n++)
 168:	4501                	li	a0,0
 16a:	bfe5                	j	162 <strlen+0x20>

000000000000016c <memset>:

void*
memset(void *dst, int c, uint n)
{
 16c:	1141                	addi	sp,sp,-16
 16e:	e422                	sd	s0,8(sp)
 170:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 172:	ca19                	beqz	a2,188 <memset+0x1c>
 174:	87aa                	mv	a5,a0
 176:	1602                	slli	a2,a2,0x20
 178:	9201                	srli	a2,a2,0x20
 17a:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 17e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 182:	0785                	addi	a5,a5,1
 184:	fee79de3          	bne	a5,a4,17e <memset+0x12>
  }
  return dst;
}
 188:	6422                	ld	s0,8(sp)
 18a:	0141                	addi	sp,sp,16
 18c:	8082                	ret

000000000000018e <strchr>:

char*
strchr(const char *s, char c)
{
 18e:	1141                	addi	sp,sp,-16
 190:	e422                	sd	s0,8(sp)
 192:	0800                	addi	s0,sp,16
  for(; *s; s++)
 194:	00054783          	lbu	a5,0(a0)
 198:	cb99                	beqz	a5,1ae <strchr+0x20>
    if(*s == c)
 19a:	00f58763          	beq	a1,a5,1a8 <strchr+0x1a>
  for(; *s; s++)
 19e:	0505                	addi	a0,a0,1
 1a0:	00054783          	lbu	a5,0(a0)
 1a4:	fbfd                	bnez	a5,19a <strchr+0xc>
      return (char*)s;
  return 0;
 1a6:	4501                	li	a0,0
}
 1a8:	6422                	ld	s0,8(sp)
 1aa:	0141                	addi	sp,sp,16
 1ac:	8082                	ret
  return 0;
 1ae:	4501                	li	a0,0
 1b0:	bfe5                	j	1a8 <strchr+0x1a>

00000000000001b2 <gets>:

char*
gets(char *buf, int max)
{
 1b2:	711d                	addi	sp,sp,-96
 1b4:	ec86                	sd	ra,88(sp)
 1b6:	e8a2                	sd	s0,80(sp)
 1b8:	e4a6                	sd	s1,72(sp)
 1ba:	e0ca                	sd	s2,64(sp)
 1bc:	fc4e                	sd	s3,56(sp)
 1be:	f852                	sd	s4,48(sp)
 1c0:	f456                	sd	s5,40(sp)
 1c2:	f05a                	sd	s6,32(sp)
 1c4:	ec5e                	sd	s7,24(sp)
 1c6:	1080                	addi	s0,sp,96
 1c8:	8baa                	mv	s7,a0
 1ca:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1cc:	892a                	mv	s2,a0
 1ce:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1d0:	4aa9                	li	s5,10
 1d2:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1d4:	89a6                	mv	s3,s1
 1d6:	2485                	addiw	s1,s1,1
 1d8:	0344d663          	bge	s1,s4,204 <gets+0x52>
    cc = read(0, &c, 1);
 1dc:	4605                	li	a2,1
 1de:	faf40593          	addi	a1,s0,-81
 1e2:	4501                	li	a0,0
 1e4:	242000ef          	jal	426 <read>
    if(cc < 1)
 1e8:	00a05e63          	blez	a0,204 <gets+0x52>
    buf[i++] = c;
 1ec:	faf44783          	lbu	a5,-81(s0)
 1f0:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1f4:	01578763          	beq	a5,s5,202 <gets+0x50>
 1f8:	0905                	addi	s2,s2,1
 1fa:	fd679de3          	bne	a5,s6,1d4 <gets+0x22>
    buf[i++] = c;
 1fe:	89a6                	mv	s3,s1
 200:	a011                	j	204 <gets+0x52>
 202:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 204:	99de                	add	s3,s3,s7
 206:	00098023          	sb	zero,0(s3)
  return buf;
}
 20a:	855e                	mv	a0,s7
 20c:	60e6                	ld	ra,88(sp)
 20e:	6446                	ld	s0,80(sp)
 210:	64a6                	ld	s1,72(sp)
 212:	6906                	ld	s2,64(sp)
 214:	79e2                	ld	s3,56(sp)
 216:	7a42                	ld	s4,48(sp)
 218:	7aa2                	ld	s5,40(sp)
 21a:	7b02                	ld	s6,32(sp)
 21c:	6be2                	ld	s7,24(sp)
 21e:	6125                	addi	sp,sp,96
 220:	8082                	ret

0000000000000222 <stat>:

int
stat(const char *n, struct stat *st)
{
 222:	1101                	addi	sp,sp,-32
 224:	ec06                	sd	ra,24(sp)
 226:	e822                	sd	s0,16(sp)
 228:	e04a                	sd	s2,0(sp)
 22a:	1000                	addi	s0,sp,32
 22c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 22e:	4581                	li	a1,0
 230:	21e000ef          	jal	44e <open>
  if(fd < 0)
 234:	02054263          	bltz	a0,258 <stat+0x36>
 238:	e426                	sd	s1,8(sp)
 23a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 23c:	85ca                	mv	a1,s2
 23e:	228000ef          	jal	466 <fstat>
 242:	892a                	mv	s2,a0
  close(fd);
 244:	8526                	mv	a0,s1
 246:	1f0000ef          	jal	436 <close>
  return r;
 24a:	64a2                	ld	s1,8(sp)
}
 24c:	854a                	mv	a0,s2
 24e:	60e2                	ld	ra,24(sp)
 250:	6442                	ld	s0,16(sp)
 252:	6902                	ld	s2,0(sp)
 254:	6105                	addi	sp,sp,32
 256:	8082                	ret
    return -1;
 258:	597d                	li	s2,-1
 25a:	bfcd                	j	24c <stat+0x2a>

000000000000025c <atoi>:

int
atoi(const char *s)
{
 25c:	1141                	addi	sp,sp,-16
 25e:	e422                	sd	s0,8(sp)
 260:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 262:	00054683          	lbu	a3,0(a0)
 266:	fd06879b          	addiw	a5,a3,-48
 26a:	0ff7f793          	zext.b	a5,a5
 26e:	4625                	li	a2,9
 270:	02f66863          	bltu	a2,a5,2a0 <atoi+0x44>
 274:	872a                	mv	a4,a0
  n = 0;
 276:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 278:	0705                	addi	a4,a4,1
 27a:	0025179b          	slliw	a5,a0,0x2
 27e:	9fa9                	addw	a5,a5,a0
 280:	0017979b          	slliw	a5,a5,0x1
 284:	9fb5                	addw	a5,a5,a3
 286:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 28a:	00074683          	lbu	a3,0(a4)
 28e:	fd06879b          	addiw	a5,a3,-48
 292:	0ff7f793          	zext.b	a5,a5
 296:	fef671e3          	bgeu	a2,a5,278 <atoi+0x1c>
  return n;
}
 29a:	6422                	ld	s0,8(sp)
 29c:	0141                	addi	sp,sp,16
 29e:	8082                	ret
  n = 0;
 2a0:	4501                	li	a0,0
 2a2:	bfe5                	j	29a <atoi+0x3e>

00000000000002a4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2a4:	1141                	addi	sp,sp,-16
 2a6:	e422                	sd	s0,8(sp)
 2a8:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2aa:	02b57463          	bgeu	a0,a1,2d2 <memmove+0x2e>
    while(n-- > 0)
 2ae:	00c05f63          	blez	a2,2cc <memmove+0x28>
 2b2:	1602                	slli	a2,a2,0x20
 2b4:	9201                	srli	a2,a2,0x20
 2b6:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2ba:	872a                	mv	a4,a0
      *dst++ = *src++;
 2bc:	0585                	addi	a1,a1,1
 2be:	0705                	addi	a4,a4,1
 2c0:	fff5c683          	lbu	a3,-1(a1)
 2c4:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2c8:	fef71ae3          	bne	a4,a5,2bc <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2cc:	6422                	ld	s0,8(sp)
 2ce:	0141                	addi	sp,sp,16
 2d0:	8082                	ret
    dst += n;
 2d2:	00c50733          	add	a4,a0,a2
    src += n;
 2d6:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2d8:	fec05ae3          	blez	a2,2cc <memmove+0x28>
 2dc:	fff6079b          	addiw	a5,a2,-1
 2e0:	1782                	slli	a5,a5,0x20
 2e2:	9381                	srli	a5,a5,0x20
 2e4:	fff7c793          	not	a5,a5
 2e8:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2ea:	15fd                	addi	a1,a1,-1
 2ec:	177d                	addi	a4,a4,-1
 2ee:	0005c683          	lbu	a3,0(a1)
 2f2:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2f6:	fee79ae3          	bne	a5,a4,2ea <memmove+0x46>
 2fa:	bfc9                	j	2cc <memmove+0x28>

00000000000002fc <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2fc:	1141                	addi	sp,sp,-16
 2fe:	e422                	sd	s0,8(sp)
 300:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 302:	ca05                	beqz	a2,332 <memcmp+0x36>
 304:	fff6069b          	addiw	a3,a2,-1
 308:	1682                	slli	a3,a3,0x20
 30a:	9281                	srli	a3,a3,0x20
 30c:	0685                	addi	a3,a3,1
 30e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 310:	00054783          	lbu	a5,0(a0)
 314:	0005c703          	lbu	a4,0(a1)
 318:	00e79863          	bne	a5,a4,328 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 31c:	0505                	addi	a0,a0,1
    p2++;
 31e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 320:	fed518e3          	bne	a0,a3,310 <memcmp+0x14>
  }
  return 0;
 324:	4501                	li	a0,0
 326:	a019                	j	32c <memcmp+0x30>
      return *p1 - *p2;
 328:	40e7853b          	subw	a0,a5,a4
}
 32c:	6422                	ld	s0,8(sp)
 32e:	0141                	addi	sp,sp,16
 330:	8082                	ret
  return 0;
 332:	4501                	li	a0,0
 334:	bfe5                	j	32c <memcmp+0x30>

0000000000000336 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 336:	1141                	addi	sp,sp,-16
 338:	e406                	sd	ra,8(sp)
 33a:	e022                	sd	s0,0(sp)
 33c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 33e:	f67ff0ef          	jal	2a4 <memmove>
}
 342:	60a2                	ld	ra,8(sp)
 344:	6402                	ld	s0,0(sp)
 346:	0141                	addi	sp,sp,16
 348:	8082                	ret

000000000000034a <sbrk>:

char *
sbrk(int n) {
 34a:	1141                	addi	sp,sp,-16
 34c:	e406                	sd	ra,8(sp)
 34e:	e022                	sd	s0,0(sp)
 350:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 352:	4585                	li	a1,1
 354:	142000ef          	jal	496 <sys_sbrk>
}
 358:	60a2                	ld	ra,8(sp)
 35a:	6402                	ld	s0,0(sp)
 35c:	0141                	addi	sp,sp,16
 35e:	8082                	ret

0000000000000360 <sbrklazy>:

char *
sbrklazy(int n) {
 360:	1141                	addi	sp,sp,-16
 362:	e406                	sd	ra,8(sp)
 364:	e022                	sd	s0,0(sp)
 366:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 368:	4589                	li	a1,2
 36a:	12c000ef          	jal	496 <sys_sbrk>
}
 36e:	60a2                	ld	ra,8(sp)
 370:	6402                	ld	s0,0(sp)
 372:	0141                	addi	sp,sp,16
 374:	8082                	ret

0000000000000376 <thread_create>:
// thread_create allocates a page-sized stack, calls clone(fn, arg, stacktop).
// Returns the new thread's pid, or -1 on error.
// The stack is passed back via *stack so the caller can free it after join.
int
thread_create(void(*fn)(void*), void *arg, void **stack)
{
 376:	7179                	addi	sp,sp,-48
 378:	f406                	sd	ra,40(sp)
 37a:	f022                	sd	s0,32(sp)
 37c:	e84a                	sd	s2,16(sp)
 37e:	e44e                	sd	s3,8(sp)
 380:	e052                	sd	s4,0(sp)
 382:	1800                	addi	s0,sp,48
 384:	89aa                	mv	s3,a0
 386:	8a2e                	mv	s4,a1
 388:	8932                	mv	s2,a2
  char *s = malloc(PGSIZE);
 38a:	6505                	lui	a0,0x1
 38c:	5b8000ef          	jal	944 <malloc>
  if(s == 0)
 390:	cd0d                	beqz	a0,3ca <thread_create+0x54>
 392:	ec26                	sd	s1,24(sp)
 394:	84aa                	mv	s1,a0
    return -1;
  *stack = s;
 396:	00a93023          	sd	a0,0(s2)
  // Stack grows downward- pass the top of the allocated region.
  int pid = clone(fn, arg, s + PGSIZE);
 39a:	6605                	lui	a2,0x1
 39c:	962a                	add	a2,a2,a0
 39e:	85d2                	mv	a1,s4
 3a0:	854e                	mv	a0,s3
 3a2:	134000ef          	jal	4d6 <clone>
  if(pid < 0){
 3a6:	00054a63          	bltz	a0,3ba <thread_create+0x44>
 3aa:	64e2                	ld	s1,24(sp)
    free(s);
    *stack = 0;
    return -1;
  }
  return pid;
}
 3ac:	70a2                	ld	ra,40(sp)
 3ae:	7402                	ld	s0,32(sp)
 3b0:	6942                	ld	s2,16(sp)
 3b2:	69a2                	ld	s3,8(sp)
 3b4:	6a02                	ld	s4,0(sp)
 3b6:	6145                	addi	sp,sp,48
 3b8:	8082                	ret
    free(s);
 3ba:	8526                	mv	a0,s1
 3bc:	506000ef          	jal	8c2 <free>
    *stack = 0;
 3c0:	00093023          	sd	zero,0(s2)
    return -1;
 3c4:	557d                	li	a0,-1
 3c6:	64e2                	ld	s1,24(sp)
 3c8:	b7d5                	j	3ac <thread_create+0x36>
    return -1;
 3ca:	557d                	li	a0,-1
 3cc:	b7c5                	j	3ac <thread_create+0x36>

00000000000003ce <thread_join>:
// Wait for any child thread to exit.
// If stack is non-null, frees the memory pointed to by *stack and clears it.
// Returns the joined thread's pid, or -1 Son error.
int
thread_join(void **stack)
{
 3ce:	1101                	addi	sp,sp,-32
 3d0:	ec06                	sd	ra,24(sp)
 3d2:	e822                	sd	s0,16(sp)
 3d4:	e426                	sd	s1,8(sp)
 3d6:	e04a                	sd	s2,0(sp)
 3d8:	1000                	addi	s0,sp,32
 3da:	84aa                	mv	s1,a0
  int pid = join();
 3dc:	102000ef          	jal	4de <join>
  if(pid < 0)
 3e0:	02054163          	bltz	a0,402 <thread_join+0x34>
 3e4:	892a                	mv	s2,a0
    return -1;
  if(stack && *stack){
 3e6:	c499                	beqz	s1,3f4 <thread_join+0x26>
 3e8:	6088                	ld	a0,0(s1)
 3ea:	c509                	beqz	a0,3f4 <thread_join+0x26>
    free(*stack);
 3ec:	4d6000ef          	jal	8c2 <free>
    *stack = 0;
 3f0:	0004b023          	sd	zero,0(s1)
  }
  return pid;
}
 3f4:	854a                	mv	a0,s2
 3f6:	60e2                	ld	ra,24(sp)
 3f8:	6442                	ld	s0,16(sp)
 3fa:	64a2                	ld	s1,8(sp)
 3fc:	6902                	ld	s2,0(sp)
 3fe:	6105                	addi	sp,sp,32
 400:	8082                	ret
    return -1;
 402:	597d                	li	s2,-1
 404:	bfc5                	j	3f4 <thread_join+0x26>

0000000000000406 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 406:	4885                	li	a7,1
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <exit>:
.global exit
exit:
 li a7, SYS_exit
 40e:	4889                	li	a7,2
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <wait>:
.global wait
wait:
 li a7, SYS_wait
 416:	488d                	li	a7,3
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 41e:	4891                	li	a7,4
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <read>:
.global read
read:
 li a7, SYS_read
 426:	4895                	li	a7,5
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <write>:
.global write
write:
 li a7, SYS_write
 42e:	48c1                	li	a7,16
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <close>:
.global close
close:
 li a7, SYS_close
 436:	48d5                	li	a7,21
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <kill>:
.global kill
kill:
 li a7, SYS_kill
 43e:	4899                	li	a7,6
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <exec>:
.global exec
exec:
 li a7, SYS_exec
 446:	489d                	li	a7,7
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <open>:
.global open
open:
 li a7, SYS_open
 44e:	48bd                	li	a7,15
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 456:	48c5                	li	a7,17
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 45e:	48c9                	li	a7,18
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 466:	48a1                	li	a7,8
 ecall
 468:	00000073          	ecall
 ret
 46c:	8082                	ret

000000000000046e <link>:
.global link
link:
 li a7, SYS_link
 46e:	48cd                	li	a7,19
 ecall
 470:	00000073          	ecall
 ret
 474:	8082                	ret

0000000000000476 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 476:	48d1                	li	a7,20
 ecall
 478:	00000073          	ecall
 ret
 47c:	8082                	ret

000000000000047e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 47e:	48a5                	li	a7,9
 ecall
 480:	00000073          	ecall
 ret
 484:	8082                	ret

0000000000000486 <dup>:
.global dup
dup:
 li a7, SYS_dup
 486:	48a9                	li	a7,10
 ecall
 488:	00000073          	ecall
 ret
 48c:	8082                	ret

000000000000048e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 48e:	48ad                	li	a7,11
 ecall
 490:	00000073          	ecall
 ret
 494:	8082                	ret

0000000000000496 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 496:	48b1                	li	a7,12
 ecall
 498:	00000073          	ecall
 ret
 49c:	8082                	ret

000000000000049e <pause>:
.global pause
pause:
 li a7, SYS_pause
 49e:	48b5                	li	a7,13
 ecall
 4a0:	00000073          	ecall
 ret
 4a4:	8082                	ret

00000000000004a6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4a6:	48b9                	li	a7,14
 ecall
 4a8:	00000073          	ecall
 ret
 4ac:	8082                	ret

00000000000004ae <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 4ae:	48d9                	li	a7,22
 ecall
 4b0:	00000073          	ecall
 ret
 4b4:	8082                	ret

00000000000004b6 <lock_create>:
.global lock_create
lock_create:
 li a7, SYS_lock_create
 4b6:	48dd                	li	a7,23
 ecall
 4b8:	00000073          	ecall
 ret
 4bc:	8082                	ret

00000000000004be <lock_acquire>:
.global lock_acquire
lock_acquire:
 li a7, SYS_lock_acquire
 4be:	48e1                	li	a7,24
 ecall
 4c0:	00000073          	ecall
 ret
 4c4:	8082                	ret

00000000000004c6 <lock_release>:
.global lock_release
lock_release:
 li a7, SYS_lock_release
 4c6:	48e5                	li	a7,25
 ecall
 4c8:	00000073          	ecall
 ret
 4cc:	8082                	ret

00000000000004ce <lock_destroy>:
.global lock_destroy
lock_destroy:
 li a7, SYS_lock_destroy
 4ce:	48e9                	li	a7,26
 ecall
 4d0:	00000073          	ecall
 ret
 4d4:	8082                	ret

00000000000004d6 <clone>:
.global clone
clone:
 li a7, SYS_clone
 4d6:	48ed                	li	a7,27
 ecall
 4d8:	00000073          	ecall
 ret
 4dc:	8082                	ret

00000000000004de <join>:
.global join
join:
 li a7, SYS_join
 4de:	48f1                	li	a7,28
 ecall
 4e0:	00000073          	ecall
 ret
 4e4:	8082                	ret

00000000000004e6 <getprocessinfo>:
.global getprocessinfo
getprocessinfo:
 li a7, SYS_getprocessinfo
 4e6:	48f5                	li	a7,29
 ecall
 4e8:	00000073          	ecall
 ret
 4ec:	8082                	ret

00000000000004ee <shmget>:
.global shmget
shmget:
 li a7, SYS_shmget
 4ee:	48f9                	li	a7,30
 ecall
 4f0:	00000073          	ecall
 ret
 4f4:	8082                	ret

00000000000004f6 <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 4f6:	48fd                	li	a7,31
 ecall
 4f8:	00000073          	ecall
 ret
 4fc:	8082                	ret

00000000000004fe <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 4fe:	02000893          	li	a7,32
 ecall
 502:	00000073          	ecall
 ret
 506:	8082                	ret

0000000000000508 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 508:	1101                	addi	sp,sp,-32
 50a:	ec06                	sd	ra,24(sp)
 50c:	e822                	sd	s0,16(sp)
 50e:	1000                	addi	s0,sp,32
 510:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 514:	4605                	li	a2,1
 516:	fef40593          	addi	a1,s0,-17
 51a:	f15ff0ef          	jal	42e <write>
}
 51e:	60e2                	ld	ra,24(sp)
 520:	6442                	ld	s0,16(sp)
 522:	6105                	addi	sp,sp,32
 524:	8082                	ret

0000000000000526 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 526:	715d                	addi	sp,sp,-80
 528:	e486                	sd	ra,72(sp)
 52a:	e0a2                	sd	s0,64(sp)
 52c:	f84a                	sd	s2,48(sp)
 52e:	0880                	addi	s0,sp,80
 530:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 532:	c299                	beqz	a3,538 <printint+0x12>
 534:	0805c363          	bltz	a1,5ba <printint+0x94>
  neg = 0;
 538:	4881                	li	a7,0
 53a:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 53e:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 540:	00000517          	auipc	a0,0x0
 544:	55050513          	addi	a0,a0,1360 # a90 <digits>
 548:	883e                	mv	a6,a5
 54a:	2785                	addiw	a5,a5,1
 54c:	02c5f733          	remu	a4,a1,a2
 550:	972a                	add	a4,a4,a0
 552:	00074703          	lbu	a4,0(a4)
 556:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 55a:	872e                	mv	a4,a1
 55c:	02c5d5b3          	divu	a1,a1,a2
 560:	0685                	addi	a3,a3,1
 562:	fec773e3          	bgeu	a4,a2,548 <printint+0x22>
  if(neg)
 566:	00088b63          	beqz	a7,57c <printint+0x56>
    buf[i++] = '-';
 56a:	fd078793          	addi	a5,a5,-48
 56e:	97a2                	add	a5,a5,s0
 570:	02d00713          	li	a4,45
 574:	fee78423          	sb	a4,-24(a5)
 578:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 57c:	02f05a63          	blez	a5,5b0 <printint+0x8a>
 580:	fc26                	sd	s1,56(sp)
 582:	f44e                	sd	s3,40(sp)
 584:	fb840713          	addi	a4,s0,-72
 588:	00f704b3          	add	s1,a4,a5
 58c:	fff70993          	addi	s3,a4,-1
 590:	99be                	add	s3,s3,a5
 592:	37fd                	addiw	a5,a5,-1
 594:	1782                	slli	a5,a5,0x20
 596:	9381                	srli	a5,a5,0x20
 598:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 59c:	fff4c583          	lbu	a1,-1(s1)
 5a0:	854a                	mv	a0,s2
 5a2:	f67ff0ef          	jal	508 <putc>
  while(--i >= 0)
 5a6:	14fd                	addi	s1,s1,-1
 5a8:	ff349ae3          	bne	s1,s3,59c <printint+0x76>
 5ac:	74e2                	ld	s1,56(sp)
 5ae:	79a2                	ld	s3,40(sp)
}
 5b0:	60a6                	ld	ra,72(sp)
 5b2:	6406                	ld	s0,64(sp)
 5b4:	7942                	ld	s2,48(sp)
 5b6:	6161                	addi	sp,sp,80
 5b8:	8082                	ret
    x = -xx;
 5ba:	40b005b3          	neg	a1,a1
    neg = 1;
 5be:	4885                	li	a7,1
    x = -xx;
 5c0:	bfad                	j	53a <printint+0x14>

00000000000005c2 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5c2:	711d                	addi	sp,sp,-96
 5c4:	ec86                	sd	ra,88(sp)
 5c6:	e8a2                	sd	s0,80(sp)
 5c8:	e0ca                	sd	s2,64(sp)
 5ca:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5cc:	0005c903          	lbu	s2,0(a1)
 5d0:	28090663          	beqz	s2,85c <vprintf+0x29a>
 5d4:	e4a6                	sd	s1,72(sp)
 5d6:	fc4e                	sd	s3,56(sp)
 5d8:	f852                	sd	s4,48(sp)
 5da:	f456                	sd	s5,40(sp)
 5dc:	f05a                	sd	s6,32(sp)
 5de:	ec5e                	sd	s7,24(sp)
 5e0:	e862                	sd	s8,16(sp)
 5e2:	e466                	sd	s9,8(sp)
 5e4:	8b2a                	mv	s6,a0
 5e6:	8a2e                	mv	s4,a1
 5e8:	8bb2                	mv	s7,a2
  state = 0;
 5ea:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 5ec:	4481                	li	s1,0
 5ee:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 5f0:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 5f4:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 5f8:	06c00c93          	li	s9,108
 5fc:	a005                	j	61c <vprintf+0x5a>
        putc(fd, c0);
 5fe:	85ca                	mv	a1,s2
 600:	855a                	mv	a0,s6
 602:	f07ff0ef          	jal	508 <putc>
 606:	a019                	j	60c <vprintf+0x4a>
    } else if(state == '%'){
 608:	03598263          	beq	s3,s5,62c <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 60c:	2485                	addiw	s1,s1,1
 60e:	8726                	mv	a4,s1
 610:	009a07b3          	add	a5,s4,s1
 614:	0007c903          	lbu	s2,0(a5)
 618:	22090a63          	beqz	s2,84c <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 61c:	0009079b          	sext.w	a5,s2
    if(state == 0){
 620:	fe0994e3          	bnez	s3,608 <vprintf+0x46>
      if(c0 == '%'){
 624:	fd579de3          	bne	a5,s5,5fe <vprintf+0x3c>
        state = '%';
 628:	89be                	mv	s3,a5
 62a:	b7cd                	j	60c <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 62c:	00ea06b3          	add	a3,s4,a4
 630:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 634:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 636:	c681                	beqz	a3,63e <vprintf+0x7c>
 638:	9752                	add	a4,a4,s4
 63a:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 63e:	05878363          	beq	a5,s8,684 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 642:	05978d63          	beq	a5,s9,69c <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 646:	07500713          	li	a4,117
 64a:	0ee78763          	beq	a5,a4,738 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 64e:	07800713          	li	a4,120
 652:	12e78963          	beq	a5,a4,784 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 656:	07000713          	li	a4,112
 65a:	14e78e63          	beq	a5,a4,7b6 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 65e:	06300713          	li	a4,99
 662:	18e78e63          	beq	a5,a4,7fe <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 666:	07300713          	li	a4,115
 66a:	1ae78463          	beq	a5,a4,812 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 66e:	02500713          	li	a4,37
 672:	04e79563          	bne	a5,a4,6bc <vprintf+0xfa>
        putc(fd, '%');
 676:	02500593          	li	a1,37
 67a:	855a                	mv	a0,s6
 67c:	e8dff0ef          	jal	508 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 680:	4981                	li	s3,0
 682:	b769                	j	60c <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 684:	008b8913          	addi	s2,s7,8
 688:	4685                	li	a3,1
 68a:	4629                	li	a2,10
 68c:	000ba583          	lw	a1,0(s7)
 690:	855a                	mv	a0,s6
 692:	e95ff0ef          	jal	526 <printint>
 696:	8bca                	mv	s7,s2
      state = 0;
 698:	4981                	li	s3,0
 69a:	bf8d                	j	60c <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 69c:	06400793          	li	a5,100
 6a0:	02f68963          	beq	a3,a5,6d2 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6a4:	06c00793          	li	a5,108
 6a8:	04f68263          	beq	a3,a5,6ec <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 6ac:	07500793          	li	a5,117
 6b0:	0af68063          	beq	a3,a5,750 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 6b4:	07800793          	li	a5,120
 6b8:	0ef68263          	beq	a3,a5,79c <vprintf+0x1da>
        putc(fd, '%');
 6bc:	02500593          	li	a1,37
 6c0:	855a                	mv	a0,s6
 6c2:	e47ff0ef          	jal	508 <putc>
        putc(fd, c0);
 6c6:	85ca                	mv	a1,s2
 6c8:	855a                	mv	a0,s6
 6ca:	e3fff0ef          	jal	508 <putc>
      state = 0;
 6ce:	4981                	li	s3,0
 6d0:	bf35                	j	60c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6d2:	008b8913          	addi	s2,s7,8
 6d6:	4685                	li	a3,1
 6d8:	4629                	li	a2,10
 6da:	000bb583          	ld	a1,0(s7)
 6de:	855a                	mv	a0,s6
 6e0:	e47ff0ef          	jal	526 <printint>
        i += 1;
 6e4:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 6e6:	8bca                	mv	s7,s2
      state = 0;
 6e8:	4981                	li	s3,0
        i += 1;
 6ea:	b70d                	j	60c <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6ec:	06400793          	li	a5,100
 6f0:	02f60763          	beq	a2,a5,71e <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 6f4:	07500793          	li	a5,117
 6f8:	06f60963          	beq	a2,a5,76a <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 6fc:	07800793          	li	a5,120
 700:	faf61ee3          	bne	a2,a5,6bc <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 704:	008b8913          	addi	s2,s7,8
 708:	4681                	li	a3,0
 70a:	4641                	li	a2,16
 70c:	000bb583          	ld	a1,0(s7)
 710:	855a                	mv	a0,s6
 712:	e15ff0ef          	jal	526 <printint>
        i += 2;
 716:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 718:	8bca                	mv	s7,s2
      state = 0;
 71a:	4981                	li	s3,0
        i += 2;
 71c:	bdc5                	j	60c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 71e:	008b8913          	addi	s2,s7,8
 722:	4685                	li	a3,1
 724:	4629                	li	a2,10
 726:	000bb583          	ld	a1,0(s7)
 72a:	855a                	mv	a0,s6
 72c:	dfbff0ef          	jal	526 <printint>
        i += 2;
 730:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 732:	8bca                	mv	s7,s2
      state = 0;
 734:	4981                	li	s3,0
        i += 2;
 736:	bdd9                	j	60c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 738:	008b8913          	addi	s2,s7,8
 73c:	4681                	li	a3,0
 73e:	4629                	li	a2,10
 740:	000be583          	lwu	a1,0(s7)
 744:	855a                	mv	a0,s6
 746:	de1ff0ef          	jal	526 <printint>
 74a:	8bca                	mv	s7,s2
      state = 0;
 74c:	4981                	li	s3,0
 74e:	bd7d                	j	60c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 750:	008b8913          	addi	s2,s7,8
 754:	4681                	li	a3,0
 756:	4629                	li	a2,10
 758:	000bb583          	ld	a1,0(s7)
 75c:	855a                	mv	a0,s6
 75e:	dc9ff0ef          	jal	526 <printint>
        i += 1;
 762:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 764:	8bca                	mv	s7,s2
      state = 0;
 766:	4981                	li	s3,0
        i += 1;
 768:	b555                	j	60c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 76a:	008b8913          	addi	s2,s7,8
 76e:	4681                	li	a3,0
 770:	4629                	li	a2,10
 772:	000bb583          	ld	a1,0(s7)
 776:	855a                	mv	a0,s6
 778:	dafff0ef          	jal	526 <printint>
        i += 2;
 77c:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 77e:	8bca                	mv	s7,s2
      state = 0;
 780:	4981                	li	s3,0
        i += 2;
 782:	b569                	j	60c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 784:	008b8913          	addi	s2,s7,8
 788:	4681                	li	a3,0
 78a:	4641                	li	a2,16
 78c:	000be583          	lwu	a1,0(s7)
 790:	855a                	mv	a0,s6
 792:	d95ff0ef          	jal	526 <printint>
 796:	8bca                	mv	s7,s2
      state = 0;
 798:	4981                	li	s3,0
 79a:	bd8d                	j	60c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 79c:	008b8913          	addi	s2,s7,8
 7a0:	4681                	li	a3,0
 7a2:	4641                	li	a2,16
 7a4:	000bb583          	ld	a1,0(s7)
 7a8:	855a                	mv	a0,s6
 7aa:	d7dff0ef          	jal	526 <printint>
        i += 1;
 7ae:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 7b0:	8bca                	mv	s7,s2
      state = 0;
 7b2:	4981                	li	s3,0
        i += 1;
 7b4:	bda1                	j	60c <vprintf+0x4a>
 7b6:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 7b8:	008b8d13          	addi	s10,s7,8
 7bc:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 7c0:	03000593          	li	a1,48
 7c4:	855a                	mv	a0,s6
 7c6:	d43ff0ef          	jal	508 <putc>
  putc(fd, 'x');
 7ca:	07800593          	li	a1,120
 7ce:	855a                	mv	a0,s6
 7d0:	d39ff0ef          	jal	508 <putc>
 7d4:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7d6:	00000b97          	auipc	s7,0x0
 7da:	2bab8b93          	addi	s7,s7,698 # a90 <digits>
 7de:	03c9d793          	srli	a5,s3,0x3c
 7e2:	97de                	add	a5,a5,s7
 7e4:	0007c583          	lbu	a1,0(a5)
 7e8:	855a                	mv	a0,s6
 7ea:	d1fff0ef          	jal	508 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7ee:	0992                	slli	s3,s3,0x4
 7f0:	397d                	addiw	s2,s2,-1
 7f2:	fe0916e3          	bnez	s2,7de <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 7f6:	8bea                	mv	s7,s10
      state = 0;
 7f8:	4981                	li	s3,0
 7fa:	6d02                	ld	s10,0(sp)
 7fc:	bd01                	j	60c <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 7fe:	008b8913          	addi	s2,s7,8
 802:	000bc583          	lbu	a1,0(s7)
 806:	855a                	mv	a0,s6
 808:	d01ff0ef          	jal	508 <putc>
 80c:	8bca                	mv	s7,s2
      state = 0;
 80e:	4981                	li	s3,0
 810:	bbf5                	j	60c <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 812:	008b8993          	addi	s3,s7,8
 816:	000bb903          	ld	s2,0(s7)
 81a:	00090f63          	beqz	s2,838 <vprintf+0x276>
        for(; *s; s++)
 81e:	00094583          	lbu	a1,0(s2)
 822:	c195                	beqz	a1,846 <vprintf+0x284>
          putc(fd, *s);
 824:	855a                	mv	a0,s6
 826:	ce3ff0ef          	jal	508 <putc>
        for(; *s; s++)
 82a:	0905                	addi	s2,s2,1
 82c:	00094583          	lbu	a1,0(s2)
 830:	f9f5                	bnez	a1,824 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 832:	8bce                	mv	s7,s3
      state = 0;
 834:	4981                	li	s3,0
 836:	bbd9                	j	60c <vprintf+0x4a>
          s = "(null)";
 838:	00000917          	auipc	s2,0x0
 83c:	25090913          	addi	s2,s2,592 # a88 <malloc+0x144>
        for(; *s; s++)
 840:	02800593          	li	a1,40
 844:	b7c5                	j	824 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 846:	8bce                	mv	s7,s3
      state = 0;
 848:	4981                	li	s3,0
 84a:	b3c9                	j	60c <vprintf+0x4a>
 84c:	64a6                	ld	s1,72(sp)
 84e:	79e2                	ld	s3,56(sp)
 850:	7a42                	ld	s4,48(sp)
 852:	7aa2                	ld	s5,40(sp)
 854:	7b02                	ld	s6,32(sp)
 856:	6be2                	ld	s7,24(sp)
 858:	6c42                	ld	s8,16(sp)
 85a:	6ca2                	ld	s9,8(sp)
    }
  }
}
 85c:	60e6                	ld	ra,88(sp)
 85e:	6446                	ld	s0,80(sp)
 860:	6906                	ld	s2,64(sp)
 862:	6125                	addi	sp,sp,96
 864:	8082                	ret

0000000000000866 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 866:	715d                	addi	sp,sp,-80
 868:	ec06                	sd	ra,24(sp)
 86a:	e822                	sd	s0,16(sp)
 86c:	1000                	addi	s0,sp,32
 86e:	e010                	sd	a2,0(s0)
 870:	e414                	sd	a3,8(s0)
 872:	e818                	sd	a4,16(s0)
 874:	ec1c                	sd	a5,24(s0)
 876:	03043023          	sd	a6,32(s0)
 87a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 87e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 882:	8622                	mv	a2,s0
 884:	d3fff0ef          	jal	5c2 <vprintf>
}
 888:	60e2                	ld	ra,24(sp)
 88a:	6442                	ld	s0,16(sp)
 88c:	6161                	addi	sp,sp,80
 88e:	8082                	ret

0000000000000890 <printf>:

void
printf(const char *fmt, ...)
{
 890:	711d                	addi	sp,sp,-96
 892:	ec06                	sd	ra,24(sp)
 894:	e822                	sd	s0,16(sp)
 896:	1000                	addi	s0,sp,32
 898:	e40c                	sd	a1,8(s0)
 89a:	e810                	sd	a2,16(s0)
 89c:	ec14                	sd	a3,24(s0)
 89e:	f018                	sd	a4,32(s0)
 8a0:	f41c                	sd	a5,40(s0)
 8a2:	03043823          	sd	a6,48(s0)
 8a6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8aa:	00840613          	addi	a2,s0,8
 8ae:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8b2:	85aa                	mv	a1,a0
 8b4:	4505                	li	a0,1
 8b6:	d0dff0ef          	jal	5c2 <vprintf>
}
 8ba:	60e2                	ld	ra,24(sp)
 8bc:	6442                	ld	s0,16(sp)
 8be:	6125                	addi	sp,sp,96
 8c0:	8082                	ret

00000000000008c2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8c2:	1141                	addi	sp,sp,-16
 8c4:	e422                	sd	s0,8(sp)
 8c6:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8c8:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8cc:	00000797          	auipc	a5,0x0
 8d0:	7347b783          	ld	a5,1844(a5) # 1000 <freep>
 8d4:	a02d                	j	8fe <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8d6:	4618                	lw	a4,8(a2)
 8d8:	9f2d                	addw	a4,a4,a1
 8da:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8de:	6398                	ld	a4,0(a5)
 8e0:	6310                	ld	a2,0(a4)
 8e2:	a83d                	j	920 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8e4:	ff852703          	lw	a4,-8(a0)
 8e8:	9f31                	addw	a4,a4,a2
 8ea:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8ec:	ff053683          	ld	a3,-16(a0)
 8f0:	a091                	j	934 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8f2:	6398                	ld	a4,0(a5)
 8f4:	00e7e463          	bltu	a5,a4,8fc <free+0x3a>
 8f8:	00e6ea63          	bltu	a3,a4,90c <free+0x4a>
{
 8fc:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8fe:	fed7fae3          	bgeu	a5,a3,8f2 <free+0x30>
 902:	6398                	ld	a4,0(a5)
 904:	00e6e463          	bltu	a3,a4,90c <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 908:	fee7eae3          	bltu	a5,a4,8fc <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 90c:	ff852583          	lw	a1,-8(a0)
 910:	6390                	ld	a2,0(a5)
 912:	02059813          	slli	a6,a1,0x20
 916:	01c85713          	srli	a4,a6,0x1c
 91a:	9736                	add	a4,a4,a3
 91c:	fae60de3          	beq	a2,a4,8d6 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 920:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 924:	4790                	lw	a2,8(a5)
 926:	02061593          	slli	a1,a2,0x20
 92a:	01c5d713          	srli	a4,a1,0x1c
 92e:	973e                	add	a4,a4,a5
 930:	fae68ae3          	beq	a3,a4,8e4 <free+0x22>
    p->s.ptr = bp->s.ptr;
 934:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 936:	00000717          	auipc	a4,0x0
 93a:	6cf73523          	sd	a5,1738(a4) # 1000 <freep>
}
 93e:	6422                	ld	s0,8(sp)
 940:	0141                	addi	sp,sp,16
 942:	8082                	ret

0000000000000944 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 944:	7139                	addi	sp,sp,-64
 946:	fc06                	sd	ra,56(sp)
 948:	f822                	sd	s0,48(sp)
 94a:	f426                	sd	s1,40(sp)
 94c:	ec4e                	sd	s3,24(sp)
 94e:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 950:	02051493          	slli	s1,a0,0x20
 954:	9081                	srli	s1,s1,0x20
 956:	04bd                	addi	s1,s1,15
 958:	8091                	srli	s1,s1,0x4
 95a:	0014899b          	addiw	s3,s1,1
 95e:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 960:	00000517          	auipc	a0,0x0
 964:	6a053503          	ld	a0,1696(a0) # 1000 <freep>
 968:	c915                	beqz	a0,99c <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 96a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 96c:	4798                	lw	a4,8(a5)
 96e:	08977a63          	bgeu	a4,s1,a02 <malloc+0xbe>
 972:	f04a                	sd	s2,32(sp)
 974:	e852                	sd	s4,16(sp)
 976:	e456                	sd	s5,8(sp)
 978:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 97a:	8a4e                	mv	s4,s3
 97c:	0009871b          	sext.w	a4,s3
 980:	6685                	lui	a3,0x1
 982:	00d77363          	bgeu	a4,a3,988 <malloc+0x44>
 986:	6a05                	lui	s4,0x1
 988:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 98c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 990:	00000917          	auipc	s2,0x0
 994:	67090913          	addi	s2,s2,1648 # 1000 <freep>
  if(p == SBRK_ERROR)
 998:	5afd                	li	s5,-1
 99a:	a081                	j	9da <malloc+0x96>
 99c:	f04a                	sd	s2,32(sp)
 99e:	e852                	sd	s4,16(sp)
 9a0:	e456                	sd	s5,8(sp)
 9a2:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 9a4:	00001797          	auipc	a5,0x1
 9a8:	86c78793          	addi	a5,a5,-1940 # 1210 <base>
 9ac:	00000717          	auipc	a4,0x0
 9b0:	64f73a23          	sd	a5,1620(a4) # 1000 <freep>
 9b4:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9b6:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 9ba:	b7c1                	j	97a <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 9bc:	6398                	ld	a4,0(a5)
 9be:	e118                	sd	a4,0(a0)
 9c0:	a8a9                	j	a1a <malloc+0xd6>
  hp->s.size = nu;
 9c2:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 9c6:	0541                	addi	a0,a0,16
 9c8:	efbff0ef          	jal	8c2 <free>
  return freep;
 9cc:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9d0:	c12d                	beqz	a0,a32 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9d2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9d4:	4798                	lw	a4,8(a5)
 9d6:	02977263          	bgeu	a4,s1,9fa <malloc+0xb6>
    if(p == freep)
 9da:	00093703          	ld	a4,0(s2)
 9de:	853e                	mv	a0,a5
 9e0:	fef719e3          	bne	a4,a5,9d2 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 9e4:	8552                	mv	a0,s4
 9e6:	965ff0ef          	jal	34a <sbrk>
  if(p == SBRK_ERROR)
 9ea:	fd551ce3          	bne	a0,s5,9c2 <malloc+0x7e>
        return 0;
 9ee:	4501                	li	a0,0
 9f0:	7902                	ld	s2,32(sp)
 9f2:	6a42                	ld	s4,16(sp)
 9f4:	6aa2                	ld	s5,8(sp)
 9f6:	6b02                	ld	s6,0(sp)
 9f8:	a03d                	j	a26 <malloc+0xe2>
 9fa:	7902                	ld	s2,32(sp)
 9fc:	6a42                	ld	s4,16(sp)
 9fe:	6aa2                	ld	s5,8(sp)
 a00:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 a02:	fae48de3          	beq	s1,a4,9bc <malloc+0x78>
        p->s.size -= nunits;
 a06:	4137073b          	subw	a4,a4,s3
 a0a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a0c:	02071693          	slli	a3,a4,0x20
 a10:	01c6d713          	srli	a4,a3,0x1c
 a14:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a16:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a1a:	00000717          	auipc	a4,0x0
 a1e:	5ea73323          	sd	a0,1510(a4) # 1000 <freep>
      return (void*)(p + 1);
 a22:	01078513          	addi	a0,a5,16
  }
}
 a26:	70e2                	ld	ra,56(sp)
 a28:	7442                	ld	s0,48(sp)
 a2a:	74a2                	ld	s1,40(sp)
 a2c:	69e2                	ld	s3,24(sp)
 a2e:	6121                	addi	sp,sp,64
 a30:	8082                	ret
 a32:	7902                	ld	s2,32(sp)
 a34:	6a42                	ld	s4,16(sp)
 a36:	6aa2                	ld	s5,8(sp)
 a38:	6b02                	ld	s6,0(sp)
 a3a:	b7f5                	j	a26 <malloc+0xe2>
