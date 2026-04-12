
user/_zombie:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
   8:	332000ef          	jal	33a <fork>
   c:	00a04563          	bgtz	a0,16 <main+0x16>
  10:	4501                	li	a0,0
  12:	330000ef          	jal	342 <exit>
  16:	4515                	li	a0,5
  18:	3ba000ef          	jal	3d2 <pause>
  1c:	bfd5                	j	10 <main+0x10>

000000000000001e <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  1e:	1141                	addi	sp,sp,-16
  20:	e406                	sd	ra,8(sp)
  22:	e022                	sd	s0,0(sp)
  24:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  26:	fdbff0ef          	jal	0 <main>
  exit(r);
  2a:	318000ef          	jal	342 <exit>

000000000000002e <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  2e:	1141                	addi	sp,sp,-16
  30:	e422                	sd	s0,8(sp)
  32:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  34:	87aa                	mv	a5,a0
  36:	0585                	addi	a1,a1,1
  38:	0785                	addi	a5,a5,1
  3a:	fff5c703          	lbu	a4,-1(a1)
  3e:	fee78fa3          	sb	a4,-1(a5)
  42:	fb75                	bnez	a4,36 <strcpy+0x8>
    ;
  return os;
}
  44:	6422                	ld	s0,8(sp)
  46:	0141                	addi	sp,sp,16
  48:	8082                	ret

000000000000004a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  4a:	1141                	addi	sp,sp,-16
  4c:	e422                	sd	s0,8(sp)
  4e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  50:	00054783          	lbu	a5,0(a0)
  54:	cb91                	beqz	a5,68 <strcmp+0x1e>
  56:	0005c703          	lbu	a4,0(a1)
  5a:	00f71763          	bne	a4,a5,68 <strcmp+0x1e>
    p++, q++;
  5e:	0505                	addi	a0,a0,1
  60:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  62:	00054783          	lbu	a5,0(a0)
  66:	fbe5                	bnez	a5,56 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  68:	0005c503          	lbu	a0,0(a1)
}
  6c:	40a7853b          	subw	a0,a5,a0
  70:	6422                	ld	s0,8(sp)
  72:	0141                	addi	sp,sp,16
  74:	8082                	ret

0000000000000076 <strlen>:

uint
strlen(const char *s)
{
  76:	1141                	addi	sp,sp,-16
  78:	e422                	sd	s0,8(sp)
  7a:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  7c:	00054783          	lbu	a5,0(a0)
  80:	cf91                	beqz	a5,9c <strlen+0x26>
  82:	0505                	addi	a0,a0,1
  84:	87aa                	mv	a5,a0
  86:	86be                	mv	a3,a5
  88:	0785                	addi	a5,a5,1
  8a:	fff7c703          	lbu	a4,-1(a5)
  8e:	ff65                	bnez	a4,86 <strlen+0x10>
  90:	40a6853b          	subw	a0,a3,a0
  94:	2505                	addiw	a0,a0,1
    ;
  return n;
}
  96:	6422                	ld	s0,8(sp)
  98:	0141                	addi	sp,sp,16
  9a:	8082                	ret
  for(n = 0; s[n]; n++)
  9c:	4501                	li	a0,0
  9e:	bfe5                	j	96 <strlen+0x20>

00000000000000a0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  a0:	1141                	addi	sp,sp,-16
  a2:	e422                	sd	s0,8(sp)
  a4:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  a6:	ca19                	beqz	a2,bc <memset+0x1c>
  a8:	87aa                	mv	a5,a0
  aa:	1602                	slli	a2,a2,0x20
  ac:	9201                	srli	a2,a2,0x20
  ae:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  b2:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  b6:	0785                	addi	a5,a5,1
  b8:	fee79de3          	bne	a5,a4,b2 <memset+0x12>
  }
  return dst;
}
  bc:	6422                	ld	s0,8(sp)
  be:	0141                	addi	sp,sp,16
  c0:	8082                	ret

00000000000000c2 <strchr>:

char*
strchr(const char *s, char c)
{
  c2:	1141                	addi	sp,sp,-16
  c4:	e422                	sd	s0,8(sp)
  c6:	0800                	addi	s0,sp,16
  for(; *s; s++)
  c8:	00054783          	lbu	a5,0(a0)
  cc:	cb99                	beqz	a5,e2 <strchr+0x20>
    if(*s == c)
  ce:	00f58763          	beq	a1,a5,dc <strchr+0x1a>
  for(; *s; s++)
  d2:	0505                	addi	a0,a0,1
  d4:	00054783          	lbu	a5,0(a0)
  d8:	fbfd                	bnez	a5,ce <strchr+0xc>
      return (char*)s;
  return 0;
  da:	4501                	li	a0,0
}
  dc:	6422                	ld	s0,8(sp)
  de:	0141                	addi	sp,sp,16
  e0:	8082                	ret
  return 0;
  e2:	4501                	li	a0,0
  e4:	bfe5                	j	dc <strchr+0x1a>

00000000000000e6 <gets>:

char*
gets(char *buf, int max)
{
  e6:	711d                	addi	sp,sp,-96
  e8:	ec86                	sd	ra,88(sp)
  ea:	e8a2                	sd	s0,80(sp)
  ec:	e4a6                	sd	s1,72(sp)
  ee:	e0ca                	sd	s2,64(sp)
  f0:	fc4e                	sd	s3,56(sp)
  f2:	f852                	sd	s4,48(sp)
  f4:	f456                	sd	s5,40(sp)
  f6:	f05a                	sd	s6,32(sp)
  f8:	ec5e                	sd	s7,24(sp)
  fa:	1080                	addi	s0,sp,96
  fc:	8baa                	mv	s7,a0
  fe:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 100:	892a                	mv	s2,a0
 102:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 104:	4aa9                	li	s5,10
 106:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 108:	89a6                	mv	s3,s1
 10a:	2485                	addiw	s1,s1,1
 10c:	0344d663          	bge	s1,s4,138 <gets+0x52>
    cc = read(0, &c, 1);
 110:	4605                	li	a2,1
 112:	faf40593          	addi	a1,s0,-81
 116:	4501                	li	a0,0
 118:	242000ef          	jal	35a <read>
    if(cc < 1)
 11c:	00a05e63          	blez	a0,138 <gets+0x52>
    buf[i++] = c;
 120:	faf44783          	lbu	a5,-81(s0)
 124:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 128:	01578763          	beq	a5,s5,136 <gets+0x50>
 12c:	0905                	addi	s2,s2,1
 12e:	fd679de3          	bne	a5,s6,108 <gets+0x22>
    buf[i++] = c;
 132:	89a6                	mv	s3,s1
 134:	a011                	j	138 <gets+0x52>
 136:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 138:	99de                	add	s3,s3,s7
 13a:	00098023          	sb	zero,0(s3)
  return buf;
}
 13e:	855e                	mv	a0,s7
 140:	60e6                	ld	ra,88(sp)
 142:	6446                	ld	s0,80(sp)
 144:	64a6                	ld	s1,72(sp)
 146:	6906                	ld	s2,64(sp)
 148:	79e2                	ld	s3,56(sp)
 14a:	7a42                	ld	s4,48(sp)
 14c:	7aa2                	ld	s5,40(sp)
 14e:	7b02                	ld	s6,32(sp)
 150:	6be2                	ld	s7,24(sp)
 152:	6125                	addi	sp,sp,96
 154:	8082                	ret

0000000000000156 <stat>:

int
stat(const char *n, struct stat *st)
{
 156:	1101                	addi	sp,sp,-32
 158:	ec06                	sd	ra,24(sp)
 15a:	e822                	sd	s0,16(sp)
 15c:	e04a                	sd	s2,0(sp)
 15e:	1000                	addi	s0,sp,32
 160:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 162:	4581                	li	a1,0
 164:	21e000ef          	jal	382 <open>
  if(fd < 0)
 168:	02054263          	bltz	a0,18c <stat+0x36>
 16c:	e426                	sd	s1,8(sp)
 16e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 170:	85ca                	mv	a1,s2
 172:	228000ef          	jal	39a <fstat>
 176:	892a                	mv	s2,a0
  close(fd);
 178:	8526                	mv	a0,s1
 17a:	1f0000ef          	jal	36a <close>
  return r;
 17e:	64a2                	ld	s1,8(sp)
}
 180:	854a                	mv	a0,s2
 182:	60e2                	ld	ra,24(sp)
 184:	6442                	ld	s0,16(sp)
 186:	6902                	ld	s2,0(sp)
 188:	6105                	addi	sp,sp,32
 18a:	8082                	ret
    return -1;
 18c:	597d                	li	s2,-1
 18e:	bfcd                	j	180 <stat+0x2a>

0000000000000190 <atoi>:

int
atoi(const char *s)
{
 190:	1141                	addi	sp,sp,-16
 192:	e422                	sd	s0,8(sp)
 194:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 196:	00054683          	lbu	a3,0(a0)
 19a:	fd06879b          	addiw	a5,a3,-48
 19e:	0ff7f793          	zext.b	a5,a5
 1a2:	4625                	li	a2,9
 1a4:	02f66863          	bltu	a2,a5,1d4 <atoi+0x44>
 1a8:	872a                	mv	a4,a0
  n = 0;
 1aa:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 1ac:	0705                	addi	a4,a4,1
 1ae:	0025179b          	slliw	a5,a0,0x2
 1b2:	9fa9                	addw	a5,a5,a0
 1b4:	0017979b          	slliw	a5,a5,0x1
 1b8:	9fb5                	addw	a5,a5,a3
 1ba:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1be:	00074683          	lbu	a3,0(a4)
 1c2:	fd06879b          	addiw	a5,a3,-48
 1c6:	0ff7f793          	zext.b	a5,a5
 1ca:	fef671e3          	bgeu	a2,a5,1ac <atoi+0x1c>
  return n;
}
 1ce:	6422                	ld	s0,8(sp)
 1d0:	0141                	addi	sp,sp,16
 1d2:	8082                	ret
  n = 0;
 1d4:	4501                	li	a0,0
 1d6:	bfe5                	j	1ce <atoi+0x3e>

00000000000001d8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1d8:	1141                	addi	sp,sp,-16
 1da:	e422                	sd	s0,8(sp)
 1dc:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 1de:	02b57463          	bgeu	a0,a1,206 <memmove+0x2e>
    while(n-- > 0)
 1e2:	00c05f63          	blez	a2,200 <memmove+0x28>
 1e6:	1602                	slli	a2,a2,0x20
 1e8:	9201                	srli	a2,a2,0x20
 1ea:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 1ee:	872a                	mv	a4,a0
      *dst++ = *src++;
 1f0:	0585                	addi	a1,a1,1
 1f2:	0705                	addi	a4,a4,1
 1f4:	fff5c683          	lbu	a3,-1(a1)
 1f8:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 1fc:	fef71ae3          	bne	a4,a5,1f0 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 200:	6422                	ld	s0,8(sp)
 202:	0141                	addi	sp,sp,16
 204:	8082                	ret
    dst += n;
 206:	00c50733          	add	a4,a0,a2
    src += n;
 20a:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 20c:	fec05ae3          	blez	a2,200 <memmove+0x28>
 210:	fff6079b          	addiw	a5,a2,-1
 214:	1782                	slli	a5,a5,0x20
 216:	9381                	srli	a5,a5,0x20
 218:	fff7c793          	not	a5,a5
 21c:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 21e:	15fd                	addi	a1,a1,-1
 220:	177d                	addi	a4,a4,-1
 222:	0005c683          	lbu	a3,0(a1)
 226:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 22a:	fee79ae3          	bne	a5,a4,21e <memmove+0x46>
 22e:	bfc9                	j	200 <memmove+0x28>

0000000000000230 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 230:	1141                	addi	sp,sp,-16
 232:	e422                	sd	s0,8(sp)
 234:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 236:	ca05                	beqz	a2,266 <memcmp+0x36>
 238:	fff6069b          	addiw	a3,a2,-1
 23c:	1682                	slli	a3,a3,0x20
 23e:	9281                	srli	a3,a3,0x20
 240:	0685                	addi	a3,a3,1
 242:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 244:	00054783          	lbu	a5,0(a0)
 248:	0005c703          	lbu	a4,0(a1)
 24c:	00e79863          	bne	a5,a4,25c <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 250:	0505                	addi	a0,a0,1
    p2++;
 252:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 254:	fed518e3          	bne	a0,a3,244 <memcmp+0x14>
  }
  return 0;
 258:	4501                	li	a0,0
 25a:	a019                	j	260 <memcmp+0x30>
      return *p1 - *p2;
 25c:	40e7853b          	subw	a0,a5,a4
}
 260:	6422                	ld	s0,8(sp)
 262:	0141                	addi	sp,sp,16
 264:	8082                	ret
  return 0;
 266:	4501                	li	a0,0
 268:	bfe5                	j	260 <memcmp+0x30>

000000000000026a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 26a:	1141                	addi	sp,sp,-16
 26c:	e406                	sd	ra,8(sp)
 26e:	e022                	sd	s0,0(sp)
 270:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 272:	f67ff0ef          	jal	1d8 <memmove>
}
 276:	60a2                	ld	ra,8(sp)
 278:	6402                	ld	s0,0(sp)
 27a:	0141                	addi	sp,sp,16
 27c:	8082                	ret

000000000000027e <sbrk>:

char *
sbrk(int n) {
 27e:	1141                	addi	sp,sp,-16
 280:	e406                	sd	ra,8(sp)
 282:	e022                	sd	s0,0(sp)
 284:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 286:	4585                	li	a1,1
 288:	142000ef          	jal	3ca <sys_sbrk>
}
 28c:	60a2                	ld	ra,8(sp)
 28e:	6402                	ld	s0,0(sp)
 290:	0141                	addi	sp,sp,16
 292:	8082                	ret

0000000000000294 <sbrklazy>:

char *
sbrklazy(int n) {
 294:	1141                	addi	sp,sp,-16
 296:	e406                	sd	ra,8(sp)
 298:	e022                	sd	s0,0(sp)
 29a:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 29c:	4589                	li	a1,2
 29e:	12c000ef          	jal	3ca <sys_sbrk>
}
 2a2:	60a2                	ld	ra,8(sp)
 2a4:	6402                	ld	s0,0(sp)
 2a6:	0141                	addi	sp,sp,16
 2a8:	8082                	ret

00000000000002aa <thread_create>:
// thread_create allocates a page-sized stack, calls clone(fn, arg, stacktop).
// Returns the new thread's pid, or -1 on error.
// The stack is passed back via *stack so the caller can free it after join.
int
thread_create(void(*fn)(void*), void *arg, void **stack)
{
 2aa:	7179                	addi	sp,sp,-48
 2ac:	f406                	sd	ra,40(sp)
 2ae:	f022                	sd	s0,32(sp)
 2b0:	e84a                	sd	s2,16(sp)
 2b2:	e44e                	sd	s3,8(sp)
 2b4:	e052                	sd	s4,0(sp)
 2b6:	1800                	addi	s0,sp,48
 2b8:	89aa                	mv	s3,a0
 2ba:	8a2e                	mv	s4,a1
 2bc:	8932                	mv	s2,a2
  char *s = malloc(PGSIZE);
 2be:	6505                	lui	a0,0x1
 2c0:	5b8000ef          	jal	878 <malloc>
  if(s == 0)
 2c4:	cd0d                	beqz	a0,2fe <thread_create+0x54>
 2c6:	ec26                	sd	s1,24(sp)
 2c8:	84aa                	mv	s1,a0
    return -1;
  *stack = s;
 2ca:	00a93023          	sd	a0,0(s2)
  // Stack grows downward- pass the top of the allocated region.
  int pid = clone(fn, arg, s + PGSIZE);
 2ce:	6605                	lui	a2,0x1
 2d0:	962a                	add	a2,a2,a0
 2d2:	85d2                	mv	a1,s4
 2d4:	854e                	mv	a0,s3
 2d6:	134000ef          	jal	40a <clone>
  if(pid < 0){
 2da:	00054a63          	bltz	a0,2ee <thread_create+0x44>
 2de:	64e2                	ld	s1,24(sp)
    free(s);
    *stack = 0;
    return -1;
  }
  return pid;
}
 2e0:	70a2                	ld	ra,40(sp)
 2e2:	7402                	ld	s0,32(sp)
 2e4:	6942                	ld	s2,16(sp)
 2e6:	69a2                	ld	s3,8(sp)
 2e8:	6a02                	ld	s4,0(sp)
 2ea:	6145                	addi	sp,sp,48
 2ec:	8082                	ret
    free(s);
 2ee:	8526                	mv	a0,s1
 2f0:	506000ef          	jal	7f6 <free>
    *stack = 0;
 2f4:	00093023          	sd	zero,0(s2)
    return -1;
 2f8:	557d                	li	a0,-1
 2fa:	64e2                	ld	s1,24(sp)
 2fc:	b7d5                	j	2e0 <thread_create+0x36>
    return -1;
 2fe:	557d                	li	a0,-1
 300:	b7c5                	j	2e0 <thread_create+0x36>

0000000000000302 <thread_join>:
// Wait for any child thread to exit.
// If stack is non-null, frees the memory pointed to by *stack and clears it.
// Returns the joined thread's pid, or -1 Son error.
int
thread_join(void **stack)
{
 302:	1101                	addi	sp,sp,-32
 304:	ec06                	sd	ra,24(sp)
 306:	e822                	sd	s0,16(sp)
 308:	e426                	sd	s1,8(sp)
 30a:	e04a                	sd	s2,0(sp)
 30c:	1000                	addi	s0,sp,32
 30e:	84aa                	mv	s1,a0
  int pid = join();
 310:	102000ef          	jal	412 <join>
  if(pid < 0)
 314:	02054163          	bltz	a0,336 <thread_join+0x34>
 318:	892a                	mv	s2,a0
    return -1;
  if(stack && *stack){
 31a:	c499                	beqz	s1,328 <thread_join+0x26>
 31c:	6088                	ld	a0,0(s1)
 31e:	c509                	beqz	a0,328 <thread_join+0x26>
    free(*stack);
 320:	4d6000ef          	jal	7f6 <free>
    *stack = 0;
 324:	0004b023          	sd	zero,0(s1)
  }
  return pid;
}
 328:	854a                	mv	a0,s2
 32a:	60e2                	ld	ra,24(sp)
 32c:	6442                	ld	s0,16(sp)
 32e:	64a2                	ld	s1,8(sp)
 330:	6902                	ld	s2,0(sp)
 332:	6105                	addi	sp,sp,32
 334:	8082                	ret
    return -1;
 336:	597d                	li	s2,-1
 338:	bfc5                	j	328 <thread_join+0x26>

000000000000033a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 33a:	4885                	li	a7,1
 ecall
 33c:	00000073          	ecall
 ret
 340:	8082                	ret

0000000000000342 <exit>:
.global exit
exit:
 li a7, SYS_exit
 342:	4889                	li	a7,2
 ecall
 344:	00000073          	ecall
 ret
 348:	8082                	ret

000000000000034a <wait>:
.global wait
wait:
 li a7, SYS_wait
 34a:	488d                	li	a7,3
 ecall
 34c:	00000073          	ecall
 ret
 350:	8082                	ret

0000000000000352 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 352:	4891                	li	a7,4
 ecall
 354:	00000073          	ecall
 ret
 358:	8082                	ret

000000000000035a <read>:
.global read
read:
 li a7, SYS_read
 35a:	4895                	li	a7,5
 ecall
 35c:	00000073          	ecall
 ret
 360:	8082                	ret

0000000000000362 <write>:
.global write
write:
 li a7, SYS_write
 362:	48c1                	li	a7,16
 ecall
 364:	00000073          	ecall
 ret
 368:	8082                	ret

000000000000036a <close>:
.global close
close:
 li a7, SYS_close
 36a:	48d5                	li	a7,21
 ecall
 36c:	00000073          	ecall
 ret
 370:	8082                	ret

0000000000000372 <kill>:
.global kill
kill:
 li a7, SYS_kill
 372:	4899                	li	a7,6
 ecall
 374:	00000073          	ecall
 ret
 378:	8082                	ret

000000000000037a <exec>:
.global exec
exec:
 li a7, SYS_exec
 37a:	489d                	li	a7,7
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <open>:
.global open
open:
 li a7, SYS_open
 382:	48bd                	li	a7,15
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 38a:	48c5                	li	a7,17
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 392:	48c9                	li	a7,18
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 39a:	48a1                	li	a7,8
 ecall
 39c:	00000073          	ecall
 ret
 3a0:	8082                	ret

00000000000003a2 <link>:
.global link
link:
 li a7, SYS_link
 3a2:	48cd                	li	a7,19
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3aa:	48d1                	li	a7,20
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3b2:	48a5                	li	a7,9
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <dup>:
.global dup
dup:
 li a7, SYS_dup
 3ba:	48a9                	li	a7,10
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3c2:	48ad                	li	a7,11
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 3ca:	48b1                	li	a7,12
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <pause>:
.global pause
pause:
 li a7, SYS_pause
 3d2:	48b5                	li	a7,13
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3da:	48b9                	li	a7,14
 ecall
 3dc:	00000073          	ecall
 ret
 3e0:	8082                	ret

00000000000003e2 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 3e2:	48d9                	li	a7,22
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <lock_create>:
.global lock_create
lock_create:
 li a7, SYS_lock_create
 3ea:	48dd                	li	a7,23
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <lock_acquire>:
.global lock_acquire
lock_acquire:
 li a7, SYS_lock_acquire
 3f2:	48e1                	li	a7,24
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <lock_release>:
.global lock_release
lock_release:
 li a7, SYS_lock_release
 3fa:	48e5                	li	a7,25
 ecall
 3fc:	00000073          	ecall
 ret
 400:	8082                	ret

0000000000000402 <lock_destroy>:
.global lock_destroy
lock_destroy:
 li a7, SYS_lock_destroy
 402:	48e9                	li	a7,26
 ecall
 404:	00000073          	ecall
 ret
 408:	8082                	ret

000000000000040a <clone>:
.global clone
clone:
 li a7, SYS_clone
 40a:	48ed                	li	a7,27
 ecall
 40c:	00000073          	ecall
 ret
 410:	8082                	ret

0000000000000412 <join>:
.global join
join:
 li a7, SYS_join
 412:	48f1                	li	a7,28
 ecall
 414:	00000073          	ecall
 ret
 418:	8082                	ret

000000000000041a <getprocessinfo>:
.global getprocessinfo
getprocessinfo:
 li a7, SYS_getprocessinfo
 41a:	48f5                	li	a7,29
 ecall
 41c:	00000073          	ecall
 ret
 420:	8082                	ret

0000000000000422 <shmget>:
.global shmget
shmget:
 li a7, SYS_shmget
 422:	48f9                	li	a7,30
 ecall
 424:	00000073          	ecall
 ret
 428:	8082                	ret

000000000000042a <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 42a:	48fd                	li	a7,31
 ecall
 42c:	00000073          	ecall
 ret
 430:	8082                	ret

0000000000000432 <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 432:	02000893          	li	a7,32
 ecall
 436:	00000073          	ecall
 ret
 43a:	8082                	ret

000000000000043c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 43c:	1101                	addi	sp,sp,-32
 43e:	ec06                	sd	ra,24(sp)
 440:	e822                	sd	s0,16(sp)
 442:	1000                	addi	s0,sp,32
 444:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 448:	4605                	li	a2,1
 44a:	fef40593          	addi	a1,s0,-17
 44e:	f15ff0ef          	jal	362 <write>
}
 452:	60e2                	ld	ra,24(sp)
 454:	6442                	ld	s0,16(sp)
 456:	6105                	addi	sp,sp,32
 458:	8082                	ret

000000000000045a <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 45a:	715d                	addi	sp,sp,-80
 45c:	e486                	sd	ra,72(sp)
 45e:	e0a2                	sd	s0,64(sp)
 460:	f84a                	sd	s2,48(sp)
 462:	0880                	addi	s0,sp,80
 464:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 466:	c299                	beqz	a3,46c <printint+0x12>
 468:	0805c363          	bltz	a1,4ee <printint+0x94>
  neg = 0;
 46c:	4881                	li	a7,0
 46e:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 472:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 474:	00000517          	auipc	a0,0x0
 478:	50450513          	addi	a0,a0,1284 # 978 <digits>
 47c:	883e                	mv	a6,a5
 47e:	2785                	addiw	a5,a5,1
 480:	02c5f733          	remu	a4,a1,a2
 484:	972a                	add	a4,a4,a0
 486:	00074703          	lbu	a4,0(a4)
 48a:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 48e:	872e                	mv	a4,a1
 490:	02c5d5b3          	divu	a1,a1,a2
 494:	0685                	addi	a3,a3,1
 496:	fec773e3          	bgeu	a4,a2,47c <printint+0x22>
  if(neg)
 49a:	00088b63          	beqz	a7,4b0 <printint+0x56>
    buf[i++] = '-';
 49e:	fd078793          	addi	a5,a5,-48
 4a2:	97a2                	add	a5,a5,s0
 4a4:	02d00713          	li	a4,45
 4a8:	fee78423          	sb	a4,-24(a5)
 4ac:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 4b0:	02f05a63          	blez	a5,4e4 <printint+0x8a>
 4b4:	fc26                	sd	s1,56(sp)
 4b6:	f44e                	sd	s3,40(sp)
 4b8:	fb840713          	addi	a4,s0,-72
 4bc:	00f704b3          	add	s1,a4,a5
 4c0:	fff70993          	addi	s3,a4,-1
 4c4:	99be                	add	s3,s3,a5
 4c6:	37fd                	addiw	a5,a5,-1
 4c8:	1782                	slli	a5,a5,0x20
 4ca:	9381                	srli	a5,a5,0x20
 4cc:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 4d0:	fff4c583          	lbu	a1,-1(s1)
 4d4:	854a                	mv	a0,s2
 4d6:	f67ff0ef          	jal	43c <putc>
  while(--i >= 0)
 4da:	14fd                	addi	s1,s1,-1
 4dc:	ff349ae3          	bne	s1,s3,4d0 <printint+0x76>
 4e0:	74e2                	ld	s1,56(sp)
 4e2:	79a2                	ld	s3,40(sp)
}
 4e4:	60a6                	ld	ra,72(sp)
 4e6:	6406                	ld	s0,64(sp)
 4e8:	7942                	ld	s2,48(sp)
 4ea:	6161                	addi	sp,sp,80
 4ec:	8082                	ret
    x = -xx;
 4ee:	40b005b3          	neg	a1,a1
    neg = 1;
 4f2:	4885                	li	a7,1
    x = -xx;
 4f4:	bfad                	j	46e <printint+0x14>

00000000000004f6 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4f6:	711d                	addi	sp,sp,-96
 4f8:	ec86                	sd	ra,88(sp)
 4fa:	e8a2                	sd	s0,80(sp)
 4fc:	e0ca                	sd	s2,64(sp)
 4fe:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 500:	0005c903          	lbu	s2,0(a1)
 504:	28090663          	beqz	s2,790 <vprintf+0x29a>
 508:	e4a6                	sd	s1,72(sp)
 50a:	fc4e                	sd	s3,56(sp)
 50c:	f852                	sd	s4,48(sp)
 50e:	f456                	sd	s5,40(sp)
 510:	f05a                	sd	s6,32(sp)
 512:	ec5e                	sd	s7,24(sp)
 514:	e862                	sd	s8,16(sp)
 516:	e466                	sd	s9,8(sp)
 518:	8b2a                	mv	s6,a0
 51a:	8a2e                	mv	s4,a1
 51c:	8bb2                	mv	s7,a2
  state = 0;
 51e:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 520:	4481                	li	s1,0
 522:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 524:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 528:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 52c:	06c00c93          	li	s9,108
 530:	a005                	j	550 <vprintf+0x5a>
        putc(fd, c0);
 532:	85ca                	mv	a1,s2
 534:	855a                	mv	a0,s6
 536:	f07ff0ef          	jal	43c <putc>
 53a:	a019                	j	540 <vprintf+0x4a>
    } else if(state == '%'){
 53c:	03598263          	beq	s3,s5,560 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 540:	2485                	addiw	s1,s1,1
 542:	8726                	mv	a4,s1
 544:	009a07b3          	add	a5,s4,s1
 548:	0007c903          	lbu	s2,0(a5)
 54c:	22090a63          	beqz	s2,780 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 550:	0009079b          	sext.w	a5,s2
    if(state == 0){
 554:	fe0994e3          	bnez	s3,53c <vprintf+0x46>
      if(c0 == '%'){
 558:	fd579de3          	bne	a5,s5,532 <vprintf+0x3c>
        state = '%';
 55c:	89be                	mv	s3,a5
 55e:	b7cd                	j	540 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 560:	00ea06b3          	add	a3,s4,a4
 564:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 568:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 56a:	c681                	beqz	a3,572 <vprintf+0x7c>
 56c:	9752                	add	a4,a4,s4
 56e:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 572:	05878363          	beq	a5,s8,5b8 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 576:	05978d63          	beq	a5,s9,5d0 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 57a:	07500713          	li	a4,117
 57e:	0ee78763          	beq	a5,a4,66c <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 582:	07800713          	li	a4,120
 586:	12e78963          	beq	a5,a4,6b8 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 58a:	07000713          	li	a4,112
 58e:	14e78e63          	beq	a5,a4,6ea <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 592:	06300713          	li	a4,99
 596:	18e78e63          	beq	a5,a4,732 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 59a:	07300713          	li	a4,115
 59e:	1ae78463          	beq	a5,a4,746 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 5a2:	02500713          	li	a4,37
 5a6:	04e79563          	bne	a5,a4,5f0 <vprintf+0xfa>
        putc(fd, '%');
 5aa:	02500593          	li	a1,37
 5ae:	855a                	mv	a0,s6
 5b0:	e8dff0ef          	jal	43c <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 5b4:	4981                	li	s3,0
 5b6:	b769                	j	540 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 5b8:	008b8913          	addi	s2,s7,8
 5bc:	4685                	li	a3,1
 5be:	4629                	li	a2,10
 5c0:	000ba583          	lw	a1,0(s7)
 5c4:	855a                	mv	a0,s6
 5c6:	e95ff0ef          	jal	45a <printint>
 5ca:	8bca                	mv	s7,s2
      state = 0;
 5cc:	4981                	li	s3,0
 5ce:	bf8d                	j	540 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 5d0:	06400793          	li	a5,100
 5d4:	02f68963          	beq	a3,a5,606 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 5d8:	06c00793          	li	a5,108
 5dc:	04f68263          	beq	a3,a5,620 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 5e0:	07500793          	li	a5,117
 5e4:	0af68063          	beq	a3,a5,684 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 5e8:	07800793          	li	a5,120
 5ec:	0ef68263          	beq	a3,a5,6d0 <vprintf+0x1da>
        putc(fd, '%');
 5f0:	02500593          	li	a1,37
 5f4:	855a                	mv	a0,s6
 5f6:	e47ff0ef          	jal	43c <putc>
        putc(fd, c0);
 5fa:	85ca                	mv	a1,s2
 5fc:	855a                	mv	a0,s6
 5fe:	e3fff0ef          	jal	43c <putc>
      state = 0;
 602:	4981                	li	s3,0
 604:	bf35                	j	540 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 606:	008b8913          	addi	s2,s7,8
 60a:	4685                	li	a3,1
 60c:	4629                	li	a2,10
 60e:	000bb583          	ld	a1,0(s7)
 612:	855a                	mv	a0,s6
 614:	e47ff0ef          	jal	45a <printint>
        i += 1;
 618:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 61a:	8bca                	mv	s7,s2
      state = 0;
 61c:	4981                	li	s3,0
        i += 1;
 61e:	b70d                	j	540 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 620:	06400793          	li	a5,100
 624:	02f60763          	beq	a2,a5,652 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 628:	07500793          	li	a5,117
 62c:	06f60963          	beq	a2,a5,69e <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 630:	07800793          	li	a5,120
 634:	faf61ee3          	bne	a2,a5,5f0 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 638:	008b8913          	addi	s2,s7,8
 63c:	4681                	li	a3,0
 63e:	4641                	li	a2,16
 640:	000bb583          	ld	a1,0(s7)
 644:	855a                	mv	a0,s6
 646:	e15ff0ef          	jal	45a <printint>
        i += 2;
 64a:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 64c:	8bca                	mv	s7,s2
      state = 0;
 64e:	4981                	li	s3,0
        i += 2;
 650:	bdc5                	j	540 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 652:	008b8913          	addi	s2,s7,8
 656:	4685                	li	a3,1
 658:	4629                	li	a2,10
 65a:	000bb583          	ld	a1,0(s7)
 65e:	855a                	mv	a0,s6
 660:	dfbff0ef          	jal	45a <printint>
        i += 2;
 664:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 666:	8bca                	mv	s7,s2
      state = 0;
 668:	4981                	li	s3,0
        i += 2;
 66a:	bdd9                	j	540 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 66c:	008b8913          	addi	s2,s7,8
 670:	4681                	li	a3,0
 672:	4629                	li	a2,10
 674:	000be583          	lwu	a1,0(s7)
 678:	855a                	mv	a0,s6
 67a:	de1ff0ef          	jal	45a <printint>
 67e:	8bca                	mv	s7,s2
      state = 0;
 680:	4981                	li	s3,0
 682:	bd7d                	j	540 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 684:	008b8913          	addi	s2,s7,8
 688:	4681                	li	a3,0
 68a:	4629                	li	a2,10
 68c:	000bb583          	ld	a1,0(s7)
 690:	855a                	mv	a0,s6
 692:	dc9ff0ef          	jal	45a <printint>
        i += 1;
 696:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 698:	8bca                	mv	s7,s2
      state = 0;
 69a:	4981                	li	s3,0
        i += 1;
 69c:	b555                	j	540 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 69e:	008b8913          	addi	s2,s7,8
 6a2:	4681                	li	a3,0
 6a4:	4629                	li	a2,10
 6a6:	000bb583          	ld	a1,0(s7)
 6aa:	855a                	mv	a0,s6
 6ac:	dafff0ef          	jal	45a <printint>
        i += 2;
 6b0:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 6b2:	8bca                	mv	s7,s2
      state = 0;
 6b4:	4981                	li	s3,0
        i += 2;
 6b6:	b569                	j	540 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 6b8:	008b8913          	addi	s2,s7,8
 6bc:	4681                	li	a3,0
 6be:	4641                	li	a2,16
 6c0:	000be583          	lwu	a1,0(s7)
 6c4:	855a                	mv	a0,s6
 6c6:	d95ff0ef          	jal	45a <printint>
 6ca:	8bca                	mv	s7,s2
      state = 0;
 6cc:	4981                	li	s3,0
 6ce:	bd8d                	j	540 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6d0:	008b8913          	addi	s2,s7,8
 6d4:	4681                	li	a3,0
 6d6:	4641                	li	a2,16
 6d8:	000bb583          	ld	a1,0(s7)
 6dc:	855a                	mv	a0,s6
 6de:	d7dff0ef          	jal	45a <printint>
        i += 1;
 6e2:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 6e4:	8bca                	mv	s7,s2
      state = 0;
 6e6:	4981                	li	s3,0
        i += 1;
 6e8:	bda1                	j	540 <vprintf+0x4a>
 6ea:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 6ec:	008b8d13          	addi	s10,s7,8
 6f0:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 6f4:	03000593          	li	a1,48
 6f8:	855a                	mv	a0,s6
 6fa:	d43ff0ef          	jal	43c <putc>
  putc(fd, 'x');
 6fe:	07800593          	li	a1,120
 702:	855a                	mv	a0,s6
 704:	d39ff0ef          	jal	43c <putc>
 708:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 70a:	00000b97          	auipc	s7,0x0
 70e:	26eb8b93          	addi	s7,s7,622 # 978 <digits>
 712:	03c9d793          	srli	a5,s3,0x3c
 716:	97de                	add	a5,a5,s7
 718:	0007c583          	lbu	a1,0(a5)
 71c:	855a                	mv	a0,s6
 71e:	d1fff0ef          	jal	43c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 722:	0992                	slli	s3,s3,0x4
 724:	397d                	addiw	s2,s2,-1
 726:	fe0916e3          	bnez	s2,712 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 72a:	8bea                	mv	s7,s10
      state = 0;
 72c:	4981                	li	s3,0
 72e:	6d02                	ld	s10,0(sp)
 730:	bd01                	j	540 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 732:	008b8913          	addi	s2,s7,8
 736:	000bc583          	lbu	a1,0(s7)
 73a:	855a                	mv	a0,s6
 73c:	d01ff0ef          	jal	43c <putc>
 740:	8bca                	mv	s7,s2
      state = 0;
 742:	4981                	li	s3,0
 744:	bbf5                	j	540 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 746:	008b8993          	addi	s3,s7,8
 74a:	000bb903          	ld	s2,0(s7)
 74e:	00090f63          	beqz	s2,76c <vprintf+0x276>
        for(; *s; s++)
 752:	00094583          	lbu	a1,0(s2)
 756:	c195                	beqz	a1,77a <vprintf+0x284>
          putc(fd, *s);
 758:	855a                	mv	a0,s6
 75a:	ce3ff0ef          	jal	43c <putc>
        for(; *s; s++)
 75e:	0905                	addi	s2,s2,1
 760:	00094583          	lbu	a1,0(s2)
 764:	f9f5                	bnez	a1,758 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 766:	8bce                	mv	s7,s3
      state = 0;
 768:	4981                	li	s3,0
 76a:	bbd9                	j	540 <vprintf+0x4a>
          s = "(null)";
 76c:	00000917          	auipc	s2,0x0
 770:	20490913          	addi	s2,s2,516 # 970 <malloc+0xf8>
        for(; *s; s++)
 774:	02800593          	li	a1,40
 778:	b7c5                	j	758 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 77a:	8bce                	mv	s7,s3
      state = 0;
 77c:	4981                	li	s3,0
 77e:	b3c9                	j	540 <vprintf+0x4a>
 780:	64a6                	ld	s1,72(sp)
 782:	79e2                	ld	s3,56(sp)
 784:	7a42                	ld	s4,48(sp)
 786:	7aa2                	ld	s5,40(sp)
 788:	7b02                	ld	s6,32(sp)
 78a:	6be2                	ld	s7,24(sp)
 78c:	6c42                	ld	s8,16(sp)
 78e:	6ca2                	ld	s9,8(sp)
    }
  }
}
 790:	60e6                	ld	ra,88(sp)
 792:	6446                	ld	s0,80(sp)
 794:	6906                	ld	s2,64(sp)
 796:	6125                	addi	sp,sp,96
 798:	8082                	ret

000000000000079a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 79a:	715d                	addi	sp,sp,-80
 79c:	ec06                	sd	ra,24(sp)
 79e:	e822                	sd	s0,16(sp)
 7a0:	1000                	addi	s0,sp,32
 7a2:	e010                	sd	a2,0(s0)
 7a4:	e414                	sd	a3,8(s0)
 7a6:	e818                	sd	a4,16(s0)
 7a8:	ec1c                	sd	a5,24(s0)
 7aa:	03043023          	sd	a6,32(s0)
 7ae:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7b2:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7b6:	8622                	mv	a2,s0
 7b8:	d3fff0ef          	jal	4f6 <vprintf>
}
 7bc:	60e2                	ld	ra,24(sp)
 7be:	6442                	ld	s0,16(sp)
 7c0:	6161                	addi	sp,sp,80
 7c2:	8082                	ret

00000000000007c4 <printf>:

void
printf(const char *fmt, ...)
{
 7c4:	711d                	addi	sp,sp,-96
 7c6:	ec06                	sd	ra,24(sp)
 7c8:	e822                	sd	s0,16(sp)
 7ca:	1000                	addi	s0,sp,32
 7cc:	e40c                	sd	a1,8(s0)
 7ce:	e810                	sd	a2,16(s0)
 7d0:	ec14                	sd	a3,24(s0)
 7d2:	f018                	sd	a4,32(s0)
 7d4:	f41c                	sd	a5,40(s0)
 7d6:	03043823          	sd	a6,48(s0)
 7da:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7de:	00840613          	addi	a2,s0,8
 7e2:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7e6:	85aa                	mv	a1,a0
 7e8:	4505                	li	a0,1
 7ea:	d0dff0ef          	jal	4f6 <vprintf>
}
 7ee:	60e2                	ld	ra,24(sp)
 7f0:	6442                	ld	s0,16(sp)
 7f2:	6125                	addi	sp,sp,96
 7f4:	8082                	ret

00000000000007f6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7f6:	1141                	addi	sp,sp,-16
 7f8:	e422                	sd	s0,8(sp)
 7fa:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7fc:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 800:	00001797          	auipc	a5,0x1
 804:	8007b783          	ld	a5,-2048(a5) # 1000 <freep>
 808:	a02d                	j	832 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 80a:	4618                	lw	a4,8(a2)
 80c:	9f2d                	addw	a4,a4,a1
 80e:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 812:	6398                	ld	a4,0(a5)
 814:	6310                	ld	a2,0(a4)
 816:	a83d                	j	854 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 818:	ff852703          	lw	a4,-8(a0)
 81c:	9f31                	addw	a4,a4,a2
 81e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 820:	ff053683          	ld	a3,-16(a0)
 824:	a091                	j	868 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 826:	6398                	ld	a4,0(a5)
 828:	00e7e463          	bltu	a5,a4,830 <free+0x3a>
 82c:	00e6ea63          	bltu	a3,a4,840 <free+0x4a>
{
 830:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 832:	fed7fae3          	bgeu	a5,a3,826 <free+0x30>
 836:	6398                	ld	a4,0(a5)
 838:	00e6e463          	bltu	a3,a4,840 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 83c:	fee7eae3          	bltu	a5,a4,830 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 840:	ff852583          	lw	a1,-8(a0)
 844:	6390                	ld	a2,0(a5)
 846:	02059813          	slli	a6,a1,0x20
 84a:	01c85713          	srli	a4,a6,0x1c
 84e:	9736                	add	a4,a4,a3
 850:	fae60de3          	beq	a2,a4,80a <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 854:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 858:	4790                	lw	a2,8(a5)
 85a:	02061593          	slli	a1,a2,0x20
 85e:	01c5d713          	srli	a4,a1,0x1c
 862:	973e                	add	a4,a4,a5
 864:	fae68ae3          	beq	a3,a4,818 <free+0x22>
    p->s.ptr = bp->s.ptr;
 868:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 86a:	00000717          	auipc	a4,0x0
 86e:	78f73b23          	sd	a5,1942(a4) # 1000 <freep>
}
 872:	6422                	ld	s0,8(sp)
 874:	0141                	addi	sp,sp,16
 876:	8082                	ret

0000000000000878 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 878:	7139                	addi	sp,sp,-64
 87a:	fc06                	sd	ra,56(sp)
 87c:	f822                	sd	s0,48(sp)
 87e:	f426                	sd	s1,40(sp)
 880:	ec4e                	sd	s3,24(sp)
 882:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 884:	02051493          	slli	s1,a0,0x20
 888:	9081                	srli	s1,s1,0x20
 88a:	04bd                	addi	s1,s1,15
 88c:	8091                	srli	s1,s1,0x4
 88e:	0014899b          	addiw	s3,s1,1
 892:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 894:	00000517          	auipc	a0,0x0
 898:	76c53503          	ld	a0,1900(a0) # 1000 <freep>
 89c:	c915                	beqz	a0,8d0 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 89e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8a0:	4798                	lw	a4,8(a5)
 8a2:	08977a63          	bgeu	a4,s1,936 <malloc+0xbe>
 8a6:	f04a                	sd	s2,32(sp)
 8a8:	e852                	sd	s4,16(sp)
 8aa:	e456                	sd	s5,8(sp)
 8ac:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 8ae:	8a4e                	mv	s4,s3
 8b0:	0009871b          	sext.w	a4,s3
 8b4:	6685                	lui	a3,0x1
 8b6:	00d77363          	bgeu	a4,a3,8bc <malloc+0x44>
 8ba:	6a05                	lui	s4,0x1
 8bc:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8c0:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8c4:	00000917          	auipc	s2,0x0
 8c8:	73c90913          	addi	s2,s2,1852 # 1000 <freep>
  if(p == SBRK_ERROR)
 8cc:	5afd                	li	s5,-1
 8ce:	a081                	j	90e <malloc+0x96>
 8d0:	f04a                	sd	s2,32(sp)
 8d2:	e852                	sd	s4,16(sp)
 8d4:	e456                	sd	s5,8(sp)
 8d6:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 8d8:	00000797          	auipc	a5,0x0
 8dc:	73878793          	addi	a5,a5,1848 # 1010 <base>
 8e0:	00000717          	auipc	a4,0x0
 8e4:	72f73023          	sd	a5,1824(a4) # 1000 <freep>
 8e8:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8ea:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8ee:	b7c1                	j	8ae <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 8f0:	6398                	ld	a4,0(a5)
 8f2:	e118                	sd	a4,0(a0)
 8f4:	a8a9                	j	94e <malloc+0xd6>
  hp->s.size = nu;
 8f6:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8fa:	0541                	addi	a0,a0,16
 8fc:	efbff0ef          	jal	7f6 <free>
  return freep;
 900:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 904:	c12d                	beqz	a0,966 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 906:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 908:	4798                	lw	a4,8(a5)
 90a:	02977263          	bgeu	a4,s1,92e <malloc+0xb6>
    if(p == freep)
 90e:	00093703          	ld	a4,0(s2)
 912:	853e                	mv	a0,a5
 914:	fef719e3          	bne	a4,a5,906 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 918:	8552                	mv	a0,s4
 91a:	965ff0ef          	jal	27e <sbrk>
  if(p == SBRK_ERROR)
 91e:	fd551ce3          	bne	a0,s5,8f6 <malloc+0x7e>
        return 0;
 922:	4501                	li	a0,0
 924:	7902                	ld	s2,32(sp)
 926:	6a42                	ld	s4,16(sp)
 928:	6aa2                	ld	s5,8(sp)
 92a:	6b02                	ld	s6,0(sp)
 92c:	a03d                	j	95a <malloc+0xe2>
 92e:	7902                	ld	s2,32(sp)
 930:	6a42                	ld	s4,16(sp)
 932:	6aa2                	ld	s5,8(sp)
 934:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 936:	fae48de3          	beq	s1,a4,8f0 <malloc+0x78>
        p->s.size -= nunits;
 93a:	4137073b          	subw	a4,a4,s3
 93e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 940:	02071693          	slli	a3,a4,0x20
 944:	01c6d713          	srli	a4,a3,0x1c
 948:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 94a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 94e:	00000717          	auipc	a4,0x0
 952:	6aa73923          	sd	a0,1714(a4) # 1000 <freep>
      return (void*)(p + 1);
 956:	01078513          	addi	a0,a5,16
  }
}
 95a:	70e2                	ld	ra,56(sp)
 95c:	7442                	ld	s0,48(sp)
 95e:	74a2                	ld	s1,40(sp)
 960:	69e2                	ld	s3,24(sp)
 962:	6121                	addi	sp,sp,64
 964:	8082                	ret
 966:	7902                	ld	s2,32(sp)
 968:	6a42                	ld	s4,16(sp)
 96a:	6aa2                	ld	s5,8(sp)
 96c:	6b02                	ld	s6,0(sp)
 96e:	b7f5                	j	95a <malloc+0xe2>
