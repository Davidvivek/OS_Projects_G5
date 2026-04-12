
user/_ln:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	addi	s0,sp,32
  if(argc != 3){
   8:	478d                	li	a5,3
   a:	00f50d63          	beq	a0,a5,24 <main+0x24>
   e:	e426                	sd	s1,8(sp)
    fprintf(2, "Usage: ln old new\n");
  10:	00001597          	auipc	a1,0x1
  14:	99058593          	addi	a1,a1,-1648 # 9a0 <malloc+0xf8>
  18:	4509                	li	a0,2
  1a:	7b0000ef          	jal	7ca <fprintf>
    exit(1);
  1e:	4505                	li	a0,1
  20:	352000ef          	jal	372 <exit>
  24:	e426                	sd	s1,8(sp)
  26:	84ae                	mv	s1,a1
  }
  if(link(argv[1], argv[2]) < 0)
  28:	698c                	ld	a1,16(a1)
  2a:	6488                	ld	a0,8(s1)
  2c:	3a6000ef          	jal	3d2 <link>
  30:	00054563          	bltz	a0,3a <main+0x3a>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit(0);
  34:	4501                	li	a0,0
  36:	33c000ef          	jal	372 <exit>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  3a:	6894                	ld	a3,16(s1)
  3c:	6490                	ld	a2,8(s1)
  3e:	00001597          	auipc	a1,0x1
  42:	97a58593          	addi	a1,a1,-1670 # 9b8 <malloc+0x110>
  46:	4509                	li	a0,2
  48:	782000ef          	jal	7ca <fprintf>
  4c:	b7e5                	j	34 <main+0x34>

000000000000004e <start>:
  4e:	1141                	addi	sp,sp,-16
  50:	e406                	sd	ra,8(sp)
  52:	e022                	sd	s0,0(sp)
  54:	0800                	addi	s0,sp,16
  56:	fabff0ef          	jal	0 <main>
  5a:	318000ef          	jal	372 <exit>

000000000000005e <strcpy>:
  5e:	1141                	addi	sp,sp,-16
  60:	e422                	sd	s0,8(sp)
  62:	0800                	addi	s0,sp,16
  64:	87aa                	mv	a5,a0
  66:	0585                	addi	a1,a1,1
  68:	0785                	addi	a5,a5,1
  6a:	fff5c703          	lbu	a4,-1(a1)
  6e:	fee78fa3          	sb	a4,-1(a5)
  72:	fb75                	bnez	a4,66 <strcpy+0x8>
  74:	6422                	ld	s0,8(sp)
  76:	0141                	addi	sp,sp,16
  78:	8082                	ret

000000000000007a <strcmp>:
  7a:	1141                	addi	sp,sp,-16
  7c:	e422                	sd	s0,8(sp)
  7e:	0800                	addi	s0,sp,16
  80:	00054783          	lbu	a5,0(a0)
  84:	cb91                	beqz	a5,98 <strcmp+0x1e>
  86:	0005c703          	lbu	a4,0(a1)
  8a:	00f71763          	bne	a4,a5,98 <strcmp+0x1e>
  8e:	0505                	addi	a0,a0,1
  90:	0585                	addi	a1,a1,1
  92:	00054783          	lbu	a5,0(a0)
  96:	fbe5                	bnez	a5,86 <strcmp+0xc>
  98:	0005c503          	lbu	a0,0(a1)
  9c:	40a7853b          	subw	a0,a5,a0
  a0:	6422                	ld	s0,8(sp)
  a2:	0141                	addi	sp,sp,16
  a4:	8082                	ret

00000000000000a6 <strlen>:
  a6:	1141                	addi	sp,sp,-16
  a8:	e422                	sd	s0,8(sp)
  aa:	0800                	addi	s0,sp,16
  ac:	00054783          	lbu	a5,0(a0)
  b0:	cf91                	beqz	a5,cc <strlen+0x26>
  b2:	0505                	addi	a0,a0,1
  b4:	87aa                	mv	a5,a0
  b6:	86be                	mv	a3,a5
  b8:	0785                	addi	a5,a5,1
  ba:	fff7c703          	lbu	a4,-1(a5)
  be:	ff65                	bnez	a4,b6 <strlen+0x10>
  c0:	40a6853b          	subw	a0,a3,a0
  c4:	2505                	addiw	a0,a0,1
  c6:	6422                	ld	s0,8(sp)
  c8:	0141                	addi	sp,sp,16
  ca:	8082                	ret
  cc:	4501                	li	a0,0
  ce:	bfe5                	j	c6 <strlen+0x20>

00000000000000d0 <memset>:
  d0:	1141                	addi	sp,sp,-16
  d2:	e422                	sd	s0,8(sp)
  d4:	0800                	addi	s0,sp,16
  d6:	ca19                	beqz	a2,ec <memset+0x1c>
  d8:	87aa                	mv	a5,a0
  da:	1602                	slli	a2,a2,0x20
  dc:	9201                	srli	a2,a2,0x20
  de:	00a60733          	add	a4,a2,a0
  e2:	00b78023          	sb	a1,0(a5)
  e6:	0785                	addi	a5,a5,1
  e8:	fee79de3          	bne	a5,a4,e2 <memset+0x12>
  ec:	6422                	ld	s0,8(sp)
  ee:	0141                	addi	sp,sp,16
  f0:	8082                	ret

00000000000000f2 <strchr>:
  f2:	1141                	addi	sp,sp,-16
  f4:	e422                	sd	s0,8(sp)
  f6:	0800                	addi	s0,sp,16
  f8:	00054783          	lbu	a5,0(a0)
  fc:	cb99                	beqz	a5,112 <strchr+0x20>
  fe:	00f58763          	beq	a1,a5,10c <strchr+0x1a>
 102:	0505                	addi	a0,a0,1
 104:	00054783          	lbu	a5,0(a0)
 108:	fbfd                	bnez	a5,fe <strchr+0xc>
 10a:	4501                	li	a0,0
 10c:	6422                	ld	s0,8(sp)
 10e:	0141                	addi	sp,sp,16
 110:	8082                	ret
 112:	4501                	li	a0,0
 114:	bfe5                	j	10c <strchr+0x1a>

0000000000000116 <gets>:
 116:	711d                	addi	sp,sp,-96
 118:	ec86                	sd	ra,88(sp)
 11a:	e8a2                	sd	s0,80(sp)
 11c:	e4a6                	sd	s1,72(sp)
 11e:	e0ca                	sd	s2,64(sp)
 120:	fc4e                	sd	s3,56(sp)
 122:	f852                	sd	s4,48(sp)
 124:	f456                	sd	s5,40(sp)
 126:	f05a                	sd	s6,32(sp)
 128:	ec5e                	sd	s7,24(sp)
 12a:	1080                	addi	s0,sp,96
 12c:	8baa                	mv	s7,a0
 12e:	8a2e                	mv	s4,a1
 130:	892a                	mv	s2,a0
 132:	4481                	li	s1,0
 134:	4aa9                	li	s5,10
 136:	4b35                	li	s6,13
 138:	89a6                	mv	s3,s1
 13a:	2485                	addiw	s1,s1,1
 13c:	0344d663          	bge	s1,s4,168 <gets+0x52>
 140:	4605                	li	a2,1
 142:	faf40593          	addi	a1,s0,-81
 146:	4501                	li	a0,0
 148:	242000ef          	jal	38a <read>
 14c:	00a05e63          	blez	a0,168 <gets+0x52>
 150:	faf44783          	lbu	a5,-81(s0)
 154:	00f90023          	sb	a5,0(s2)
 158:	01578763          	beq	a5,s5,166 <gets+0x50>
 15c:	0905                	addi	s2,s2,1
 15e:	fd679de3          	bne	a5,s6,138 <gets+0x22>
 162:	89a6                	mv	s3,s1
 164:	a011                	j	168 <gets+0x52>
 166:	89a6                	mv	s3,s1
 168:	99de                	add	s3,s3,s7
 16a:	00098023          	sb	zero,0(s3)
 16e:	855e                	mv	a0,s7
 170:	60e6                	ld	ra,88(sp)
 172:	6446                	ld	s0,80(sp)
 174:	64a6                	ld	s1,72(sp)
 176:	6906                	ld	s2,64(sp)
 178:	79e2                	ld	s3,56(sp)
 17a:	7a42                	ld	s4,48(sp)
 17c:	7aa2                	ld	s5,40(sp)
 17e:	7b02                	ld	s6,32(sp)
 180:	6be2                	ld	s7,24(sp)
 182:	6125                	addi	sp,sp,96
 184:	8082                	ret

0000000000000186 <stat>:
 186:	1101                	addi	sp,sp,-32
 188:	ec06                	sd	ra,24(sp)
 18a:	e822                	sd	s0,16(sp)
 18c:	e04a                	sd	s2,0(sp)
 18e:	1000                	addi	s0,sp,32
 190:	892e                	mv	s2,a1
 192:	4581                	li	a1,0
 194:	21e000ef          	jal	3b2 <open>
 198:	02054263          	bltz	a0,1bc <stat+0x36>
 19c:	e426                	sd	s1,8(sp)
 19e:	84aa                	mv	s1,a0
 1a0:	85ca                	mv	a1,s2
 1a2:	228000ef          	jal	3ca <fstat>
 1a6:	892a                	mv	s2,a0
 1a8:	8526                	mv	a0,s1
 1aa:	1f0000ef          	jal	39a <close>
 1ae:	64a2                	ld	s1,8(sp)
 1b0:	854a                	mv	a0,s2
 1b2:	60e2                	ld	ra,24(sp)
 1b4:	6442                	ld	s0,16(sp)
 1b6:	6902                	ld	s2,0(sp)
 1b8:	6105                	addi	sp,sp,32
 1ba:	8082                	ret
 1bc:	597d                	li	s2,-1
 1be:	bfcd                	j	1b0 <stat+0x2a>

00000000000001c0 <atoi>:
 1c0:	1141                	addi	sp,sp,-16
 1c2:	e422                	sd	s0,8(sp)
 1c4:	0800                	addi	s0,sp,16
 1c6:	00054683          	lbu	a3,0(a0)
 1ca:	fd06879b          	addiw	a5,a3,-48
 1ce:	0ff7f793          	zext.b	a5,a5
 1d2:	4625                	li	a2,9
 1d4:	02f66863          	bltu	a2,a5,204 <atoi+0x44>
 1d8:	872a                	mv	a4,a0
 1da:	4501                	li	a0,0
 1dc:	0705                	addi	a4,a4,1
 1de:	0025179b          	slliw	a5,a0,0x2
 1e2:	9fa9                	addw	a5,a5,a0
 1e4:	0017979b          	slliw	a5,a5,0x1
 1e8:	9fb5                	addw	a5,a5,a3
 1ea:	fd07851b          	addiw	a0,a5,-48
 1ee:	00074683          	lbu	a3,0(a4)
 1f2:	fd06879b          	addiw	a5,a3,-48
 1f6:	0ff7f793          	zext.b	a5,a5
 1fa:	fef671e3          	bgeu	a2,a5,1dc <atoi+0x1c>
 1fe:	6422                	ld	s0,8(sp)
 200:	0141                	addi	sp,sp,16
 202:	8082                	ret
 204:	4501                	li	a0,0
 206:	bfe5                	j	1fe <atoi+0x3e>

0000000000000208 <memmove>:
 208:	1141                	addi	sp,sp,-16
 20a:	e422                	sd	s0,8(sp)
 20c:	0800                	addi	s0,sp,16
 20e:	02b57463          	bgeu	a0,a1,236 <memmove+0x2e>
 212:	00c05f63          	blez	a2,230 <memmove+0x28>
 216:	1602                	slli	a2,a2,0x20
 218:	9201                	srli	a2,a2,0x20
 21a:	00c507b3          	add	a5,a0,a2
 21e:	872a                	mv	a4,a0
 220:	0585                	addi	a1,a1,1
 222:	0705                	addi	a4,a4,1
 224:	fff5c683          	lbu	a3,-1(a1)
 228:	fed70fa3          	sb	a3,-1(a4)
 22c:	fef71ae3          	bne	a4,a5,220 <memmove+0x18>
 230:	6422                	ld	s0,8(sp)
 232:	0141                	addi	sp,sp,16
 234:	8082                	ret
 236:	00c50733          	add	a4,a0,a2
 23a:	95b2                	add	a1,a1,a2
 23c:	fec05ae3          	blez	a2,230 <memmove+0x28>
 240:	fff6079b          	addiw	a5,a2,-1
 244:	1782                	slli	a5,a5,0x20
 246:	9381                	srli	a5,a5,0x20
 248:	fff7c793          	not	a5,a5
 24c:	97ba                	add	a5,a5,a4
 24e:	15fd                	addi	a1,a1,-1
 250:	177d                	addi	a4,a4,-1
 252:	0005c683          	lbu	a3,0(a1)
 256:	00d70023          	sb	a3,0(a4)
 25a:	fee79ae3          	bne	a5,a4,24e <memmove+0x46>
 25e:	bfc9                	j	230 <memmove+0x28>

0000000000000260 <memcmp>:
 260:	1141                	addi	sp,sp,-16
 262:	e422                	sd	s0,8(sp)
 264:	0800                	addi	s0,sp,16
 266:	ca05                	beqz	a2,296 <memcmp+0x36>
 268:	fff6069b          	addiw	a3,a2,-1
 26c:	1682                	slli	a3,a3,0x20
 26e:	9281                	srli	a3,a3,0x20
 270:	0685                	addi	a3,a3,1
 272:	96aa                	add	a3,a3,a0
 274:	00054783          	lbu	a5,0(a0)
 278:	0005c703          	lbu	a4,0(a1)
 27c:	00e79863          	bne	a5,a4,28c <memcmp+0x2c>
 280:	0505                	addi	a0,a0,1
 282:	0585                	addi	a1,a1,1
 284:	fed518e3          	bne	a0,a3,274 <memcmp+0x14>
 288:	4501                	li	a0,0
 28a:	a019                	j	290 <memcmp+0x30>
 28c:	40e7853b          	subw	a0,a5,a4
 290:	6422                	ld	s0,8(sp)
 292:	0141                	addi	sp,sp,16
 294:	8082                	ret
 296:	4501                	li	a0,0
 298:	bfe5                	j	290 <memcmp+0x30>

000000000000029a <memcpy>:
 29a:	1141                	addi	sp,sp,-16
 29c:	e406                	sd	ra,8(sp)
 29e:	e022                	sd	s0,0(sp)
 2a0:	0800                	addi	s0,sp,16
 2a2:	f67ff0ef          	jal	208 <memmove>
 2a6:	60a2                	ld	ra,8(sp)
 2a8:	6402                	ld	s0,0(sp)
 2aa:	0141                	addi	sp,sp,16
 2ac:	8082                	ret

00000000000002ae <sbrk>:
 2ae:	1141                	addi	sp,sp,-16
 2b0:	e406                	sd	ra,8(sp)
 2b2:	e022                	sd	s0,0(sp)
 2b4:	0800                	addi	s0,sp,16
 2b6:	4585                	li	a1,1
 2b8:	142000ef          	jal	3fa <sys_sbrk>
 2bc:	60a2                	ld	ra,8(sp)
 2be:	6402                	ld	s0,0(sp)
 2c0:	0141                	addi	sp,sp,16
 2c2:	8082                	ret

00000000000002c4 <sbrklazy>:
 2c4:	1141                	addi	sp,sp,-16
 2c6:	e406                	sd	ra,8(sp)
 2c8:	e022                	sd	s0,0(sp)
 2ca:	0800                	addi	s0,sp,16
 2cc:	4589                	li	a1,2
 2ce:	12c000ef          	jal	3fa <sys_sbrk>
 2d2:	60a2                	ld	ra,8(sp)
 2d4:	6402                	ld	s0,0(sp)
 2d6:	0141                	addi	sp,sp,16
 2d8:	8082                	ret

00000000000002da <thread_create>:
 2da:	7179                	addi	sp,sp,-48
 2dc:	f406                	sd	ra,40(sp)
 2de:	f022                	sd	s0,32(sp)
 2e0:	e84a                	sd	s2,16(sp)
 2e2:	e44e                	sd	s3,8(sp)
 2e4:	e052                	sd	s4,0(sp)
 2e6:	1800                	addi	s0,sp,48
 2e8:	89aa                	mv	s3,a0
 2ea:	8a2e                	mv	s4,a1
 2ec:	8932                	mv	s2,a2
 2ee:	6505                	lui	a0,0x1
 2f0:	5b8000ef          	jal	8a8 <malloc>
 2f4:	cd0d                	beqz	a0,32e <thread_create+0x54>
 2f6:	ec26                	sd	s1,24(sp)
 2f8:	84aa                	mv	s1,a0
 2fa:	00a93023          	sd	a0,0(s2)
 2fe:	6605                	lui	a2,0x1
 300:	962a                	add	a2,a2,a0
 302:	85d2                	mv	a1,s4
 304:	854e                	mv	a0,s3
 306:	134000ef          	jal	43a <clone>
 30a:	00054a63          	bltz	a0,31e <thread_create+0x44>
 30e:	64e2                	ld	s1,24(sp)
 310:	70a2                	ld	ra,40(sp)
 312:	7402                	ld	s0,32(sp)
 314:	6942                	ld	s2,16(sp)
 316:	69a2                	ld	s3,8(sp)
 318:	6a02                	ld	s4,0(sp)
 31a:	6145                	addi	sp,sp,48
 31c:	8082                	ret
 31e:	8526                	mv	a0,s1
 320:	506000ef          	jal	826 <free>
 324:	00093023          	sd	zero,0(s2)
 328:	557d                	li	a0,-1
 32a:	64e2                	ld	s1,24(sp)
 32c:	b7d5                	j	310 <thread_create+0x36>
 32e:	557d                	li	a0,-1
 330:	b7c5                	j	310 <thread_create+0x36>

0000000000000332 <thread_join>:
 332:	1101                	addi	sp,sp,-32
 334:	ec06                	sd	ra,24(sp)
 336:	e822                	sd	s0,16(sp)
 338:	e426                	sd	s1,8(sp)
 33a:	e04a                	sd	s2,0(sp)
 33c:	1000                	addi	s0,sp,32
 33e:	84aa                	mv	s1,a0
 340:	102000ef          	jal	442 <join>
 344:	02054163          	bltz	a0,366 <thread_join+0x34>
 348:	892a                	mv	s2,a0
 34a:	c499                	beqz	s1,358 <thread_join+0x26>
 34c:	6088                	ld	a0,0(s1)
 34e:	c509                	beqz	a0,358 <thread_join+0x26>
 350:	4d6000ef          	jal	826 <free>
 354:	0004b023          	sd	zero,0(s1)
 358:	854a                	mv	a0,s2
 35a:	60e2                	ld	ra,24(sp)
 35c:	6442                	ld	s0,16(sp)
 35e:	64a2                	ld	s1,8(sp)
 360:	6902                	ld	s2,0(sp)
 362:	6105                	addi	sp,sp,32
 364:	8082                	ret
 366:	597d                	li	s2,-1
 368:	bfc5                	j	358 <thread_join+0x26>

000000000000036a <fork>:
 36a:	4885                	li	a7,1
 36c:	00000073          	ecall
 370:	8082                	ret

0000000000000372 <exit>:
 372:	4889                	li	a7,2
 374:	00000073          	ecall
 378:	8082                	ret

000000000000037a <wait>:
 37a:	488d                	li	a7,3
 37c:	00000073          	ecall
 380:	8082                	ret

0000000000000382 <pipe>:
 382:	4891                	li	a7,4
 384:	00000073          	ecall
 388:	8082                	ret

000000000000038a <read>:
 38a:	4895                	li	a7,5
 38c:	00000073          	ecall
 390:	8082                	ret

0000000000000392 <write>:
 392:	48c1                	li	a7,16
 394:	00000073          	ecall
 398:	8082                	ret

000000000000039a <close>:
 39a:	48d5                	li	a7,21
 39c:	00000073          	ecall
 3a0:	8082                	ret

00000000000003a2 <kill>:
 3a2:	4899                	li	a7,6
 3a4:	00000073          	ecall
 3a8:	8082                	ret

00000000000003aa <exec>:
 3aa:	489d                	li	a7,7
 3ac:	00000073          	ecall
 3b0:	8082                	ret

00000000000003b2 <open>:
 3b2:	48bd                	li	a7,15
 3b4:	00000073          	ecall
 3b8:	8082                	ret

00000000000003ba <mknod>:
 3ba:	48c5                	li	a7,17
 3bc:	00000073          	ecall
 3c0:	8082                	ret

00000000000003c2 <unlink>:
 3c2:	48c9                	li	a7,18
 3c4:	00000073          	ecall
 3c8:	8082                	ret

00000000000003ca <fstat>:
 3ca:	48a1                	li	a7,8
 3cc:	00000073          	ecall
 3d0:	8082                	ret

00000000000003d2 <link>:
 3d2:	48cd                	li	a7,19
 3d4:	00000073          	ecall
 3d8:	8082                	ret

00000000000003da <mkdir>:
 3da:	48d1                	li	a7,20
 3dc:	00000073          	ecall
 3e0:	8082                	ret

00000000000003e2 <chdir>:
 3e2:	48a5                	li	a7,9
 3e4:	00000073          	ecall
 3e8:	8082                	ret

00000000000003ea <dup>:
 3ea:	48a9                	li	a7,10
 3ec:	00000073          	ecall
 3f0:	8082                	ret

00000000000003f2 <getpid>:
 3f2:	48ad                	li	a7,11
 3f4:	00000073          	ecall
 3f8:	8082                	ret

00000000000003fa <sys_sbrk>:
 3fa:	48b1                	li	a7,12
 3fc:	00000073          	ecall
 400:	8082                	ret

0000000000000402 <pause>:
 402:	48b5                	li	a7,13
 404:	00000073          	ecall
 408:	8082                	ret

000000000000040a <uptime>:
 40a:	48b9                	li	a7,14
 40c:	00000073          	ecall
 410:	8082                	ret

0000000000000412 <getcwd>:
 412:	48d9                	li	a7,22
 414:	00000073          	ecall
 418:	8082                	ret

000000000000041a <lock_create>:
 41a:	48dd                	li	a7,23
 41c:	00000073          	ecall
 420:	8082                	ret

0000000000000422 <lock_acquire>:
 422:	48e1                	li	a7,24
 424:	00000073          	ecall
 428:	8082                	ret

000000000000042a <lock_release>:
 42a:	48e5                	li	a7,25
 42c:	00000073          	ecall
 430:	8082                	ret

0000000000000432 <lock_destroy>:
 432:	48e9                	li	a7,26
 434:	00000073          	ecall
 438:	8082                	ret

000000000000043a <clone>:
 43a:	48ed                	li	a7,27
 43c:	00000073          	ecall
 440:	8082                	ret

0000000000000442 <join>:
 442:	48f1                	li	a7,28
 444:	00000073          	ecall
 448:	8082                	ret

000000000000044a <getprocessinfo>:
 44a:	48f5                	li	a7,29
 44c:	00000073          	ecall
 450:	8082                	ret

0000000000000452 <shmget>:
 452:	48f9                	li	a7,30
 454:	00000073          	ecall
 458:	8082                	ret

000000000000045a <shmattach>:
 45a:	48fd                	li	a7,31
 45c:	00000073          	ecall
 460:	8082                	ret

0000000000000462 <shmdetach>:
 462:	02000893          	li	a7,32
 466:	00000073          	ecall
 46a:	8082                	ret

000000000000046c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 46c:	1101                	addi	sp,sp,-32
 46e:	ec06                	sd	ra,24(sp)
 470:	e822                	sd	s0,16(sp)
 472:	1000                	addi	s0,sp,32
 474:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 478:	4605                	li	a2,1
 47a:	fef40593          	addi	a1,s0,-17
 47e:	f15ff0ef          	jal	392 <write>
}
 482:	60e2                	ld	ra,24(sp)
 484:	6442                	ld	s0,16(sp)
 486:	6105                	addi	sp,sp,32
 488:	8082                	ret

000000000000048a <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 48a:	715d                	addi	sp,sp,-80
 48c:	e486                	sd	ra,72(sp)
 48e:	e0a2                	sd	s0,64(sp)
 490:	f84a                	sd	s2,48(sp)
 492:	0880                	addi	s0,sp,80
 494:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 496:	c299                	beqz	a3,49c <printint+0x12>
 498:	0805c363          	bltz	a1,51e <printint+0x94>
  neg = 0;
 49c:	4881                	li	a7,0
 49e:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 4a2:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 4a4:	00000517          	auipc	a0,0x0
 4a8:	53450513          	addi	a0,a0,1332 # 9d8 <digits>
 4ac:	883e                	mv	a6,a5
 4ae:	2785                	addiw	a5,a5,1
 4b0:	02c5f733          	remu	a4,a1,a2
 4b4:	972a                	add	a4,a4,a0
 4b6:	00074703          	lbu	a4,0(a4)
 4ba:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 4be:	872e                	mv	a4,a1
 4c0:	02c5d5b3          	divu	a1,a1,a2
 4c4:	0685                	addi	a3,a3,1
 4c6:	fec773e3          	bgeu	a4,a2,4ac <printint+0x22>
  if(neg)
 4ca:	00088b63          	beqz	a7,4e0 <printint+0x56>
    buf[i++] = '-';
 4ce:	fd078793          	addi	a5,a5,-48
 4d2:	97a2                	add	a5,a5,s0
 4d4:	02d00713          	li	a4,45
 4d8:	fee78423          	sb	a4,-24(a5)
 4dc:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 4e0:	02f05a63          	blez	a5,514 <printint+0x8a>
 4e4:	fc26                	sd	s1,56(sp)
 4e6:	f44e                	sd	s3,40(sp)
 4e8:	fb840713          	addi	a4,s0,-72
 4ec:	00f704b3          	add	s1,a4,a5
 4f0:	fff70993          	addi	s3,a4,-1
 4f4:	99be                	add	s3,s3,a5
 4f6:	37fd                	addiw	a5,a5,-1
 4f8:	1782                	slli	a5,a5,0x20
 4fa:	9381                	srli	a5,a5,0x20
 4fc:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 500:	fff4c583          	lbu	a1,-1(s1)
 504:	854a                	mv	a0,s2
 506:	f67ff0ef          	jal	46c <putc>
  while(--i >= 0)
 50a:	14fd                	addi	s1,s1,-1
 50c:	ff349ae3          	bne	s1,s3,500 <printint+0x76>
 510:	74e2                	ld	s1,56(sp)
 512:	79a2                	ld	s3,40(sp)
}
 514:	60a6                	ld	ra,72(sp)
 516:	6406                	ld	s0,64(sp)
 518:	7942                	ld	s2,48(sp)
 51a:	6161                	addi	sp,sp,80
 51c:	8082                	ret
    x = -xx;
 51e:	40b005b3          	neg	a1,a1
    neg = 1;
 522:	4885                	li	a7,1
    x = -xx;
 524:	bfad                	j	49e <printint+0x14>

0000000000000526 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 526:	711d                	addi	sp,sp,-96
 528:	ec86                	sd	ra,88(sp)
 52a:	e8a2                	sd	s0,80(sp)
 52c:	e0ca                	sd	s2,64(sp)
 52e:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 530:	0005c903          	lbu	s2,0(a1)
 534:	28090663          	beqz	s2,7c0 <vprintf+0x29a>
 538:	e4a6                	sd	s1,72(sp)
 53a:	fc4e                	sd	s3,56(sp)
 53c:	f852                	sd	s4,48(sp)
 53e:	f456                	sd	s5,40(sp)
 540:	f05a                	sd	s6,32(sp)
 542:	ec5e                	sd	s7,24(sp)
 544:	e862                	sd	s8,16(sp)
 546:	e466                	sd	s9,8(sp)
 548:	8b2a                	mv	s6,a0
 54a:	8a2e                	mv	s4,a1
 54c:	8bb2                	mv	s7,a2
  state = 0;
 54e:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 550:	4481                	li	s1,0
 552:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 554:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 558:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 55c:	06c00c93          	li	s9,108
 560:	a005                	j	580 <vprintf+0x5a>
        putc(fd, c0);
 562:	85ca                	mv	a1,s2
 564:	855a                	mv	a0,s6
 566:	f07ff0ef          	jal	46c <putc>
 56a:	a019                	j	570 <vprintf+0x4a>
    } else if(state == '%'){
 56c:	03598263          	beq	s3,s5,590 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 570:	2485                	addiw	s1,s1,1
 572:	8726                	mv	a4,s1
 574:	009a07b3          	add	a5,s4,s1
 578:	0007c903          	lbu	s2,0(a5)
 57c:	22090a63          	beqz	s2,7b0 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 580:	0009079b          	sext.w	a5,s2
    if(state == 0){
 584:	fe0994e3          	bnez	s3,56c <vprintf+0x46>
      if(c0 == '%'){
 588:	fd579de3          	bne	a5,s5,562 <vprintf+0x3c>
        state = '%';
 58c:	89be                	mv	s3,a5
 58e:	b7cd                	j	570 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 590:	00ea06b3          	add	a3,s4,a4
 594:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 598:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 59a:	c681                	beqz	a3,5a2 <vprintf+0x7c>
 59c:	9752                	add	a4,a4,s4
 59e:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 5a2:	05878363          	beq	a5,s8,5e8 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 5a6:	05978d63          	beq	a5,s9,600 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 5aa:	07500713          	li	a4,117
 5ae:	0ee78763          	beq	a5,a4,69c <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 5b2:	07800713          	li	a4,120
 5b6:	12e78963          	beq	a5,a4,6e8 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 5ba:	07000713          	li	a4,112
 5be:	14e78e63          	beq	a5,a4,71a <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 5c2:	06300713          	li	a4,99
 5c6:	18e78e63          	beq	a5,a4,762 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 5ca:	07300713          	li	a4,115
 5ce:	1ae78463          	beq	a5,a4,776 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 5d2:	02500713          	li	a4,37
 5d6:	04e79563          	bne	a5,a4,620 <vprintf+0xfa>
        putc(fd, '%');
 5da:	02500593          	li	a1,37
 5de:	855a                	mv	a0,s6
 5e0:	e8dff0ef          	jal	46c <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 5e4:	4981                	li	s3,0
 5e6:	b769                	j	570 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 5e8:	008b8913          	addi	s2,s7,8
 5ec:	4685                	li	a3,1
 5ee:	4629                	li	a2,10
 5f0:	000ba583          	lw	a1,0(s7)
 5f4:	855a                	mv	a0,s6
 5f6:	e95ff0ef          	jal	48a <printint>
 5fa:	8bca                	mv	s7,s2
      state = 0;
 5fc:	4981                	li	s3,0
 5fe:	bf8d                	j	570 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 600:	06400793          	li	a5,100
 604:	02f68963          	beq	a3,a5,636 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 608:	06c00793          	li	a5,108
 60c:	04f68263          	beq	a3,a5,650 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 610:	07500793          	li	a5,117
 614:	0af68063          	beq	a3,a5,6b4 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 618:	07800793          	li	a5,120
 61c:	0ef68263          	beq	a3,a5,700 <vprintf+0x1da>
        putc(fd, '%');
 620:	02500593          	li	a1,37
 624:	855a                	mv	a0,s6
 626:	e47ff0ef          	jal	46c <putc>
        putc(fd, c0);
 62a:	85ca                	mv	a1,s2
 62c:	855a                	mv	a0,s6
 62e:	e3fff0ef          	jal	46c <putc>
      state = 0;
 632:	4981                	li	s3,0
 634:	bf35                	j	570 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 636:	008b8913          	addi	s2,s7,8
 63a:	4685                	li	a3,1
 63c:	4629                	li	a2,10
 63e:	000bb583          	ld	a1,0(s7)
 642:	855a                	mv	a0,s6
 644:	e47ff0ef          	jal	48a <printint>
        i += 1;
 648:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 64a:	8bca                	mv	s7,s2
      state = 0;
 64c:	4981                	li	s3,0
        i += 1;
 64e:	b70d                	j	570 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 650:	06400793          	li	a5,100
 654:	02f60763          	beq	a2,a5,682 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 658:	07500793          	li	a5,117
 65c:	06f60963          	beq	a2,a5,6ce <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 660:	07800793          	li	a5,120
 664:	faf61ee3          	bne	a2,a5,620 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 668:	008b8913          	addi	s2,s7,8
 66c:	4681                	li	a3,0
 66e:	4641                	li	a2,16
 670:	000bb583          	ld	a1,0(s7)
 674:	855a                	mv	a0,s6
 676:	e15ff0ef          	jal	48a <printint>
        i += 2;
 67a:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 67c:	8bca                	mv	s7,s2
      state = 0;
 67e:	4981                	li	s3,0
        i += 2;
 680:	bdc5                	j	570 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 682:	008b8913          	addi	s2,s7,8
 686:	4685                	li	a3,1
 688:	4629                	li	a2,10
 68a:	000bb583          	ld	a1,0(s7)
 68e:	855a                	mv	a0,s6
 690:	dfbff0ef          	jal	48a <printint>
        i += 2;
 694:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 696:	8bca                	mv	s7,s2
      state = 0;
 698:	4981                	li	s3,0
        i += 2;
 69a:	bdd9                	j	570 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 69c:	008b8913          	addi	s2,s7,8
 6a0:	4681                	li	a3,0
 6a2:	4629                	li	a2,10
 6a4:	000be583          	lwu	a1,0(s7)
 6a8:	855a                	mv	a0,s6
 6aa:	de1ff0ef          	jal	48a <printint>
 6ae:	8bca                	mv	s7,s2
      state = 0;
 6b0:	4981                	li	s3,0
 6b2:	bd7d                	j	570 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6b4:	008b8913          	addi	s2,s7,8
 6b8:	4681                	li	a3,0
 6ba:	4629                	li	a2,10
 6bc:	000bb583          	ld	a1,0(s7)
 6c0:	855a                	mv	a0,s6
 6c2:	dc9ff0ef          	jal	48a <printint>
        i += 1;
 6c6:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 6c8:	8bca                	mv	s7,s2
      state = 0;
 6ca:	4981                	li	s3,0
        i += 1;
 6cc:	b555                	j	570 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6ce:	008b8913          	addi	s2,s7,8
 6d2:	4681                	li	a3,0
 6d4:	4629                	li	a2,10
 6d6:	000bb583          	ld	a1,0(s7)
 6da:	855a                	mv	a0,s6
 6dc:	dafff0ef          	jal	48a <printint>
        i += 2;
 6e0:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 6e2:	8bca                	mv	s7,s2
      state = 0;
 6e4:	4981                	li	s3,0
        i += 2;
 6e6:	b569                	j	570 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 6e8:	008b8913          	addi	s2,s7,8
 6ec:	4681                	li	a3,0
 6ee:	4641                	li	a2,16
 6f0:	000be583          	lwu	a1,0(s7)
 6f4:	855a                	mv	a0,s6
 6f6:	d95ff0ef          	jal	48a <printint>
 6fa:	8bca                	mv	s7,s2
      state = 0;
 6fc:	4981                	li	s3,0
 6fe:	bd8d                	j	570 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 700:	008b8913          	addi	s2,s7,8
 704:	4681                	li	a3,0
 706:	4641                	li	a2,16
 708:	000bb583          	ld	a1,0(s7)
 70c:	855a                	mv	a0,s6
 70e:	d7dff0ef          	jal	48a <printint>
        i += 1;
 712:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 714:	8bca                	mv	s7,s2
      state = 0;
 716:	4981                	li	s3,0
        i += 1;
 718:	bda1                	j	570 <vprintf+0x4a>
 71a:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 71c:	008b8d13          	addi	s10,s7,8
 720:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 724:	03000593          	li	a1,48
 728:	855a                	mv	a0,s6
 72a:	d43ff0ef          	jal	46c <putc>
  putc(fd, 'x');
 72e:	07800593          	li	a1,120
 732:	855a                	mv	a0,s6
 734:	d39ff0ef          	jal	46c <putc>
 738:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 73a:	00000b97          	auipc	s7,0x0
 73e:	29eb8b93          	addi	s7,s7,670 # 9d8 <digits>
 742:	03c9d793          	srli	a5,s3,0x3c
 746:	97de                	add	a5,a5,s7
 748:	0007c583          	lbu	a1,0(a5)
 74c:	855a                	mv	a0,s6
 74e:	d1fff0ef          	jal	46c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 752:	0992                	slli	s3,s3,0x4
 754:	397d                	addiw	s2,s2,-1
 756:	fe0916e3          	bnez	s2,742 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 75a:	8bea                	mv	s7,s10
      state = 0;
 75c:	4981                	li	s3,0
 75e:	6d02                	ld	s10,0(sp)
 760:	bd01                	j	570 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 762:	008b8913          	addi	s2,s7,8
 766:	000bc583          	lbu	a1,0(s7)
 76a:	855a                	mv	a0,s6
 76c:	d01ff0ef          	jal	46c <putc>
 770:	8bca                	mv	s7,s2
      state = 0;
 772:	4981                	li	s3,0
 774:	bbf5                	j	570 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 776:	008b8993          	addi	s3,s7,8
 77a:	000bb903          	ld	s2,0(s7)
 77e:	00090f63          	beqz	s2,79c <vprintf+0x276>
        for(; *s; s++)
 782:	00094583          	lbu	a1,0(s2)
 786:	c195                	beqz	a1,7aa <vprintf+0x284>
          putc(fd, *s);
 788:	855a                	mv	a0,s6
 78a:	ce3ff0ef          	jal	46c <putc>
        for(; *s; s++)
 78e:	0905                	addi	s2,s2,1
 790:	00094583          	lbu	a1,0(s2)
 794:	f9f5                	bnez	a1,788 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 796:	8bce                	mv	s7,s3
      state = 0;
 798:	4981                	li	s3,0
 79a:	bbd9                	j	570 <vprintf+0x4a>
          s = "(null)";
 79c:	00000917          	auipc	s2,0x0
 7a0:	23490913          	addi	s2,s2,564 # 9d0 <malloc+0x128>
        for(; *s; s++)
 7a4:	02800593          	li	a1,40
 7a8:	b7c5                	j	788 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 7aa:	8bce                	mv	s7,s3
      state = 0;
 7ac:	4981                	li	s3,0
 7ae:	b3c9                	j	570 <vprintf+0x4a>
 7b0:	64a6                	ld	s1,72(sp)
 7b2:	79e2                	ld	s3,56(sp)
 7b4:	7a42                	ld	s4,48(sp)
 7b6:	7aa2                	ld	s5,40(sp)
 7b8:	7b02                	ld	s6,32(sp)
 7ba:	6be2                	ld	s7,24(sp)
 7bc:	6c42                	ld	s8,16(sp)
 7be:	6ca2                	ld	s9,8(sp)
    }
  }
}
 7c0:	60e6                	ld	ra,88(sp)
 7c2:	6446                	ld	s0,80(sp)
 7c4:	6906                	ld	s2,64(sp)
 7c6:	6125                	addi	sp,sp,96
 7c8:	8082                	ret

00000000000007ca <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7ca:	715d                	addi	sp,sp,-80
 7cc:	ec06                	sd	ra,24(sp)
 7ce:	e822                	sd	s0,16(sp)
 7d0:	1000                	addi	s0,sp,32
 7d2:	e010                	sd	a2,0(s0)
 7d4:	e414                	sd	a3,8(s0)
 7d6:	e818                	sd	a4,16(s0)
 7d8:	ec1c                	sd	a5,24(s0)
 7da:	03043023          	sd	a6,32(s0)
 7de:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7e2:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7e6:	8622                	mv	a2,s0
 7e8:	d3fff0ef          	jal	526 <vprintf>
}
 7ec:	60e2                	ld	ra,24(sp)
 7ee:	6442                	ld	s0,16(sp)
 7f0:	6161                	addi	sp,sp,80
 7f2:	8082                	ret

00000000000007f4 <printf>:

void
printf(const char *fmt, ...)
{
 7f4:	711d                	addi	sp,sp,-96
 7f6:	ec06                	sd	ra,24(sp)
 7f8:	e822                	sd	s0,16(sp)
 7fa:	1000                	addi	s0,sp,32
 7fc:	e40c                	sd	a1,8(s0)
 7fe:	e810                	sd	a2,16(s0)
 800:	ec14                	sd	a3,24(s0)
 802:	f018                	sd	a4,32(s0)
 804:	f41c                	sd	a5,40(s0)
 806:	03043823          	sd	a6,48(s0)
 80a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 80e:	00840613          	addi	a2,s0,8
 812:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 816:	85aa                	mv	a1,a0
 818:	4505                	li	a0,1
 81a:	d0dff0ef          	jal	526 <vprintf>
}
 81e:	60e2                	ld	ra,24(sp)
 820:	6442                	ld	s0,16(sp)
 822:	6125                	addi	sp,sp,96
 824:	8082                	ret

0000000000000826 <free>:
 826:	1141                	addi	sp,sp,-16
 828:	e422                	sd	s0,8(sp)
 82a:	0800                	addi	s0,sp,16
 82c:	ff050693          	addi	a3,a0,-16
 830:	00000797          	auipc	a5,0x0
 834:	7d07b783          	ld	a5,2000(a5) # 1000 <freep>
 838:	a02d                	j	862 <free+0x3c>
 83a:	4618                	lw	a4,8(a2)
 83c:	9f2d                	addw	a4,a4,a1
 83e:	fee52c23          	sw	a4,-8(a0)
 842:	6398                	ld	a4,0(a5)
 844:	6310                	ld	a2,0(a4)
 846:	a83d                	j	884 <free+0x5e>
 848:	ff852703          	lw	a4,-8(a0)
 84c:	9f31                	addw	a4,a4,a2
 84e:	c798                	sw	a4,8(a5)
 850:	ff053683          	ld	a3,-16(a0)
 854:	a091                	j	898 <free+0x72>
 856:	6398                	ld	a4,0(a5)
 858:	00e7e463          	bltu	a5,a4,860 <free+0x3a>
 85c:	00e6ea63          	bltu	a3,a4,870 <free+0x4a>
 860:	87ba                	mv	a5,a4
 862:	fed7fae3          	bgeu	a5,a3,856 <free+0x30>
 866:	6398                	ld	a4,0(a5)
 868:	00e6e463          	bltu	a3,a4,870 <free+0x4a>
 86c:	fee7eae3          	bltu	a5,a4,860 <free+0x3a>
 870:	ff852583          	lw	a1,-8(a0)
 874:	6390                	ld	a2,0(a5)
 876:	02059813          	slli	a6,a1,0x20
 87a:	01c85713          	srli	a4,a6,0x1c
 87e:	9736                	add	a4,a4,a3
 880:	fae60de3          	beq	a2,a4,83a <free+0x14>
 884:	fec53823          	sd	a2,-16(a0)
 888:	4790                	lw	a2,8(a5)
 88a:	02061593          	slli	a1,a2,0x20
 88e:	01c5d713          	srli	a4,a1,0x1c
 892:	973e                	add	a4,a4,a5
 894:	fae68ae3          	beq	a3,a4,848 <free+0x22>
 898:	e394                	sd	a3,0(a5)
 89a:	00000717          	auipc	a4,0x0
 89e:	76f73323          	sd	a5,1894(a4) # 1000 <freep>
 8a2:	6422                	ld	s0,8(sp)
 8a4:	0141                	addi	sp,sp,16
 8a6:	8082                	ret

00000000000008a8 <malloc>:
 8a8:	7139                	addi	sp,sp,-64
 8aa:	fc06                	sd	ra,56(sp)
 8ac:	f822                	sd	s0,48(sp)
 8ae:	f426                	sd	s1,40(sp)
 8b0:	ec4e                	sd	s3,24(sp)
 8b2:	0080                	addi	s0,sp,64
 8b4:	02051493          	slli	s1,a0,0x20
 8b8:	9081                	srli	s1,s1,0x20
 8ba:	04bd                	addi	s1,s1,15
 8bc:	8091                	srli	s1,s1,0x4
 8be:	0014899b          	addiw	s3,s1,1
 8c2:	0485                	addi	s1,s1,1
 8c4:	00000517          	auipc	a0,0x0
 8c8:	73c53503          	ld	a0,1852(a0) # 1000 <freep>
 8cc:	c915                	beqz	a0,900 <malloc+0x58>
 8ce:	611c                	ld	a5,0(a0)
 8d0:	4798                	lw	a4,8(a5)
 8d2:	08977a63          	bgeu	a4,s1,966 <malloc+0xbe>
 8d6:	f04a                	sd	s2,32(sp)
 8d8:	e852                	sd	s4,16(sp)
 8da:	e456                	sd	s5,8(sp)
 8dc:	e05a                	sd	s6,0(sp)
 8de:	8a4e                	mv	s4,s3
 8e0:	0009871b          	sext.w	a4,s3
 8e4:	6685                	lui	a3,0x1
 8e6:	00d77363          	bgeu	a4,a3,8ec <malloc+0x44>
 8ea:	6a05                	lui	s4,0x1
 8ec:	000a0b1b          	sext.w	s6,s4
 8f0:	004a1a1b          	slliw	s4,s4,0x4
 8f4:	00000917          	auipc	s2,0x0
 8f8:	70c90913          	addi	s2,s2,1804 # 1000 <freep>
 8fc:	5afd                	li	s5,-1
 8fe:	a081                	j	93e <malloc+0x96>
 900:	f04a                	sd	s2,32(sp)
 902:	e852                	sd	s4,16(sp)
 904:	e456                	sd	s5,8(sp)
 906:	e05a                	sd	s6,0(sp)
 908:	00000797          	auipc	a5,0x0
 90c:	70878793          	addi	a5,a5,1800 # 1010 <base>
 910:	00000717          	auipc	a4,0x0
 914:	6ef73823          	sd	a5,1776(a4) # 1000 <freep>
 918:	e39c                	sd	a5,0(a5)
 91a:	0007a423          	sw	zero,8(a5)
 91e:	b7c1                	j	8de <malloc+0x36>
 920:	6398                	ld	a4,0(a5)
 922:	e118                	sd	a4,0(a0)
 924:	a8a9                	j	97e <malloc+0xd6>
 926:	01652423          	sw	s6,8(a0)
 92a:	0541                	addi	a0,a0,16
 92c:	efbff0ef          	jal	826 <free>
 930:	00093503          	ld	a0,0(s2)
 934:	c12d                	beqz	a0,996 <malloc+0xee>
 936:	611c                	ld	a5,0(a0)
 938:	4798                	lw	a4,8(a5)
 93a:	02977263          	bgeu	a4,s1,95e <malloc+0xb6>
 93e:	00093703          	ld	a4,0(s2)
 942:	853e                	mv	a0,a5
 944:	fef719e3          	bne	a4,a5,936 <malloc+0x8e>
 948:	8552                	mv	a0,s4
 94a:	965ff0ef          	jal	2ae <sbrk>
 94e:	fd551ce3          	bne	a0,s5,926 <malloc+0x7e>
 952:	4501                	li	a0,0
 954:	7902                	ld	s2,32(sp)
 956:	6a42                	ld	s4,16(sp)
 958:	6aa2                	ld	s5,8(sp)
 95a:	6b02                	ld	s6,0(sp)
 95c:	a03d                	j	98a <malloc+0xe2>
 95e:	7902                	ld	s2,32(sp)
 960:	6a42                	ld	s4,16(sp)
 962:	6aa2                	ld	s5,8(sp)
 964:	6b02                	ld	s6,0(sp)
 966:	fae48de3          	beq	s1,a4,920 <malloc+0x78>
 96a:	4137073b          	subw	a4,a4,s3
 96e:	c798                	sw	a4,8(a5)
 970:	02071693          	slli	a3,a4,0x20
 974:	01c6d713          	srli	a4,a3,0x1c
 978:	97ba                	add	a5,a5,a4
 97a:	0137a423          	sw	s3,8(a5)
 97e:	00000717          	auipc	a4,0x0
 982:	68a73123          	sd	a0,1666(a4) # 1000 <freep>
 986:	01078513          	addi	a0,a5,16
 98a:	70e2                	ld	ra,56(sp)
 98c:	7442                	ld	s0,48(sp)
 98e:	74a2                	ld	s1,40(sp)
 990:	69e2                	ld	s3,24(sp)
 992:	6121                	addi	sp,sp,64
 994:	8082                	ret
 996:	7902                	ld	s2,32(sp)
 998:	6a42                	ld	s4,16(sp)
 99a:	6aa2                	ld	s5,8(sp)
 99c:	6b02                	ld	s6,0(sp)
 99e:	b7f5                	j	98a <malloc+0xe2>
