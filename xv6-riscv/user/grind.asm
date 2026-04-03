
user/_grind:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <do_rand>:
#include "kernel/riscv.h"

// from FreeBSD.
int
do_rand(unsigned long *ctx)
{
       0:	1141                	addi	sp,sp,-16
       2:	e422                	sd	s0,8(sp)
       4:	0800                	addi	s0,sp,16
 * October 1988, p. 1195.
 */
    long hi, lo, x;

    /* Transform to [1, 0x7ffffffe] range. */
    x = (*ctx % 0x7ffffffe) + 1;
       6:	611c                	ld	a5,0(a0)
       8:	80000737          	lui	a4,0x80000
       c:	ffe74713          	xori	a4,a4,-2
      10:	02e7f7b3          	remu	a5,a5,a4
      14:	0785                	addi	a5,a5,1
    hi = x / 127773;
    lo = x % 127773;
      16:	66fd                	lui	a3,0x1f
      18:	31d68693          	addi	a3,a3,797 # 1f31d <base+0x1cf15>
      1c:	02d7e733          	rem	a4,a5,a3
    x = 16807 * lo - 2836 * hi;
      20:	6611                	lui	a2,0x4
      22:	1a760613          	addi	a2,a2,423 # 41a7 <base+0x1d9f>
      26:	02c70733          	mul	a4,a4,a2
    hi = x / 127773;
      2a:	02d7c7b3          	div	a5,a5,a3
    x = 16807 * lo - 2836 * hi;
      2e:	76fd                	lui	a3,0xfffff
      30:	4ec68693          	addi	a3,a3,1260 # fffffffffffff4ec <base+0xffffffffffffd0e4>
      34:	02d787b3          	mul	a5,a5,a3
      38:	97ba                	add	a5,a5,a4
    if (x < 0)
      3a:	0007c963          	bltz	a5,4c <do_rand+0x4c>
        x += 0x7fffffff;
    /* Transform to [0, 0x7ffffffd] range. */
    x--;
      3e:	17fd                	addi	a5,a5,-1
    *ctx = x;
      40:	e11c                	sd	a5,0(a0)
    return (x);
}
      42:	0007851b          	sext.w	a0,a5
      46:	6422                	ld	s0,8(sp)
      48:	0141                	addi	sp,sp,16
      4a:	8082                	ret
        x += 0x7fffffff;
      4c:	80000737          	lui	a4,0x80000
      50:	fff74713          	not	a4,a4
      54:	97ba                	add	a5,a5,a4
      56:	b7e5                	j	3e <do_rand+0x3e>

0000000000000058 <rand>:

unsigned long rand_next = 1;

int
rand(void)
{
      58:	1141                	addi	sp,sp,-16
      5a:	e406                	sd	ra,8(sp)
      5c:	e022                	sd	s0,0(sp)
      5e:	0800                	addi	s0,sp,16
    return (do_rand(&rand_next));
      60:	00002517          	auipc	a0,0x2
      64:	fa050513          	addi	a0,a0,-96 # 2000 <rand_next>
      68:	f99ff0ef          	jal	0 <do_rand>
}
      6c:	60a2                	ld	ra,8(sp)
      6e:	6402                	ld	s0,0(sp)
      70:	0141                	addi	sp,sp,16
      72:	8082                	ret

0000000000000074 <go>:

void
go(int which_child)
{
      74:	7159                	addi	sp,sp,-112
      76:	f486                	sd	ra,104(sp)
      78:	f0a2                	sd	s0,96(sp)
      7a:	eca6                	sd	s1,88(sp)
      7c:	fc56                	sd	s5,56(sp)
      7e:	1880                	addi	s0,sp,112
      80:	84aa                	mv	s1,a0
  int fd = -1;
  static char buf[999];
  char *break0 = sbrk(0);
      82:	4501                	li	a0,0
      84:	2bb000ef          	jal	b3e <sbrk>
      88:	8aaa                	mv	s5,a0
  uint64 iters = 0;

  mkdir("grindir");
      8a:	00001517          	auipc	a0,0x1
      8e:	18650513          	addi	a0,a0,390 # 1210 <malloc+0xfa>
      92:	3d9000ef          	jal	c6a <mkdir>
  if(chdir("grindir") != 0){
      96:	00001517          	auipc	a0,0x1
      9a:	17a50513          	addi	a0,a0,378 # 1210 <malloc+0xfa>
      9e:	3d5000ef          	jal	c72 <chdir>
      a2:	cd11                	beqz	a0,be <go+0x4a>
      a4:	e8ca                	sd	s2,80(sp)
      a6:	e4ce                	sd	s3,72(sp)
      a8:	e0d2                	sd	s4,64(sp)
      aa:	f85a                	sd	s6,48(sp)
    printf("grind: chdir grindir failed\n");
      ac:	00001517          	auipc	a0,0x1
      b0:	16c50513          	addi	a0,a0,364 # 1218 <malloc+0x102>
      b4:	7af000ef          	jal	1062 <printf>
    exit(1);
      b8:	4505                	li	a0,1
      ba:	349000ef          	jal	c02 <exit>
      be:	e8ca                	sd	s2,80(sp)
      c0:	e4ce                	sd	s3,72(sp)
      c2:	e0d2                	sd	s4,64(sp)
      c4:	f85a                	sd	s6,48(sp)
  }
  chdir("/");
      c6:	00001517          	auipc	a0,0x1
      ca:	17a50513          	addi	a0,a0,378 # 1240 <malloc+0x12a>
      ce:	3a5000ef          	jal	c72 <chdir>
      d2:	00001997          	auipc	s3,0x1
      d6:	17e98993          	addi	s3,s3,382 # 1250 <malloc+0x13a>
      da:	c489                	beqz	s1,e4 <go+0x70>
      dc:	00001997          	auipc	s3,0x1
      e0:	16c98993          	addi	s3,s3,364 # 1248 <malloc+0x132>
  uint64 iters = 0;
      e4:	4481                	li	s1,0
  int fd = -1;
      e6:	5a7d                	li	s4,-1
      e8:	00001917          	auipc	s2,0x1
      ec:	43890913          	addi	s2,s2,1080 # 1520 <malloc+0x40a>
      f0:	a819                	j	106 <go+0x92>
    iters++;
    if((iters % 500) == 0)
      write(1, which_child?"B":"A", 1);
    int what = rand() % 23;
    if(what == 1){
      close(open("grindir/../a", O_CREATE|O_RDWR));
      f2:	20200593          	li	a1,514
      f6:	00001517          	auipc	a0,0x1
      fa:	16250513          	addi	a0,a0,354 # 1258 <malloc+0x142>
      fe:	345000ef          	jal	c42 <open>
     102:	329000ef          	jal	c2a <close>
    iters++;
     106:	0485                	addi	s1,s1,1
    if((iters % 500) == 0)
     108:	1f400793          	li	a5,500
     10c:	02f4f7b3          	remu	a5,s1,a5
     110:	e791                	bnez	a5,11c <go+0xa8>
      write(1, which_child?"B":"A", 1);
     112:	4605                	li	a2,1
     114:	85ce                	mv	a1,s3
     116:	4505                	li	a0,1
     118:	30b000ef          	jal	c22 <write>
    int what = rand() % 23;
     11c:	f3dff0ef          	jal	58 <rand>
     120:	47dd                	li	a5,23
     122:	02f5653b          	remw	a0,a0,a5
     126:	0005071b          	sext.w	a4,a0
     12a:	47d9                	li	a5,22
     12c:	fce7ede3          	bltu	a5,a4,106 <go+0x92>
     130:	02051793          	slli	a5,a0,0x20
     134:	01e7d513          	srli	a0,a5,0x1e
     138:	954a                	add	a0,a0,s2
     13a:	411c                	lw	a5,0(a0)
     13c:	97ca                	add	a5,a5,s2
     13e:	8782                	jr	a5
    } else if(what == 2){
      close(open("grindir/../grindir/../b", O_CREATE|O_RDWR));
     140:	20200593          	li	a1,514
     144:	00001517          	auipc	a0,0x1
     148:	12450513          	addi	a0,a0,292 # 1268 <malloc+0x152>
     14c:	2f7000ef          	jal	c42 <open>
     150:	2db000ef          	jal	c2a <close>
     154:	bf4d                	j	106 <go+0x92>
    } else if(what == 3){
      unlink("grindir/../a");
     156:	00001517          	auipc	a0,0x1
     15a:	10250513          	addi	a0,a0,258 # 1258 <malloc+0x142>
     15e:	2f5000ef          	jal	c52 <unlink>
     162:	b755                	j	106 <go+0x92>
    } else if(what == 4){
      if(chdir("grindir") != 0){
     164:	00001517          	auipc	a0,0x1
     168:	0ac50513          	addi	a0,a0,172 # 1210 <malloc+0xfa>
     16c:	307000ef          	jal	c72 <chdir>
     170:	ed11                	bnez	a0,18c <go+0x118>
        printf("grind: chdir grindir failed\n");
        exit(1);
      }
      unlink("../b");
     172:	00001517          	auipc	a0,0x1
     176:	10e50513          	addi	a0,a0,270 # 1280 <malloc+0x16a>
     17a:	2d9000ef          	jal	c52 <unlink>
      chdir("/");
     17e:	00001517          	auipc	a0,0x1
     182:	0c250513          	addi	a0,a0,194 # 1240 <malloc+0x12a>
     186:	2ed000ef          	jal	c72 <chdir>
     18a:	bfb5                	j	106 <go+0x92>
        printf("grind: chdir grindir failed\n");
     18c:	00001517          	auipc	a0,0x1
     190:	08c50513          	addi	a0,a0,140 # 1218 <malloc+0x102>
     194:	6cf000ef          	jal	1062 <printf>
        exit(1);
     198:	4505                	li	a0,1
     19a:	269000ef          	jal	c02 <exit>
    } else if(what == 5){
      close(fd);
     19e:	8552                	mv	a0,s4
     1a0:	28b000ef          	jal	c2a <close>
      fd = open("/grindir/../a", O_CREATE|O_RDWR);
     1a4:	20200593          	li	a1,514
     1a8:	00001517          	auipc	a0,0x1
     1ac:	0e050513          	addi	a0,a0,224 # 1288 <malloc+0x172>
     1b0:	293000ef          	jal	c42 <open>
     1b4:	8a2a                	mv	s4,a0
     1b6:	bf81                	j	106 <go+0x92>
    } else if(what == 6){
      close(fd);
     1b8:	8552                	mv	a0,s4
     1ba:	271000ef          	jal	c2a <close>
      fd = open("/./grindir/./../b", O_CREATE|O_RDWR);
     1be:	20200593          	li	a1,514
     1c2:	00001517          	auipc	a0,0x1
     1c6:	0d650513          	addi	a0,a0,214 # 1298 <malloc+0x182>
     1ca:	279000ef          	jal	c42 <open>
     1ce:	8a2a                	mv	s4,a0
     1d0:	bf1d                	j	106 <go+0x92>
    } else if(what == 7){
      write(fd, buf, sizeof(buf));
     1d2:	3e700613          	li	a2,999
     1d6:	00002597          	auipc	a1,0x2
     1da:	e4a58593          	addi	a1,a1,-438 # 2020 <buf.0>
     1de:	8552                	mv	a0,s4
     1e0:	243000ef          	jal	c22 <write>
     1e4:	b70d                	j	106 <go+0x92>
    } else if(what == 8){
      read(fd, buf, sizeof(buf));
     1e6:	3e700613          	li	a2,999
     1ea:	00002597          	auipc	a1,0x2
     1ee:	e3658593          	addi	a1,a1,-458 # 2020 <buf.0>
     1f2:	8552                	mv	a0,s4
     1f4:	227000ef          	jal	c1a <read>
     1f8:	b739                	j	106 <go+0x92>
    } else if(what == 9){
      mkdir("grindir/../a");
     1fa:	00001517          	auipc	a0,0x1
     1fe:	05e50513          	addi	a0,a0,94 # 1258 <malloc+0x142>
     202:	269000ef          	jal	c6a <mkdir>
      close(open("a/../a/./a", O_CREATE|O_RDWR));
     206:	20200593          	li	a1,514
     20a:	00001517          	auipc	a0,0x1
     20e:	0a650513          	addi	a0,a0,166 # 12b0 <malloc+0x19a>
     212:	231000ef          	jal	c42 <open>
     216:	215000ef          	jal	c2a <close>
      unlink("a/a");
     21a:	00001517          	auipc	a0,0x1
     21e:	0a650513          	addi	a0,a0,166 # 12c0 <malloc+0x1aa>
     222:	231000ef          	jal	c52 <unlink>
     226:	b5c5                	j	106 <go+0x92>
    } else if(what == 10){
      mkdir("/../b");
     228:	00001517          	auipc	a0,0x1
     22c:	0a050513          	addi	a0,a0,160 # 12c8 <malloc+0x1b2>
     230:	23b000ef          	jal	c6a <mkdir>
      close(open("grindir/../b/b", O_CREATE|O_RDWR));
     234:	20200593          	li	a1,514
     238:	00001517          	auipc	a0,0x1
     23c:	09850513          	addi	a0,a0,152 # 12d0 <malloc+0x1ba>
     240:	203000ef          	jal	c42 <open>
     244:	1e7000ef          	jal	c2a <close>
      unlink("b/b");
     248:	00001517          	auipc	a0,0x1
     24c:	09850513          	addi	a0,a0,152 # 12e0 <malloc+0x1ca>
     250:	203000ef          	jal	c52 <unlink>
     254:	bd4d                	j	106 <go+0x92>
    } else if(what == 11){
      unlink("b");
     256:	00001517          	auipc	a0,0x1
     25a:	09250513          	addi	a0,a0,146 # 12e8 <malloc+0x1d2>
     25e:	1f5000ef          	jal	c52 <unlink>
      link("../grindir/./../a", "../b");
     262:	00001597          	auipc	a1,0x1
     266:	01e58593          	addi	a1,a1,30 # 1280 <malloc+0x16a>
     26a:	00001517          	auipc	a0,0x1
     26e:	08650513          	addi	a0,a0,134 # 12f0 <malloc+0x1da>
     272:	1f1000ef          	jal	c62 <link>
     276:	bd41                	j	106 <go+0x92>
    } else if(what == 12){
      unlink("../grindir/../a");
     278:	00001517          	auipc	a0,0x1
     27c:	09050513          	addi	a0,a0,144 # 1308 <malloc+0x1f2>
     280:	1d3000ef          	jal	c52 <unlink>
      link(".././b", "/grindir/../a");
     284:	00001597          	auipc	a1,0x1
     288:	00458593          	addi	a1,a1,4 # 1288 <malloc+0x172>
     28c:	00001517          	auipc	a0,0x1
     290:	08c50513          	addi	a0,a0,140 # 1318 <malloc+0x202>
     294:	1cf000ef          	jal	c62 <link>
     298:	b5bd                	j	106 <go+0x92>
    } else if(what == 13){
      int pid = fork();
     29a:	161000ef          	jal	bfa <fork>
      if(pid == 0){
     29e:	c519                	beqz	a0,2ac <go+0x238>
        exit(0);
      } else if(pid < 0){
     2a0:	00054863          	bltz	a0,2b0 <go+0x23c>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     2a4:	4501                	li	a0,0
     2a6:	165000ef          	jal	c0a <wait>
     2aa:	bdb1                	j	106 <go+0x92>
        exit(0);
     2ac:	157000ef          	jal	c02 <exit>
        printf("grind: fork failed\n");
     2b0:	00001517          	auipc	a0,0x1
     2b4:	07050513          	addi	a0,a0,112 # 1320 <malloc+0x20a>
     2b8:	5ab000ef          	jal	1062 <printf>
        exit(1);
     2bc:	4505                	li	a0,1
     2be:	145000ef          	jal	c02 <exit>
    } else if(what == 14){
      int pid = fork();
     2c2:	139000ef          	jal	bfa <fork>
      if(pid == 0){
     2c6:	c519                	beqz	a0,2d4 <go+0x260>
        fork();
        fork();
        exit(0);
      } else if(pid < 0){
     2c8:	00054d63          	bltz	a0,2e2 <go+0x26e>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     2cc:	4501                	li	a0,0
     2ce:	13d000ef          	jal	c0a <wait>
     2d2:	bd15                	j	106 <go+0x92>
        fork();
     2d4:	127000ef          	jal	bfa <fork>
        fork();
     2d8:	123000ef          	jal	bfa <fork>
        exit(0);
     2dc:	4501                	li	a0,0
     2de:	125000ef          	jal	c02 <exit>
        printf("grind: fork failed\n");
     2e2:	00001517          	auipc	a0,0x1
     2e6:	03e50513          	addi	a0,a0,62 # 1320 <malloc+0x20a>
     2ea:	579000ef          	jal	1062 <printf>
        exit(1);
     2ee:	4505                	li	a0,1
     2f0:	113000ef          	jal	c02 <exit>
    } else if(what == 15){
      sbrk(6011);
     2f4:	6505                	lui	a0,0x1
     2f6:	77b50513          	addi	a0,a0,1915 # 177b <digits+0x1fb>
     2fa:	045000ef          	jal	b3e <sbrk>
     2fe:	b521                	j	106 <go+0x92>
    } else if(what == 16){
      if(sbrk(0) > break0)
     300:	4501                	li	a0,0
     302:	03d000ef          	jal	b3e <sbrk>
     306:	e0aaf0e3          	bgeu	s5,a0,106 <go+0x92>
        sbrk(-(sbrk(0) - break0));
     30a:	4501                	li	a0,0
     30c:	033000ef          	jal	b3e <sbrk>
     310:	40aa853b          	subw	a0,s5,a0
     314:	02b000ef          	jal	b3e <sbrk>
     318:	b3fd                	j	106 <go+0x92>
    } else if(what == 17){
      int pid = fork();
     31a:	0e1000ef          	jal	bfa <fork>
     31e:	8b2a                	mv	s6,a0
      if(pid == 0){
     320:	c10d                	beqz	a0,342 <go+0x2ce>
        close(open("a", O_CREATE|O_RDWR));
        exit(0);
      } else if(pid < 0){
     322:	02054d63          	bltz	a0,35c <go+0x2e8>
        printf("grind: fork failed\n");
        exit(1);
      }
      if(chdir("../grindir/..") != 0){
     326:	00001517          	auipc	a0,0x1
     32a:	01a50513          	addi	a0,a0,26 # 1340 <malloc+0x22a>
     32e:	145000ef          	jal	c72 <chdir>
     332:	ed15                	bnez	a0,36e <go+0x2fa>
        printf("grind: chdir failed\n");
        exit(1);
      }
      kill(pid);
     334:	855a                	mv	a0,s6
     336:	0fd000ef          	jal	c32 <kill>
      wait(0);
     33a:	4501                	li	a0,0
     33c:	0cf000ef          	jal	c0a <wait>
     340:	b3d9                	j	106 <go+0x92>
        close(open("a", O_CREATE|O_RDWR));
     342:	20200593          	li	a1,514
     346:	00001517          	auipc	a0,0x1
     34a:	ff250513          	addi	a0,a0,-14 # 1338 <malloc+0x222>
     34e:	0f5000ef          	jal	c42 <open>
     352:	0d9000ef          	jal	c2a <close>
        exit(0);
     356:	4501                	li	a0,0
     358:	0ab000ef          	jal	c02 <exit>
        printf("grind: fork failed\n");
     35c:	00001517          	auipc	a0,0x1
     360:	fc450513          	addi	a0,a0,-60 # 1320 <malloc+0x20a>
     364:	4ff000ef          	jal	1062 <printf>
        exit(1);
     368:	4505                	li	a0,1
     36a:	099000ef          	jal	c02 <exit>
        printf("grind: chdir failed\n");
     36e:	00001517          	auipc	a0,0x1
     372:	fe250513          	addi	a0,a0,-30 # 1350 <malloc+0x23a>
     376:	4ed000ef          	jal	1062 <printf>
        exit(1);
     37a:	4505                	li	a0,1
     37c:	087000ef          	jal	c02 <exit>
    } else if(what == 18){
      int pid = fork();
     380:	07b000ef          	jal	bfa <fork>
      if(pid == 0){
     384:	c519                	beqz	a0,392 <go+0x31e>
        kill(getpid());
        exit(0);
      } else if(pid < 0){
     386:	00054d63          	bltz	a0,3a0 <go+0x32c>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     38a:	4501                	li	a0,0
     38c:	07f000ef          	jal	c0a <wait>
     390:	bb9d                	j	106 <go+0x92>
        kill(getpid());
     392:	0f1000ef          	jal	c82 <getpid>
     396:	09d000ef          	jal	c32 <kill>
        exit(0);
     39a:	4501                	li	a0,0
     39c:	067000ef          	jal	c02 <exit>
        printf("grind: fork failed\n");
     3a0:	00001517          	auipc	a0,0x1
     3a4:	f8050513          	addi	a0,a0,-128 # 1320 <malloc+0x20a>
     3a8:	4bb000ef          	jal	1062 <printf>
        exit(1);
     3ac:	4505                	li	a0,1
     3ae:	055000ef          	jal	c02 <exit>
    } else if(what == 19){
      int fds[2];
      if(pipe(fds) < 0){
     3b2:	fa840513          	addi	a0,s0,-88
     3b6:	05d000ef          	jal	c12 <pipe>
     3ba:	02054363          	bltz	a0,3e0 <go+0x36c>
        printf("grind: pipe failed\n");
        exit(1);
      }
      int pid = fork();
     3be:	03d000ef          	jal	bfa <fork>
      if(pid == 0){
     3c2:	c905                	beqz	a0,3f2 <go+0x37e>
          printf("grind: pipe write failed\n");
        char c;
        if(read(fds[0], &c, 1) != 1)
          printf("grind: pipe read failed\n");
        exit(0);
      } else if(pid < 0){
     3c4:	08054263          	bltz	a0,448 <go+0x3d4>
        printf("grind: fork failed\n");
        exit(1);
      }
      close(fds[0]);
     3c8:	fa842503          	lw	a0,-88(s0)
     3cc:	05f000ef          	jal	c2a <close>
      close(fds[1]);
     3d0:	fac42503          	lw	a0,-84(s0)
     3d4:	057000ef          	jal	c2a <close>
      wait(0);
     3d8:	4501                	li	a0,0
     3da:	031000ef          	jal	c0a <wait>
     3de:	b325                	j	106 <go+0x92>
        printf("grind: pipe failed\n");
     3e0:	00001517          	auipc	a0,0x1
     3e4:	f8850513          	addi	a0,a0,-120 # 1368 <malloc+0x252>
     3e8:	47b000ef          	jal	1062 <printf>
        exit(1);
     3ec:	4505                	li	a0,1
     3ee:	015000ef          	jal	c02 <exit>
        fork();
     3f2:	009000ef          	jal	bfa <fork>
        fork();
     3f6:	005000ef          	jal	bfa <fork>
        if(write(fds[1], "x", 1) != 1)
     3fa:	4605                	li	a2,1
     3fc:	00001597          	auipc	a1,0x1
     400:	f8458593          	addi	a1,a1,-124 # 1380 <malloc+0x26a>
     404:	fac42503          	lw	a0,-84(s0)
     408:	01b000ef          	jal	c22 <write>
     40c:	4785                	li	a5,1
     40e:	00f51f63          	bne	a0,a5,42c <go+0x3b8>
        if(read(fds[0], &c, 1) != 1)
     412:	4605                	li	a2,1
     414:	fa040593          	addi	a1,s0,-96
     418:	fa842503          	lw	a0,-88(s0)
     41c:	7fe000ef          	jal	c1a <read>
     420:	4785                	li	a5,1
     422:	00f51c63          	bne	a0,a5,43a <go+0x3c6>
        exit(0);
     426:	4501                	li	a0,0
     428:	7da000ef          	jal	c02 <exit>
          printf("grind: pipe write failed\n");
     42c:	00001517          	auipc	a0,0x1
     430:	f5c50513          	addi	a0,a0,-164 # 1388 <malloc+0x272>
     434:	42f000ef          	jal	1062 <printf>
     438:	bfe9                	j	412 <go+0x39e>
          printf("grind: pipe read failed\n");
     43a:	00001517          	auipc	a0,0x1
     43e:	f6e50513          	addi	a0,a0,-146 # 13a8 <malloc+0x292>
     442:	421000ef          	jal	1062 <printf>
     446:	b7c5                	j	426 <go+0x3b2>
        printf("grind: fork failed\n");
     448:	00001517          	auipc	a0,0x1
     44c:	ed850513          	addi	a0,a0,-296 # 1320 <malloc+0x20a>
     450:	413000ef          	jal	1062 <printf>
        exit(1);
     454:	4505                	li	a0,1
     456:	7ac000ef          	jal	c02 <exit>
    } else if(what == 20){
      int pid = fork();
     45a:	7a0000ef          	jal	bfa <fork>
      if(pid == 0){
     45e:	c519                	beqz	a0,46c <go+0x3f8>
        chdir("a");
        unlink("../a");
        fd = open("x", O_CREATE|O_RDWR);
        unlink("x");
        exit(0);
      } else if(pid < 0){
     460:	04054f63          	bltz	a0,4be <go+0x44a>
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
     464:	4501                	li	a0,0
     466:	7a4000ef          	jal	c0a <wait>
     46a:	b971                	j	106 <go+0x92>
        unlink("a");
     46c:	00001517          	auipc	a0,0x1
     470:	ecc50513          	addi	a0,a0,-308 # 1338 <malloc+0x222>
     474:	7de000ef          	jal	c52 <unlink>
        mkdir("a");
     478:	00001517          	auipc	a0,0x1
     47c:	ec050513          	addi	a0,a0,-320 # 1338 <malloc+0x222>
     480:	7ea000ef          	jal	c6a <mkdir>
        chdir("a");
     484:	00001517          	auipc	a0,0x1
     488:	eb450513          	addi	a0,a0,-332 # 1338 <malloc+0x222>
     48c:	7e6000ef          	jal	c72 <chdir>
        unlink("../a");
     490:	00001517          	auipc	a0,0x1
     494:	f3850513          	addi	a0,a0,-200 # 13c8 <malloc+0x2b2>
     498:	7ba000ef          	jal	c52 <unlink>
        fd = open("x", O_CREATE|O_RDWR);
     49c:	20200593          	li	a1,514
     4a0:	00001517          	auipc	a0,0x1
     4a4:	ee050513          	addi	a0,a0,-288 # 1380 <malloc+0x26a>
     4a8:	79a000ef          	jal	c42 <open>
        unlink("x");
     4ac:	00001517          	auipc	a0,0x1
     4b0:	ed450513          	addi	a0,a0,-300 # 1380 <malloc+0x26a>
     4b4:	79e000ef          	jal	c52 <unlink>
        exit(0);
     4b8:	4501                	li	a0,0
     4ba:	748000ef          	jal	c02 <exit>
        printf("grind: fork failed\n");
     4be:	00001517          	auipc	a0,0x1
     4c2:	e6250513          	addi	a0,a0,-414 # 1320 <malloc+0x20a>
     4c6:	39d000ef          	jal	1062 <printf>
        exit(1);
     4ca:	4505                	li	a0,1
     4cc:	736000ef          	jal	c02 <exit>
    } else if(what == 21){
      unlink("c");
     4d0:	00001517          	auipc	a0,0x1
     4d4:	f0050513          	addi	a0,a0,-256 # 13d0 <malloc+0x2ba>
     4d8:	77a000ef          	jal	c52 <unlink>
      // should always succeed. check that there are free i-nodes,
      // file descriptors, blocks.
      int fd1 = open("c", O_CREATE|O_RDWR);
     4dc:	20200593          	li	a1,514
     4e0:	00001517          	auipc	a0,0x1
     4e4:	ef050513          	addi	a0,a0,-272 # 13d0 <malloc+0x2ba>
     4e8:	75a000ef          	jal	c42 <open>
     4ec:	8b2a                	mv	s6,a0
      if(fd1 < 0){
     4ee:	04054763          	bltz	a0,53c <go+0x4c8>
        printf("grind: create c failed\n");
        exit(1);
      }
      if(write(fd1, "x", 1) != 1){
     4f2:	4605                	li	a2,1
     4f4:	00001597          	auipc	a1,0x1
     4f8:	e8c58593          	addi	a1,a1,-372 # 1380 <malloc+0x26a>
     4fc:	726000ef          	jal	c22 <write>
     500:	4785                	li	a5,1
     502:	04f51663          	bne	a0,a5,54e <go+0x4da>
        printf("grind: write c failed\n");
        exit(1);
      }
      struct stat st;
      if(fstat(fd1, &st) != 0){
     506:	fa840593          	addi	a1,s0,-88
     50a:	855a                	mv	a0,s6
     50c:	74e000ef          	jal	c5a <fstat>
     510:	e921                	bnez	a0,560 <go+0x4ec>
        printf("grind: fstat failed\n");
        exit(1);
      }
      if(st.size != 1){
     512:	fb843583          	ld	a1,-72(s0)
     516:	4785                	li	a5,1
     518:	04f59d63          	bne	a1,a5,572 <go+0x4fe>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
        exit(1);
      }
      if(st.ino > 200){
     51c:	fac42583          	lw	a1,-84(s0)
     520:	0c800793          	li	a5,200
     524:	06b7e163          	bltu	a5,a1,586 <go+0x512>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
        exit(1);
      }
      close(fd1);
     528:	855a                	mv	a0,s6
     52a:	700000ef          	jal	c2a <close>
      unlink("c");
     52e:	00001517          	auipc	a0,0x1
     532:	ea250513          	addi	a0,a0,-350 # 13d0 <malloc+0x2ba>
     536:	71c000ef          	jal	c52 <unlink>
     53a:	b6f1                	j	106 <go+0x92>
        printf("grind: create c failed\n");
     53c:	00001517          	auipc	a0,0x1
     540:	e9c50513          	addi	a0,a0,-356 # 13d8 <malloc+0x2c2>
     544:	31f000ef          	jal	1062 <printf>
        exit(1);
     548:	4505                	li	a0,1
     54a:	6b8000ef          	jal	c02 <exit>
        printf("grind: write c failed\n");
     54e:	00001517          	auipc	a0,0x1
     552:	ea250513          	addi	a0,a0,-350 # 13f0 <malloc+0x2da>
     556:	30d000ef          	jal	1062 <printf>
        exit(1);
     55a:	4505                	li	a0,1
     55c:	6a6000ef          	jal	c02 <exit>
        printf("grind: fstat failed\n");
     560:	00001517          	auipc	a0,0x1
     564:	ea850513          	addi	a0,a0,-344 # 1408 <malloc+0x2f2>
     568:	2fb000ef          	jal	1062 <printf>
        exit(1);
     56c:	4505                	li	a0,1
     56e:	694000ef          	jal	c02 <exit>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
     572:	2581                	sext.w	a1,a1
     574:	00001517          	auipc	a0,0x1
     578:	eac50513          	addi	a0,a0,-340 # 1420 <malloc+0x30a>
     57c:	2e7000ef          	jal	1062 <printf>
        exit(1);
     580:	4505                	li	a0,1
     582:	680000ef          	jal	c02 <exit>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
     586:	00001517          	auipc	a0,0x1
     58a:	ec250513          	addi	a0,a0,-318 # 1448 <malloc+0x332>
     58e:	2d5000ef          	jal	1062 <printf>
        exit(1);
     592:	4505                	li	a0,1
     594:	66e000ef          	jal	c02 <exit>
    } else if(what == 22){
      // echo hi | cat
      int aa[2], bb[2];
      if(pipe(aa) < 0){
     598:	f9840513          	addi	a0,s0,-104
     59c:	676000ef          	jal	c12 <pipe>
     5a0:	0c054263          	bltz	a0,664 <go+0x5f0>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      if(pipe(bb) < 0){
     5a4:	fa040513          	addi	a0,s0,-96
     5a8:	66a000ef          	jal	c12 <pipe>
     5ac:	0c054663          	bltz	a0,678 <go+0x604>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      int pid1 = fork();
     5b0:	64a000ef          	jal	bfa <fork>
      if(pid1 == 0){
     5b4:	0c050c63          	beqz	a0,68c <go+0x618>
        close(aa[1]);
        char *args[3] = { "echo", "hi", 0 };
        exec("grindir/../echo", args);
        fprintf(2, "grind: echo: not found\n");
        exit(2);
      } else if(pid1 < 0){
     5b8:	14054e63          	bltz	a0,714 <go+0x6a0>
        fprintf(2, "grind: fork failed\n");
        exit(3);
      }
      int pid2 = fork();
     5bc:	63e000ef          	jal	bfa <fork>
      if(pid2 == 0){
     5c0:	16050463          	beqz	a0,728 <go+0x6b4>
        close(bb[1]);
        char *args[2] = { "cat", 0 };
        exec("/cat", args);
        fprintf(2, "grind: cat: not found\n");
        exit(6);
      } else if(pid2 < 0){
     5c4:	20054263          	bltz	a0,7c8 <go+0x754>
        fprintf(2, "grind: fork failed\n");
        exit(7);
      }
      close(aa[0]);
     5c8:	f9842503          	lw	a0,-104(s0)
     5cc:	65e000ef          	jal	c2a <close>
      close(aa[1]);
     5d0:	f9c42503          	lw	a0,-100(s0)
     5d4:	656000ef          	jal	c2a <close>
      close(bb[1]);
     5d8:	fa442503          	lw	a0,-92(s0)
     5dc:	64e000ef          	jal	c2a <close>
      char buf[4] = { 0, 0, 0, 0 };
     5e0:	f8042823          	sw	zero,-112(s0)
      read(bb[0], buf+0, 1);
     5e4:	4605                	li	a2,1
     5e6:	f9040593          	addi	a1,s0,-112
     5ea:	fa042503          	lw	a0,-96(s0)
     5ee:	62c000ef          	jal	c1a <read>
      read(bb[0], buf+1, 1);
     5f2:	4605                	li	a2,1
     5f4:	f9140593          	addi	a1,s0,-111
     5f8:	fa042503          	lw	a0,-96(s0)
     5fc:	61e000ef          	jal	c1a <read>
      read(bb[0], buf+2, 1);
     600:	4605                	li	a2,1
     602:	f9240593          	addi	a1,s0,-110
     606:	fa042503          	lw	a0,-96(s0)
     60a:	610000ef          	jal	c1a <read>
      close(bb[0]);
     60e:	fa042503          	lw	a0,-96(s0)
     612:	618000ef          	jal	c2a <close>
      int st1, st2;
      wait(&st1);
     616:	f9440513          	addi	a0,s0,-108
     61a:	5f0000ef          	jal	c0a <wait>
      wait(&st2);
     61e:	fa840513          	addi	a0,s0,-88
     622:	5e8000ef          	jal	c0a <wait>
      if(st1 != 0 || st2 != 0 || strcmp(buf, "hi\n") != 0){
     626:	f9442783          	lw	a5,-108(s0)
     62a:	fa842703          	lw	a4,-88(s0)
     62e:	8fd9                	or	a5,a5,a4
     630:	eb99                	bnez	a5,646 <go+0x5d2>
     632:	00001597          	auipc	a1,0x1
     636:	eb658593          	addi	a1,a1,-330 # 14e8 <malloc+0x3d2>
     63a:	f9040513          	addi	a0,s0,-112
     63e:	2cc000ef          	jal	90a <strcmp>
     642:	ac0502e3          	beqz	a0,106 <go+0x92>
        printf("grind: exec pipeline failed %d %d \"%s\"\n", st1, st2, buf);
     646:	f9040693          	addi	a3,s0,-112
     64a:	fa842603          	lw	a2,-88(s0)
     64e:	f9442583          	lw	a1,-108(s0)
     652:	00001517          	auipc	a0,0x1
     656:	e9e50513          	addi	a0,a0,-354 # 14f0 <malloc+0x3da>
     65a:	209000ef          	jal	1062 <printf>
        exit(1);
     65e:	4505                	li	a0,1
     660:	5a2000ef          	jal	c02 <exit>
        fprintf(2, "grind: pipe failed\n");
     664:	00001597          	auipc	a1,0x1
     668:	d0458593          	addi	a1,a1,-764 # 1368 <malloc+0x252>
     66c:	4509                	li	a0,2
     66e:	1cb000ef          	jal	1038 <fprintf>
        exit(1);
     672:	4505                	li	a0,1
     674:	58e000ef          	jal	c02 <exit>
        fprintf(2, "grind: pipe failed\n");
     678:	00001597          	auipc	a1,0x1
     67c:	cf058593          	addi	a1,a1,-784 # 1368 <malloc+0x252>
     680:	4509                	li	a0,2
     682:	1b7000ef          	jal	1038 <fprintf>
        exit(1);
     686:	4505                	li	a0,1
     688:	57a000ef          	jal	c02 <exit>
        close(bb[0]);
     68c:	fa042503          	lw	a0,-96(s0)
     690:	59a000ef          	jal	c2a <close>
        close(bb[1]);
     694:	fa442503          	lw	a0,-92(s0)
     698:	592000ef          	jal	c2a <close>
        close(aa[0]);
     69c:	f9842503          	lw	a0,-104(s0)
     6a0:	58a000ef          	jal	c2a <close>
        close(1);
     6a4:	4505                	li	a0,1
     6a6:	584000ef          	jal	c2a <close>
        if(dup(aa[1]) != 1){
     6aa:	f9c42503          	lw	a0,-100(s0)
     6ae:	5cc000ef          	jal	c7a <dup>
     6b2:	4785                	li	a5,1
     6b4:	00f50c63          	beq	a0,a5,6cc <go+0x658>
          fprintf(2, "grind: dup failed\n");
     6b8:	00001597          	auipc	a1,0x1
     6bc:	db858593          	addi	a1,a1,-584 # 1470 <malloc+0x35a>
     6c0:	4509                	li	a0,2
     6c2:	177000ef          	jal	1038 <fprintf>
          exit(1);
     6c6:	4505                	li	a0,1
     6c8:	53a000ef          	jal	c02 <exit>
        close(aa[1]);
     6cc:	f9c42503          	lw	a0,-100(s0)
     6d0:	55a000ef          	jal	c2a <close>
        char *args[3] = { "echo", "hi", 0 };
     6d4:	00001797          	auipc	a5,0x1
     6d8:	db478793          	addi	a5,a5,-588 # 1488 <malloc+0x372>
     6dc:	faf43423          	sd	a5,-88(s0)
     6e0:	00001797          	auipc	a5,0x1
     6e4:	db078793          	addi	a5,a5,-592 # 1490 <malloc+0x37a>
     6e8:	faf43823          	sd	a5,-80(s0)
     6ec:	fa043c23          	sd	zero,-72(s0)
        exec("grindir/../echo", args);
     6f0:	fa840593          	addi	a1,s0,-88
     6f4:	00001517          	auipc	a0,0x1
     6f8:	da450513          	addi	a0,a0,-604 # 1498 <malloc+0x382>
     6fc:	53e000ef          	jal	c3a <exec>
        fprintf(2, "grind: echo: not found\n");
     700:	00001597          	auipc	a1,0x1
     704:	da858593          	addi	a1,a1,-600 # 14a8 <malloc+0x392>
     708:	4509                	li	a0,2
     70a:	12f000ef          	jal	1038 <fprintf>
        exit(2);
     70e:	4509                	li	a0,2
     710:	4f2000ef          	jal	c02 <exit>
        fprintf(2, "grind: fork failed\n");
     714:	00001597          	auipc	a1,0x1
     718:	c0c58593          	addi	a1,a1,-1012 # 1320 <malloc+0x20a>
     71c:	4509                	li	a0,2
     71e:	11b000ef          	jal	1038 <fprintf>
        exit(3);
     722:	450d                	li	a0,3
     724:	4de000ef          	jal	c02 <exit>
        close(aa[1]);
     728:	f9c42503          	lw	a0,-100(s0)
     72c:	4fe000ef          	jal	c2a <close>
        close(bb[0]);
     730:	fa042503          	lw	a0,-96(s0)
     734:	4f6000ef          	jal	c2a <close>
        close(0);
     738:	4501                	li	a0,0
     73a:	4f0000ef          	jal	c2a <close>
        if(dup(aa[0]) != 0){
     73e:	f9842503          	lw	a0,-104(s0)
     742:	538000ef          	jal	c7a <dup>
     746:	c919                	beqz	a0,75c <go+0x6e8>
          fprintf(2, "grind: dup failed\n");
     748:	00001597          	auipc	a1,0x1
     74c:	d2858593          	addi	a1,a1,-728 # 1470 <malloc+0x35a>
     750:	4509                	li	a0,2
     752:	0e7000ef          	jal	1038 <fprintf>
          exit(4);
     756:	4511                	li	a0,4
     758:	4aa000ef          	jal	c02 <exit>
        close(aa[0]);
     75c:	f9842503          	lw	a0,-104(s0)
     760:	4ca000ef          	jal	c2a <close>
        close(1);
     764:	4505                	li	a0,1
     766:	4c4000ef          	jal	c2a <close>
        if(dup(bb[1]) != 1){
     76a:	fa442503          	lw	a0,-92(s0)
     76e:	50c000ef          	jal	c7a <dup>
     772:	4785                	li	a5,1
     774:	00f50c63          	beq	a0,a5,78c <go+0x718>
          fprintf(2, "grind: dup failed\n");
     778:	00001597          	auipc	a1,0x1
     77c:	cf858593          	addi	a1,a1,-776 # 1470 <malloc+0x35a>
     780:	4509                	li	a0,2
     782:	0b7000ef          	jal	1038 <fprintf>
          exit(5);
     786:	4515                	li	a0,5
     788:	47a000ef          	jal	c02 <exit>
        close(bb[1]);
     78c:	fa442503          	lw	a0,-92(s0)
     790:	49a000ef          	jal	c2a <close>
        char *args[2] = { "cat", 0 };
     794:	00001797          	auipc	a5,0x1
     798:	d2c78793          	addi	a5,a5,-724 # 14c0 <malloc+0x3aa>
     79c:	faf43423          	sd	a5,-88(s0)
     7a0:	fa043823          	sd	zero,-80(s0)
        exec("/cat", args);
     7a4:	fa840593          	addi	a1,s0,-88
     7a8:	00001517          	auipc	a0,0x1
     7ac:	d2050513          	addi	a0,a0,-736 # 14c8 <malloc+0x3b2>
     7b0:	48a000ef          	jal	c3a <exec>
        fprintf(2, "grind: cat: not found\n");
     7b4:	00001597          	auipc	a1,0x1
     7b8:	d1c58593          	addi	a1,a1,-740 # 14d0 <malloc+0x3ba>
     7bc:	4509                	li	a0,2
     7be:	07b000ef          	jal	1038 <fprintf>
        exit(6);
     7c2:	4519                	li	a0,6
     7c4:	43e000ef          	jal	c02 <exit>
        fprintf(2, "grind: fork failed\n");
     7c8:	00001597          	auipc	a1,0x1
     7cc:	b5858593          	addi	a1,a1,-1192 # 1320 <malloc+0x20a>
     7d0:	4509                	li	a0,2
     7d2:	067000ef          	jal	1038 <fprintf>
        exit(7);
     7d6:	451d                	li	a0,7
     7d8:	42a000ef          	jal	c02 <exit>

00000000000007dc <iter>:
  }
}

void
iter()
{
     7dc:	7179                	addi	sp,sp,-48
     7de:	f406                	sd	ra,40(sp)
     7e0:	f022                	sd	s0,32(sp)
     7e2:	1800                	addi	s0,sp,48
  unlink("a");
     7e4:	00001517          	auipc	a0,0x1
     7e8:	b5450513          	addi	a0,a0,-1196 # 1338 <malloc+0x222>
     7ec:	466000ef          	jal	c52 <unlink>
  unlink("b");
     7f0:	00001517          	auipc	a0,0x1
     7f4:	af850513          	addi	a0,a0,-1288 # 12e8 <malloc+0x1d2>
     7f8:	45a000ef          	jal	c52 <unlink>
  
  int pid1 = fork();
     7fc:	3fe000ef          	jal	bfa <fork>
  if(pid1 < 0){
     800:	02054163          	bltz	a0,822 <iter+0x46>
     804:	ec26                	sd	s1,24(sp)
     806:	84aa                	mv	s1,a0
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid1 == 0){
     808:	e905                	bnez	a0,838 <iter+0x5c>
     80a:	e84a                	sd	s2,16(sp)
    rand_next ^= 31;
     80c:	00001717          	auipc	a4,0x1
     810:	7f470713          	addi	a4,a4,2036 # 2000 <rand_next>
     814:	631c                	ld	a5,0(a4)
     816:	01f7c793          	xori	a5,a5,31
     81a:	e31c                	sd	a5,0(a4)
    go(0);
     81c:	4501                	li	a0,0
     81e:	857ff0ef          	jal	74 <go>
     822:	ec26                	sd	s1,24(sp)
     824:	e84a                	sd	s2,16(sp)
    printf("grind: fork failed\n");
     826:	00001517          	auipc	a0,0x1
     82a:	afa50513          	addi	a0,a0,-1286 # 1320 <malloc+0x20a>
     82e:	035000ef          	jal	1062 <printf>
    exit(1);
     832:	4505                	li	a0,1
     834:	3ce000ef          	jal	c02 <exit>
     838:	e84a                	sd	s2,16(sp)
    exit(0);
  }

  int pid2 = fork();
     83a:	3c0000ef          	jal	bfa <fork>
     83e:	892a                	mv	s2,a0
  if(pid2 < 0){
     840:	02054063          	bltz	a0,860 <iter+0x84>
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid2 == 0){
     844:	e51d                	bnez	a0,872 <iter+0x96>
    rand_next ^= 7177;
     846:	00001697          	auipc	a3,0x1
     84a:	7ba68693          	addi	a3,a3,1978 # 2000 <rand_next>
     84e:	629c                	ld	a5,0(a3)
     850:	6709                	lui	a4,0x2
     852:	c0970713          	addi	a4,a4,-1015 # 1c09 <digits+0x689>
     856:	8fb9                	xor	a5,a5,a4
     858:	e29c                	sd	a5,0(a3)
    go(1);
     85a:	4505                	li	a0,1
     85c:	819ff0ef          	jal	74 <go>
    printf("grind: fork failed\n");
     860:	00001517          	auipc	a0,0x1
     864:	ac050513          	addi	a0,a0,-1344 # 1320 <malloc+0x20a>
     868:	7fa000ef          	jal	1062 <printf>
    exit(1);
     86c:	4505                	li	a0,1
     86e:	394000ef          	jal	c02 <exit>
    exit(0);
  }

  int st1 = -1;
     872:	57fd                	li	a5,-1
     874:	fcf42e23          	sw	a5,-36(s0)
  wait(&st1);
     878:	fdc40513          	addi	a0,s0,-36
     87c:	38e000ef          	jal	c0a <wait>
  if(st1 != 0){
     880:	fdc42783          	lw	a5,-36(s0)
     884:	eb99                	bnez	a5,89a <iter+0xbe>
    kill(pid1);
    kill(pid2);
  }
  int st2 = -1;
     886:	57fd                	li	a5,-1
     888:	fcf42c23          	sw	a5,-40(s0)
  wait(&st2);
     88c:	fd840513          	addi	a0,s0,-40
     890:	37a000ef          	jal	c0a <wait>

  exit(0);
     894:	4501                	li	a0,0
     896:	36c000ef          	jal	c02 <exit>
    kill(pid1);
     89a:	8526                	mv	a0,s1
     89c:	396000ef          	jal	c32 <kill>
    kill(pid2);
     8a0:	854a                	mv	a0,s2
     8a2:	390000ef          	jal	c32 <kill>
     8a6:	b7c5                	j	886 <iter+0xaa>

00000000000008a8 <main>:
}

int
main()
{
     8a8:	1101                	addi	sp,sp,-32
     8aa:	ec06                	sd	ra,24(sp)
     8ac:	e822                	sd	s0,16(sp)
     8ae:	e426                	sd	s1,8(sp)
     8b0:	1000                	addi	s0,sp,32
    }
    if(pid > 0){
      wait(0);
    }
    pause(20);
    rand_next += 1;
     8b2:	00001497          	auipc	s1,0x1
     8b6:	74e48493          	addi	s1,s1,1870 # 2000 <rand_next>
     8ba:	a809                	j	8cc <main+0x24>
      iter();
     8bc:	f21ff0ef          	jal	7dc <iter>
    pause(20);
     8c0:	4551                	li	a0,20
     8c2:	3d0000ef          	jal	c92 <pause>
    rand_next += 1;
     8c6:	609c                	ld	a5,0(s1)
     8c8:	0785                	addi	a5,a5,1
     8ca:	e09c                	sd	a5,0(s1)
    int pid = fork();
     8cc:	32e000ef          	jal	bfa <fork>
    if(pid == 0){
     8d0:	d575                	beqz	a0,8bc <main+0x14>
    if(pid > 0){
     8d2:	fea057e3          	blez	a0,8c0 <main+0x18>
      wait(0);
     8d6:	4501                	li	a0,0
     8d8:	332000ef          	jal	c0a <wait>
     8dc:	b7d5                	j	8c0 <main+0x18>

00000000000008de <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
     8de:	1141                	addi	sp,sp,-16
     8e0:	e406                	sd	ra,8(sp)
     8e2:	e022                	sd	s0,0(sp)
     8e4:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
     8e6:	fc3ff0ef          	jal	8a8 <main>
  exit(r);
     8ea:	318000ef          	jal	c02 <exit>

00000000000008ee <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     8ee:	1141                	addi	sp,sp,-16
     8f0:	e422                	sd	s0,8(sp)
     8f2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     8f4:	87aa                	mv	a5,a0
     8f6:	0585                	addi	a1,a1,1
     8f8:	0785                	addi	a5,a5,1
     8fa:	fff5c703          	lbu	a4,-1(a1)
     8fe:	fee78fa3          	sb	a4,-1(a5)
     902:	fb75                	bnez	a4,8f6 <strcpy+0x8>
    ;
  return os;
}
     904:	6422                	ld	s0,8(sp)
     906:	0141                	addi	sp,sp,16
     908:	8082                	ret

000000000000090a <strcmp>:

int
strcmp(const char *p, const char *q)
{
     90a:	1141                	addi	sp,sp,-16
     90c:	e422                	sd	s0,8(sp)
     90e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
     910:	00054783          	lbu	a5,0(a0)
     914:	cb91                	beqz	a5,928 <strcmp+0x1e>
     916:	0005c703          	lbu	a4,0(a1)
     91a:	00f71763          	bne	a4,a5,928 <strcmp+0x1e>
    p++, q++;
     91e:	0505                	addi	a0,a0,1
     920:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
     922:	00054783          	lbu	a5,0(a0)
     926:	fbe5                	bnez	a5,916 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     928:	0005c503          	lbu	a0,0(a1)
}
     92c:	40a7853b          	subw	a0,a5,a0
     930:	6422                	ld	s0,8(sp)
     932:	0141                	addi	sp,sp,16
     934:	8082                	ret

0000000000000936 <strlen>:

uint
strlen(const char *s)
{
     936:	1141                	addi	sp,sp,-16
     938:	e422                	sd	s0,8(sp)
     93a:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     93c:	00054783          	lbu	a5,0(a0)
     940:	cf91                	beqz	a5,95c <strlen+0x26>
     942:	0505                	addi	a0,a0,1
     944:	87aa                	mv	a5,a0
     946:	86be                	mv	a3,a5
     948:	0785                	addi	a5,a5,1
     94a:	fff7c703          	lbu	a4,-1(a5)
     94e:	ff65                	bnez	a4,946 <strlen+0x10>
     950:	40a6853b          	subw	a0,a3,a0
     954:	2505                	addiw	a0,a0,1
    ;
  return n;
}
     956:	6422                	ld	s0,8(sp)
     958:	0141                	addi	sp,sp,16
     95a:	8082                	ret
  for(n = 0; s[n]; n++)
     95c:	4501                	li	a0,0
     95e:	bfe5                	j	956 <strlen+0x20>

0000000000000960 <memset>:

void*
memset(void *dst, int c, uint n)
{
     960:	1141                	addi	sp,sp,-16
     962:	e422                	sd	s0,8(sp)
     964:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     966:	ca19                	beqz	a2,97c <memset+0x1c>
     968:	87aa                	mv	a5,a0
     96a:	1602                	slli	a2,a2,0x20
     96c:	9201                	srli	a2,a2,0x20
     96e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     972:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     976:	0785                	addi	a5,a5,1
     978:	fee79de3          	bne	a5,a4,972 <memset+0x12>
  }
  return dst;
}
     97c:	6422                	ld	s0,8(sp)
     97e:	0141                	addi	sp,sp,16
     980:	8082                	ret

0000000000000982 <strchr>:

char*
strchr(const char *s, char c)
{
     982:	1141                	addi	sp,sp,-16
     984:	e422                	sd	s0,8(sp)
     986:	0800                	addi	s0,sp,16
  for(; *s; s++)
     988:	00054783          	lbu	a5,0(a0)
     98c:	cb99                	beqz	a5,9a2 <strchr+0x20>
    if(*s == c)
     98e:	00f58763          	beq	a1,a5,99c <strchr+0x1a>
  for(; *s; s++)
     992:	0505                	addi	a0,a0,1
     994:	00054783          	lbu	a5,0(a0)
     998:	fbfd                	bnez	a5,98e <strchr+0xc>
      return (char*)s;
  return 0;
     99a:	4501                	li	a0,0
}
     99c:	6422                	ld	s0,8(sp)
     99e:	0141                	addi	sp,sp,16
     9a0:	8082                	ret
  return 0;
     9a2:	4501                	li	a0,0
     9a4:	bfe5                	j	99c <strchr+0x1a>

00000000000009a6 <gets>:

char*
gets(char *buf, int max)
{
     9a6:	711d                	addi	sp,sp,-96
     9a8:	ec86                	sd	ra,88(sp)
     9aa:	e8a2                	sd	s0,80(sp)
     9ac:	e4a6                	sd	s1,72(sp)
     9ae:	e0ca                	sd	s2,64(sp)
     9b0:	fc4e                	sd	s3,56(sp)
     9b2:	f852                	sd	s4,48(sp)
     9b4:	f456                	sd	s5,40(sp)
     9b6:	f05a                	sd	s6,32(sp)
     9b8:	ec5e                	sd	s7,24(sp)
     9ba:	1080                	addi	s0,sp,96
     9bc:	8baa                	mv	s7,a0
     9be:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     9c0:	892a                	mv	s2,a0
     9c2:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     9c4:	4aa9                	li	s5,10
     9c6:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     9c8:	89a6                	mv	s3,s1
     9ca:	2485                	addiw	s1,s1,1
     9cc:	0344d663          	bge	s1,s4,9f8 <gets+0x52>
    cc = read(0, &c, 1);
     9d0:	4605                	li	a2,1
     9d2:	faf40593          	addi	a1,s0,-81
     9d6:	4501                	li	a0,0
     9d8:	242000ef          	jal	c1a <read>
    if(cc < 1)
     9dc:	00a05e63          	blez	a0,9f8 <gets+0x52>
    buf[i++] = c;
     9e0:	faf44783          	lbu	a5,-81(s0)
     9e4:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     9e8:	01578763          	beq	a5,s5,9f6 <gets+0x50>
     9ec:	0905                	addi	s2,s2,1
     9ee:	fd679de3          	bne	a5,s6,9c8 <gets+0x22>
    buf[i++] = c;
     9f2:	89a6                	mv	s3,s1
     9f4:	a011                	j	9f8 <gets+0x52>
     9f6:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     9f8:	99de                	add	s3,s3,s7
     9fa:	00098023          	sb	zero,0(s3)
  return buf;
}
     9fe:	855e                	mv	a0,s7
     a00:	60e6                	ld	ra,88(sp)
     a02:	6446                	ld	s0,80(sp)
     a04:	64a6                	ld	s1,72(sp)
     a06:	6906                	ld	s2,64(sp)
     a08:	79e2                	ld	s3,56(sp)
     a0a:	7a42                	ld	s4,48(sp)
     a0c:	7aa2                	ld	s5,40(sp)
     a0e:	7b02                	ld	s6,32(sp)
     a10:	6be2                	ld	s7,24(sp)
     a12:	6125                	addi	sp,sp,96
     a14:	8082                	ret

0000000000000a16 <stat>:

int
stat(const char *n, struct stat *st)
{
     a16:	1101                	addi	sp,sp,-32
     a18:	ec06                	sd	ra,24(sp)
     a1a:	e822                	sd	s0,16(sp)
     a1c:	e04a                	sd	s2,0(sp)
     a1e:	1000                	addi	s0,sp,32
     a20:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     a22:	4581                	li	a1,0
     a24:	21e000ef          	jal	c42 <open>
  if(fd < 0)
     a28:	02054263          	bltz	a0,a4c <stat+0x36>
     a2c:	e426                	sd	s1,8(sp)
     a2e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     a30:	85ca                	mv	a1,s2
     a32:	228000ef          	jal	c5a <fstat>
     a36:	892a                	mv	s2,a0
  close(fd);
     a38:	8526                	mv	a0,s1
     a3a:	1f0000ef          	jal	c2a <close>
  return r;
     a3e:	64a2                	ld	s1,8(sp)
}
     a40:	854a                	mv	a0,s2
     a42:	60e2                	ld	ra,24(sp)
     a44:	6442                	ld	s0,16(sp)
     a46:	6902                	ld	s2,0(sp)
     a48:	6105                	addi	sp,sp,32
     a4a:	8082                	ret
    return -1;
     a4c:	597d                	li	s2,-1
     a4e:	bfcd                	j	a40 <stat+0x2a>

0000000000000a50 <atoi>:

int
atoi(const char *s)
{
     a50:	1141                	addi	sp,sp,-16
     a52:	e422                	sd	s0,8(sp)
     a54:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     a56:	00054683          	lbu	a3,0(a0)
     a5a:	fd06879b          	addiw	a5,a3,-48
     a5e:	0ff7f793          	zext.b	a5,a5
     a62:	4625                	li	a2,9
     a64:	02f66863          	bltu	a2,a5,a94 <atoi+0x44>
     a68:	872a                	mv	a4,a0
  n = 0;
     a6a:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
     a6c:	0705                	addi	a4,a4,1
     a6e:	0025179b          	slliw	a5,a0,0x2
     a72:	9fa9                	addw	a5,a5,a0
     a74:	0017979b          	slliw	a5,a5,0x1
     a78:	9fb5                	addw	a5,a5,a3
     a7a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     a7e:	00074683          	lbu	a3,0(a4)
     a82:	fd06879b          	addiw	a5,a3,-48
     a86:	0ff7f793          	zext.b	a5,a5
     a8a:	fef671e3          	bgeu	a2,a5,a6c <atoi+0x1c>
  return n;
}
     a8e:	6422                	ld	s0,8(sp)
     a90:	0141                	addi	sp,sp,16
     a92:	8082                	ret
  n = 0;
     a94:	4501                	li	a0,0
     a96:	bfe5                	j	a8e <atoi+0x3e>

0000000000000a98 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     a98:	1141                	addi	sp,sp,-16
     a9a:	e422                	sd	s0,8(sp)
     a9c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     a9e:	02b57463          	bgeu	a0,a1,ac6 <memmove+0x2e>
    while(n-- > 0)
     aa2:	00c05f63          	blez	a2,ac0 <memmove+0x28>
     aa6:	1602                	slli	a2,a2,0x20
     aa8:	9201                	srli	a2,a2,0x20
     aaa:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     aae:	872a                	mv	a4,a0
      *dst++ = *src++;
     ab0:	0585                	addi	a1,a1,1
     ab2:	0705                	addi	a4,a4,1
     ab4:	fff5c683          	lbu	a3,-1(a1)
     ab8:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     abc:	fef71ae3          	bne	a4,a5,ab0 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     ac0:	6422                	ld	s0,8(sp)
     ac2:	0141                	addi	sp,sp,16
     ac4:	8082                	ret
    dst += n;
     ac6:	00c50733          	add	a4,a0,a2
    src += n;
     aca:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     acc:	fec05ae3          	blez	a2,ac0 <memmove+0x28>
     ad0:	fff6079b          	addiw	a5,a2,-1
     ad4:	1782                	slli	a5,a5,0x20
     ad6:	9381                	srli	a5,a5,0x20
     ad8:	fff7c793          	not	a5,a5
     adc:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     ade:	15fd                	addi	a1,a1,-1
     ae0:	177d                	addi	a4,a4,-1
     ae2:	0005c683          	lbu	a3,0(a1)
     ae6:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     aea:	fee79ae3          	bne	a5,a4,ade <memmove+0x46>
     aee:	bfc9                	j	ac0 <memmove+0x28>

0000000000000af0 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     af0:	1141                	addi	sp,sp,-16
     af2:	e422                	sd	s0,8(sp)
     af4:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     af6:	ca05                	beqz	a2,b26 <memcmp+0x36>
     af8:	fff6069b          	addiw	a3,a2,-1
     afc:	1682                	slli	a3,a3,0x20
     afe:	9281                	srli	a3,a3,0x20
     b00:	0685                	addi	a3,a3,1
     b02:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
     b04:	00054783          	lbu	a5,0(a0)
     b08:	0005c703          	lbu	a4,0(a1)
     b0c:	00e79863          	bne	a5,a4,b1c <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
     b10:	0505                	addi	a0,a0,1
    p2++;
     b12:	0585                	addi	a1,a1,1
  while (n-- > 0) {
     b14:	fed518e3          	bne	a0,a3,b04 <memcmp+0x14>
  }
  return 0;
     b18:	4501                	li	a0,0
     b1a:	a019                	j	b20 <memcmp+0x30>
      return *p1 - *p2;
     b1c:	40e7853b          	subw	a0,a5,a4
}
     b20:	6422                	ld	s0,8(sp)
     b22:	0141                	addi	sp,sp,16
     b24:	8082                	ret
  return 0;
     b26:	4501                	li	a0,0
     b28:	bfe5                	j	b20 <memcmp+0x30>

0000000000000b2a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     b2a:	1141                	addi	sp,sp,-16
     b2c:	e406                	sd	ra,8(sp)
     b2e:	e022                	sd	s0,0(sp)
     b30:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
     b32:	f67ff0ef          	jal	a98 <memmove>
}
     b36:	60a2                	ld	ra,8(sp)
     b38:	6402                	ld	s0,0(sp)
     b3a:	0141                	addi	sp,sp,16
     b3c:	8082                	ret

0000000000000b3e <sbrk>:

char *
sbrk(int n) {
     b3e:	1141                	addi	sp,sp,-16
     b40:	e406                	sd	ra,8(sp)
     b42:	e022                	sd	s0,0(sp)
     b44:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
     b46:	4585                	li	a1,1
     b48:	142000ef          	jal	c8a <sys_sbrk>
}
     b4c:	60a2                	ld	ra,8(sp)
     b4e:	6402                	ld	s0,0(sp)
     b50:	0141                	addi	sp,sp,16
     b52:	8082                	ret

0000000000000b54 <sbrklazy>:

char *
sbrklazy(int n) {
     b54:	1141                	addi	sp,sp,-16
     b56:	e406                	sd	ra,8(sp)
     b58:	e022                	sd	s0,0(sp)
     b5a:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
     b5c:	4589                	li	a1,2
     b5e:	12c000ef          	jal	c8a <sys_sbrk>
}
     b62:	60a2                	ld	ra,8(sp)
     b64:	6402                	ld	s0,0(sp)
     b66:	0141                	addi	sp,sp,16
     b68:	8082                	ret

0000000000000b6a <thread_create>:
// thread_create allocates a page-sized stack, calls clone(fn, arg, stacktop).
// Returns the new thread's pid, or -1 on error.
// The stack is passed back via *stack so the caller can free it after join.
int
thread_create(void(*fn)(void*), void *arg, void **stack)
{
     b6a:	7179                	addi	sp,sp,-48
     b6c:	f406                	sd	ra,40(sp)
     b6e:	f022                	sd	s0,32(sp)
     b70:	e84a                	sd	s2,16(sp)
     b72:	e44e                	sd	s3,8(sp)
     b74:	e052                	sd	s4,0(sp)
     b76:	1800                	addi	s0,sp,48
     b78:	89aa                	mv	s3,a0
     b7a:	8a2e                	mv	s4,a1
     b7c:	8932                	mv	s2,a2
  char *s = malloc(PGSIZE);
     b7e:	6505                	lui	a0,0x1
     b80:	596000ef          	jal	1116 <malloc>
  if(s == 0)
     b84:	cd0d                	beqz	a0,bbe <thread_create+0x54>
     b86:	ec26                	sd	s1,24(sp)
     b88:	84aa                	mv	s1,a0
    return -1;
  *stack = s;
     b8a:	00a93023          	sd	a0,0(s2)
  // Stack grows downward: pass the top of the allocated region.
  int pid = clone(fn, arg, s + PGSIZE);
     b8e:	6605                	lui	a2,0x1
     b90:	962a                	add	a2,a2,a0
     b92:	85d2                	mv	a1,s4
     b94:	854e                	mv	a0,s3
     b96:	134000ef          	jal	cca <clone>
  if(pid < 0){
     b9a:	00054a63          	bltz	a0,bae <thread_create+0x44>
     b9e:	64e2                	ld	s1,24(sp)
    free(s);
    *stack = 0;
    return -1;
  }
  return pid;
}
     ba0:	70a2                	ld	ra,40(sp)
     ba2:	7402                	ld	s0,32(sp)
     ba4:	6942                	ld	s2,16(sp)
     ba6:	69a2                	ld	s3,8(sp)
     ba8:	6a02                	ld	s4,0(sp)
     baa:	6145                	addi	sp,sp,48
     bac:	8082                	ret
    free(s);
     bae:	8526                	mv	a0,s1
     bb0:	4e4000ef          	jal	1094 <free>
    *stack = 0;
     bb4:	00093023          	sd	zero,0(s2)
    return -1;
     bb8:	557d                	li	a0,-1
     bba:	64e2                	ld	s1,24(sp)
     bbc:	b7d5                	j	ba0 <thread_create+0x36>
    return -1;
     bbe:	557d                	li	a0,-1
     bc0:	b7c5                	j	ba0 <thread_create+0x36>

0000000000000bc2 <thread_join>:
// Wait for any child thread to exit.
// If stack is non-null, frees the memory pointed to by *stack and clears it.
// Returns the joined thread's pid, or -1 on error.
int
thread_join(void **stack)
{
     bc2:	1101                	addi	sp,sp,-32
     bc4:	ec06                	sd	ra,24(sp)
     bc6:	e822                	sd	s0,16(sp)
     bc8:	e426                	sd	s1,8(sp)
     bca:	e04a                	sd	s2,0(sp)
     bcc:	1000                	addi	s0,sp,32
     bce:	84aa                	mv	s1,a0
  int pid = join();
     bd0:	102000ef          	jal	cd2 <join>
  if(pid < 0)
     bd4:	02054163          	bltz	a0,bf6 <thread_join+0x34>
     bd8:	892a                	mv	s2,a0
    return -1;
  if(stack && *stack){
     bda:	c499                	beqz	s1,be8 <thread_join+0x26>
     bdc:	6088                	ld	a0,0(s1)
     bde:	c509                	beqz	a0,be8 <thread_join+0x26>
    free(*stack);
     be0:	4b4000ef          	jal	1094 <free>
    *stack = 0;
     be4:	0004b023          	sd	zero,0(s1)
  }
  return pid;
}
     be8:	854a                	mv	a0,s2
     bea:	60e2                	ld	ra,24(sp)
     bec:	6442                	ld	s0,16(sp)
     bee:	64a2                	ld	s1,8(sp)
     bf0:	6902                	ld	s2,0(sp)
     bf2:	6105                	addi	sp,sp,32
     bf4:	8082                	ret
    return -1;
     bf6:	597d                	li	s2,-1
     bf8:	bfc5                	j	be8 <thread_join+0x26>

0000000000000bfa <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     bfa:	4885                	li	a7,1
 ecall
     bfc:	00000073          	ecall
 ret
     c00:	8082                	ret

0000000000000c02 <exit>:
.global exit
exit:
 li a7, SYS_exit
     c02:	4889                	li	a7,2
 ecall
     c04:	00000073          	ecall
 ret
     c08:	8082                	ret

0000000000000c0a <wait>:
.global wait
wait:
 li a7, SYS_wait
     c0a:	488d                	li	a7,3
 ecall
     c0c:	00000073          	ecall
 ret
     c10:	8082                	ret

0000000000000c12 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     c12:	4891                	li	a7,4
 ecall
     c14:	00000073          	ecall
 ret
     c18:	8082                	ret

0000000000000c1a <read>:
.global read
read:
 li a7, SYS_read
     c1a:	4895                	li	a7,5
 ecall
     c1c:	00000073          	ecall
 ret
     c20:	8082                	ret

0000000000000c22 <write>:
.global write
write:
 li a7, SYS_write
     c22:	48c1                	li	a7,16
 ecall
     c24:	00000073          	ecall
 ret
     c28:	8082                	ret

0000000000000c2a <close>:
.global close
close:
 li a7, SYS_close
     c2a:	48d5                	li	a7,21
 ecall
     c2c:	00000073          	ecall
 ret
     c30:	8082                	ret

0000000000000c32 <kill>:
.global kill
kill:
 li a7, SYS_kill
     c32:	4899                	li	a7,6
 ecall
     c34:	00000073          	ecall
 ret
     c38:	8082                	ret

0000000000000c3a <exec>:
.global exec
exec:
 li a7, SYS_exec
     c3a:	489d                	li	a7,7
 ecall
     c3c:	00000073          	ecall
 ret
     c40:	8082                	ret

0000000000000c42 <open>:
.global open
open:
 li a7, SYS_open
     c42:	48bd                	li	a7,15
 ecall
     c44:	00000073          	ecall
 ret
     c48:	8082                	ret

0000000000000c4a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     c4a:	48c5                	li	a7,17
 ecall
     c4c:	00000073          	ecall
 ret
     c50:	8082                	ret

0000000000000c52 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     c52:	48c9                	li	a7,18
 ecall
     c54:	00000073          	ecall
 ret
     c58:	8082                	ret

0000000000000c5a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     c5a:	48a1                	li	a7,8
 ecall
     c5c:	00000073          	ecall
 ret
     c60:	8082                	ret

0000000000000c62 <link>:
.global link
link:
 li a7, SYS_link
     c62:	48cd                	li	a7,19
 ecall
     c64:	00000073          	ecall
 ret
     c68:	8082                	ret

0000000000000c6a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     c6a:	48d1                	li	a7,20
 ecall
     c6c:	00000073          	ecall
 ret
     c70:	8082                	ret

0000000000000c72 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     c72:	48a5                	li	a7,9
 ecall
     c74:	00000073          	ecall
 ret
     c78:	8082                	ret

0000000000000c7a <dup>:
.global dup
dup:
 li a7, SYS_dup
     c7a:	48a9                	li	a7,10
 ecall
     c7c:	00000073          	ecall
 ret
     c80:	8082                	ret

0000000000000c82 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     c82:	48ad                	li	a7,11
 ecall
     c84:	00000073          	ecall
 ret
     c88:	8082                	ret

0000000000000c8a <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
     c8a:	48b1                	li	a7,12
 ecall
     c8c:	00000073          	ecall
 ret
     c90:	8082                	ret

0000000000000c92 <pause>:
.global pause
pause:
 li a7, SYS_pause
     c92:	48b5                	li	a7,13
 ecall
     c94:	00000073          	ecall
 ret
     c98:	8082                	ret

0000000000000c9a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     c9a:	48b9                	li	a7,14
 ecall
     c9c:	00000073          	ecall
 ret
     ca0:	8082                	ret

0000000000000ca2 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
     ca2:	48d9                	li	a7,22
 ecall
     ca4:	00000073          	ecall
 ret
     ca8:	8082                	ret

0000000000000caa <lock_create>:
.global lock_create
lock_create:
 li a7, SYS_lock_create
     caa:	48dd                	li	a7,23
 ecall
     cac:	00000073          	ecall
 ret
     cb0:	8082                	ret

0000000000000cb2 <lock_acquire>:
.global lock_acquire
lock_acquire:
 li a7, SYS_lock_acquire
     cb2:	48e1                	li	a7,24
 ecall
     cb4:	00000073          	ecall
 ret
     cb8:	8082                	ret

0000000000000cba <lock_release>:
.global lock_release
lock_release:
 li a7, SYS_lock_release
     cba:	48e5                	li	a7,25
 ecall
     cbc:	00000073          	ecall
 ret
     cc0:	8082                	ret

0000000000000cc2 <lock_destroy>:
.global lock_destroy
lock_destroy:
 li a7, SYS_lock_destroy
     cc2:	48e9                	li	a7,26
 ecall
     cc4:	00000073          	ecall
 ret
     cc8:	8082                	ret

0000000000000cca <clone>:
.global clone
clone:
 li a7, SYS_clone
     cca:	48ed                	li	a7,27
 ecall
     ccc:	00000073          	ecall
 ret
     cd0:	8082                	ret

0000000000000cd2 <join>:
.global join
join:
 li a7, SYS_join
     cd2:	48f1                	li	a7,28
 ecall
     cd4:	00000073          	ecall
 ret
     cd8:	8082                	ret

0000000000000cda <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     cda:	1101                	addi	sp,sp,-32
     cdc:	ec06                	sd	ra,24(sp)
     cde:	e822                	sd	s0,16(sp)
     ce0:	1000                	addi	s0,sp,32
     ce2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     ce6:	4605                	li	a2,1
     ce8:	fef40593          	addi	a1,s0,-17
     cec:	f37ff0ef          	jal	c22 <write>
}
     cf0:	60e2                	ld	ra,24(sp)
     cf2:	6442                	ld	s0,16(sp)
     cf4:	6105                	addi	sp,sp,32
     cf6:	8082                	ret

0000000000000cf8 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
     cf8:	715d                	addi	sp,sp,-80
     cfa:	e486                	sd	ra,72(sp)
     cfc:	e0a2                	sd	s0,64(sp)
     cfe:	f84a                	sd	s2,48(sp)
     d00:	0880                	addi	s0,sp,80
     d02:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
     d04:	c299                	beqz	a3,d0a <printint+0x12>
     d06:	0805c363          	bltz	a1,d8c <printint+0x94>
  neg = 0;
     d0a:	4881                	li	a7,0
     d0c:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
     d10:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
     d12:	00001517          	auipc	a0,0x1
     d16:	86e50513          	addi	a0,a0,-1938 # 1580 <digits>
     d1a:	883e                	mv	a6,a5
     d1c:	2785                	addiw	a5,a5,1
     d1e:	02c5f733          	remu	a4,a1,a2
     d22:	972a                	add	a4,a4,a0
     d24:	00074703          	lbu	a4,0(a4)
     d28:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
     d2c:	872e                	mv	a4,a1
     d2e:	02c5d5b3          	divu	a1,a1,a2
     d32:	0685                	addi	a3,a3,1
     d34:	fec773e3          	bgeu	a4,a2,d1a <printint+0x22>
  if(neg)
     d38:	00088b63          	beqz	a7,d4e <printint+0x56>
    buf[i++] = '-';
     d3c:	fd078793          	addi	a5,a5,-48
     d40:	97a2                	add	a5,a5,s0
     d42:	02d00713          	li	a4,45
     d46:	fee78423          	sb	a4,-24(a5)
     d4a:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
     d4e:	02f05a63          	blez	a5,d82 <printint+0x8a>
     d52:	fc26                	sd	s1,56(sp)
     d54:	f44e                	sd	s3,40(sp)
     d56:	fb840713          	addi	a4,s0,-72
     d5a:	00f704b3          	add	s1,a4,a5
     d5e:	fff70993          	addi	s3,a4,-1
     d62:	99be                	add	s3,s3,a5
     d64:	37fd                	addiw	a5,a5,-1
     d66:	1782                	slli	a5,a5,0x20
     d68:	9381                	srli	a5,a5,0x20
     d6a:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
     d6e:	fff4c583          	lbu	a1,-1(s1)
     d72:	854a                	mv	a0,s2
     d74:	f67ff0ef          	jal	cda <putc>
  while(--i >= 0)
     d78:	14fd                	addi	s1,s1,-1
     d7a:	ff349ae3          	bne	s1,s3,d6e <printint+0x76>
     d7e:	74e2                	ld	s1,56(sp)
     d80:	79a2                	ld	s3,40(sp)
}
     d82:	60a6                	ld	ra,72(sp)
     d84:	6406                	ld	s0,64(sp)
     d86:	7942                	ld	s2,48(sp)
     d88:	6161                	addi	sp,sp,80
     d8a:	8082                	ret
    x = -xx;
     d8c:	40b005b3          	neg	a1,a1
    neg = 1;
     d90:	4885                	li	a7,1
    x = -xx;
     d92:	bfad                	j	d0c <printint+0x14>

0000000000000d94 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     d94:	711d                	addi	sp,sp,-96
     d96:	ec86                	sd	ra,88(sp)
     d98:	e8a2                	sd	s0,80(sp)
     d9a:	e0ca                	sd	s2,64(sp)
     d9c:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
     d9e:	0005c903          	lbu	s2,0(a1)
     da2:	28090663          	beqz	s2,102e <vprintf+0x29a>
     da6:	e4a6                	sd	s1,72(sp)
     da8:	fc4e                	sd	s3,56(sp)
     daa:	f852                	sd	s4,48(sp)
     dac:	f456                	sd	s5,40(sp)
     dae:	f05a                	sd	s6,32(sp)
     db0:	ec5e                	sd	s7,24(sp)
     db2:	e862                	sd	s8,16(sp)
     db4:	e466                	sd	s9,8(sp)
     db6:	8b2a                	mv	s6,a0
     db8:	8a2e                	mv	s4,a1
     dba:	8bb2                	mv	s7,a2
  state = 0;
     dbc:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
     dbe:	4481                	li	s1,0
     dc0:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
     dc2:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
     dc6:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
     dca:	06c00c93          	li	s9,108
     dce:	a005                	j	dee <vprintf+0x5a>
        putc(fd, c0);
     dd0:	85ca                	mv	a1,s2
     dd2:	855a                	mv	a0,s6
     dd4:	f07ff0ef          	jal	cda <putc>
     dd8:	a019                	j	dde <vprintf+0x4a>
    } else if(state == '%'){
     dda:	03598263          	beq	s3,s5,dfe <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
     dde:	2485                	addiw	s1,s1,1
     de0:	8726                	mv	a4,s1
     de2:	009a07b3          	add	a5,s4,s1
     de6:	0007c903          	lbu	s2,0(a5)
     dea:	22090a63          	beqz	s2,101e <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
     dee:	0009079b          	sext.w	a5,s2
    if(state == 0){
     df2:	fe0994e3          	bnez	s3,dda <vprintf+0x46>
      if(c0 == '%'){
     df6:	fd579de3          	bne	a5,s5,dd0 <vprintf+0x3c>
        state = '%';
     dfa:	89be                	mv	s3,a5
     dfc:	b7cd                	j	dde <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
     dfe:	00ea06b3          	add	a3,s4,a4
     e02:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
     e06:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
     e08:	c681                	beqz	a3,e10 <vprintf+0x7c>
     e0a:	9752                	add	a4,a4,s4
     e0c:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
     e10:	05878363          	beq	a5,s8,e56 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
     e14:	05978d63          	beq	a5,s9,e6e <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
     e18:	07500713          	li	a4,117
     e1c:	0ee78763          	beq	a5,a4,f0a <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
     e20:	07800713          	li	a4,120
     e24:	12e78963          	beq	a5,a4,f56 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
     e28:	07000713          	li	a4,112
     e2c:	14e78e63          	beq	a5,a4,f88 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
     e30:	06300713          	li	a4,99
     e34:	18e78e63          	beq	a5,a4,fd0 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
     e38:	07300713          	li	a4,115
     e3c:	1ae78463          	beq	a5,a4,fe4 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
     e40:	02500713          	li	a4,37
     e44:	04e79563          	bne	a5,a4,e8e <vprintf+0xfa>
        putc(fd, '%');
     e48:	02500593          	li	a1,37
     e4c:	855a                	mv	a0,s6
     e4e:	e8dff0ef          	jal	cda <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
     e52:	4981                	li	s3,0
     e54:	b769                	j	dde <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
     e56:	008b8913          	addi	s2,s7,8
     e5a:	4685                	li	a3,1
     e5c:	4629                	li	a2,10
     e5e:	000ba583          	lw	a1,0(s7)
     e62:	855a                	mv	a0,s6
     e64:	e95ff0ef          	jal	cf8 <printint>
     e68:	8bca                	mv	s7,s2
      state = 0;
     e6a:	4981                	li	s3,0
     e6c:	bf8d                	j	dde <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
     e6e:	06400793          	li	a5,100
     e72:	02f68963          	beq	a3,a5,ea4 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     e76:	06c00793          	li	a5,108
     e7a:	04f68263          	beq	a3,a5,ebe <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
     e7e:	07500793          	li	a5,117
     e82:	0af68063          	beq	a3,a5,f22 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
     e86:	07800793          	li	a5,120
     e8a:	0ef68263          	beq	a3,a5,f6e <vprintf+0x1da>
        putc(fd, '%');
     e8e:	02500593          	li	a1,37
     e92:	855a                	mv	a0,s6
     e94:	e47ff0ef          	jal	cda <putc>
        putc(fd, c0);
     e98:	85ca                	mv	a1,s2
     e9a:	855a                	mv	a0,s6
     e9c:	e3fff0ef          	jal	cda <putc>
      state = 0;
     ea0:	4981                	li	s3,0
     ea2:	bf35                	j	dde <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
     ea4:	008b8913          	addi	s2,s7,8
     ea8:	4685                	li	a3,1
     eaa:	4629                	li	a2,10
     eac:	000bb583          	ld	a1,0(s7)
     eb0:	855a                	mv	a0,s6
     eb2:	e47ff0ef          	jal	cf8 <printint>
        i += 1;
     eb6:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
     eb8:	8bca                	mv	s7,s2
      state = 0;
     eba:	4981                	li	s3,0
        i += 1;
     ebc:	b70d                	j	dde <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     ebe:	06400793          	li	a5,100
     ec2:	02f60763          	beq	a2,a5,ef0 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
     ec6:	07500793          	li	a5,117
     eca:	06f60963          	beq	a2,a5,f3c <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
     ece:	07800793          	li	a5,120
     ed2:	faf61ee3          	bne	a2,a5,e8e <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
     ed6:	008b8913          	addi	s2,s7,8
     eda:	4681                	li	a3,0
     edc:	4641                	li	a2,16
     ede:	000bb583          	ld	a1,0(s7)
     ee2:	855a                	mv	a0,s6
     ee4:	e15ff0ef          	jal	cf8 <printint>
        i += 2;
     ee8:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
     eea:	8bca                	mv	s7,s2
      state = 0;
     eec:	4981                	li	s3,0
        i += 2;
     eee:	bdc5                	j	dde <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
     ef0:	008b8913          	addi	s2,s7,8
     ef4:	4685                	li	a3,1
     ef6:	4629                	li	a2,10
     ef8:	000bb583          	ld	a1,0(s7)
     efc:	855a                	mv	a0,s6
     efe:	dfbff0ef          	jal	cf8 <printint>
        i += 2;
     f02:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
     f04:	8bca                	mv	s7,s2
      state = 0;
     f06:	4981                	li	s3,0
        i += 2;
     f08:	bdd9                	j	dde <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
     f0a:	008b8913          	addi	s2,s7,8
     f0e:	4681                	li	a3,0
     f10:	4629                	li	a2,10
     f12:	000be583          	lwu	a1,0(s7)
     f16:	855a                	mv	a0,s6
     f18:	de1ff0ef          	jal	cf8 <printint>
     f1c:	8bca                	mv	s7,s2
      state = 0;
     f1e:	4981                	li	s3,0
     f20:	bd7d                	j	dde <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
     f22:	008b8913          	addi	s2,s7,8
     f26:	4681                	li	a3,0
     f28:	4629                	li	a2,10
     f2a:	000bb583          	ld	a1,0(s7)
     f2e:	855a                	mv	a0,s6
     f30:	dc9ff0ef          	jal	cf8 <printint>
        i += 1;
     f34:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
     f36:	8bca                	mv	s7,s2
      state = 0;
     f38:	4981                	li	s3,0
        i += 1;
     f3a:	b555                	j	dde <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
     f3c:	008b8913          	addi	s2,s7,8
     f40:	4681                	li	a3,0
     f42:	4629                	li	a2,10
     f44:	000bb583          	ld	a1,0(s7)
     f48:	855a                	mv	a0,s6
     f4a:	dafff0ef          	jal	cf8 <printint>
        i += 2;
     f4e:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
     f50:	8bca                	mv	s7,s2
      state = 0;
     f52:	4981                	li	s3,0
        i += 2;
     f54:	b569                	j	dde <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
     f56:	008b8913          	addi	s2,s7,8
     f5a:	4681                	li	a3,0
     f5c:	4641                	li	a2,16
     f5e:	000be583          	lwu	a1,0(s7)
     f62:	855a                	mv	a0,s6
     f64:	d95ff0ef          	jal	cf8 <printint>
     f68:	8bca                	mv	s7,s2
      state = 0;
     f6a:	4981                	li	s3,0
     f6c:	bd8d                	j	dde <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
     f6e:	008b8913          	addi	s2,s7,8
     f72:	4681                	li	a3,0
     f74:	4641                	li	a2,16
     f76:	000bb583          	ld	a1,0(s7)
     f7a:	855a                	mv	a0,s6
     f7c:	d7dff0ef          	jal	cf8 <printint>
        i += 1;
     f80:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
     f82:	8bca                	mv	s7,s2
      state = 0;
     f84:	4981                	li	s3,0
        i += 1;
     f86:	bda1                	j	dde <vprintf+0x4a>
     f88:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
     f8a:	008b8d13          	addi	s10,s7,8
     f8e:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
     f92:	03000593          	li	a1,48
     f96:	855a                	mv	a0,s6
     f98:	d43ff0ef          	jal	cda <putc>
  putc(fd, 'x');
     f9c:	07800593          	li	a1,120
     fa0:	855a                	mv	a0,s6
     fa2:	d39ff0ef          	jal	cda <putc>
     fa6:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     fa8:	00000b97          	auipc	s7,0x0
     fac:	5d8b8b93          	addi	s7,s7,1496 # 1580 <digits>
     fb0:	03c9d793          	srli	a5,s3,0x3c
     fb4:	97de                	add	a5,a5,s7
     fb6:	0007c583          	lbu	a1,0(a5)
     fba:	855a                	mv	a0,s6
     fbc:	d1fff0ef          	jal	cda <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     fc0:	0992                	slli	s3,s3,0x4
     fc2:	397d                	addiw	s2,s2,-1
     fc4:	fe0916e3          	bnez	s2,fb0 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
     fc8:	8bea                	mv	s7,s10
      state = 0;
     fca:	4981                	li	s3,0
     fcc:	6d02                	ld	s10,0(sp)
     fce:	bd01                	j	dde <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
     fd0:	008b8913          	addi	s2,s7,8
     fd4:	000bc583          	lbu	a1,0(s7)
     fd8:	855a                	mv	a0,s6
     fda:	d01ff0ef          	jal	cda <putc>
     fde:	8bca                	mv	s7,s2
      state = 0;
     fe0:	4981                	li	s3,0
     fe2:	bbf5                	j	dde <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
     fe4:	008b8993          	addi	s3,s7,8
     fe8:	000bb903          	ld	s2,0(s7)
     fec:	00090f63          	beqz	s2,100a <vprintf+0x276>
        for(; *s; s++)
     ff0:	00094583          	lbu	a1,0(s2)
     ff4:	c195                	beqz	a1,1018 <vprintf+0x284>
          putc(fd, *s);
     ff6:	855a                	mv	a0,s6
     ff8:	ce3ff0ef          	jal	cda <putc>
        for(; *s; s++)
     ffc:	0905                	addi	s2,s2,1
     ffe:	00094583          	lbu	a1,0(s2)
    1002:	f9f5                	bnez	a1,ff6 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
    1004:	8bce                	mv	s7,s3
      state = 0;
    1006:	4981                	li	s3,0
    1008:	bbd9                	j	dde <vprintf+0x4a>
          s = "(null)";
    100a:	00000917          	auipc	s2,0x0
    100e:	50e90913          	addi	s2,s2,1294 # 1518 <malloc+0x402>
        for(; *s; s++)
    1012:	02800593          	li	a1,40
    1016:	b7c5                	j	ff6 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
    1018:	8bce                	mv	s7,s3
      state = 0;
    101a:	4981                	li	s3,0
    101c:	b3c9                	j	dde <vprintf+0x4a>
    101e:	64a6                	ld	s1,72(sp)
    1020:	79e2                	ld	s3,56(sp)
    1022:	7a42                	ld	s4,48(sp)
    1024:	7aa2                	ld	s5,40(sp)
    1026:	7b02                	ld	s6,32(sp)
    1028:	6be2                	ld	s7,24(sp)
    102a:	6c42                	ld	s8,16(sp)
    102c:	6ca2                	ld	s9,8(sp)
    }
  }
}
    102e:	60e6                	ld	ra,88(sp)
    1030:	6446                	ld	s0,80(sp)
    1032:	6906                	ld	s2,64(sp)
    1034:	6125                	addi	sp,sp,96
    1036:	8082                	ret

0000000000001038 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    1038:	715d                	addi	sp,sp,-80
    103a:	ec06                	sd	ra,24(sp)
    103c:	e822                	sd	s0,16(sp)
    103e:	1000                	addi	s0,sp,32
    1040:	e010                	sd	a2,0(s0)
    1042:	e414                	sd	a3,8(s0)
    1044:	e818                	sd	a4,16(s0)
    1046:	ec1c                	sd	a5,24(s0)
    1048:	03043023          	sd	a6,32(s0)
    104c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    1050:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    1054:	8622                	mv	a2,s0
    1056:	d3fff0ef          	jal	d94 <vprintf>
}
    105a:	60e2                	ld	ra,24(sp)
    105c:	6442                	ld	s0,16(sp)
    105e:	6161                	addi	sp,sp,80
    1060:	8082                	ret

0000000000001062 <printf>:

void
printf(const char *fmt, ...)
{
    1062:	711d                	addi	sp,sp,-96
    1064:	ec06                	sd	ra,24(sp)
    1066:	e822                	sd	s0,16(sp)
    1068:	1000                	addi	s0,sp,32
    106a:	e40c                	sd	a1,8(s0)
    106c:	e810                	sd	a2,16(s0)
    106e:	ec14                	sd	a3,24(s0)
    1070:	f018                	sd	a4,32(s0)
    1072:	f41c                	sd	a5,40(s0)
    1074:	03043823          	sd	a6,48(s0)
    1078:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    107c:	00840613          	addi	a2,s0,8
    1080:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    1084:	85aa                	mv	a1,a0
    1086:	4505                	li	a0,1
    1088:	d0dff0ef          	jal	d94 <vprintf>
}
    108c:	60e2                	ld	ra,24(sp)
    108e:	6442                	ld	s0,16(sp)
    1090:	6125                	addi	sp,sp,96
    1092:	8082                	ret

0000000000001094 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1094:	1141                	addi	sp,sp,-16
    1096:	e422                	sd	s0,8(sp)
    1098:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    109a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    109e:	00001797          	auipc	a5,0x1
    10a2:	f727b783          	ld	a5,-142(a5) # 2010 <freep>
    10a6:	a02d                	j	10d0 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    10a8:	4618                	lw	a4,8(a2)
    10aa:	9f2d                	addw	a4,a4,a1
    10ac:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    10b0:	6398                	ld	a4,0(a5)
    10b2:	6310                	ld	a2,0(a4)
    10b4:	a83d                	j	10f2 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    10b6:	ff852703          	lw	a4,-8(a0)
    10ba:	9f31                	addw	a4,a4,a2
    10bc:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    10be:	ff053683          	ld	a3,-16(a0)
    10c2:	a091                	j	1106 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    10c4:	6398                	ld	a4,0(a5)
    10c6:	00e7e463          	bltu	a5,a4,10ce <free+0x3a>
    10ca:	00e6ea63          	bltu	a3,a4,10de <free+0x4a>
{
    10ce:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    10d0:	fed7fae3          	bgeu	a5,a3,10c4 <free+0x30>
    10d4:	6398                	ld	a4,0(a5)
    10d6:	00e6e463          	bltu	a3,a4,10de <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    10da:	fee7eae3          	bltu	a5,a4,10ce <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
    10de:	ff852583          	lw	a1,-8(a0)
    10e2:	6390                	ld	a2,0(a5)
    10e4:	02059813          	slli	a6,a1,0x20
    10e8:	01c85713          	srli	a4,a6,0x1c
    10ec:	9736                	add	a4,a4,a3
    10ee:	fae60de3          	beq	a2,a4,10a8 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    10f2:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    10f6:	4790                	lw	a2,8(a5)
    10f8:	02061593          	slli	a1,a2,0x20
    10fc:	01c5d713          	srli	a4,a1,0x1c
    1100:	973e                	add	a4,a4,a5
    1102:	fae68ae3          	beq	a3,a4,10b6 <free+0x22>
    p->s.ptr = bp->s.ptr;
    1106:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    1108:	00001717          	auipc	a4,0x1
    110c:	f0f73423          	sd	a5,-248(a4) # 2010 <freep>
}
    1110:	6422                	ld	s0,8(sp)
    1112:	0141                	addi	sp,sp,16
    1114:	8082                	ret

0000000000001116 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1116:	7139                	addi	sp,sp,-64
    1118:	fc06                	sd	ra,56(sp)
    111a:	f822                	sd	s0,48(sp)
    111c:	f426                	sd	s1,40(sp)
    111e:	ec4e                	sd	s3,24(sp)
    1120:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1122:	02051493          	slli	s1,a0,0x20
    1126:	9081                	srli	s1,s1,0x20
    1128:	04bd                	addi	s1,s1,15
    112a:	8091                	srli	s1,s1,0x4
    112c:	0014899b          	addiw	s3,s1,1
    1130:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    1132:	00001517          	auipc	a0,0x1
    1136:	ede53503          	ld	a0,-290(a0) # 2010 <freep>
    113a:	c915                	beqz	a0,116e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    113c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    113e:	4798                	lw	a4,8(a5)
    1140:	08977a63          	bgeu	a4,s1,11d4 <malloc+0xbe>
    1144:	f04a                	sd	s2,32(sp)
    1146:	e852                	sd	s4,16(sp)
    1148:	e456                	sd	s5,8(sp)
    114a:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    114c:	8a4e                	mv	s4,s3
    114e:	0009871b          	sext.w	a4,s3
    1152:	6685                	lui	a3,0x1
    1154:	00d77363          	bgeu	a4,a3,115a <malloc+0x44>
    1158:	6a05                	lui	s4,0x1
    115a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    115e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1162:	00001917          	auipc	s2,0x1
    1166:	eae90913          	addi	s2,s2,-338 # 2010 <freep>
  if(p == SBRK_ERROR)
    116a:	5afd                	li	s5,-1
    116c:	a081                	j	11ac <malloc+0x96>
    116e:	f04a                	sd	s2,32(sp)
    1170:	e852                	sd	s4,16(sp)
    1172:	e456                	sd	s5,8(sp)
    1174:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    1176:	00001797          	auipc	a5,0x1
    117a:	29278793          	addi	a5,a5,658 # 2408 <base>
    117e:	00001717          	auipc	a4,0x1
    1182:	e8f73923          	sd	a5,-366(a4) # 2010 <freep>
    1186:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    1188:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    118c:	b7c1                	j	114c <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
    118e:	6398                	ld	a4,0(a5)
    1190:	e118                	sd	a4,0(a0)
    1192:	a8a9                	j	11ec <malloc+0xd6>
  hp->s.size = nu;
    1194:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    1198:	0541                	addi	a0,a0,16
    119a:	efbff0ef          	jal	1094 <free>
  return freep;
    119e:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    11a2:	c12d                	beqz	a0,1204 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    11a4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    11a6:	4798                	lw	a4,8(a5)
    11a8:	02977263          	bgeu	a4,s1,11cc <malloc+0xb6>
    if(p == freep)
    11ac:	00093703          	ld	a4,0(s2)
    11b0:	853e                	mv	a0,a5
    11b2:	fef719e3          	bne	a4,a5,11a4 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
    11b6:	8552                	mv	a0,s4
    11b8:	987ff0ef          	jal	b3e <sbrk>
  if(p == SBRK_ERROR)
    11bc:	fd551ce3          	bne	a0,s5,1194 <malloc+0x7e>
        return 0;
    11c0:	4501                	li	a0,0
    11c2:	7902                	ld	s2,32(sp)
    11c4:	6a42                	ld	s4,16(sp)
    11c6:	6aa2                	ld	s5,8(sp)
    11c8:	6b02                	ld	s6,0(sp)
    11ca:	a03d                	j	11f8 <malloc+0xe2>
    11cc:	7902                	ld	s2,32(sp)
    11ce:	6a42                	ld	s4,16(sp)
    11d0:	6aa2                	ld	s5,8(sp)
    11d2:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    11d4:	fae48de3          	beq	s1,a4,118e <malloc+0x78>
        p->s.size -= nunits;
    11d8:	4137073b          	subw	a4,a4,s3
    11dc:	c798                	sw	a4,8(a5)
        p += p->s.size;
    11de:	02071693          	slli	a3,a4,0x20
    11e2:	01c6d713          	srli	a4,a3,0x1c
    11e6:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    11e8:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    11ec:	00001717          	auipc	a4,0x1
    11f0:	e2a73223          	sd	a0,-476(a4) # 2010 <freep>
      return (void*)(p + 1);
    11f4:	01078513          	addi	a0,a5,16
  }
}
    11f8:	70e2                	ld	ra,56(sp)
    11fa:	7442                	ld	s0,48(sp)
    11fc:	74a2                	ld	s1,40(sp)
    11fe:	69e2                	ld	s3,24(sp)
    1200:	6121                	addi	sp,sp,64
    1202:	8082                	ret
    1204:	7902                	ld	s2,32(sp)
    1206:	6a42                	ld	s4,16(sp)
    1208:	6aa2                	ld	s5,8(sp)
    120a:	6b02                	ld	s6,0(sp)
    120c:	b7f5                	j	11f8 <malloc+0xe2>
