
user/_forktest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <print>:

#define N  1000

void
print(const char *s)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	addi	s0,sp,32
   a:	84aa                	mv	s1,a0
  write(1, s, strlen(s));
   c:	122000ef          	jal	12e <strlen>
  10:	0005061b          	sext.w	a2,a0
  14:	85a6                	mv	a1,s1
  16:	4505                	li	a0,1
  18:	402000ef          	jal	41a <write>
}
  1c:	60e2                	ld	ra,24(sp)
  1e:	6442                	ld	s0,16(sp)
  20:	64a2                	ld	s1,8(sp)
  22:	6105                	addi	sp,sp,32
  24:	8082                	ret

0000000000000026 <forktest>:

void
forktest(void)
{
  26:	1101                	addi	sp,sp,-32
  28:	ec06                	sd	ra,24(sp)
  2a:	e822                	sd	s0,16(sp)
  2c:	e426                	sd	s1,8(sp)
  2e:	e04a                	sd	s2,0(sp)
  30:	1000                	addi	s0,sp,32
  int n, pid;

  print("fork test\n");
  32:	00000517          	auipc	a0,0x0
  36:	61650513          	addi	a0,a0,1558 # 648 <malloc+0xf4>
  3a:	fc7ff0ef          	jal	0 <print>

  for(n=0; n<N; n++){
  3e:	4481                	li	s1,0
  40:	3e800913          	li	s2,1000
    pid = fork();
  44:	3ae000ef          	jal	3f2 <fork>
    if(pid < 0)
  48:	04054363          	bltz	a0,8e <forktest+0x68>
      break;
    if(pid == 0)
  4c:	cd09                	beqz	a0,66 <forktest+0x40>
  for(n=0; n<N; n++){
  4e:	2485                	addiw	s1,s1,1
  50:	ff249ae3          	bne	s1,s2,44 <forktest+0x1e>
      exit(0);
  }

  if(n == N){
    print("fork claimed to work N times!\n");
  54:	00000517          	auipc	a0,0x0
  58:	64450513          	addi	a0,a0,1604 # 698 <malloc+0x144>
  5c:	fa5ff0ef          	jal	0 <print>
    exit(1);
  60:	4505                	li	a0,1
  62:	398000ef          	jal	3fa <exit>
      exit(0);
  66:	394000ef          	jal	3fa <exit>
  }

  for(; n > 0; n--){
    if(wait(0) < 0){
      print("wait stopped early\n");
  6a:	00000517          	auipc	a0,0x0
  6e:	5ee50513          	addi	a0,a0,1518 # 658 <malloc+0x104>
  72:	f8fff0ef          	jal	0 <print>
      exit(1);
  76:	4505                	li	a0,1
  78:	382000ef          	jal	3fa <exit>
    }
  }

  if(wait(0) != -1){
    print("wait got too many\n");
  7c:	00000517          	auipc	a0,0x0
  80:	5f450513          	addi	a0,a0,1524 # 670 <malloc+0x11c>
  84:	f7dff0ef          	jal	0 <print>
    exit(1);
  88:	4505                	li	a0,1
  8a:	370000ef          	jal	3fa <exit>
  for(; n > 0; n--){
  8e:	00905963          	blez	s1,a0 <forktest+0x7a>
    if(wait(0) < 0){
  92:	4501                	li	a0,0
  94:	36e000ef          	jal	402 <wait>
  98:	fc0549e3          	bltz	a0,6a <forktest+0x44>
  for(; n > 0; n--){
  9c:	34fd                	addiw	s1,s1,-1
  9e:	f8f5                	bnez	s1,92 <forktest+0x6c>
  if(wait(0) != -1){
  a0:	4501                	li	a0,0
  a2:	360000ef          	jal	402 <wait>
  a6:	57fd                	li	a5,-1
  a8:	fcf51ae3          	bne	a0,a5,7c <forktest+0x56>
  }

  print("fork test OK\n");
  ac:	00000517          	auipc	a0,0x0
  b0:	5dc50513          	addi	a0,a0,1500 # 688 <malloc+0x134>
  b4:	f4dff0ef          	jal	0 <print>
}
  b8:	60e2                	ld	ra,24(sp)
  ba:	6442                	ld	s0,16(sp)
  bc:	64a2                	ld	s1,8(sp)
  be:	6902                	ld	s2,0(sp)
  c0:	6105                	addi	sp,sp,32
  c2:	8082                	ret

00000000000000c4 <main>:

int
main(void)
{
  c4:	1141                	addi	sp,sp,-16
  c6:	e406                	sd	ra,8(sp)
  c8:	e022                	sd	s0,0(sp)
  ca:	0800                	addi	s0,sp,16
  forktest();
  cc:	f5bff0ef          	jal	26 <forktest>
  exit(0);
  d0:	4501                	li	a0,0
  d2:	328000ef          	jal	3fa <exit>

00000000000000d6 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  d6:	1141                	addi	sp,sp,-16
  d8:	e406                	sd	ra,8(sp)
  da:	e022                	sd	s0,0(sp)
  dc:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  de:	fe7ff0ef          	jal	c4 <main>
  exit(r);
  e2:	318000ef          	jal	3fa <exit>

00000000000000e6 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  e6:	1141                	addi	sp,sp,-16
  e8:	e422                	sd	s0,8(sp)
  ea:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  ec:	87aa                	mv	a5,a0
  ee:	0585                	addi	a1,a1,1
  f0:	0785                	addi	a5,a5,1
  f2:	fff5c703          	lbu	a4,-1(a1)
  f6:	fee78fa3          	sb	a4,-1(a5)
  fa:	fb75                	bnez	a4,ee <strcpy+0x8>
    ;
  return os;
}
  fc:	6422                	ld	s0,8(sp)
  fe:	0141                	addi	sp,sp,16
 100:	8082                	ret

0000000000000102 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 102:	1141                	addi	sp,sp,-16
 104:	e422                	sd	s0,8(sp)
 106:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 108:	00054783          	lbu	a5,0(a0)
 10c:	cb91                	beqz	a5,120 <strcmp+0x1e>
 10e:	0005c703          	lbu	a4,0(a1)
 112:	00f71763          	bne	a4,a5,120 <strcmp+0x1e>
    p++, q++;
 116:	0505                	addi	a0,a0,1
 118:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 11a:	00054783          	lbu	a5,0(a0)
 11e:	fbe5                	bnez	a5,10e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 120:	0005c503          	lbu	a0,0(a1)
}
 124:	40a7853b          	subw	a0,a5,a0
 128:	6422                	ld	s0,8(sp)
 12a:	0141                	addi	sp,sp,16
 12c:	8082                	ret

000000000000012e <strlen>:

uint
strlen(const char *s)
{
 12e:	1141                	addi	sp,sp,-16
 130:	e422                	sd	s0,8(sp)
 132:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 134:	00054783          	lbu	a5,0(a0)
 138:	cf91                	beqz	a5,154 <strlen+0x26>
 13a:	0505                	addi	a0,a0,1
 13c:	87aa                	mv	a5,a0
 13e:	86be                	mv	a3,a5
 140:	0785                	addi	a5,a5,1
 142:	fff7c703          	lbu	a4,-1(a5)
 146:	ff65                	bnez	a4,13e <strlen+0x10>
 148:	40a6853b          	subw	a0,a3,a0
 14c:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 14e:	6422                	ld	s0,8(sp)
 150:	0141                	addi	sp,sp,16
 152:	8082                	ret
  for(n = 0; s[n]; n++)
 154:	4501                	li	a0,0
 156:	bfe5                	j	14e <strlen+0x20>

0000000000000158 <memset>:

void*
memset(void *dst, int c, uint n)
{
 158:	1141                	addi	sp,sp,-16
 15a:	e422                	sd	s0,8(sp)
 15c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 15e:	ca19                	beqz	a2,174 <memset+0x1c>
 160:	87aa                	mv	a5,a0
 162:	1602                	slli	a2,a2,0x20
 164:	9201                	srli	a2,a2,0x20
 166:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 16a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 16e:	0785                	addi	a5,a5,1
 170:	fee79de3          	bne	a5,a4,16a <memset+0x12>
  }
  return dst;
}
 174:	6422                	ld	s0,8(sp)
 176:	0141                	addi	sp,sp,16
 178:	8082                	ret

000000000000017a <strchr>:

char*
strchr(const char *s, char c)
{
 17a:	1141                	addi	sp,sp,-16
 17c:	e422                	sd	s0,8(sp)
 17e:	0800                	addi	s0,sp,16
  for(; *s; s++)
 180:	00054783          	lbu	a5,0(a0)
 184:	cb99                	beqz	a5,19a <strchr+0x20>
    if(*s == c)
 186:	00f58763          	beq	a1,a5,194 <strchr+0x1a>
  for(; *s; s++)
 18a:	0505                	addi	a0,a0,1
 18c:	00054783          	lbu	a5,0(a0)
 190:	fbfd                	bnez	a5,186 <strchr+0xc>
      return (char*)s;
  return 0;
 192:	4501                	li	a0,0
}
 194:	6422                	ld	s0,8(sp)
 196:	0141                	addi	sp,sp,16
 198:	8082                	ret
  return 0;
 19a:	4501                	li	a0,0
 19c:	bfe5                	j	194 <strchr+0x1a>

000000000000019e <gets>:

char*
gets(char *buf, int max)
{
 19e:	711d                	addi	sp,sp,-96
 1a0:	ec86                	sd	ra,88(sp)
 1a2:	e8a2                	sd	s0,80(sp)
 1a4:	e4a6                	sd	s1,72(sp)
 1a6:	e0ca                	sd	s2,64(sp)
 1a8:	fc4e                	sd	s3,56(sp)
 1aa:	f852                	sd	s4,48(sp)
 1ac:	f456                	sd	s5,40(sp)
 1ae:	f05a                	sd	s6,32(sp)
 1b0:	ec5e                	sd	s7,24(sp)
 1b2:	1080                	addi	s0,sp,96
 1b4:	8baa                	mv	s7,a0
 1b6:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1b8:	892a                	mv	s2,a0
 1ba:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1bc:	4aa9                	li	s5,10
 1be:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1c0:	89a6                	mv	s3,s1
 1c2:	2485                	addiw	s1,s1,1
 1c4:	0344d663          	bge	s1,s4,1f0 <gets+0x52>
    cc = read(0, &c, 1);
 1c8:	4605                	li	a2,1
 1ca:	faf40593          	addi	a1,s0,-81
 1ce:	4501                	li	a0,0
 1d0:	242000ef          	jal	412 <read>
    if(cc < 1)
 1d4:	00a05e63          	blez	a0,1f0 <gets+0x52>
    buf[i++] = c;
 1d8:	faf44783          	lbu	a5,-81(s0)
 1dc:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1e0:	01578763          	beq	a5,s5,1ee <gets+0x50>
 1e4:	0905                	addi	s2,s2,1
 1e6:	fd679de3          	bne	a5,s6,1c0 <gets+0x22>
    buf[i++] = c;
 1ea:	89a6                	mv	s3,s1
 1ec:	a011                	j	1f0 <gets+0x52>
 1ee:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1f0:	99de                	add	s3,s3,s7
 1f2:	00098023          	sb	zero,0(s3)
  return buf;
}
 1f6:	855e                	mv	a0,s7
 1f8:	60e6                	ld	ra,88(sp)
 1fa:	6446                	ld	s0,80(sp)
 1fc:	64a6                	ld	s1,72(sp)
 1fe:	6906                	ld	s2,64(sp)
 200:	79e2                	ld	s3,56(sp)
 202:	7a42                	ld	s4,48(sp)
 204:	7aa2                	ld	s5,40(sp)
 206:	7b02                	ld	s6,32(sp)
 208:	6be2                	ld	s7,24(sp)
 20a:	6125                	addi	sp,sp,96
 20c:	8082                	ret

000000000000020e <stat>:

int
stat(const char *n, struct stat *st)
{
 20e:	1101                	addi	sp,sp,-32
 210:	ec06                	sd	ra,24(sp)
 212:	e822                	sd	s0,16(sp)
 214:	e04a                	sd	s2,0(sp)
 216:	1000                	addi	s0,sp,32
 218:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 21a:	4581                	li	a1,0
 21c:	21e000ef          	jal	43a <open>
  if(fd < 0)
 220:	02054263          	bltz	a0,244 <stat+0x36>
 224:	e426                	sd	s1,8(sp)
 226:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 228:	85ca                	mv	a1,s2
 22a:	228000ef          	jal	452 <fstat>
 22e:	892a                	mv	s2,a0
  close(fd);
 230:	8526                	mv	a0,s1
 232:	1f0000ef          	jal	422 <close>
  return r;
 236:	64a2                	ld	s1,8(sp)
}
 238:	854a                	mv	a0,s2
 23a:	60e2                	ld	ra,24(sp)
 23c:	6442                	ld	s0,16(sp)
 23e:	6902                	ld	s2,0(sp)
 240:	6105                	addi	sp,sp,32
 242:	8082                	ret
    return -1;
 244:	597d                	li	s2,-1
 246:	bfcd                	j	238 <stat+0x2a>

0000000000000248 <atoi>:

int
atoi(const char *s)
{
 248:	1141                	addi	sp,sp,-16
 24a:	e422                	sd	s0,8(sp)
 24c:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 24e:	00054683          	lbu	a3,0(a0)
 252:	fd06879b          	addiw	a5,a3,-48
 256:	0ff7f793          	zext.b	a5,a5
 25a:	4625                	li	a2,9
 25c:	02f66863          	bltu	a2,a5,28c <atoi+0x44>
 260:	872a                	mv	a4,a0
  n = 0;
 262:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 264:	0705                	addi	a4,a4,1
 266:	0025179b          	slliw	a5,a0,0x2
 26a:	9fa9                	addw	a5,a5,a0
 26c:	0017979b          	slliw	a5,a5,0x1
 270:	9fb5                	addw	a5,a5,a3
 272:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 276:	00074683          	lbu	a3,0(a4)
 27a:	fd06879b          	addiw	a5,a3,-48
 27e:	0ff7f793          	zext.b	a5,a5
 282:	fef671e3          	bgeu	a2,a5,264 <atoi+0x1c>
  return n;
}
 286:	6422                	ld	s0,8(sp)
 288:	0141                	addi	sp,sp,16
 28a:	8082                	ret
  n = 0;
 28c:	4501                	li	a0,0
 28e:	bfe5                	j	286 <atoi+0x3e>

0000000000000290 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 290:	1141                	addi	sp,sp,-16
 292:	e422                	sd	s0,8(sp)
 294:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 296:	02b57463          	bgeu	a0,a1,2be <memmove+0x2e>
    while(n-- > 0)
 29a:	00c05f63          	blez	a2,2b8 <memmove+0x28>
 29e:	1602                	slli	a2,a2,0x20
 2a0:	9201                	srli	a2,a2,0x20
 2a2:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2a6:	872a                	mv	a4,a0
      *dst++ = *src++;
 2a8:	0585                	addi	a1,a1,1
 2aa:	0705                	addi	a4,a4,1
 2ac:	fff5c683          	lbu	a3,-1(a1)
 2b0:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2b4:	fef71ae3          	bne	a4,a5,2a8 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2b8:	6422                	ld	s0,8(sp)
 2ba:	0141                	addi	sp,sp,16
 2bc:	8082                	ret
    dst += n;
 2be:	00c50733          	add	a4,a0,a2
    src += n;
 2c2:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2c4:	fec05ae3          	blez	a2,2b8 <memmove+0x28>
 2c8:	fff6079b          	addiw	a5,a2,-1
 2cc:	1782                	slli	a5,a5,0x20
 2ce:	9381                	srli	a5,a5,0x20
 2d0:	fff7c793          	not	a5,a5
 2d4:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2d6:	15fd                	addi	a1,a1,-1
 2d8:	177d                	addi	a4,a4,-1
 2da:	0005c683          	lbu	a3,0(a1)
 2de:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2e2:	fee79ae3          	bne	a5,a4,2d6 <memmove+0x46>
 2e6:	bfc9                	j	2b8 <memmove+0x28>

00000000000002e8 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2e8:	1141                	addi	sp,sp,-16
 2ea:	e422                	sd	s0,8(sp)
 2ec:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2ee:	ca05                	beqz	a2,31e <memcmp+0x36>
 2f0:	fff6069b          	addiw	a3,a2,-1
 2f4:	1682                	slli	a3,a3,0x20
 2f6:	9281                	srli	a3,a3,0x20
 2f8:	0685                	addi	a3,a3,1
 2fa:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2fc:	00054783          	lbu	a5,0(a0)
 300:	0005c703          	lbu	a4,0(a1)
 304:	00e79863          	bne	a5,a4,314 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 308:	0505                	addi	a0,a0,1
    p2++;
 30a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 30c:	fed518e3          	bne	a0,a3,2fc <memcmp+0x14>
  }
  return 0;
 310:	4501                	li	a0,0
 312:	a019                	j	318 <memcmp+0x30>
      return *p1 - *p2;
 314:	40e7853b          	subw	a0,a5,a4
}
 318:	6422                	ld	s0,8(sp)
 31a:	0141                	addi	sp,sp,16
 31c:	8082                	ret
  return 0;
 31e:	4501                	li	a0,0
 320:	bfe5                	j	318 <memcmp+0x30>

0000000000000322 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 322:	1141                	addi	sp,sp,-16
 324:	e406                	sd	ra,8(sp)
 326:	e022                	sd	s0,0(sp)
 328:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 32a:	f67ff0ef          	jal	290 <memmove>
}
 32e:	60a2                	ld	ra,8(sp)
 330:	6402                	ld	s0,0(sp)
 332:	0141                	addi	sp,sp,16
 334:	8082                	ret

0000000000000336 <sbrk>:

char *
sbrk(int n) {
 336:	1141                	addi	sp,sp,-16
 338:	e406                	sd	ra,8(sp)
 33a:	e022                	sd	s0,0(sp)
 33c:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 33e:	4585                	li	a1,1
 340:	142000ef          	jal	482 <sys_sbrk>
}
 344:	60a2                	ld	ra,8(sp)
 346:	6402                	ld	s0,0(sp)
 348:	0141                	addi	sp,sp,16
 34a:	8082                	ret

000000000000034c <sbrklazy>:

char *
sbrklazy(int n) {
 34c:	1141                	addi	sp,sp,-16
 34e:	e406                	sd	ra,8(sp)
 350:	e022                	sd	s0,0(sp)
 352:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 354:	4589                	li	a1,2
 356:	12c000ef          	jal	482 <sys_sbrk>
}
 35a:	60a2                	ld	ra,8(sp)
 35c:	6402                	ld	s0,0(sp)
 35e:	0141                	addi	sp,sp,16
 360:	8082                	ret

0000000000000362 <thread_create>:
// thread_create allocates a page-sized stack, calls clone(fn, arg, stacktop).
// Returns the new thread's pid, or -1 on error.
// The stack is passed back via *stack so the caller can free it after join.
int
thread_create(void(*fn)(void*), void *arg, void **stack)
{
 362:	7179                	addi	sp,sp,-48
 364:	f406                	sd	ra,40(sp)
 366:	f022                	sd	s0,32(sp)
 368:	e84a                	sd	s2,16(sp)
 36a:	e44e                	sd	s3,8(sp)
 36c:	e052                	sd	s4,0(sp)
 36e:	1800                	addi	s0,sp,48
 370:	89aa                	mv	s3,a0
 372:	8a2e                	mv	s4,a1
 374:	8932                	mv	s2,a2
  char *s = malloc(PGSIZE);
 376:	6505                	lui	a0,0x1
 378:	1dc000ef          	jal	554 <malloc>
  if(s == 0)
 37c:	cd0d                	beqz	a0,3b6 <thread_create+0x54>
 37e:	ec26                	sd	s1,24(sp)
 380:	84aa                	mv	s1,a0
    return -1;
  *stack = s;
 382:	00a93023          	sd	a0,0(s2)
  // Stack grows downward: pass the top of the allocated region.
  int pid = clone(fn, arg, s + PGSIZE);
 386:	6605                	lui	a2,0x1
 388:	962a                	add	a2,a2,a0
 38a:	85d2                	mv	a1,s4
 38c:	854e                	mv	a0,s3
 38e:	134000ef          	jal	4c2 <clone>
  if(pid < 0){
 392:	00054a63          	bltz	a0,3a6 <thread_create+0x44>
 396:	64e2                	ld	s1,24(sp)
    free(s);
    *stack = 0;
    return -1;
  }
  return pid;
}
 398:	70a2                	ld	ra,40(sp)
 39a:	7402                	ld	s0,32(sp)
 39c:	6942                	ld	s2,16(sp)
 39e:	69a2                	ld	s3,8(sp)
 3a0:	6a02                	ld	s4,0(sp)
 3a2:	6145                	addi	sp,sp,48
 3a4:	8082                	ret
    free(s);
 3a6:	8526                	mv	a0,s1
 3a8:	12a000ef          	jal	4d2 <free>
    *stack = 0;
 3ac:	00093023          	sd	zero,0(s2)
    return -1;
 3b0:	557d                	li	a0,-1
 3b2:	64e2                	ld	s1,24(sp)
 3b4:	b7d5                	j	398 <thread_create+0x36>
    return -1;
 3b6:	557d                	li	a0,-1
 3b8:	b7c5                	j	398 <thread_create+0x36>

00000000000003ba <thread_join>:
// Wait for any child thread to exit.
// If stack is non-null, frees the memory pointed to by *stack and clears it.
// Returns the joined thread's pid, or -1 on error.
int
thread_join(void **stack)
{
 3ba:	1101                	addi	sp,sp,-32
 3bc:	ec06                	sd	ra,24(sp)
 3be:	e822                	sd	s0,16(sp)
 3c0:	e426                	sd	s1,8(sp)
 3c2:	e04a                	sd	s2,0(sp)
 3c4:	1000                	addi	s0,sp,32
 3c6:	84aa                	mv	s1,a0
  int pid = join();
 3c8:	102000ef          	jal	4ca <join>
  if(pid < 0)
 3cc:	02054163          	bltz	a0,3ee <thread_join+0x34>
 3d0:	892a                	mv	s2,a0
    return -1;
  if(stack && *stack){
 3d2:	c499                	beqz	s1,3e0 <thread_join+0x26>
 3d4:	6088                	ld	a0,0(s1)
 3d6:	c509                	beqz	a0,3e0 <thread_join+0x26>
    free(*stack);
 3d8:	0fa000ef          	jal	4d2 <free>
    *stack = 0;
 3dc:	0004b023          	sd	zero,0(s1)
  }
  return pid;
}
 3e0:	854a                	mv	a0,s2
 3e2:	60e2                	ld	ra,24(sp)
 3e4:	6442                	ld	s0,16(sp)
 3e6:	64a2                	ld	s1,8(sp)
 3e8:	6902                	ld	s2,0(sp)
 3ea:	6105                	addi	sp,sp,32
 3ec:	8082                	ret
    return -1;
 3ee:	597d                	li	s2,-1
 3f0:	bfc5                	j	3e0 <thread_join+0x26>

00000000000003f2 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3f2:	4885                	li	a7,1
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <exit>:
.global exit
exit:
 li a7, SYS_exit
 3fa:	4889                	li	a7,2
 ecall
 3fc:	00000073          	ecall
 ret
 400:	8082                	ret

0000000000000402 <wait>:
.global wait
wait:
 li a7, SYS_wait
 402:	488d                	li	a7,3
 ecall
 404:	00000073          	ecall
 ret
 408:	8082                	ret

000000000000040a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 40a:	4891                	li	a7,4
 ecall
 40c:	00000073          	ecall
 ret
 410:	8082                	ret

0000000000000412 <read>:
.global read
read:
 li a7, SYS_read
 412:	4895                	li	a7,5
 ecall
 414:	00000073          	ecall
 ret
 418:	8082                	ret

000000000000041a <write>:
.global write
write:
 li a7, SYS_write
 41a:	48c1                	li	a7,16
 ecall
 41c:	00000073          	ecall
 ret
 420:	8082                	ret

0000000000000422 <close>:
.global close
close:
 li a7, SYS_close
 422:	48d5                	li	a7,21
 ecall
 424:	00000073          	ecall
 ret
 428:	8082                	ret

000000000000042a <kill>:
.global kill
kill:
 li a7, SYS_kill
 42a:	4899                	li	a7,6
 ecall
 42c:	00000073          	ecall
 ret
 430:	8082                	ret

0000000000000432 <exec>:
.global exec
exec:
 li a7, SYS_exec
 432:	489d                	li	a7,7
 ecall
 434:	00000073          	ecall
 ret
 438:	8082                	ret

000000000000043a <open>:
.global open
open:
 li a7, SYS_open
 43a:	48bd                	li	a7,15
 ecall
 43c:	00000073          	ecall
 ret
 440:	8082                	ret

0000000000000442 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 442:	48c5                	li	a7,17
 ecall
 444:	00000073          	ecall
 ret
 448:	8082                	ret

000000000000044a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 44a:	48c9                	li	a7,18
 ecall
 44c:	00000073          	ecall
 ret
 450:	8082                	ret

0000000000000452 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 452:	48a1                	li	a7,8
 ecall
 454:	00000073          	ecall
 ret
 458:	8082                	ret

000000000000045a <link>:
.global link
link:
 li a7, SYS_link
 45a:	48cd                	li	a7,19
 ecall
 45c:	00000073          	ecall
 ret
 460:	8082                	ret

0000000000000462 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 462:	48d1                	li	a7,20
 ecall
 464:	00000073          	ecall
 ret
 468:	8082                	ret

000000000000046a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 46a:	48a5                	li	a7,9
 ecall
 46c:	00000073          	ecall
 ret
 470:	8082                	ret

0000000000000472 <dup>:
.global dup
dup:
 li a7, SYS_dup
 472:	48a9                	li	a7,10
 ecall
 474:	00000073          	ecall
 ret
 478:	8082                	ret

000000000000047a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 47a:	48ad                	li	a7,11
 ecall
 47c:	00000073          	ecall
 ret
 480:	8082                	ret

0000000000000482 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 482:	48b1                	li	a7,12
 ecall
 484:	00000073          	ecall
 ret
 488:	8082                	ret

000000000000048a <pause>:
.global pause
pause:
 li a7, SYS_pause
 48a:	48b5                	li	a7,13
 ecall
 48c:	00000073          	ecall
 ret
 490:	8082                	ret

0000000000000492 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 492:	48b9                	li	a7,14
 ecall
 494:	00000073          	ecall
 ret
 498:	8082                	ret

000000000000049a <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 49a:	48d9                	li	a7,22
 ecall
 49c:	00000073          	ecall
 ret
 4a0:	8082                	ret

00000000000004a2 <lock_create>:
.global lock_create
lock_create:
 li a7, SYS_lock_create
 4a2:	48dd                	li	a7,23
 ecall
 4a4:	00000073          	ecall
 ret
 4a8:	8082                	ret

00000000000004aa <lock_acquire>:
.global lock_acquire
lock_acquire:
 li a7, SYS_lock_acquire
 4aa:	48e1                	li	a7,24
 ecall
 4ac:	00000073          	ecall
 ret
 4b0:	8082                	ret

00000000000004b2 <lock_release>:
.global lock_release
lock_release:
 li a7, SYS_lock_release
 4b2:	48e5                	li	a7,25
 ecall
 4b4:	00000073          	ecall
 ret
 4b8:	8082                	ret

00000000000004ba <lock_destroy>:
.global lock_destroy
lock_destroy:
 li a7, SYS_lock_destroy
 4ba:	48e9                	li	a7,26
 ecall
 4bc:	00000073          	ecall
 ret
 4c0:	8082                	ret

00000000000004c2 <clone>:
.global clone
clone:
 li a7, SYS_clone
 4c2:	48ed                	li	a7,27
 ecall
 4c4:	00000073          	ecall
 ret
 4c8:	8082                	ret

00000000000004ca <join>:
.global join
join:
 li a7, SYS_join
 4ca:	48f1                	li	a7,28
 ecall
 4cc:	00000073          	ecall
 ret
 4d0:	8082                	ret

00000000000004d2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 4d2:	1141                	addi	sp,sp,-16
 4d4:	e422                	sd	s0,8(sp)
 4d6:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 4d8:	ff050693          	addi	a3,a0,-16 # ff0 <__BSS_END__+0x520>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4dc:	00000797          	auipc	a5,0x0
 4e0:	5dc7b783          	ld	a5,1500(a5) # ab8 <freep>
 4e4:	a02d                	j	50e <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 4e6:	4618                	lw	a4,8(a2)
 4e8:	9f2d                	addw	a4,a4,a1
 4ea:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 4ee:	6398                	ld	a4,0(a5)
 4f0:	6310                	ld	a2,0(a4)
 4f2:	a83d                	j	530 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 4f4:	ff852703          	lw	a4,-8(a0)
 4f8:	9f31                	addw	a4,a4,a2
 4fa:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 4fc:	ff053683          	ld	a3,-16(a0)
 500:	a091                	j	544 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 502:	6398                	ld	a4,0(a5)
 504:	00e7e463          	bltu	a5,a4,50c <free+0x3a>
 508:	00e6ea63          	bltu	a3,a4,51c <free+0x4a>
{
 50c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 50e:	fed7fae3          	bgeu	a5,a3,502 <free+0x30>
 512:	6398                	ld	a4,0(a5)
 514:	00e6e463          	bltu	a3,a4,51c <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 518:	fee7eae3          	bltu	a5,a4,50c <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 51c:	ff852583          	lw	a1,-8(a0)
 520:	6390                	ld	a2,0(a5)
 522:	02059813          	slli	a6,a1,0x20
 526:	01c85713          	srli	a4,a6,0x1c
 52a:	9736                	add	a4,a4,a3
 52c:	fae60de3          	beq	a2,a4,4e6 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 530:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 534:	4790                	lw	a2,8(a5)
 536:	02061593          	slli	a1,a2,0x20
 53a:	01c5d713          	srli	a4,a1,0x1c
 53e:	973e                	add	a4,a4,a5
 540:	fae68ae3          	beq	a3,a4,4f4 <free+0x22>
    p->s.ptr = bp->s.ptr;
 544:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 546:	00000717          	auipc	a4,0x0
 54a:	56f73923          	sd	a5,1394(a4) # ab8 <freep>
}
 54e:	6422                	ld	s0,8(sp)
 550:	0141                	addi	sp,sp,16
 552:	8082                	ret

0000000000000554 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 554:	7139                	addi	sp,sp,-64
 556:	fc06                	sd	ra,56(sp)
 558:	f822                	sd	s0,48(sp)
 55a:	f426                	sd	s1,40(sp)
 55c:	ec4e                	sd	s3,24(sp)
 55e:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 560:	02051493          	slli	s1,a0,0x20
 564:	9081                	srli	s1,s1,0x20
 566:	04bd                	addi	s1,s1,15
 568:	8091                	srli	s1,s1,0x4
 56a:	0014899b          	addiw	s3,s1,1
 56e:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 570:	00000517          	auipc	a0,0x0
 574:	54853503          	ld	a0,1352(a0) # ab8 <freep>
 578:	c915                	beqz	a0,5ac <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 57a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 57c:	4798                	lw	a4,8(a5)
 57e:	08977863          	bgeu	a4,s1,60e <malloc+0xba>
 582:	f04a                	sd	s2,32(sp)
 584:	e852                	sd	s4,16(sp)
 586:	e456                	sd	s5,8(sp)
 588:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 58a:	8a4e                	mv	s4,s3
 58c:	0009871b          	sext.w	a4,s3
 590:	6685                	lui	a3,0x1
 592:	00d77363          	bgeu	a4,a3,598 <malloc+0x44>
 596:	6a05                	lui	s4,0x1
 598:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 59c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 5a0:	00000917          	auipc	s2,0x0
 5a4:	51890913          	addi	s2,s2,1304 # ab8 <freep>
  if(p == SBRK_ERROR)
 5a8:	5afd                	li	s5,-1
 5aa:	a835                	j	5e6 <malloc+0x92>
 5ac:	f04a                	sd	s2,32(sp)
 5ae:	e852                	sd	s4,16(sp)
 5b0:	e456                	sd	s5,8(sp)
 5b2:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 5b4:	80c18793          	addi	a5,gp,-2036 # ac0 <base>
 5b8:	00000717          	auipc	a4,0x0
 5bc:	50f73023          	sd	a5,1280(a4) # ab8 <freep>
 5c0:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 5c2:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 5c6:	b7d1                	j	58a <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 5c8:	6398                	ld	a4,0(a5)
 5ca:	e118                	sd	a4,0(a0)
 5cc:	a8a9                	j	626 <malloc+0xd2>
  hp->s.size = nu;
 5ce:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 5d2:	0541                	addi	a0,a0,16
 5d4:	effff0ef          	jal	4d2 <free>
  return freep;
 5d8:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 5dc:	c12d                	beqz	a0,63e <malloc+0xea>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5de:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 5e0:	4798                	lw	a4,8(a5)
 5e2:	02977263          	bgeu	a4,s1,606 <malloc+0xb2>
    if(p == freep)
 5e6:	00093703          	ld	a4,0(s2)
 5ea:	853e                	mv	a0,a5
 5ec:	fef719e3          	bne	a4,a5,5de <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 5f0:	8552                	mv	a0,s4
 5f2:	d45ff0ef          	jal	336 <sbrk>
  if(p == SBRK_ERROR)
 5f6:	fd551ce3          	bne	a0,s5,5ce <malloc+0x7a>
        return 0;
 5fa:	4501                	li	a0,0
 5fc:	7902                	ld	s2,32(sp)
 5fe:	6a42                	ld	s4,16(sp)
 600:	6aa2                	ld	s5,8(sp)
 602:	6b02                	ld	s6,0(sp)
 604:	a03d                	j	632 <malloc+0xde>
 606:	7902                	ld	s2,32(sp)
 608:	6a42                	ld	s4,16(sp)
 60a:	6aa2                	ld	s5,8(sp)
 60c:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 60e:	fae48de3          	beq	s1,a4,5c8 <malloc+0x74>
        p->s.size -= nunits;
 612:	4137073b          	subw	a4,a4,s3
 616:	c798                	sw	a4,8(a5)
        p += p->s.size;
 618:	02071693          	slli	a3,a4,0x20
 61c:	01c6d713          	srli	a4,a3,0x1c
 620:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 622:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 626:	00000717          	auipc	a4,0x0
 62a:	48a73923          	sd	a0,1170(a4) # ab8 <freep>
      return (void*)(p + 1);
 62e:	01078513          	addi	a0,a5,16
  }
}
 632:	70e2                	ld	ra,56(sp)
 634:	7442                	ld	s0,48(sp)
 636:	74a2                	ld	s1,40(sp)
 638:	69e2                	ld	s3,24(sp)
 63a:	6121                	addi	sp,sp,64
 63c:	8082                	ret
 63e:	7902                	ld	s2,32(sp)
 640:	6a42                	ld	s4,16(sp)
 642:	6aa2                	ld	s5,8(sp)
 644:	6b02                	ld	s6,0(sp)
 646:	b7f5                	j	632 <malloc+0xde>
