
user/_ls:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

char*
fmtname(char *path)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	1800                	addi	s0,sp,48
   a:	84aa                	mv	s1,a0
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
   c:	2b8000ef          	jal	2c4 <strlen>
  10:	02051793          	slli	a5,a0,0x20
  14:	9381                	srli	a5,a5,0x20
  16:	97a6                	add	a5,a5,s1
  18:	02f00693          	li	a3,47
  1c:	0097e963          	bltu	a5,s1,2e <fmtname+0x2e>
  20:	0007c703          	lbu	a4,0(a5)
  24:	00d70563          	beq	a4,a3,2e <fmtname+0x2e>
  28:	17fd                	addi	a5,a5,-1
  2a:	fe97fbe3          	bgeu	a5,s1,20 <fmtname+0x20>
    ;
  p++;
  2e:	00178493          	addi	s1,a5,1

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  32:	8526                	mv	a0,s1
  34:	290000ef          	jal	2c4 <strlen>
  38:	2501                	sext.w	a0,a0
  3a:	47b5                	li	a5,13
  3c:	00a7f863          	bgeu	a5,a0,4c <fmtname+0x4c>
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  buf[sizeof(buf)-1] = '\0';
  return buf;
}
  40:	8526                	mv	a0,s1
  42:	70a2                	ld	ra,40(sp)
  44:	7402                	ld	s0,32(sp)
  46:	64e2                	ld	s1,24(sp)
  48:	6145                	addi	sp,sp,48
  4a:	8082                	ret
  4c:	e84a                	sd	s2,16(sp)
  4e:	e44e                	sd	s3,8(sp)
  memmove(buf, p, strlen(p));
  50:	8526                	mv	a0,s1
  52:	272000ef          	jal	2c4 <strlen>
  56:	00002997          	auipc	s3,0x2
  5a:	fba98993          	addi	s3,s3,-70 # 2010 <buf.0>
  5e:	0005061b          	sext.w	a2,a0
  62:	85a6                	mv	a1,s1
  64:	854e                	mv	a0,s3
  66:	3c0000ef          	jal	426 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  6a:	8526                	mv	a0,s1
  6c:	258000ef          	jal	2c4 <strlen>
  70:	0005091b          	sext.w	s2,a0
  74:	8526                	mv	a0,s1
  76:	24e000ef          	jal	2c4 <strlen>
  7a:	1902                	slli	s2,s2,0x20
  7c:	02095913          	srli	s2,s2,0x20
  80:	4639                	li	a2,14
  82:	9e09                	subw	a2,a2,a0
  84:	02000593          	li	a1,32
  88:	01298533          	add	a0,s3,s2
  8c:	262000ef          	jal	2ee <memset>
  buf[sizeof(buf)-1] = '\0';
  90:	00098723          	sb	zero,14(s3)
  return buf;
  94:	84ce                	mv	s1,s3
  96:	6942                	ld	s2,16(sp)
  98:	69a2                	ld	s3,8(sp)
  9a:	b75d                	j	40 <fmtname+0x40>

000000000000009c <ls>:

void
ls(char *path)
{
  9c:	d9010113          	addi	sp,sp,-624
  a0:	26113423          	sd	ra,616(sp)
  a4:	26813023          	sd	s0,608(sp)
  a8:	25213823          	sd	s2,592(sp)
  ac:	1c80                	addi	s0,sp,624
  ae:	892a                	mv	s2,a0
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, O_RDONLY)) < 0){
  b0:	4581                	li	a1,0
  b2:	51e000ef          	jal	5d0 <open>
  b6:	06054363          	bltz	a0,11c <ls+0x80>
  ba:	24913c23          	sd	s1,600(sp)
  be:	84aa                	mv	s1,a0
    fprintf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  c0:	d9840593          	addi	a1,s0,-616
  c4:	524000ef          	jal	5e8 <fstat>
  c8:	06054363          	bltz	a0,12e <ls+0x92>
    fprintf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
  cc:	da041783          	lh	a5,-608(s0)
  d0:	4705                	li	a4,1
  d2:	06e78c63          	beq	a5,a4,14a <ls+0xae>
  d6:	37f9                	addiw	a5,a5,-2
  d8:	17c2                	slli	a5,a5,0x30
  da:	93c1                	srli	a5,a5,0x30
  dc:	02f76263          	bltu	a4,a5,100 <ls+0x64>
  case T_DEVICE:
  case T_FILE:
    printf("%s %d %d %d\n", fmtname(path), st.type, st.ino, (int) st.size);
  e0:	854a                	mv	a0,s2
  e2:	f1fff0ef          	jal	0 <fmtname>
  e6:	85aa                	mv	a1,a0
  e8:	da842703          	lw	a4,-600(s0)
  ec:	d9c42683          	lw	a3,-612(s0)
  f0:	da041603          	lh	a2,-608(s0)
  f4:	00001517          	auipc	a0,0x1
  f8:	adc50513          	addi	a0,a0,-1316 # bd0 <malloc+0x12c>
  fc:	0f5000ef          	jal	9f0 <printf>
      }
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, (int) st.size);
    }
    break;
  }
  close(fd);
 100:	8526                	mv	a0,s1
 102:	4b6000ef          	jal	5b8 <close>
 106:	25813483          	ld	s1,600(sp)
}
 10a:	26813083          	ld	ra,616(sp)
 10e:	26013403          	ld	s0,608(sp)
 112:	25013903          	ld	s2,592(sp)
 116:	27010113          	addi	sp,sp,624
 11a:	8082                	ret
    fprintf(2, "ls: cannot open %s\n", path);
 11c:	864a                	mv	a2,s2
 11e:	00001597          	auipc	a1,0x1
 122:	a8258593          	addi	a1,a1,-1406 # ba0 <malloc+0xfc>
 126:	4509                	li	a0,2
 128:	09f000ef          	jal	9c6 <fprintf>
    return;
 12c:	bff9                	j	10a <ls+0x6e>
    fprintf(2, "ls: cannot stat %s\n", path);
 12e:	864a                	mv	a2,s2
 130:	00001597          	auipc	a1,0x1
 134:	a8858593          	addi	a1,a1,-1400 # bb8 <malloc+0x114>
 138:	4509                	li	a0,2
 13a:	08d000ef          	jal	9c6 <fprintf>
    close(fd);
 13e:	8526                	mv	a0,s1
 140:	478000ef          	jal	5b8 <close>
    return;
 144:	25813483          	ld	s1,600(sp)
 148:	b7c9                	j	10a <ls+0x6e>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 14a:	854a                	mv	a0,s2
 14c:	178000ef          	jal	2c4 <strlen>
 150:	2541                	addiw	a0,a0,16
 152:	20000793          	li	a5,512
 156:	00a7f963          	bgeu	a5,a0,168 <ls+0xcc>
      printf("ls: path too long\n");
 15a:	00001517          	auipc	a0,0x1
 15e:	a8650513          	addi	a0,a0,-1402 # be0 <malloc+0x13c>
 162:	08f000ef          	jal	9f0 <printf>
      break;
 166:	bf69                	j	100 <ls+0x64>
 168:	25313423          	sd	s3,584(sp)
 16c:	25413023          	sd	s4,576(sp)
 170:	23513c23          	sd	s5,568(sp)
    strcpy(buf, path);
 174:	85ca                	mv	a1,s2
 176:	dc040513          	addi	a0,s0,-576
 17a:	102000ef          	jal	27c <strcpy>
    p = buf+strlen(buf);
 17e:	dc040513          	addi	a0,s0,-576
 182:	142000ef          	jal	2c4 <strlen>
 186:	1502                	slli	a0,a0,0x20
 188:	9101                	srli	a0,a0,0x20
 18a:	dc040793          	addi	a5,s0,-576
 18e:	00a78933          	add	s2,a5,a0
    *p++ = '/';
 192:	00190993          	addi	s3,s2,1
 196:	02f00793          	li	a5,47
 19a:	00f90023          	sb	a5,0(s2)
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, (int) st.size);
 19e:	00001a17          	auipc	s4,0x1
 1a2:	a32a0a13          	addi	s4,s4,-1486 # bd0 <malloc+0x12c>
        printf("ls: cannot stat %s\n", buf);
 1a6:	00001a97          	auipc	s5,0x1
 1aa:	a12a8a93          	addi	s5,s5,-1518 # bb8 <malloc+0x114>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1ae:	a031                	j	1ba <ls+0x11e>
        printf("ls: cannot stat %s\n", buf);
 1b0:	dc040593          	addi	a1,s0,-576
 1b4:	8556                	mv	a0,s5
 1b6:	03b000ef          	jal	9f0 <printf>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1ba:	4641                	li	a2,16
 1bc:	db040593          	addi	a1,s0,-592
 1c0:	8526                	mv	a0,s1
 1c2:	3e6000ef          	jal	5a8 <read>
 1c6:	47c1                	li	a5,16
 1c8:	04f51463          	bne	a0,a5,210 <ls+0x174>
      if(de.inum == 0)
 1cc:	db045783          	lhu	a5,-592(s0)
 1d0:	d7ed                	beqz	a5,1ba <ls+0x11e>
      memmove(p, de.name, DIRSIZ);
 1d2:	4639                	li	a2,14
 1d4:	db240593          	addi	a1,s0,-590
 1d8:	854e                	mv	a0,s3
 1da:	24c000ef          	jal	426 <memmove>
      p[DIRSIZ] = 0;
 1de:	000907a3          	sb	zero,15(s2)
      if(stat(buf, &st) < 0){
 1e2:	d9840593          	addi	a1,s0,-616
 1e6:	dc040513          	addi	a0,s0,-576
 1ea:	1ba000ef          	jal	3a4 <stat>
 1ee:	fc0541e3          	bltz	a0,1b0 <ls+0x114>
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, (int) st.size);
 1f2:	dc040513          	addi	a0,s0,-576
 1f6:	e0bff0ef          	jal	0 <fmtname>
 1fa:	85aa                	mv	a1,a0
 1fc:	da842703          	lw	a4,-600(s0)
 200:	d9c42683          	lw	a3,-612(s0)
 204:	da041603          	lh	a2,-608(s0)
 208:	8552                	mv	a0,s4
 20a:	7e6000ef          	jal	9f0 <printf>
 20e:	b775                	j	1ba <ls+0x11e>
 210:	24813983          	ld	s3,584(sp)
 214:	24013a03          	ld	s4,576(sp)
 218:	23813a83          	ld	s5,568(sp)
 21c:	b5d5                	j	100 <ls+0x64>

000000000000021e <main>:

int
main(int argc, char *argv[])
{
 21e:	1101                	addi	sp,sp,-32
 220:	ec06                	sd	ra,24(sp)
 222:	e822                	sd	s0,16(sp)
 224:	1000                	addi	s0,sp,32
  int i;

  if(argc < 2){
 226:	4785                	li	a5,1
 228:	02a7d763          	bge	a5,a0,256 <main+0x38>
 22c:	e426                	sd	s1,8(sp)
 22e:	e04a                	sd	s2,0(sp)
 230:	00858493          	addi	s1,a1,8
 234:	ffe5091b          	addiw	s2,a0,-2
 238:	02091793          	slli	a5,s2,0x20
 23c:	01d7d913          	srli	s2,a5,0x1d
 240:	05c1                	addi	a1,a1,16
 242:	992e                	add	s2,s2,a1
    ls(".");
    exit(0);
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
 244:	6088                	ld	a0,0(s1)
 246:	e57ff0ef          	jal	9c <ls>
  for(i=1; i<argc; i++)
 24a:	04a1                	addi	s1,s1,8
 24c:	ff249ce3          	bne	s1,s2,244 <main+0x26>
  exit(0);
 250:	4501                	li	a0,0
 252:	33e000ef          	jal	590 <exit>
 256:	e426                	sd	s1,8(sp)
 258:	e04a                	sd	s2,0(sp)
    ls(".");
 25a:	00001517          	auipc	a0,0x1
 25e:	99e50513          	addi	a0,a0,-1634 # bf8 <malloc+0x154>
 262:	e3bff0ef          	jal	9c <ls>
    exit(0);
 266:	4501                	li	a0,0
 268:	328000ef          	jal	590 <exit>

000000000000026c <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
 26c:	1141                	addi	sp,sp,-16
 26e:	e406                	sd	ra,8(sp)
 270:	e022                	sd	s0,0(sp)
 272:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
 274:	fabff0ef          	jal	21e <main>
  exit(r);
 278:	318000ef          	jal	590 <exit>

000000000000027c <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 27c:	1141                	addi	sp,sp,-16
 27e:	e422                	sd	s0,8(sp)
 280:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 282:	87aa                	mv	a5,a0
 284:	0585                	addi	a1,a1,1
 286:	0785                	addi	a5,a5,1
 288:	fff5c703          	lbu	a4,-1(a1)
 28c:	fee78fa3          	sb	a4,-1(a5)
 290:	fb75                	bnez	a4,284 <strcpy+0x8>
    ;
  return os;
}
 292:	6422                	ld	s0,8(sp)
 294:	0141                	addi	sp,sp,16
 296:	8082                	ret

0000000000000298 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 298:	1141                	addi	sp,sp,-16
 29a:	e422                	sd	s0,8(sp)
 29c:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 29e:	00054783          	lbu	a5,0(a0)
 2a2:	cb91                	beqz	a5,2b6 <strcmp+0x1e>
 2a4:	0005c703          	lbu	a4,0(a1)
 2a8:	00f71763          	bne	a4,a5,2b6 <strcmp+0x1e>
    p++, q++;
 2ac:	0505                	addi	a0,a0,1
 2ae:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2b0:	00054783          	lbu	a5,0(a0)
 2b4:	fbe5                	bnez	a5,2a4 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 2b6:	0005c503          	lbu	a0,0(a1)
}
 2ba:	40a7853b          	subw	a0,a5,a0
 2be:	6422                	ld	s0,8(sp)
 2c0:	0141                	addi	sp,sp,16
 2c2:	8082                	ret

00000000000002c4 <strlen>:

uint
strlen(const char *s)
{
 2c4:	1141                	addi	sp,sp,-16
 2c6:	e422                	sd	s0,8(sp)
 2c8:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2ca:	00054783          	lbu	a5,0(a0)
 2ce:	cf91                	beqz	a5,2ea <strlen+0x26>
 2d0:	0505                	addi	a0,a0,1
 2d2:	87aa                	mv	a5,a0
 2d4:	86be                	mv	a3,a5
 2d6:	0785                	addi	a5,a5,1
 2d8:	fff7c703          	lbu	a4,-1(a5)
 2dc:	ff65                	bnez	a4,2d4 <strlen+0x10>
 2de:	40a6853b          	subw	a0,a3,a0
 2e2:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 2e4:	6422                	ld	s0,8(sp)
 2e6:	0141                	addi	sp,sp,16
 2e8:	8082                	ret
  for(n = 0; s[n]; n++)
 2ea:	4501                	li	a0,0
 2ec:	bfe5                	j	2e4 <strlen+0x20>

00000000000002ee <memset>:

void*
memset(void *dst, int c, uint n)
{
 2ee:	1141                	addi	sp,sp,-16
 2f0:	e422                	sd	s0,8(sp)
 2f2:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2f4:	ca19                	beqz	a2,30a <memset+0x1c>
 2f6:	87aa                	mv	a5,a0
 2f8:	1602                	slli	a2,a2,0x20
 2fa:	9201                	srli	a2,a2,0x20
 2fc:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 300:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 304:	0785                	addi	a5,a5,1
 306:	fee79de3          	bne	a5,a4,300 <memset+0x12>
  }
  return dst;
}
 30a:	6422                	ld	s0,8(sp)
 30c:	0141                	addi	sp,sp,16
 30e:	8082                	ret

0000000000000310 <strchr>:

char*
strchr(const char *s, char c)
{
 310:	1141                	addi	sp,sp,-16
 312:	e422                	sd	s0,8(sp)
 314:	0800                	addi	s0,sp,16
  for(; *s; s++)
 316:	00054783          	lbu	a5,0(a0)
 31a:	cb99                	beqz	a5,330 <strchr+0x20>
    if(*s == c)
 31c:	00f58763          	beq	a1,a5,32a <strchr+0x1a>
  for(; *s; s++)
 320:	0505                	addi	a0,a0,1
 322:	00054783          	lbu	a5,0(a0)
 326:	fbfd                	bnez	a5,31c <strchr+0xc>
      return (char*)s;
  return 0;
 328:	4501                	li	a0,0
}
 32a:	6422                	ld	s0,8(sp)
 32c:	0141                	addi	sp,sp,16
 32e:	8082                	ret
  return 0;
 330:	4501                	li	a0,0
 332:	bfe5                	j	32a <strchr+0x1a>

0000000000000334 <gets>:

char*
gets(char *buf, int max)
{
 334:	711d                	addi	sp,sp,-96
 336:	ec86                	sd	ra,88(sp)
 338:	e8a2                	sd	s0,80(sp)
 33a:	e4a6                	sd	s1,72(sp)
 33c:	e0ca                	sd	s2,64(sp)
 33e:	fc4e                	sd	s3,56(sp)
 340:	f852                	sd	s4,48(sp)
 342:	f456                	sd	s5,40(sp)
 344:	f05a                	sd	s6,32(sp)
 346:	ec5e                	sd	s7,24(sp)
 348:	1080                	addi	s0,sp,96
 34a:	8baa                	mv	s7,a0
 34c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 34e:	892a                	mv	s2,a0
 350:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 352:	4aa9                	li	s5,10
 354:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 356:	89a6                	mv	s3,s1
 358:	2485                	addiw	s1,s1,1
 35a:	0344d663          	bge	s1,s4,386 <gets+0x52>
    cc = read(0, &c, 1);
 35e:	4605                	li	a2,1
 360:	faf40593          	addi	a1,s0,-81
 364:	4501                	li	a0,0
 366:	242000ef          	jal	5a8 <read>
    if(cc < 1)
 36a:	00a05e63          	blez	a0,386 <gets+0x52>
    buf[i++] = c;
 36e:	faf44783          	lbu	a5,-81(s0)
 372:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 376:	01578763          	beq	a5,s5,384 <gets+0x50>
 37a:	0905                	addi	s2,s2,1
 37c:	fd679de3          	bne	a5,s6,356 <gets+0x22>
    buf[i++] = c;
 380:	89a6                	mv	s3,s1
 382:	a011                	j	386 <gets+0x52>
 384:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 386:	99de                	add	s3,s3,s7
 388:	00098023          	sb	zero,0(s3)
  return buf;
}
 38c:	855e                	mv	a0,s7
 38e:	60e6                	ld	ra,88(sp)
 390:	6446                	ld	s0,80(sp)
 392:	64a6                	ld	s1,72(sp)
 394:	6906                	ld	s2,64(sp)
 396:	79e2                	ld	s3,56(sp)
 398:	7a42                	ld	s4,48(sp)
 39a:	7aa2                	ld	s5,40(sp)
 39c:	7b02                	ld	s6,32(sp)
 39e:	6be2                	ld	s7,24(sp)
 3a0:	6125                	addi	sp,sp,96
 3a2:	8082                	ret

00000000000003a4 <stat>:

int
stat(const char *n, struct stat *st)
{
 3a4:	1101                	addi	sp,sp,-32
 3a6:	ec06                	sd	ra,24(sp)
 3a8:	e822                	sd	s0,16(sp)
 3aa:	e04a                	sd	s2,0(sp)
 3ac:	1000                	addi	s0,sp,32
 3ae:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3b0:	4581                	li	a1,0
 3b2:	21e000ef          	jal	5d0 <open>
  if(fd < 0)
 3b6:	02054263          	bltz	a0,3da <stat+0x36>
 3ba:	e426                	sd	s1,8(sp)
 3bc:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3be:	85ca                	mv	a1,s2
 3c0:	228000ef          	jal	5e8 <fstat>
 3c4:	892a                	mv	s2,a0
  close(fd);
 3c6:	8526                	mv	a0,s1
 3c8:	1f0000ef          	jal	5b8 <close>
  return r;
 3cc:	64a2                	ld	s1,8(sp)
}
 3ce:	854a                	mv	a0,s2
 3d0:	60e2                	ld	ra,24(sp)
 3d2:	6442                	ld	s0,16(sp)
 3d4:	6902                	ld	s2,0(sp)
 3d6:	6105                	addi	sp,sp,32
 3d8:	8082                	ret
    return -1;
 3da:	597d                	li	s2,-1
 3dc:	bfcd                	j	3ce <stat+0x2a>

00000000000003de <atoi>:

int
atoi(const char *s)
{
 3de:	1141                	addi	sp,sp,-16
 3e0:	e422                	sd	s0,8(sp)
 3e2:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3e4:	00054683          	lbu	a3,0(a0)
 3e8:	fd06879b          	addiw	a5,a3,-48
 3ec:	0ff7f793          	zext.b	a5,a5
 3f0:	4625                	li	a2,9
 3f2:	02f66863          	bltu	a2,a5,422 <atoi+0x44>
 3f6:	872a                	mv	a4,a0
  n = 0;
 3f8:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 3fa:	0705                	addi	a4,a4,1
 3fc:	0025179b          	slliw	a5,a0,0x2
 400:	9fa9                	addw	a5,a5,a0
 402:	0017979b          	slliw	a5,a5,0x1
 406:	9fb5                	addw	a5,a5,a3
 408:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 40c:	00074683          	lbu	a3,0(a4)
 410:	fd06879b          	addiw	a5,a3,-48
 414:	0ff7f793          	zext.b	a5,a5
 418:	fef671e3          	bgeu	a2,a5,3fa <atoi+0x1c>
  return n;
}
 41c:	6422                	ld	s0,8(sp)
 41e:	0141                	addi	sp,sp,16
 420:	8082                	ret
  n = 0;
 422:	4501                	li	a0,0
 424:	bfe5                	j	41c <atoi+0x3e>

0000000000000426 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 426:	1141                	addi	sp,sp,-16
 428:	e422                	sd	s0,8(sp)
 42a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 42c:	02b57463          	bgeu	a0,a1,454 <memmove+0x2e>
    while(n-- > 0)
 430:	00c05f63          	blez	a2,44e <memmove+0x28>
 434:	1602                	slli	a2,a2,0x20
 436:	9201                	srli	a2,a2,0x20
 438:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 43c:	872a                	mv	a4,a0
      *dst++ = *src++;
 43e:	0585                	addi	a1,a1,1
 440:	0705                	addi	a4,a4,1
 442:	fff5c683          	lbu	a3,-1(a1)
 446:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 44a:	fef71ae3          	bne	a4,a5,43e <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 44e:	6422                	ld	s0,8(sp)
 450:	0141                	addi	sp,sp,16
 452:	8082                	ret
    dst += n;
 454:	00c50733          	add	a4,a0,a2
    src += n;
 458:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 45a:	fec05ae3          	blez	a2,44e <memmove+0x28>
 45e:	fff6079b          	addiw	a5,a2,-1
 462:	1782                	slli	a5,a5,0x20
 464:	9381                	srli	a5,a5,0x20
 466:	fff7c793          	not	a5,a5
 46a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 46c:	15fd                	addi	a1,a1,-1
 46e:	177d                	addi	a4,a4,-1
 470:	0005c683          	lbu	a3,0(a1)
 474:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 478:	fee79ae3          	bne	a5,a4,46c <memmove+0x46>
 47c:	bfc9                	j	44e <memmove+0x28>

000000000000047e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 47e:	1141                	addi	sp,sp,-16
 480:	e422                	sd	s0,8(sp)
 482:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 484:	ca05                	beqz	a2,4b4 <memcmp+0x36>
 486:	fff6069b          	addiw	a3,a2,-1
 48a:	1682                	slli	a3,a3,0x20
 48c:	9281                	srli	a3,a3,0x20
 48e:	0685                	addi	a3,a3,1
 490:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 492:	00054783          	lbu	a5,0(a0)
 496:	0005c703          	lbu	a4,0(a1)
 49a:	00e79863          	bne	a5,a4,4aa <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 49e:	0505                	addi	a0,a0,1
    p2++;
 4a0:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 4a2:	fed518e3          	bne	a0,a3,492 <memcmp+0x14>
  }
  return 0;
 4a6:	4501                	li	a0,0
 4a8:	a019                	j	4ae <memcmp+0x30>
      return *p1 - *p2;
 4aa:	40e7853b          	subw	a0,a5,a4
}
 4ae:	6422                	ld	s0,8(sp)
 4b0:	0141                	addi	sp,sp,16
 4b2:	8082                	ret
  return 0;
 4b4:	4501                	li	a0,0
 4b6:	bfe5                	j	4ae <memcmp+0x30>

00000000000004b8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4b8:	1141                	addi	sp,sp,-16
 4ba:	e406                	sd	ra,8(sp)
 4bc:	e022                	sd	s0,0(sp)
 4be:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 4c0:	f67ff0ef          	jal	426 <memmove>
}
 4c4:	60a2                	ld	ra,8(sp)
 4c6:	6402                	ld	s0,0(sp)
 4c8:	0141                	addi	sp,sp,16
 4ca:	8082                	ret

00000000000004cc <sbrk>:

char *
sbrk(int n) {
 4cc:	1141                	addi	sp,sp,-16
 4ce:	e406                	sd	ra,8(sp)
 4d0:	e022                	sd	s0,0(sp)
 4d2:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 4d4:	4585                	li	a1,1
 4d6:	142000ef          	jal	618 <sys_sbrk>
}
 4da:	60a2                	ld	ra,8(sp)
 4dc:	6402                	ld	s0,0(sp)
 4de:	0141                	addi	sp,sp,16
 4e0:	8082                	ret

00000000000004e2 <sbrklazy>:

char *
sbrklazy(int n) {
 4e2:	1141                	addi	sp,sp,-16
 4e4:	e406                	sd	ra,8(sp)
 4e6:	e022                	sd	s0,0(sp)
 4e8:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 4ea:	4589                	li	a1,2
 4ec:	12c000ef          	jal	618 <sys_sbrk>
}
 4f0:	60a2                	ld	ra,8(sp)
 4f2:	6402                	ld	s0,0(sp)
 4f4:	0141                	addi	sp,sp,16
 4f6:	8082                	ret

00000000000004f8 <thread_create>:
// thread_create allocates a page-sized stack, calls clone(fn, arg, stacktop).
// Returns the new thread's pid, or -1 on error.
// The stack is passed back via *stack so the caller can free it after join.
int
thread_create(void(*fn)(void*), void *arg, void **stack)
{
 4f8:	7179                	addi	sp,sp,-48
 4fa:	f406                	sd	ra,40(sp)
 4fc:	f022                	sd	s0,32(sp)
 4fe:	e84a                	sd	s2,16(sp)
 500:	e44e                	sd	s3,8(sp)
 502:	e052                	sd	s4,0(sp)
 504:	1800                	addi	s0,sp,48
 506:	89aa                	mv	s3,a0
 508:	8a2e                	mv	s4,a1
 50a:	8932                	mv	s2,a2
  char *s = malloc(PGSIZE);
 50c:	6505                	lui	a0,0x1
 50e:	596000ef          	jal	aa4 <malloc>
  if(s == 0)
 512:	cd0d                	beqz	a0,54c <thread_create+0x54>
 514:	ec26                	sd	s1,24(sp)
 516:	84aa                	mv	s1,a0
    return -1;
  *stack = s;
 518:	00a93023          	sd	a0,0(s2)
  // Stack grows downward: pass the top of the allocated region.
  int pid = clone(fn, arg, s + PGSIZE);
 51c:	6605                	lui	a2,0x1
 51e:	962a                	add	a2,a2,a0
 520:	85d2                	mv	a1,s4
 522:	854e                	mv	a0,s3
 524:	134000ef          	jal	658 <clone>
  if(pid < 0){
 528:	00054a63          	bltz	a0,53c <thread_create+0x44>
 52c:	64e2                	ld	s1,24(sp)
    free(s);
    *stack = 0;
    return -1;
  }
  return pid;
}
 52e:	70a2                	ld	ra,40(sp)
 530:	7402                	ld	s0,32(sp)
 532:	6942                	ld	s2,16(sp)
 534:	69a2                	ld	s3,8(sp)
 536:	6a02                	ld	s4,0(sp)
 538:	6145                	addi	sp,sp,48
 53a:	8082                	ret
    free(s);
 53c:	8526                	mv	a0,s1
 53e:	4e4000ef          	jal	a22 <free>
    *stack = 0;
 542:	00093023          	sd	zero,0(s2)
    return -1;
 546:	557d                	li	a0,-1
 548:	64e2                	ld	s1,24(sp)
 54a:	b7d5                	j	52e <thread_create+0x36>
    return -1;
 54c:	557d                	li	a0,-1
 54e:	b7c5                	j	52e <thread_create+0x36>

0000000000000550 <thread_join>:
// Wait for any child thread to exit.
// If stack is non-null, frees the memory pointed to by *stack and clears it.
// Returns the joined thread's pid, or -1 on error.
int
thread_join(void **stack)
{
 550:	1101                	addi	sp,sp,-32
 552:	ec06                	sd	ra,24(sp)
 554:	e822                	sd	s0,16(sp)
 556:	e426                	sd	s1,8(sp)
 558:	e04a                	sd	s2,0(sp)
 55a:	1000                	addi	s0,sp,32
 55c:	84aa                	mv	s1,a0
  int pid = join();
 55e:	102000ef          	jal	660 <join>
  if(pid < 0)
 562:	02054163          	bltz	a0,584 <thread_join+0x34>
 566:	892a                	mv	s2,a0
    return -1;
  if(stack && *stack){
 568:	c499                	beqz	s1,576 <thread_join+0x26>
 56a:	6088                	ld	a0,0(s1)
 56c:	c509                	beqz	a0,576 <thread_join+0x26>
    free(*stack);
 56e:	4b4000ef          	jal	a22 <free>
    *stack = 0;
 572:	0004b023          	sd	zero,0(s1)
  }
  return pid;
}
 576:	854a                	mv	a0,s2
 578:	60e2                	ld	ra,24(sp)
 57a:	6442                	ld	s0,16(sp)
 57c:	64a2                	ld	s1,8(sp)
 57e:	6902                	ld	s2,0(sp)
 580:	6105                	addi	sp,sp,32
 582:	8082                	ret
    return -1;
 584:	597d                	li	s2,-1
 586:	bfc5                	j	576 <thread_join+0x26>

0000000000000588 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 588:	4885                	li	a7,1
 ecall
 58a:	00000073          	ecall
 ret
 58e:	8082                	ret

0000000000000590 <exit>:
.global exit
exit:
 li a7, SYS_exit
 590:	4889                	li	a7,2
 ecall
 592:	00000073          	ecall
 ret
 596:	8082                	ret

0000000000000598 <wait>:
.global wait
wait:
 li a7, SYS_wait
 598:	488d                	li	a7,3
 ecall
 59a:	00000073          	ecall
 ret
 59e:	8082                	ret

00000000000005a0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5a0:	4891                	li	a7,4
 ecall
 5a2:	00000073          	ecall
 ret
 5a6:	8082                	ret

00000000000005a8 <read>:
.global read
read:
 li a7, SYS_read
 5a8:	4895                	li	a7,5
 ecall
 5aa:	00000073          	ecall
 ret
 5ae:	8082                	ret

00000000000005b0 <write>:
.global write
write:
 li a7, SYS_write
 5b0:	48c1                	li	a7,16
 ecall
 5b2:	00000073          	ecall
 ret
 5b6:	8082                	ret

00000000000005b8 <close>:
.global close
close:
 li a7, SYS_close
 5b8:	48d5                	li	a7,21
 ecall
 5ba:	00000073          	ecall
 ret
 5be:	8082                	ret

00000000000005c0 <kill>:
.global kill
kill:
 li a7, SYS_kill
 5c0:	4899                	li	a7,6
 ecall
 5c2:	00000073          	ecall
 ret
 5c6:	8082                	ret

00000000000005c8 <exec>:
.global exec
exec:
 li a7, SYS_exec
 5c8:	489d                	li	a7,7
 ecall
 5ca:	00000073          	ecall
 ret
 5ce:	8082                	ret

00000000000005d0 <open>:
.global open
open:
 li a7, SYS_open
 5d0:	48bd                	li	a7,15
 ecall
 5d2:	00000073          	ecall
 ret
 5d6:	8082                	ret

00000000000005d8 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5d8:	48c5                	li	a7,17
 ecall
 5da:	00000073          	ecall
 ret
 5de:	8082                	ret

00000000000005e0 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5e0:	48c9                	li	a7,18
 ecall
 5e2:	00000073          	ecall
 ret
 5e6:	8082                	ret

00000000000005e8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5e8:	48a1                	li	a7,8
 ecall
 5ea:	00000073          	ecall
 ret
 5ee:	8082                	ret

00000000000005f0 <link>:
.global link
link:
 li a7, SYS_link
 5f0:	48cd                	li	a7,19
 ecall
 5f2:	00000073          	ecall
 ret
 5f6:	8082                	ret

00000000000005f8 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5f8:	48d1                	li	a7,20
 ecall
 5fa:	00000073          	ecall
 ret
 5fe:	8082                	ret

0000000000000600 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 600:	48a5                	li	a7,9
 ecall
 602:	00000073          	ecall
 ret
 606:	8082                	ret

0000000000000608 <dup>:
.global dup
dup:
 li a7, SYS_dup
 608:	48a9                	li	a7,10
 ecall
 60a:	00000073          	ecall
 ret
 60e:	8082                	ret

0000000000000610 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 610:	48ad                	li	a7,11
 ecall
 612:	00000073          	ecall
 ret
 616:	8082                	ret

0000000000000618 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 618:	48b1                	li	a7,12
 ecall
 61a:	00000073          	ecall
 ret
 61e:	8082                	ret

0000000000000620 <pause>:
.global pause
pause:
 li a7, SYS_pause
 620:	48b5                	li	a7,13
 ecall
 622:	00000073          	ecall
 ret
 626:	8082                	ret

0000000000000628 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 628:	48b9                	li	a7,14
 ecall
 62a:	00000073          	ecall
 ret
 62e:	8082                	ret

0000000000000630 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 630:	48d9                	li	a7,22
 ecall
 632:	00000073          	ecall
 ret
 636:	8082                	ret

0000000000000638 <lock_create>:
.global lock_create
lock_create:
 li a7, SYS_lock_create
 638:	48dd                	li	a7,23
 ecall
 63a:	00000073          	ecall
 ret
 63e:	8082                	ret

0000000000000640 <lock_acquire>:
.global lock_acquire
lock_acquire:
 li a7, SYS_lock_acquire
 640:	48e1                	li	a7,24
 ecall
 642:	00000073          	ecall
 ret
 646:	8082                	ret

0000000000000648 <lock_release>:
.global lock_release
lock_release:
 li a7, SYS_lock_release
 648:	48e5                	li	a7,25
 ecall
 64a:	00000073          	ecall
 ret
 64e:	8082                	ret

0000000000000650 <lock_destroy>:
.global lock_destroy
lock_destroy:
 li a7, SYS_lock_destroy
 650:	48e9                	li	a7,26
 ecall
 652:	00000073          	ecall
 ret
 656:	8082                	ret

0000000000000658 <clone>:
.global clone
clone:
 li a7, SYS_clone
 658:	48ed                	li	a7,27
 ecall
 65a:	00000073          	ecall
 ret
 65e:	8082                	ret

0000000000000660 <join>:
.global join
join:
 li a7, SYS_join
 660:	48f1                	li	a7,28
 ecall
 662:	00000073          	ecall
 ret
 666:	8082                	ret

0000000000000668 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 668:	1101                	addi	sp,sp,-32
 66a:	ec06                	sd	ra,24(sp)
 66c:	e822                	sd	s0,16(sp)
 66e:	1000                	addi	s0,sp,32
 670:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 674:	4605                	li	a2,1
 676:	fef40593          	addi	a1,s0,-17
 67a:	f37ff0ef          	jal	5b0 <write>
}
 67e:	60e2                	ld	ra,24(sp)
 680:	6442                	ld	s0,16(sp)
 682:	6105                	addi	sp,sp,32
 684:	8082                	ret

0000000000000686 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 686:	715d                	addi	sp,sp,-80
 688:	e486                	sd	ra,72(sp)
 68a:	e0a2                	sd	s0,64(sp)
 68c:	f84a                	sd	s2,48(sp)
 68e:	0880                	addi	s0,sp,80
 690:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 692:	c299                	beqz	a3,698 <printint+0x12>
 694:	0805c363          	bltz	a1,71a <printint+0x94>
  neg = 0;
 698:	4881                	li	a7,0
 69a:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 69e:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 6a0:	00000517          	auipc	a0,0x0
 6a4:	56850513          	addi	a0,a0,1384 # c08 <digits>
 6a8:	883e                	mv	a6,a5
 6aa:	2785                	addiw	a5,a5,1
 6ac:	02c5f733          	remu	a4,a1,a2
 6b0:	972a                	add	a4,a4,a0
 6b2:	00074703          	lbu	a4,0(a4)
 6b6:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 6ba:	872e                	mv	a4,a1
 6bc:	02c5d5b3          	divu	a1,a1,a2
 6c0:	0685                	addi	a3,a3,1
 6c2:	fec773e3          	bgeu	a4,a2,6a8 <printint+0x22>
  if(neg)
 6c6:	00088b63          	beqz	a7,6dc <printint+0x56>
    buf[i++] = '-';
 6ca:	fd078793          	addi	a5,a5,-48
 6ce:	97a2                	add	a5,a5,s0
 6d0:	02d00713          	li	a4,45
 6d4:	fee78423          	sb	a4,-24(a5)
 6d8:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 6dc:	02f05a63          	blez	a5,710 <printint+0x8a>
 6e0:	fc26                	sd	s1,56(sp)
 6e2:	f44e                	sd	s3,40(sp)
 6e4:	fb840713          	addi	a4,s0,-72
 6e8:	00f704b3          	add	s1,a4,a5
 6ec:	fff70993          	addi	s3,a4,-1
 6f0:	99be                	add	s3,s3,a5
 6f2:	37fd                	addiw	a5,a5,-1
 6f4:	1782                	slli	a5,a5,0x20
 6f6:	9381                	srli	a5,a5,0x20
 6f8:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 6fc:	fff4c583          	lbu	a1,-1(s1)
 700:	854a                	mv	a0,s2
 702:	f67ff0ef          	jal	668 <putc>
  while(--i >= 0)
 706:	14fd                	addi	s1,s1,-1
 708:	ff349ae3          	bne	s1,s3,6fc <printint+0x76>
 70c:	74e2                	ld	s1,56(sp)
 70e:	79a2                	ld	s3,40(sp)
}
 710:	60a6                	ld	ra,72(sp)
 712:	6406                	ld	s0,64(sp)
 714:	7942                	ld	s2,48(sp)
 716:	6161                	addi	sp,sp,80
 718:	8082                	ret
    x = -xx;
 71a:	40b005b3          	neg	a1,a1
    neg = 1;
 71e:	4885                	li	a7,1
    x = -xx;
 720:	bfad                	j	69a <printint+0x14>

0000000000000722 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 722:	711d                	addi	sp,sp,-96
 724:	ec86                	sd	ra,88(sp)
 726:	e8a2                	sd	s0,80(sp)
 728:	e0ca                	sd	s2,64(sp)
 72a:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 72c:	0005c903          	lbu	s2,0(a1)
 730:	28090663          	beqz	s2,9bc <vprintf+0x29a>
 734:	e4a6                	sd	s1,72(sp)
 736:	fc4e                	sd	s3,56(sp)
 738:	f852                	sd	s4,48(sp)
 73a:	f456                	sd	s5,40(sp)
 73c:	f05a                	sd	s6,32(sp)
 73e:	ec5e                	sd	s7,24(sp)
 740:	e862                	sd	s8,16(sp)
 742:	e466                	sd	s9,8(sp)
 744:	8b2a                	mv	s6,a0
 746:	8a2e                	mv	s4,a1
 748:	8bb2                	mv	s7,a2
  state = 0;
 74a:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 74c:	4481                	li	s1,0
 74e:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 750:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 754:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 758:	06c00c93          	li	s9,108
 75c:	a005                	j	77c <vprintf+0x5a>
        putc(fd, c0);
 75e:	85ca                	mv	a1,s2
 760:	855a                	mv	a0,s6
 762:	f07ff0ef          	jal	668 <putc>
 766:	a019                	j	76c <vprintf+0x4a>
    } else if(state == '%'){
 768:	03598263          	beq	s3,s5,78c <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 76c:	2485                	addiw	s1,s1,1
 76e:	8726                	mv	a4,s1
 770:	009a07b3          	add	a5,s4,s1
 774:	0007c903          	lbu	s2,0(a5)
 778:	22090a63          	beqz	s2,9ac <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 77c:	0009079b          	sext.w	a5,s2
    if(state == 0){
 780:	fe0994e3          	bnez	s3,768 <vprintf+0x46>
      if(c0 == '%'){
 784:	fd579de3          	bne	a5,s5,75e <vprintf+0x3c>
        state = '%';
 788:	89be                	mv	s3,a5
 78a:	b7cd                	j	76c <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 78c:	00ea06b3          	add	a3,s4,a4
 790:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 794:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 796:	c681                	beqz	a3,79e <vprintf+0x7c>
 798:	9752                	add	a4,a4,s4
 79a:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 79e:	05878363          	beq	a5,s8,7e4 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 7a2:	05978d63          	beq	a5,s9,7fc <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 7a6:	07500713          	li	a4,117
 7aa:	0ee78763          	beq	a5,a4,898 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 7ae:	07800713          	li	a4,120
 7b2:	12e78963          	beq	a5,a4,8e4 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 7b6:	07000713          	li	a4,112
 7ba:	14e78e63          	beq	a5,a4,916 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 7be:	06300713          	li	a4,99
 7c2:	18e78e63          	beq	a5,a4,95e <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 7c6:	07300713          	li	a4,115
 7ca:	1ae78463          	beq	a5,a4,972 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 7ce:	02500713          	li	a4,37
 7d2:	04e79563          	bne	a5,a4,81c <vprintf+0xfa>
        putc(fd, '%');
 7d6:	02500593          	li	a1,37
 7da:	855a                	mv	a0,s6
 7dc:	e8dff0ef          	jal	668 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 7e0:	4981                	li	s3,0
 7e2:	b769                	j	76c <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 7e4:	008b8913          	addi	s2,s7,8
 7e8:	4685                	li	a3,1
 7ea:	4629                	li	a2,10
 7ec:	000ba583          	lw	a1,0(s7)
 7f0:	855a                	mv	a0,s6
 7f2:	e95ff0ef          	jal	686 <printint>
 7f6:	8bca                	mv	s7,s2
      state = 0;
 7f8:	4981                	li	s3,0
 7fa:	bf8d                	j	76c <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 7fc:	06400793          	li	a5,100
 800:	02f68963          	beq	a3,a5,832 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 804:	06c00793          	li	a5,108
 808:	04f68263          	beq	a3,a5,84c <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 80c:	07500793          	li	a5,117
 810:	0af68063          	beq	a3,a5,8b0 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 814:	07800793          	li	a5,120
 818:	0ef68263          	beq	a3,a5,8fc <vprintf+0x1da>
        putc(fd, '%');
 81c:	02500593          	li	a1,37
 820:	855a                	mv	a0,s6
 822:	e47ff0ef          	jal	668 <putc>
        putc(fd, c0);
 826:	85ca                	mv	a1,s2
 828:	855a                	mv	a0,s6
 82a:	e3fff0ef          	jal	668 <putc>
      state = 0;
 82e:	4981                	li	s3,0
 830:	bf35                	j	76c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 832:	008b8913          	addi	s2,s7,8
 836:	4685                	li	a3,1
 838:	4629                	li	a2,10
 83a:	000bb583          	ld	a1,0(s7)
 83e:	855a                	mv	a0,s6
 840:	e47ff0ef          	jal	686 <printint>
        i += 1;
 844:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 846:	8bca                	mv	s7,s2
      state = 0;
 848:	4981                	li	s3,0
        i += 1;
 84a:	b70d                	j	76c <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 84c:	06400793          	li	a5,100
 850:	02f60763          	beq	a2,a5,87e <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 854:	07500793          	li	a5,117
 858:	06f60963          	beq	a2,a5,8ca <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 85c:	07800793          	li	a5,120
 860:	faf61ee3          	bne	a2,a5,81c <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 864:	008b8913          	addi	s2,s7,8
 868:	4681                	li	a3,0
 86a:	4641                	li	a2,16
 86c:	000bb583          	ld	a1,0(s7)
 870:	855a                	mv	a0,s6
 872:	e15ff0ef          	jal	686 <printint>
        i += 2;
 876:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 878:	8bca                	mv	s7,s2
      state = 0;
 87a:	4981                	li	s3,0
        i += 2;
 87c:	bdc5                	j	76c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 87e:	008b8913          	addi	s2,s7,8
 882:	4685                	li	a3,1
 884:	4629                	li	a2,10
 886:	000bb583          	ld	a1,0(s7)
 88a:	855a                	mv	a0,s6
 88c:	dfbff0ef          	jal	686 <printint>
        i += 2;
 890:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 892:	8bca                	mv	s7,s2
      state = 0;
 894:	4981                	li	s3,0
        i += 2;
 896:	bdd9                	j	76c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 898:	008b8913          	addi	s2,s7,8
 89c:	4681                	li	a3,0
 89e:	4629                	li	a2,10
 8a0:	000be583          	lwu	a1,0(s7)
 8a4:	855a                	mv	a0,s6
 8a6:	de1ff0ef          	jal	686 <printint>
 8aa:	8bca                	mv	s7,s2
      state = 0;
 8ac:	4981                	li	s3,0
 8ae:	bd7d                	j	76c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8b0:	008b8913          	addi	s2,s7,8
 8b4:	4681                	li	a3,0
 8b6:	4629                	li	a2,10
 8b8:	000bb583          	ld	a1,0(s7)
 8bc:	855a                	mv	a0,s6
 8be:	dc9ff0ef          	jal	686 <printint>
        i += 1;
 8c2:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 8c4:	8bca                	mv	s7,s2
      state = 0;
 8c6:	4981                	li	s3,0
        i += 1;
 8c8:	b555                	j	76c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8ca:	008b8913          	addi	s2,s7,8
 8ce:	4681                	li	a3,0
 8d0:	4629                	li	a2,10
 8d2:	000bb583          	ld	a1,0(s7)
 8d6:	855a                	mv	a0,s6
 8d8:	dafff0ef          	jal	686 <printint>
        i += 2;
 8dc:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 8de:	8bca                	mv	s7,s2
      state = 0;
 8e0:	4981                	li	s3,0
        i += 2;
 8e2:	b569                	j	76c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 8e4:	008b8913          	addi	s2,s7,8
 8e8:	4681                	li	a3,0
 8ea:	4641                	li	a2,16
 8ec:	000be583          	lwu	a1,0(s7)
 8f0:	855a                	mv	a0,s6
 8f2:	d95ff0ef          	jal	686 <printint>
 8f6:	8bca                	mv	s7,s2
      state = 0;
 8f8:	4981                	li	s3,0
 8fa:	bd8d                	j	76c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 8fc:	008b8913          	addi	s2,s7,8
 900:	4681                	li	a3,0
 902:	4641                	li	a2,16
 904:	000bb583          	ld	a1,0(s7)
 908:	855a                	mv	a0,s6
 90a:	d7dff0ef          	jal	686 <printint>
        i += 1;
 90e:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 910:	8bca                	mv	s7,s2
      state = 0;
 912:	4981                	li	s3,0
        i += 1;
 914:	bda1                	j	76c <vprintf+0x4a>
 916:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 918:	008b8d13          	addi	s10,s7,8
 91c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 920:	03000593          	li	a1,48
 924:	855a                	mv	a0,s6
 926:	d43ff0ef          	jal	668 <putc>
  putc(fd, 'x');
 92a:	07800593          	li	a1,120
 92e:	855a                	mv	a0,s6
 930:	d39ff0ef          	jal	668 <putc>
 934:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 936:	00000b97          	auipc	s7,0x0
 93a:	2d2b8b93          	addi	s7,s7,722 # c08 <digits>
 93e:	03c9d793          	srli	a5,s3,0x3c
 942:	97de                	add	a5,a5,s7
 944:	0007c583          	lbu	a1,0(a5)
 948:	855a                	mv	a0,s6
 94a:	d1fff0ef          	jal	668 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 94e:	0992                	slli	s3,s3,0x4
 950:	397d                	addiw	s2,s2,-1
 952:	fe0916e3          	bnez	s2,93e <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 956:	8bea                	mv	s7,s10
      state = 0;
 958:	4981                	li	s3,0
 95a:	6d02                	ld	s10,0(sp)
 95c:	bd01                	j	76c <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 95e:	008b8913          	addi	s2,s7,8
 962:	000bc583          	lbu	a1,0(s7)
 966:	855a                	mv	a0,s6
 968:	d01ff0ef          	jal	668 <putc>
 96c:	8bca                	mv	s7,s2
      state = 0;
 96e:	4981                	li	s3,0
 970:	bbf5                	j	76c <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 972:	008b8993          	addi	s3,s7,8
 976:	000bb903          	ld	s2,0(s7)
 97a:	00090f63          	beqz	s2,998 <vprintf+0x276>
        for(; *s; s++)
 97e:	00094583          	lbu	a1,0(s2)
 982:	c195                	beqz	a1,9a6 <vprintf+0x284>
          putc(fd, *s);
 984:	855a                	mv	a0,s6
 986:	ce3ff0ef          	jal	668 <putc>
        for(; *s; s++)
 98a:	0905                	addi	s2,s2,1
 98c:	00094583          	lbu	a1,0(s2)
 990:	f9f5                	bnez	a1,984 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 992:	8bce                	mv	s7,s3
      state = 0;
 994:	4981                	li	s3,0
 996:	bbd9                	j	76c <vprintf+0x4a>
          s = "(null)";
 998:	00000917          	auipc	s2,0x0
 99c:	26890913          	addi	s2,s2,616 # c00 <malloc+0x15c>
        for(; *s; s++)
 9a0:	02800593          	li	a1,40
 9a4:	b7c5                	j	984 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 9a6:	8bce                	mv	s7,s3
      state = 0;
 9a8:	4981                	li	s3,0
 9aa:	b3c9                	j	76c <vprintf+0x4a>
 9ac:	64a6                	ld	s1,72(sp)
 9ae:	79e2                	ld	s3,56(sp)
 9b0:	7a42                	ld	s4,48(sp)
 9b2:	7aa2                	ld	s5,40(sp)
 9b4:	7b02                	ld	s6,32(sp)
 9b6:	6be2                	ld	s7,24(sp)
 9b8:	6c42                	ld	s8,16(sp)
 9ba:	6ca2                	ld	s9,8(sp)
    }
  }
}
 9bc:	60e6                	ld	ra,88(sp)
 9be:	6446                	ld	s0,80(sp)
 9c0:	6906                	ld	s2,64(sp)
 9c2:	6125                	addi	sp,sp,96
 9c4:	8082                	ret

00000000000009c6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9c6:	715d                	addi	sp,sp,-80
 9c8:	ec06                	sd	ra,24(sp)
 9ca:	e822                	sd	s0,16(sp)
 9cc:	1000                	addi	s0,sp,32
 9ce:	e010                	sd	a2,0(s0)
 9d0:	e414                	sd	a3,8(s0)
 9d2:	e818                	sd	a4,16(s0)
 9d4:	ec1c                	sd	a5,24(s0)
 9d6:	03043023          	sd	a6,32(s0)
 9da:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 9de:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 9e2:	8622                	mv	a2,s0
 9e4:	d3fff0ef          	jal	722 <vprintf>
}
 9e8:	60e2                	ld	ra,24(sp)
 9ea:	6442                	ld	s0,16(sp)
 9ec:	6161                	addi	sp,sp,80
 9ee:	8082                	ret

00000000000009f0 <printf>:

void
printf(const char *fmt, ...)
{
 9f0:	711d                	addi	sp,sp,-96
 9f2:	ec06                	sd	ra,24(sp)
 9f4:	e822                	sd	s0,16(sp)
 9f6:	1000                	addi	s0,sp,32
 9f8:	e40c                	sd	a1,8(s0)
 9fa:	e810                	sd	a2,16(s0)
 9fc:	ec14                	sd	a3,24(s0)
 9fe:	f018                	sd	a4,32(s0)
 a00:	f41c                	sd	a5,40(s0)
 a02:	03043823          	sd	a6,48(s0)
 a06:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a0a:	00840613          	addi	a2,s0,8
 a0e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a12:	85aa                	mv	a1,a0
 a14:	4505                	li	a0,1
 a16:	d0dff0ef          	jal	722 <vprintf>
}
 a1a:	60e2                	ld	ra,24(sp)
 a1c:	6442                	ld	s0,16(sp)
 a1e:	6125                	addi	sp,sp,96
 a20:	8082                	ret

0000000000000a22 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a22:	1141                	addi	sp,sp,-16
 a24:	e422                	sd	s0,8(sp)
 a26:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a28:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a2c:	00001797          	auipc	a5,0x1
 a30:	5d47b783          	ld	a5,1492(a5) # 2000 <freep>
 a34:	a02d                	j	a5e <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a36:	4618                	lw	a4,8(a2)
 a38:	9f2d                	addw	a4,a4,a1
 a3a:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a3e:	6398                	ld	a4,0(a5)
 a40:	6310                	ld	a2,0(a4)
 a42:	a83d                	j	a80 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a44:	ff852703          	lw	a4,-8(a0)
 a48:	9f31                	addw	a4,a4,a2
 a4a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 a4c:	ff053683          	ld	a3,-16(a0)
 a50:	a091                	j	a94 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a52:	6398                	ld	a4,0(a5)
 a54:	00e7e463          	bltu	a5,a4,a5c <free+0x3a>
 a58:	00e6ea63          	bltu	a3,a4,a6c <free+0x4a>
{
 a5c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a5e:	fed7fae3          	bgeu	a5,a3,a52 <free+0x30>
 a62:	6398                	ld	a4,0(a5)
 a64:	00e6e463          	bltu	a3,a4,a6c <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a68:	fee7eae3          	bltu	a5,a4,a5c <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 a6c:	ff852583          	lw	a1,-8(a0)
 a70:	6390                	ld	a2,0(a5)
 a72:	02059813          	slli	a6,a1,0x20
 a76:	01c85713          	srli	a4,a6,0x1c
 a7a:	9736                	add	a4,a4,a3
 a7c:	fae60de3          	beq	a2,a4,a36 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 a80:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a84:	4790                	lw	a2,8(a5)
 a86:	02061593          	slli	a1,a2,0x20
 a8a:	01c5d713          	srli	a4,a1,0x1c
 a8e:	973e                	add	a4,a4,a5
 a90:	fae68ae3          	beq	a3,a4,a44 <free+0x22>
    p->s.ptr = bp->s.ptr;
 a94:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 a96:	00001717          	auipc	a4,0x1
 a9a:	56f73523          	sd	a5,1386(a4) # 2000 <freep>
}
 a9e:	6422                	ld	s0,8(sp)
 aa0:	0141                	addi	sp,sp,16
 aa2:	8082                	ret

0000000000000aa4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 aa4:	7139                	addi	sp,sp,-64
 aa6:	fc06                	sd	ra,56(sp)
 aa8:	f822                	sd	s0,48(sp)
 aaa:	f426                	sd	s1,40(sp)
 aac:	ec4e                	sd	s3,24(sp)
 aae:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ab0:	02051493          	slli	s1,a0,0x20
 ab4:	9081                	srli	s1,s1,0x20
 ab6:	04bd                	addi	s1,s1,15
 ab8:	8091                	srli	s1,s1,0x4
 aba:	0014899b          	addiw	s3,s1,1
 abe:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 ac0:	00001517          	auipc	a0,0x1
 ac4:	54053503          	ld	a0,1344(a0) # 2000 <freep>
 ac8:	c915                	beqz	a0,afc <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 aca:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 acc:	4798                	lw	a4,8(a5)
 ace:	08977a63          	bgeu	a4,s1,b62 <malloc+0xbe>
 ad2:	f04a                	sd	s2,32(sp)
 ad4:	e852                	sd	s4,16(sp)
 ad6:	e456                	sd	s5,8(sp)
 ad8:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 ada:	8a4e                	mv	s4,s3
 adc:	0009871b          	sext.w	a4,s3
 ae0:	6685                	lui	a3,0x1
 ae2:	00d77363          	bgeu	a4,a3,ae8 <malloc+0x44>
 ae6:	6a05                	lui	s4,0x1
 ae8:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 aec:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 af0:	00001917          	auipc	s2,0x1
 af4:	51090913          	addi	s2,s2,1296 # 2000 <freep>
  if(p == SBRK_ERROR)
 af8:	5afd                	li	s5,-1
 afa:	a081                	j	b3a <malloc+0x96>
 afc:	f04a                	sd	s2,32(sp)
 afe:	e852                	sd	s4,16(sp)
 b00:	e456                	sd	s5,8(sp)
 b02:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 b04:	00001797          	auipc	a5,0x1
 b08:	51c78793          	addi	a5,a5,1308 # 2020 <base>
 b0c:	00001717          	auipc	a4,0x1
 b10:	4ef73a23          	sd	a5,1268(a4) # 2000 <freep>
 b14:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 b16:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 b1a:	b7c1                	j	ada <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 b1c:	6398                	ld	a4,0(a5)
 b1e:	e118                	sd	a4,0(a0)
 b20:	a8a9                	j	b7a <malloc+0xd6>
  hp->s.size = nu;
 b22:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 b26:	0541                	addi	a0,a0,16
 b28:	efbff0ef          	jal	a22 <free>
  return freep;
 b2c:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 b30:	c12d                	beqz	a0,b92 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b32:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b34:	4798                	lw	a4,8(a5)
 b36:	02977263          	bgeu	a4,s1,b5a <malloc+0xb6>
    if(p == freep)
 b3a:	00093703          	ld	a4,0(s2)
 b3e:	853e                	mv	a0,a5
 b40:	fef719e3          	bne	a4,a5,b32 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 b44:	8552                	mv	a0,s4
 b46:	987ff0ef          	jal	4cc <sbrk>
  if(p == SBRK_ERROR)
 b4a:	fd551ce3          	bne	a0,s5,b22 <malloc+0x7e>
        return 0;
 b4e:	4501                	li	a0,0
 b50:	7902                	ld	s2,32(sp)
 b52:	6a42                	ld	s4,16(sp)
 b54:	6aa2                	ld	s5,8(sp)
 b56:	6b02                	ld	s6,0(sp)
 b58:	a03d                	j	b86 <malloc+0xe2>
 b5a:	7902                	ld	s2,32(sp)
 b5c:	6a42                	ld	s4,16(sp)
 b5e:	6aa2                	ld	s5,8(sp)
 b60:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 b62:	fae48de3          	beq	s1,a4,b1c <malloc+0x78>
        p->s.size -= nunits;
 b66:	4137073b          	subw	a4,a4,s3
 b6a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b6c:	02071693          	slli	a3,a4,0x20
 b70:	01c6d713          	srli	a4,a3,0x1c
 b74:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b76:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b7a:	00001717          	auipc	a4,0x1
 b7e:	48a73323          	sd	a0,1158(a4) # 2000 <freep>
      return (void*)(p + 1);
 b82:	01078513          	addi	a0,a5,16
  }
}
 b86:	70e2                	ld	ra,56(sp)
 b88:	7442                	ld	s0,48(sp)
 b8a:	74a2                	ld	s1,40(sp)
 b8c:	69e2                	ld	s3,24(sp)
 b8e:	6121                	addi	sp,sp,64
 b90:	8082                	ret
 b92:	7902                	ld	s2,32(sp)
 b94:	6a42                	ld	s4,16(sp)
 b96:	6aa2                	ld	s5,8(sp)
 b98:	6b02                	ld	s6,0(sp)
 b9a:	b7f5                	j	b86 <malloc+0xe2>
