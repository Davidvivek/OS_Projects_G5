
user/_sh:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <getcmd>:
  exit(0);
}

int
getcmd(char *buf, int nbuf)
{
       0:	1101                	addi	sp,sp,-32
       2:	ec06                	sd	ra,24(sp)
       4:	e822                	sd	s0,16(sp)
       6:	e426                	sd	s1,8(sp)
       8:	e04a                	sd	s2,0(sp)
       a:	1000                	addi	s0,sp,32
       c:	84aa                	mv	s1,a0
       e:	892e                	mv	s2,a1
  write(2, "$ ", 2);
      10:	4609                	li	a2,2
      12:	00001597          	auipc	a1,0x1
      16:	30e58593          	addi	a1,a1,782 # 1320 <malloc+0x102>
      1a:	4509                	li	a0,2
      1c:	507000ef          	jal	d22 <write>
  memset(buf, 0, nbuf);
      20:	864a                	mv	a2,s2
      22:	4581                	li	a1,0
      24:	8526                	mv	a0,s1
      26:	23b000ef          	jal	a60 <memset>
  gets(buf, nbuf);
      2a:	85ca                	mv	a1,s2
      2c:	8526                	mv	a0,s1
      2e:	279000ef          	jal	aa6 <gets>
  if(buf[0] == 0) // EOF
      32:	0004c503          	lbu	a0,0(s1)
      36:	00153513          	seqz	a0,a0
    return -1;
  return 0;
}
      3a:	40a00533          	neg	a0,a0
      3e:	60e2                	ld	ra,24(sp)
      40:	6442                	ld	s0,16(sp)
      42:	64a2                	ld	s1,8(sp)
      44:	6902                	ld	s2,0(sp)
      46:	6105                	addi	sp,sp,32
      48:	8082                	ret

000000000000004a <panic>:
  exit(0);
}

void
panic(char *s)
{
      4a:	1141                	addi	sp,sp,-16
      4c:	e406                	sd	ra,8(sp)
      4e:	e022                	sd	s0,0(sp)
      50:	0800                	addi	s0,sp,16
      52:	862a                	mv	a2,a0
  fprintf(2, "%s\n", s);
      54:	00001597          	auipc	a1,0x1
      58:	2dc58593          	addi	a1,a1,732 # 1330 <malloc+0x112>
      5c:	4509                	li	a0,2
      5e:	0e2010ef          	jal	1140 <fprintf>
  exit(1);
      62:	4505                	li	a0,1
      64:	49f000ef          	jal	d02 <exit>

0000000000000068 <fork1>:
}

int
fork1(void)
{
      68:	1141                	addi	sp,sp,-16
      6a:	e406                	sd	ra,8(sp)
      6c:	e022                	sd	s0,0(sp)
      6e:	0800                	addi	s0,sp,16
  int pid;

  pid = fork();
      70:	48b000ef          	jal	cfa <fork>
  if(pid == -1)
      74:	57fd                	li	a5,-1
      76:	00f50663          	beq	a0,a5,82 <fork1+0x1a>
    panic("fork");
  return pid;
}
      7a:	60a2                	ld	ra,8(sp)
      7c:	6402                	ld	s0,0(sp)
      7e:	0141                	addi	sp,sp,16
      80:	8082                	ret
    panic("fork");
      82:	00001517          	auipc	a0,0x1
      86:	2b650513          	addi	a0,a0,694 # 1338 <malloc+0x11a>
      8a:	fc1ff0ef          	jal	4a <panic>

000000000000008e <runcmd>:
{
      8e:	7159                	addi	sp,sp,-112
      90:	f486                	sd	ra,104(sp)
      92:	f0a2                	sd	s0,96(sp)
      94:	1880                	addi	s0,sp,112
  if(cmd == 0)
      96:	c11d                	beqz	a0,bc <runcmd+0x2e>
      98:	eca6                	sd	s1,88(sp)
      9a:	e8ca                	sd	s2,80(sp)
      9c:	84aa                	mv	s1,a0
  switch(cmd->type){
      9e:	4118                	lw	a4,0(a0)
      a0:	4795                	li	a5,5
      a2:	02e7e263          	bltu	a5,a4,c6 <runcmd+0x38>
      a6:	00056783          	lwu	a5,0(a0)
      aa:	078a                	slli	a5,a5,0x2
      ac:	00001717          	auipc	a4,0x1
      b0:	38c70713          	addi	a4,a4,908 # 1438 <malloc+0x21a>
      b4:	97ba                	add	a5,a5,a4
      b6:	439c                	lw	a5,0(a5)
      b8:	97ba                	add	a5,a5,a4
      ba:	8782                	jr	a5
      bc:	eca6                	sd	s1,88(sp)
      be:	e8ca                	sd	s2,80(sp)
    exit(1);
      c0:	4505                	li	a0,1
      c2:	441000ef          	jal	d02 <exit>
    panic("runcmd");
      c6:	00001517          	auipc	a0,0x1
      ca:	27a50513          	addi	a0,a0,634 # 1340 <malloc+0x122>
      ce:	f7dff0ef          	jal	4a <panic>
    if(ecmd->argv[0] == 0)
      d2:	6508                	ld	a0,8(a0)
      d4:	c905                	beqz	a0,104 <runcmd+0x76>
    exec(ecmd->argv[0], ecmd->argv);
      d6:	00848913          	addi	s2,s1,8
      da:	85ca                	mv	a1,s2
      dc:	45f000ef          	jal	d3a <exec>
    if(ecmd->argv[0][0] != '/') {
      e0:	6488                	ld	a0,8(s1)
      e2:	00054703          	lbu	a4,0(a0)
      e6:	02f00793          	li	a5,47
      ea:	02f71063          	bne	a4,a5,10a <runcmd+0x7c>
    fprintf(2, "exec %s failed\n", ecmd->argv[0]);
      ee:	6490                	ld	a2,8(s1)
      f0:	00001597          	auipc	a1,0x1
      f4:	25858593          	addi	a1,a1,600 # 1348 <malloc+0x12a>
      f8:	4509                	li	a0,2
      fa:	046010ef          	jal	1140 <fprintf>
  exit(0);
      fe:	4501                	li	a0,0
     100:	403000ef          	jal	d02 <exit>
      exit(1);
     104:	4505                	li	a0,1
     106:	3fd000ef          	jal	d02 <exit>
      buf[0] = '/';
     10a:	f8f40c23          	sb	a5,-104(s0)
      buf[1] = '\0';
     10e:	f8040ca3          	sb	zero,-103(s0)
      int len = strlen(ecmd->argv[0]);
     112:	125000ef          	jal	a36 <strlen>
     116:	2501                	sext.w	a0,a0
      if(len < (int)sizeof(buf) - 1) {
     118:	03e00793          	li	a5,62
     11c:	fca7c9e3          	blt	a5,a0,ee <runcmd+0x60>
        memmove(buf + 1, ecmd->argv[0], len + 1);
     120:	0015061b          	addiw	a2,a0,1
     124:	648c                	ld	a1,8(s1)
     126:	f9940513          	addi	a0,s0,-103
     12a:	26f000ef          	jal	b98 <memmove>
        exec(buf, ecmd->argv);
     12e:	85ca                	mv	a1,s2
     130:	f9840513          	addi	a0,s0,-104
     134:	407000ef          	jal	d3a <exec>
     138:	bf5d                	j	ee <runcmd+0x60>
    close(rcmd->fd);
     13a:	5148                	lw	a0,36(a0)
     13c:	3ef000ef          	jal	d2a <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     140:	508c                	lw	a1,32(s1)
     142:	6888                	ld	a0,16(s1)
     144:	3ff000ef          	jal	d42 <open>
     148:	00054563          	bltz	a0,152 <runcmd+0xc4>
    runcmd(rcmd->cmd);
     14c:	6488                	ld	a0,8(s1)
     14e:	f41ff0ef          	jal	8e <runcmd>
      fprintf(2, "open %s failed\n", rcmd->file);
     152:	6890                	ld	a2,16(s1)
     154:	00001597          	auipc	a1,0x1
     158:	20458593          	addi	a1,a1,516 # 1358 <malloc+0x13a>
     15c:	4509                	li	a0,2
     15e:	7e3000ef          	jal	1140 <fprintf>
      exit(1);
     162:	4505                	li	a0,1
     164:	39f000ef          	jal	d02 <exit>
    if(fork1() == 0)
     168:	f01ff0ef          	jal	68 <fork1>
     16c:	e501                	bnez	a0,174 <runcmd+0xe6>
      runcmd(lcmd->left);
     16e:	6488                	ld	a0,8(s1)
     170:	f1fff0ef          	jal	8e <runcmd>
    wait(0);
     174:	4501                	li	a0,0
     176:	395000ef          	jal	d0a <wait>
    runcmd(lcmd->right);
     17a:	6888                	ld	a0,16(s1)
     17c:	f13ff0ef          	jal	8e <runcmd>
    if(pipe(p) < 0)
     180:	fd840513          	addi	a0,s0,-40
     184:	38f000ef          	jal	d12 <pipe>
     188:	02054763          	bltz	a0,1b6 <runcmd+0x128>
    if(fork1() == 0){
     18c:	eddff0ef          	jal	68 <fork1>
     190:	e90d                	bnez	a0,1c2 <runcmd+0x134>
      close(1);
     192:	4505                	li	a0,1
     194:	397000ef          	jal	d2a <close>
      dup(p[1]);
     198:	fdc42503          	lw	a0,-36(s0)
     19c:	3df000ef          	jal	d7a <dup>
      close(p[0]);
     1a0:	fd842503          	lw	a0,-40(s0)
     1a4:	387000ef          	jal	d2a <close>
      close(p[1]);
     1a8:	fdc42503          	lw	a0,-36(s0)
     1ac:	37f000ef          	jal	d2a <close>
      runcmd(pcmd->left);
     1b0:	6488                	ld	a0,8(s1)
     1b2:	eddff0ef          	jal	8e <runcmd>
      panic("pipe");
     1b6:	00001517          	auipc	a0,0x1
     1ba:	1b250513          	addi	a0,a0,434 # 1368 <malloc+0x14a>
     1be:	e8dff0ef          	jal	4a <panic>
    if(fork1() == 0){
     1c2:	ea7ff0ef          	jal	68 <fork1>
     1c6:	e115                	bnez	a0,1ea <runcmd+0x15c>
      close(0);
     1c8:	363000ef          	jal	d2a <close>
      dup(p[0]);
     1cc:	fd842503          	lw	a0,-40(s0)
     1d0:	3ab000ef          	jal	d7a <dup>
      close(p[0]);
     1d4:	fd842503          	lw	a0,-40(s0)
     1d8:	353000ef          	jal	d2a <close>
      close(p[1]);
     1dc:	fdc42503          	lw	a0,-36(s0)
     1e0:	34b000ef          	jal	d2a <close>
      runcmd(pcmd->right);
     1e4:	6888                	ld	a0,16(s1)
     1e6:	ea9ff0ef          	jal	8e <runcmd>
    close(p[0]);
     1ea:	fd842503          	lw	a0,-40(s0)
     1ee:	33d000ef          	jal	d2a <close>
    close(p[1]);
     1f2:	fdc42503          	lw	a0,-36(s0)
     1f6:	335000ef          	jal	d2a <close>
    wait(0);
     1fa:	4501                	li	a0,0
     1fc:	30f000ef          	jal	d0a <wait>
    wait(0);
     200:	4501                	li	a0,0
     202:	309000ef          	jal	d0a <wait>
    break;
     206:	bde5                	j	fe <runcmd+0x70>
    if(fork1() == 0)
     208:	e61ff0ef          	jal	68 <fork1>
     20c:	ee0519e3          	bnez	a0,fe <runcmd+0x70>
      runcmd(bcmd->cmd);
     210:	6488                	ld	a0,8(s1)
     212:	e7dff0ef          	jal	8e <runcmd>

0000000000000216 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     216:	1101                	addi	sp,sp,-32
     218:	ec06                	sd	ra,24(sp)
     21a:	e822                	sd	s0,16(sp)
     21c:	e426                	sd	s1,8(sp)
     21e:	1000                	addi	s0,sp,32
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     220:	0a800513          	li	a0,168
     224:	7fb000ef          	jal	121e <malloc>
     228:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     22a:	0a800613          	li	a2,168
     22e:	4581                	li	a1,0
     230:	031000ef          	jal	a60 <memset>
  cmd->type = EXEC;
     234:	4785                	li	a5,1
     236:	c09c                	sw	a5,0(s1)
  return (struct cmd*)cmd;
}
     238:	8526                	mv	a0,s1
     23a:	60e2                	ld	ra,24(sp)
     23c:	6442                	ld	s0,16(sp)
     23e:	64a2                	ld	s1,8(sp)
     240:	6105                	addi	sp,sp,32
     242:	8082                	ret

0000000000000244 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     244:	7139                	addi	sp,sp,-64
     246:	fc06                	sd	ra,56(sp)
     248:	f822                	sd	s0,48(sp)
     24a:	f426                	sd	s1,40(sp)
     24c:	f04a                	sd	s2,32(sp)
     24e:	ec4e                	sd	s3,24(sp)
     250:	e852                	sd	s4,16(sp)
     252:	e456                	sd	s5,8(sp)
     254:	e05a                	sd	s6,0(sp)
     256:	0080                	addi	s0,sp,64
     258:	8b2a                	mv	s6,a0
     25a:	8aae                	mv	s5,a1
     25c:	8a32                	mv	s4,a2
     25e:	89b6                	mv	s3,a3
     260:	893a                	mv	s2,a4
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     262:	02800513          	li	a0,40
     266:	7b9000ef          	jal	121e <malloc>
     26a:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     26c:	02800613          	li	a2,40
     270:	4581                	li	a1,0
     272:	7ee000ef          	jal	a60 <memset>
  cmd->type = REDIR;
     276:	4789                	li	a5,2
     278:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     27a:	0164b423          	sd	s6,8(s1)
  cmd->file = file;
     27e:	0154b823          	sd	s5,16(s1)
  cmd->efile = efile;
     282:	0144bc23          	sd	s4,24(s1)
  cmd->mode = mode;
     286:	0334a023          	sw	s3,32(s1)
  cmd->fd = fd;
     28a:	0324a223          	sw	s2,36(s1)
  return (struct cmd*)cmd;
}
     28e:	8526                	mv	a0,s1
     290:	70e2                	ld	ra,56(sp)
     292:	7442                	ld	s0,48(sp)
     294:	74a2                	ld	s1,40(sp)
     296:	7902                	ld	s2,32(sp)
     298:	69e2                	ld	s3,24(sp)
     29a:	6a42                	ld	s4,16(sp)
     29c:	6aa2                	ld	s5,8(sp)
     29e:	6b02                	ld	s6,0(sp)
     2a0:	6121                	addi	sp,sp,64
     2a2:	8082                	ret

00000000000002a4 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     2a4:	7179                	addi	sp,sp,-48
     2a6:	f406                	sd	ra,40(sp)
     2a8:	f022                	sd	s0,32(sp)
     2aa:	ec26                	sd	s1,24(sp)
     2ac:	e84a                	sd	s2,16(sp)
     2ae:	e44e                	sd	s3,8(sp)
     2b0:	1800                	addi	s0,sp,48
     2b2:	89aa                	mv	s3,a0
     2b4:	892e                	mv	s2,a1
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     2b6:	4561                	li	a0,24
     2b8:	767000ef          	jal	121e <malloc>
     2bc:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     2be:	4661                	li	a2,24
     2c0:	4581                	li	a1,0
     2c2:	79e000ef          	jal	a60 <memset>
  cmd->type = PIPE;
     2c6:	478d                	li	a5,3
     2c8:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     2ca:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     2ce:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
     2d2:	8526                	mv	a0,s1
     2d4:	70a2                	ld	ra,40(sp)
     2d6:	7402                	ld	s0,32(sp)
     2d8:	64e2                	ld	s1,24(sp)
     2da:	6942                	ld	s2,16(sp)
     2dc:	69a2                	ld	s3,8(sp)
     2de:	6145                	addi	sp,sp,48
     2e0:	8082                	ret

00000000000002e2 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     2e2:	7179                	addi	sp,sp,-48
     2e4:	f406                	sd	ra,40(sp)
     2e6:	f022                	sd	s0,32(sp)
     2e8:	ec26                	sd	s1,24(sp)
     2ea:	e84a                	sd	s2,16(sp)
     2ec:	e44e                	sd	s3,8(sp)
     2ee:	1800                	addi	s0,sp,48
     2f0:	89aa                	mv	s3,a0
     2f2:	892e                	mv	s2,a1
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     2f4:	4561                	li	a0,24
     2f6:	729000ef          	jal	121e <malloc>
     2fa:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     2fc:	4661                	li	a2,24
     2fe:	4581                	li	a1,0
     300:	760000ef          	jal	a60 <memset>
  cmd->type = LIST;
     304:	4791                	li	a5,4
     306:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     308:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     30c:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
     310:	8526                	mv	a0,s1
     312:	70a2                	ld	ra,40(sp)
     314:	7402                	ld	s0,32(sp)
     316:	64e2                	ld	s1,24(sp)
     318:	6942                	ld	s2,16(sp)
     31a:	69a2                	ld	s3,8(sp)
     31c:	6145                	addi	sp,sp,48
     31e:	8082                	ret

0000000000000320 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     320:	1101                	addi	sp,sp,-32
     322:	ec06                	sd	ra,24(sp)
     324:	e822                	sd	s0,16(sp)
     326:	e426                	sd	s1,8(sp)
     328:	e04a                	sd	s2,0(sp)
     32a:	1000                	addi	s0,sp,32
     32c:	892a                	mv	s2,a0
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     32e:	4541                	li	a0,16
     330:	6ef000ef          	jal	121e <malloc>
     334:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     336:	4641                	li	a2,16
     338:	4581                	li	a1,0
     33a:	726000ef          	jal	a60 <memset>
  cmd->type = BACK;
     33e:	4795                	li	a5,5
     340:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     342:	0124b423          	sd	s2,8(s1)
  return (struct cmd*)cmd;
}
     346:	8526                	mv	a0,s1
     348:	60e2                	ld	ra,24(sp)
     34a:	6442                	ld	s0,16(sp)
     34c:	64a2                	ld	s1,8(sp)
     34e:	6902                	ld	s2,0(sp)
     350:	6105                	addi	sp,sp,32
     352:	8082                	ret

0000000000000354 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     354:	7139                	addi	sp,sp,-64
     356:	fc06                	sd	ra,56(sp)
     358:	f822                	sd	s0,48(sp)
     35a:	f426                	sd	s1,40(sp)
     35c:	f04a                	sd	s2,32(sp)
     35e:	ec4e                	sd	s3,24(sp)
     360:	e852                	sd	s4,16(sp)
     362:	e456                	sd	s5,8(sp)
     364:	e05a                	sd	s6,0(sp)
     366:	0080                	addi	s0,sp,64
     368:	8a2a                	mv	s4,a0
     36a:	892e                	mv	s2,a1
     36c:	8ab2                	mv	s5,a2
     36e:	8b36                	mv	s6,a3
  char *s;
  int ret;

  s = *ps;
     370:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     372:	00002997          	auipc	s3,0x2
     376:	c9698993          	addi	s3,s3,-874 # 2008 <whitespace>
     37a:	00b4fc63          	bgeu	s1,a1,392 <gettoken+0x3e>
     37e:	0004c583          	lbu	a1,0(s1)
     382:	854e                	mv	a0,s3
     384:	6fe000ef          	jal	a82 <strchr>
     388:	c509                	beqz	a0,392 <gettoken+0x3e>
    s++;
     38a:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     38c:	fe9919e3          	bne	s2,s1,37e <gettoken+0x2a>
     390:	84ca                	mv	s1,s2
  if(q)
     392:	000a8463          	beqz	s5,39a <gettoken+0x46>
    *q = s;
     396:	009ab023          	sd	s1,0(s5)
  ret = *s;
     39a:	0004c783          	lbu	a5,0(s1)
     39e:	00078a9b          	sext.w	s5,a5
  switch(*s){
     3a2:	03c00713          	li	a4,60
     3a6:	06f76463          	bltu	a4,a5,40e <gettoken+0xba>
     3aa:	03a00713          	li	a4,58
     3ae:	00f76e63          	bltu	a4,a5,3ca <gettoken+0x76>
     3b2:	cf89                	beqz	a5,3cc <gettoken+0x78>
     3b4:	02600713          	li	a4,38
     3b8:	00e78963          	beq	a5,a4,3ca <gettoken+0x76>
     3bc:	fd87879b          	addiw	a5,a5,-40
     3c0:	0ff7f793          	zext.b	a5,a5
     3c4:	4705                	li	a4,1
     3c6:	06f76b63          	bltu	a4,a5,43c <gettoken+0xe8>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     3ca:	0485                	addi	s1,s1,1
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     3cc:	000b0463          	beqz	s6,3d4 <gettoken+0x80>
    *eq = s;
     3d0:	009b3023          	sd	s1,0(s6)

  while(s < es && strchr(whitespace, *s))
     3d4:	00002997          	auipc	s3,0x2
     3d8:	c3498993          	addi	s3,s3,-972 # 2008 <whitespace>
     3dc:	0124fc63          	bgeu	s1,s2,3f4 <gettoken+0xa0>
     3e0:	0004c583          	lbu	a1,0(s1)
     3e4:	854e                	mv	a0,s3
     3e6:	69c000ef          	jal	a82 <strchr>
     3ea:	c509                	beqz	a0,3f4 <gettoken+0xa0>
    s++;
     3ec:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     3ee:	fe9919e3          	bne	s2,s1,3e0 <gettoken+0x8c>
     3f2:	84ca                	mv	s1,s2
  *ps = s;
     3f4:	009a3023          	sd	s1,0(s4)
  return ret;
}
     3f8:	8556                	mv	a0,s5
     3fa:	70e2                	ld	ra,56(sp)
     3fc:	7442                	ld	s0,48(sp)
     3fe:	74a2                	ld	s1,40(sp)
     400:	7902                	ld	s2,32(sp)
     402:	69e2                	ld	s3,24(sp)
     404:	6a42                	ld	s4,16(sp)
     406:	6aa2                	ld	s5,8(sp)
     408:	6b02                	ld	s6,0(sp)
     40a:	6121                	addi	sp,sp,64
     40c:	8082                	ret
  switch(*s){
     40e:	03e00713          	li	a4,62
     412:	02e79163          	bne	a5,a4,434 <gettoken+0xe0>
    s++;
     416:	00148693          	addi	a3,s1,1
    if(*s == '>'){
     41a:	0014c703          	lbu	a4,1(s1)
     41e:	03e00793          	li	a5,62
      s++;
     422:	0489                	addi	s1,s1,2
      ret = '+';
     424:	02b00a93          	li	s5,43
    if(*s == '>'){
     428:	faf702e3          	beq	a4,a5,3cc <gettoken+0x78>
    s++;
     42c:	84b6                	mv	s1,a3
  ret = *s;
     42e:	03e00a93          	li	s5,62
     432:	bf69                	j	3cc <gettoken+0x78>
  switch(*s){
     434:	07c00713          	li	a4,124
     438:	f8e789e3          	beq	a5,a4,3ca <gettoken+0x76>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     43c:	00002997          	auipc	s3,0x2
     440:	bcc98993          	addi	s3,s3,-1076 # 2008 <whitespace>
     444:	00002a97          	auipc	s5,0x2
     448:	bbca8a93          	addi	s5,s5,-1092 # 2000 <symbols>
     44c:	0324fd63          	bgeu	s1,s2,486 <gettoken+0x132>
     450:	0004c583          	lbu	a1,0(s1)
     454:	854e                	mv	a0,s3
     456:	62c000ef          	jal	a82 <strchr>
     45a:	e11d                	bnez	a0,480 <gettoken+0x12c>
     45c:	0004c583          	lbu	a1,0(s1)
     460:	8556                	mv	a0,s5
     462:	620000ef          	jal	a82 <strchr>
     466:	e911                	bnez	a0,47a <gettoken+0x126>
      s++;
     468:	0485                	addi	s1,s1,1
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     46a:	fe9913e3          	bne	s2,s1,450 <gettoken+0xfc>
  if(eq)
     46e:	84ca                	mv	s1,s2
    ret = 'a';
     470:	06100a93          	li	s5,97
  if(eq)
     474:	f40b1ee3          	bnez	s6,3d0 <gettoken+0x7c>
     478:	bfb5                	j	3f4 <gettoken+0xa0>
    ret = 'a';
     47a:	06100a93          	li	s5,97
     47e:	b7b9                	j	3cc <gettoken+0x78>
     480:	06100a93          	li	s5,97
     484:	b7a1                	j	3cc <gettoken+0x78>
     486:	06100a93          	li	s5,97
  if(eq)
     48a:	f40b13e3          	bnez	s6,3d0 <gettoken+0x7c>
     48e:	b79d                	j	3f4 <gettoken+0xa0>

0000000000000490 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     490:	7139                	addi	sp,sp,-64
     492:	fc06                	sd	ra,56(sp)
     494:	f822                	sd	s0,48(sp)
     496:	f426                	sd	s1,40(sp)
     498:	f04a                	sd	s2,32(sp)
     49a:	ec4e                	sd	s3,24(sp)
     49c:	e852                	sd	s4,16(sp)
     49e:	e456                	sd	s5,8(sp)
     4a0:	0080                	addi	s0,sp,64
     4a2:	8a2a                	mv	s4,a0
     4a4:	892e                	mv	s2,a1
     4a6:	8ab2                	mv	s5,a2
  char *s;

  s = *ps;
     4a8:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     4aa:	00002997          	auipc	s3,0x2
     4ae:	b5e98993          	addi	s3,s3,-1186 # 2008 <whitespace>
     4b2:	00b4fc63          	bgeu	s1,a1,4ca <peek+0x3a>
     4b6:	0004c583          	lbu	a1,0(s1)
     4ba:	854e                	mv	a0,s3
     4bc:	5c6000ef          	jal	a82 <strchr>
     4c0:	c509                	beqz	a0,4ca <peek+0x3a>
    s++;
     4c2:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     4c4:	fe9919e3          	bne	s2,s1,4b6 <peek+0x26>
     4c8:	84ca                	mv	s1,s2
  *ps = s;
     4ca:	009a3023          	sd	s1,0(s4)
  return *s && strchr(toks, *s);
     4ce:	0004c583          	lbu	a1,0(s1)
     4d2:	4501                	li	a0,0
     4d4:	e991                	bnez	a1,4e8 <peek+0x58>
}
     4d6:	70e2                	ld	ra,56(sp)
     4d8:	7442                	ld	s0,48(sp)
     4da:	74a2                	ld	s1,40(sp)
     4dc:	7902                	ld	s2,32(sp)
     4de:	69e2                	ld	s3,24(sp)
     4e0:	6a42                	ld	s4,16(sp)
     4e2:	6aa2                	ld	s5,8(sp)
     4e4:	6121                	addi	sp,sp,64
     4e6:	8082                	ret
  return *s && strchr(toks, *s);
     4e8:	8556                	mv	a0,s5
     4ea:	598000ef          	jal	a82 <strchr>
     4ee:	00a03533          	snez	a0,a0
     4f2:	b7d5                	j	4d6 <peek+0x46>

00000000000004f4 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     4f4:	711d                	addi	sp,sp,-96
     4f6:	ec86                	sd	ra,88(sp)
     4f8:	e8a2                	sd	s0,80(sp)
     4fa:	e4a6                	sd	s1,72(sp)
     4fc:	e0ca                	sd	s2,64(sp)
     4fe:	fc4e                	sd	s3,56(sp)
     500:	f852                	sd	s4,48(sp)
     502:	f456                	sd	s5,40(sp)
     504:	f05a                	sd	s6,32(sp)
     506:	ec5e                	sd	s7,24(sp)
     508:	1080                	addi	s0,sp,96
     50a:	8a2a                	mv	s4,a0
     50c:	89ae                	mv	s3,a1
     50e:	8932                	mv	s2,a2
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     510:	00001a97          	auipc	s5,0x1
     514:	e80a8a93          	addi	s5,s5,-384 # 1390 <malloc+0x172>
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
     518:	06100b13          	li	s6,97
      panic("missing file for redirection");
    switch(tok){
     51c:	03c00b93          	li	s7,60
  while(peek(ps, es, "<>")){
     520:	a00d                	j	542 <parseredirs+0x4e>
      panic("missing file for redirection");
     522:	00001517          	auipc	a0,0x1
     526:	e4e50513          	addi	a0,a0,-434 # 1370 <malloc+0x152>
     52a:	b21ff0ef          	jal	4a <panic>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     52e:	4701                	li	a4,0
     530:	4681                	li	a3,0
     532:	fa043603          	ld	a2,-96(s0)
     536:	fa843583          	ld	a1,-88(s0)
     53a:	8552                	mv	a0,s4
     53c:	d09ff0ef          	jal	244 <redircmd>
     540:	8a2a                	mv	s4,a0
  while(peek(ps, es, "<>")){
     542:	8656                	mv	a2,s5
     544:	85ca                	mv	a1,s2
     546:	854e                	mv	a0,s3
     548:	f49ff0ef          	jal	490 <peek>
     54c:	c525                	beqz	a0,5b4 <parseredirs+0xc0>
    tok = gettoken(ps, es, 0, 0);
     54e:	4681                	li	a3,0
     550:	4601                	li	a2,0
     552:	85ca                	mv	a1,s2
     554:	854e                	mv	a0,s3
     556:	dffff0ef          	jal	354 <gettoken>
     55a:	84aa                	mv	s1,a0
    if(gettoken(ps, es, &q, &eq) != 'a')
     55c:	fa040693          	addi	a3,s0,-96
     560:	fa840613          	addi	a2,s0,-88
     564:	85ca                	mv	a1,s2
     566:	854e                	mv	a0,s3
     568:	dedff0ef          	jal	354 <gettoken>
     56c:	fb651be3          	bne	a0,s6,522 <parseredirs+0x2e>
    switch(tok){
     570:	fb748fe3          	beq	s1,s7,52e <parseredirs+0x3a>
     574:	03e00793          	li	a5,62
     578:	02f48263          	beq	s1,a5,59c <parseredirs+0xa8>
     57c:	02b00793          	li	a5,43
     580:	fcf491e3          	bne	s1,a5,542 <parseredirs+0x4e>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     584:	4705                	li	a4,1
     586:	20100693          	li	a3,513
     58a:	fa043603          	ld	a2,-96(s0)
     58e:	fa843583          	ld	a1,-88(s0)
     592:	8552                	mv	a0,s4
     594:	cb1ff0ef          	jal	244 <redircmd>
     598:	8a2a                	mv	s4,a0
      break;
     59a:	b765                	j	542 <parseredirs+0x4e>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
     59c:	4705                	li	a4,1
     59e:	60100693          	li	a3,1537
     5a2:	fa043603          	ld	a2,-96(s0)
     5a6:	fa843583          	ld	a1,-88(s0)
     5aa:	8552                	mv	a0,s4
     5ac:	c99ff0ef          	jal	244 <redircmd>
     5b0:	8a2a                	mv	s4,a0
      break;
     5b2:	bf41                	j	542 <parseredirs+0x4e>
    }
  }
  return cmd;
}
     5b4:	8552                	mv	a0,s4
     5b6:	60e6                	ld	ra,88(sp)
     5b8:	6446                	ld	s0,80(sp)
     5ba:	64a6                	ld	s1,72(sp)
     5bc:	6906                	ld	s2,64(sp)
     5be:	79e2                	ld	s3,56(sp)
     5c0:	7a42                	ld	s4,48(sp)
     5c2:	7aa2                	ld	s5,40(sp)
     5c4:	7b02                	ld	s6,32(sp)
     5c6:	6be2                	ld	s7,24(sp)
     5c8:	6125                	addi	sp,sp,96
     5ca:	8082                	ret

00000000000005cc <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     5cc:	7159                	addi	sp,sp,-112
     5ce:	f486                	sd	ra,104(sp)
     5d0:	f0a2                	sd	s0,96(sp)
     5d2:	eca6                	sd	s1,88(sp)
     5d4:	e0d2                	sd	s4,64(sp)
     5d6:	fc56                	sd	s5,56(sp)
     5d8:	1880                	addi	s0,sp,112
     5da:	8a2a                	mv	s4,a0
     5dc:	8aae                	mv	s5,a1
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     5de:	00001617          	auipc	a2,0x1
     5e2:	dba60613          	addi	a2,a2,-582 # 1398 <malloc+0x17a>
     5e6:	eabff0ef          	jal	490 <peek>
     5ea:	e915                	bnez	a0,61e <parseexec+0x52>
     5ec:	e8ca                	sd	s2,80(sp)
     5ee:	e4ce                	sd	s3,72(sp)
     5f0:	f85a                	sd	s6,48(sp)
     5f2:	f45e                	sd	s7,40(sp)
     5f4:	f062                	sd	s8,32(sp)
     5f6:	ec66                	sd	s9,24(sp)
     5f8:	89aa                	mv	s3,a0
    return parseblock(ps, es);

  ret = execcmd();
     5fa:	c1dff0ef          	jal	216 <execcmd>
     5fe:	8c2a                	mv	s8,a0
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     600:	8656                	mv	a2,s5
     602:	85d2                	mv	a1,s4
     604:	ef1ff0ef          	jal	4f4 <parseredirs>
     608:	84aa                	mv	s1,a0
  while(!peek(ps, es, "|)&;")){
     60a:	008c0913          	addi	s2,s8,8
     60e:	00001b17          	auipc	s6,0x1
     612:	daab0b13          	addi	s6,s6,-598 # 13b8 <malloc+0x19a>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
    if(tok != 'a')
     616:	06100c93          	li	s9,97
      panic("syntax");
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
     61a:	4ba9                	li	s7,10
  while(!peek(ps, es, "|)&;")){
     61c:	a815                	j	650 <parseexec+0x84>
    return parseblock(ps, es);
     61e:	85d6                	mv	a1,s5
     620:	8552                	mv	a0,s4
     622:	170000ef          	jal	792 <parseblock>
     626:	84aa                	mv	s1,a0
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     628:	8526                	mv	a0,s1
     62a:	70a6                	ld	ra,104(sp)
     62c:	7406                	ld	s0,96(sp)
     62e:	64e6                	ld	s1,88(sp)
     630:	6a06                	ld	s4,64(sp)
     632:	7ae2                	ld	s5,56(sp)
     634:	6165                	addi	sp,sp,112
     636:	8082                	ret
      panic("syntax");
     638:	00001517          	auipc	a0,0x1
     63c:	d6850513          	addi	a0,a0,-664 # 13a0 <malloc+0x182>
     640:	a0bff0ef          	jal	4a <panic>
    ret = parseredirs(ret, ps, es);
     644:	8656                	mv	a2,s5
     646:	85d2                	mv	a1,s4
     648:	8526                	mv	a0,s1
     64a:	eabff0ef          	jal	4f4 <parseredirs>
     64e:	84aa                	mv	s1,a0
  while(!peek(ps, es, "|)&;")){
     650:	865a                	mv	a2,s6
     652:	85d6                	mv	a1,s5
     654:	8552                	mv	a0,s4
     656:	e3bff0ef          	jal	490 <peek>
     65a:	ed15                	bnez	a0,696 <parseexec+0xca>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     65c:	f9040693          	addi	a3,s0,-112
     660:	f9840613          	addi	a2,s0,-104
     664:	85d6                	mv	a1,s5
     666:	8552                	mv	a0,s4
     668:	cedff0ef          	jal	354 <gettoken>
     66c:	c50d                	beqz	a0,696 <parseexec+0xca>
    if(tok != 'a')
     66e:	fd9515e3          	bne	a0,s9,638 <parseexec+0x6c>
    cmd->argv[argc] = q;
     672:	f9843783          	ld	a5,-104(s0)
     676:	00f93023          	sd	a5,0(s2)
    cmd->eargv[argc] = eq;
     67a:	f9043783          	ld	a5,-112(s0)
     67e:	04f93823          	sd	a5,80(s2)
    argc++;
     682:	2985                	addiw	s3,s3,1
    if(argc >= MAXARGS)
     684:	0921                	addi	s2,s2,8
     686:	fb799fe3          	bne	s3,s7,644 <parseexec+0x78>
      panic("too many args");
     68a:	00001517          	auipc	a0,0x1
     68e:	d1e50513          	addi	a0,a0,-738 # 13a8 <malloc+0x18a>
     692:	9b9ff0ef          	jal	4a <panic>
  cmd->argv[argc] = 0;
     696:	098e                	slli	s3,s3,0x3
     698:	9c4e                	add	s8,s8,s3
     69a:	000c3423          	sd	zero,8(s8)
  cmd->eargv[argc] = 0;
     69e:	040c3c23          	sd	zero,88(s8)
     6a2:	6946                	ld	s2,80(sp)
     6a4:	69a6                	ld	s3,72(sp)
     6a6:	7b42                	ld	s6,48(sp)
     6a8:	7ba2                	ld	s7,40(sp)
     6aa:	7c02                	ld	s8,32(sp)
     6ac:	6ce2                	ld	s9,24(sp)
  return ret;
     6ae:	bfad                	j	628 <parseexec+0x5c>

00000000000006b0 <parsepipe>:
{
     6b0:	7179                	addi	sp,sp,-48
     6b2:	f406                	sd	ra,40(sp)
     6b4:	f022                	sd	s0,32(sp)
     6b6:	ec26                	sd	s1,24(sp)
     6b8:	e84a                	sd	s2,16(sp)
     6ba:	e44e                	sd	s3,8(sp)
     6bc:	1800                	addi	s0,sp,48
     6be:	892a                	mv	s2,a0
     6c0:	89ae                	mv	s3,a1
  cmd = parseexec(ps, es);
     6c2:	f0bff0ef          	jal	5cc <parseexec>
     6c6:	84aa                	mv	s1,a0
  if(peek(ps, es, "|")){
     6c8:	00001617          	auipc	a2,0x1
     6cc:	cf860613          	addi	a2,a2,-776 # 13c0 <malloc+0x1a2>
     6d0:	85ce                	mv	a1,s3
     6d2:	854a                	mv	a0,s2
     6d4:	dbdff0ef          	jal	490 <peek>
     6d8:	e909                	bnez	a0,6ea <parsepipe+0x3a>
}
     6da:	8526                	mv	a0,s1
     6dc:	70a2                	ld	ra,40(sp)
     6de:	7402                	ld	s0,32(sp)
     6e0:	64e2                	ld	s1,24(sp)
     6e2:	6942                	ld	s2,16(sp)
     6e4:	69a2                	ld	s3,8(sp)
     6e6:	6145                	addi	sp,sp,48
     6e8:	8082                	ret
    gettoken(ps, es, 0, 0);
     6ea:	4681                	li	a3,0
     6ec:	4601                	li	a2,0
     6ee:	85ce                	mv	a1,s3
     6f0:	854a                	mv	a0,s2
     6f2:	c63ff0ef          	jal	354 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     6f6:	85ce                	mv	a1,s3
     6f8:	854a                	mv	a0,s2
     6fa:	fb7ff0ef          	jal	6b0 <parsepipe>
     6fe:	85aa                	mv	a1,a0
     700:	8526                	mv	a0,s1
     702:	ba3ff0ef          	jal	2a4 <pipecmd>
     706:	84aa                	mv	s1,a0
  return cmd;
     708:	bfc9                	j	6da <parsepipe+0x2a>

000000000000070a <parseline>:
{
     70a:	7179                	addi	sp,sp,-48
     70c:	f406                	sd	ra,40(sp)
     70e:	f022                	sd	s0,32(sp)
     710:	ec26                	sd	s1,24(sp)
     712:	e84a                	sd	s2,16(sp)
     714:	e44e                	sd	s3,8(sp)
     716:	e052                	sd	s4,0(sp)
     718:	1800                	addi	s0,sp,48
     71a:	892a                	mv	s2,a0
     71c:	89ae                	mv	s3,a1
  cmd = parsepipe(ps, es);
     71e:	f93ff0ef          	jal	6b0 <parsepipe>
     722:	84aa                	mv	s1,a0
  while(peek(ps, es, "&")){
     724:	00001a17          	auipc	s4,0x1
     728:	ca4a0a13          	addi	s4,s4,-860 # 13c8 <malloc+0x1aa>
     72c:	a819                	j	742 <parseline+0x38>
    gettoken(ps, es, 0, 0);
     72e:	4681                	li	a3,0
     730:	4601                	li	a2,0
     732:	85ce                	mv	a1,s3
     734:	854a                	mv	a0,s2
     736:	c1fff0ef          	jal	354 <gettoken>
    cmd = backcmd(cmd);
     73a:	8526                	mv	a0,s1
     73c:	be5ff0ef          	jal	320 <backcmd>
     740:	84aa                	mv	s1,a0
  while(peek(ps, es, "&")){
     742:	8652                	mv	a2,s4
     744:	85ce                	mv	a1,s3
     746:	854a                	mv	a0,s2
     748:	d49ff0ef          	jal	490 <peek>
     74c:	f16d                	bnez	a0,72e <parseline+0x24>
  if(peek(ps, es, ";")){
     74e:	00001617          	auipc	a2,0x1
     752:	c8260613          	addi	a2,a2,-894 # 13d0 <malloc+0x1b2>
     756:	85ce                	mv	a1,s3
     758:	854a                	mv	a0,s2
     75a:	d37ff0ef          	jal	490 <peek>
     75e:	e911                	bnez	a0,772 <parseline+0x68>
}
     760:	8526                	mv	a0,s1
     762:	70a2                	ld	ra,40(sp)
     764:	7402                	ld	s0,32(sp)
     766:	64e2                	ld	s1,24(sp)
     768:	6942                	ld	s2,16(sp)
     76a:	69a2                	ld	s3,8(sp)
     76c:	6a02                	ld	s4,0(sp)
     76e:	6145                	addi	sp,sp,48
     770:	8082                	ret
    gettoken(ps, es, 0, 0);
     772:	4681                	li	a3,0
     774:	4601                	li	a2,0
     776:	85ce                	mv	a1,s3
     778:	854a                	mv	a0,s2
     77a:	bdbff0ef          	jal	354 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     77e:	85ce                	mv	a1,s3
     780:	854a                	mv	a0,s2
     782:	f89ff0ef          	jal	70a <parseline>
     786:	85aa                	mv	a1,a0
     788:	8526                	mv	a0,s1
     78a:	b59ff0ef          	jal	2e2 <listcmd>
     78e:	84aa                	mv	s1,a0
  return cmd;
     790:	bfc1                	j	760 <parseline+0x56>

0000000000000792 <parseblock>:
{
     792:	7179                	addi	sp,sp,-48
     794:	f406                	sd	ra,40(sp)
     796:	f022                	sd	s0,32(sp)
     798:	ec26                	sd	s1,24(sp)
     79a:	e84a                	sd	s2,16(sp)
     79c:	e44e                	sd	s3,8(sp)
     79e:	1800                	addi	s0,sp,48
     7a0:	84aa                	mv	s1,a0
     7a2:	892e                	mv	s2,a1
  if(!peek(ps, es, "("))
     7a4:	00001617          	auipc	a2,0x1
     7a8:	bf460613          	addi	a2,a2,-1036 # 1398 <malloc+0x17a>
     7ac:	ce5ff0ef          	jal	490 <peek>
     7b0:	c539                	beqz	a0,7fe <parseblock+0x6c>
  gettoken(ps, es, 0, 0);
     7b2:	4681                	li	a3,0
     7b4:	4601                	li	a2,0
     7b6:	85ca                	mv	a1,s2
     7b8:	8526                	mv	a0,s1
     7ba:	b9bff0ef          	jal	354 <gettoken>
  cmd = parseline(ps, es);
     7be:	85ca                	mv	a1,s2
     7c0:	8526                	mv	a0,s1
     7c2:	f49ff0ef          	jal	70a <parseline>
     7c6:	89aa                	mv	s3,a0
  if(!peek(ps, es, ")"))
     7c8:	00001617          	auipc	a2,0x1
     7cc:	c2060613          	addi	a2,a2,-992 # 13e8 <malloc+0x1ca>
     7d0:	85ca                	mv	a1,s2
     7d2:	8526                	mv	a0,s1
     7d4:	cbdff0ef          	jal	490 <peek>
     7d8:	c90d                	beqz	a0,80a <parseblock+0x78>
  gettoken(ps, es, 0, 0);
     7da:	4681                	li	a3,0
     7dc:	4601                	li	a2,0
     7de:	85ca                	mv	a1,s2
     7e0:	8526                	mv	a0,s1
     7e2:	b73ff0ef          	jal	354 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     7e6:	864a                	mv	a2,s2
     7e8:	85a6                	mv	a1,s1
     7ea:	854e                	mv	a0,s3
     7ec:	d09ff0ef          	jal	4f4 <parseredirs>
}
     7f0:	70a2                	ld	ra,40(sp)
     7f2:	7402                	ld	s0,32(sp)
     7f4:	64e2                	ld	s1,24(sp)
     7f6:	6942                	ld	s2,16(sp)
     7f8:	69a2                	ld	s3,8(sp)
     7fa:	6145                	addi	sp,sp,48
     7fc:	8082                	ret
    panic("parseblock");
     7fe:	00001517          	auipc	a0,0x1
     802:	bda50513          	addi	a0,a0,-1062 # 13d8 <malloc+0x1ba>
     806:	845ff0ef          	jal	4a <panic>
    panic("syntax - missing )");
     80a:	00001517          	auipc	a0,0x1
     80e:	be650513          	addi	a0,a0,-1050 # 13f0 <malloc+0x1d2>
     812:	839ff0ef          	jal	4a <panic>

0000000000000816 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     816:	1101                	addi	sp,sp,-32
     818:	ec06                	sd	ra,24(sp)
     81a:	e822                	sd	s0,16(sp)
     81c:	e426                	sd	s1,8(sp)
     81e:	1000                	addi	s0,sp,32
     820:	84aa                	mv	s1,a0
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     822:	c131                	beqz	a0,866 <nulterminate+0x50>
    return 0;

  switch(cmd->type){
     824:	4118                	lw	a4,0(a0)
     826:	4795                	li	a5,5
     828:	02e7ef63          	bltu	a5,a4,866 <nulterminate+0x50>
     82c:	00056783          	lwu	a5,0(a0)
     830:	078a                	slli	a5,a5,0x2
     832:	00001717          	auipc	a4,0x1
     836:	c1e70713          	addi	a4,a4,-994 # 1450 <malloc+0x232>
     83a:	97ba                	add	a5,a5,a4
     83c:	439c                	lw	a5,0(a5)
     83e:	97ba                	add	a5,a5,a4
     840:	8782                	jr	a5
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     842:	651c                	ld	a5,8(a0)
     844:	c38d                	beqz	a5,866 <nulterminate+0x50>
     846:	01050793          	addi	a5,a0,16
      *ecmd->eargv[i] = 0;
     84a:	67b8                	ld	a4,72(a5)
     84c:	00070023          	sb	zero,0(a4)
    for(i=0; ecmd->argv[i]; i++)
     850:	07a1                	addi	a5,a5,8
     852:	ff87b703          	ld	a4,-8(a5)
     856:	fb75                	bnez	a4,84a <nulterminate+0x34>
     858:	a039                	j	866 <nulterminate+0x50>
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
     85a:	6508                	ld	a0,8(a0)
     85c:	fbbff0ef          	jal	816 <nulterminate>
    *rcmd->efile = 0;
     860:	6c9c                	ld	a5,24(s1)
     862:	00078023          	sb	zero,0(a5)
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     866:	8526                	mv	a0,s1
     868:	60e2                	ld	ra,24(sp)
     86a:	6442                	ld	s0,16(sp)
     86c:	64a2                	ld	s1,8(sp)
     86e:	6105                	addi	sp,sp,32
     870:	8082                	ret
    nulterminate(pcmd->left);
     872:	6508                	ld	a0,8(a0)
     874:	fa3ff0ef          	jal	816 <nulterminate>
    nulterminate(pcmd->right);
     878:	6888                	ld	a0,16(s1)
     87a:	f9dff0ef          	jal	816 <nulterminate>
    break;
     87e:	b7e5                	j	866 <nulterminate+0x50>
    nulterminate(lcmd->left);
     880:	6508                	ld	a0,8(a0)
     882:	f95ff0ef          	jal	816 <nulterminate>
    nulterminate(lcmd->right);
     886:	6888                	ld	a0,16(s1)
     888:	f8fff0ef          	jal	816 <nulterminate>
    break;
     88c:	bfe9                	j	866 <nulterminate+0x50>
    nulterminate(bcmd->cmd);
     88e:	6508                	ld	a0,8(a0)
     890:	f87ff0ef          	jal	816 <nulterminate>
    break;
     894:	bfc9                	j	866 <nulterminate+0x50>

0000000000000896 <parsecmd>:
{
     896:	7179                	addi	sp,sp,-48
     898:	f406                	sd	ra,40(sp)
     89a:	f022                	sd	s0,32(sp)
     89c:	ec26                	sd	s1,24(sp)
     89e:	e84a                	sd	s2,16(sp)
     8a0:	1800                	addi	s0,sp,48
     8a2:	fca43c23          	sd	a0,-40(s0)
  es = s + strlen(s);
     8a6:	84aa                	mv	s1,a0
     8a8:	18e000ef          	jal	a36 <strlen>
     8ac:	1502                	slli	a0,a0,0x20
     8ae:	9101                	srli	a0,a0,0x20
     8b0:	94aa                	add	s1,s1,a0
  cmd = parseline(&s, es);
     8b2:	85a6                	mv	a1,s1
     8b4:	fd840513          	addi	a0,s0,-40
     8b8:	e53ff0ef          	jal	70a <parseline>
     8bc:	892a                	mv	s2,a0
  peek(&s, es, "");
     8be:	00001617          	auipc	a2,0x1
     8c2:	a6a60613          	addi	a2,a2,-1430 # 1328 <malloc+0x10a>
     8c6:	85a6                	mv	a1,s1
     8c8:	fd840513          	addi	a0,s0,-40
     8cc:	bc5ff0ef          	jal	490 <peek>
  if(s != es){
     8d0:	fd843603          	ld	a2,-40(s0)
     8d4:	00961c63          	bne	a2,s1,8ec <parsecmd+0x56>
  nulterminate(cmd);
     8d8:	854a                	mv	a0,s2
     8da:	f3dff0ef          	jal	816 <nulterminate>
}
     8de:	854a                	mv	a0,s2
     8e0:	70a2                	ld	ra,40(sp)
     8e2:	7402                	ld	s0,32(sp)
     8e4:	64e2                	ld	s1,24(sp)
     8e6:	6942                	ld	s2,16(sp)
     8e8:	6145                	addi	sp,sp,48
     8ea:	8082                	ret
    fprintf(2, "leftovers: %s\n", s);
     8ec:	00001597          	auipc	a1,0x1
     8f0:	b1c58593          	addi	a1,a1,-1252 # 1408 <malloc+0x1ea>
     8f4:	4509                	li	a0,2
     8f6:	04b000ef          	jal	1140 <fprintf>
    panic("syntax");
     8fa:	00001517          	auipc	a0,0x1
     8fe:	aa650513          	addi	a0,a0,-1370 # 13a0 <malloc+0x182>
     902:	f48ff0ef          	jal	4a <panic>

0000000000000906 <main>:
{
     906:	7139                	addi	sp,sp,-64
     908:	fc06                	sd	ra,56(sp)
     90a:	f822                	sd	s0,48(sp)
     90c:	f426                	sd	s1,40(sp)
     90e:	f04a                	sd	s2,32(sp)
     910:	ec4e                	sd	s3,24(sp)
     912:	e852                	sd	s4,16(sp)
     914:	e456                	sd	s5,8(sp)
     916:	e05a                	sd	s6,0(sp)
     918:	0080                	addi	s0,sp,64
  while((fd = open("console", O_RDWR)) >= 0){
     91a:	00001497          	auipc	s1,0x1
     91e:	afe48493          	addi	s1,s1,-1282 # 1418 <malloc+0x1fa>
     922:	4589                	li	a1,2
     924:	8526                	mv	a0,s1
     926:	41c000ef          	jal	d42 <open>
     92a:	00054763          	bltz	a0,938 <main+0x32>
    if(fd >= 3){
     92e:	4789                	li	a5,2
     930:	fea7d9e3          	bge	a5,a0,922 <main+0x1c>
      close(fd);
     934:	3f6000ef          	jal	d2a <close>
  while(getcmd(buf, sizeof(buf)) >= 0){
     938:	00001a17          	auipc	s4,0x1
     93c:	6e8a0a13          	addi	s4,s4,1768 # 2020 <buf.0>
    while (*cmd == ' ' || *cmd == '\t')
     940:	02000913          	li	s2,32
     944:	49a5                	li	s3,9
    if (*cmd == '\n') // is a blank command
     946:	4aa9                	li	s5,10
    if(cmd[0] == 'c' && cmd[1] == 'd' && cmd[2] == ' '){
     948:	06300b13          	li	s6,99
     94c:	a805                	j	97c <main+0x76>
      cmd++;
     94e:	0485                	addi	s1,s1,1
    while (*cmd == ' ' || *cmd == '\t')
     950:	0004c783          	lbu	a5,0(s1)
     954:	ff278de3          	beq	a5,s2,94e <main+0x48>
     958:	ff378be3          	beq	a5,s3,94e <main+0x48>
    if (*cmd == '\n') // is a blank command
     95c:	03578063          	beq	a5,s5,97c <main+0x76>
    if(cmd[0] == 'c' && cmd[1] == 'd' && cmd[2] == ' '){
     960:	01679863          	bne	a5,s6,970 <main+0x6a>
     964:	0014c703          	lbu	a4,1(s1)
     968:	06400793          	li	a5,100
     96c:	02f70463          	beq	a4,a5,994 <main+0x8e>
      if(fork1() == 0)
     970:	ef8ff0ef          	jal	68 <fork1>
     974:	cd29                	beqz	a0,9ce <main+0xc8>
      wait(0);
     976:	4501                	li	a0,0
     978:	392000ef          	jal	d0a <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
     97c:	06400593          	li	a1,100
     980:	8552                	mv	a0,s4
     982:	e7eff0ef          	jal	0 <getcmd>
     986:	04054963          	bltz	a0,9d8 <main+0xd2>
    char *cmd = buf;
     98a:	00001497          	auipc	s1,0x1
     98e:	69648493          	addi	s1,s1,1686 # 2020 <buf.0>
     992:	bf7d                	j	950 <main+0x4a>
    if(cmd[0] == 'c' && cmd[1] == 'd' && cmd[2] == ' '){
     994:	0024c783          	lbu	a5,2(s1)
     998:	fd279ce3          	bne	a5,s2,970 <main+0x6a>
      cmd[strlen(cmd)-1] = 0;  // chop \n
     99c:	8526                	mv	a0,s1
     99e:	098000ef          	jal	a36 <strlen>
     9a2:	fff5079b          	addiw	a5,a0,-1
     9a6:	1782                	slli	a5,a5,0x20
     9a8:	9381                	srli	a5,a5,0x20
     9aa:	97a6                	add	a5,a5,s1
     9ac:	00078023          	sb	zero,0(a5)
      if(chdir(cmd+3) < 0)
     9b0:	048d                	addi	s1,s1,3
     9b2:	8526                	mv	a0,s1
     9b4:	3be000ef          	jal	d72 <chdir>
     9b8:	fc0552e3          	bgez	a0,97c <main+0x76>
        fprintf(2, "cannot cd %s\n", cmd+3);
     9bc:	8626                	mv	a2,s1
     9be:	00001597          	auipc	a1,0x1
     9c2:	a6258593          	addi	a1,a1,-1438 # 1420 <malloc+0x202>
     9c6:	4509                	li	a0,2
     9c8:	778000ef          	jal	1140 <fprintf>
     9cc:	bf45                	j	97c <main+0x76>
        runcmd(parsecmd(cmd));
     9ce:	8526                	mv	a0,s1
     9d0:	ec7ff0ef          	jal	896 <parsecmd>
     9d4:	ebaff0ef          	jal	8e <runcmd>
  exit(0);
     9d8:	4501                	li	a0,0
     9da:	328000ef          	jal	d02 <exit>

00000000000009de <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
     9de:	1141                	addi	sp,sp,-16
     9e0:	e406                	sd	ra,8(sp)
     9e2:	e022                	sd	s0,0(sp)
     9e4:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
     9e6:	f21ff0ef          	jal	906 <main>
  exit(r);
     9ea:	318000ef          	jal	d02 <exit>

00000000000009ee <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     9ee:	1141                	addi	sp,sp,-16
     9f0:	e422                	sd	s0,8(sp)
     9f2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     9f4:	87aa                	mv	a5,a0
     9f6:	0585                	addi	a1,a1,1
     9f8:	0785                	addi	a5,a5,1
     9fa:	fff5c703          	lbu	a4,-1(a1)
     9fe:	fee78fa3          	sb	a4,-1(a5)
     a02:	fb75                	bnez	a4,9f6 <strcpy+0x8>
    ;
  return os;
}
     a04:	6422                	ld	s0,8(sp)
     a06:	0141                	addi	sp,sp,16
     a08:	8082                	ret

0000000000000a0a <strcmp>:

int
strcmp(const char *p, const char *q)
{
     a0a:	1141                	addi	sp,sp,-16
     a0c:	e422                	sd	s0,8(sp)
     a0e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
     a10:	00054783          	lbu	a5,0(a0)
     a14:	cb91                	beqz	a5,a28 <strcmp+0x1e>
     a16:	0005c703          	lbu	a4,0(a1)
     a1a:	00f71763          	bne	a4,a5,a28 <strcmp+0x1e>
    p++, q++;
     a1e:	0505                	addi	a0,a0,1
     a20:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
     a22:	00054783          	lbu	a5,0(a0)
     a26:	fbe5                	bnez	a5,a16 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     a28:	0005c503          	lbu	a0,0(a1)
}
     a2c:	40a7853b          	subw	a0,a5,a0
     a30:	6422                	ld	s0,8(sp)
     a32:	0141                	addi	sp,sp,16
     a34:	8082                	ret

0000000000000a36 <strlen>:

uint
strlen(const char *s)
{
     a36:	1141                	addi	sp,sp,-16
     a38:	e422                	sd	s0,8(sp)
     a3a:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     a3c:	00054783          	lbu	a5,0(a0)
     a40:	cf91                	beqz	a5,a5c <strlen+0x26>
     a42:	0505                	addi	a0,a0,1
     a44:	87aa                	mv	a5,a0
     a46:	86be                	mv	a3,a5
     a48:	0785                	addi	a5,a5,1
     a4a:	fff7c703          	lbu	a4,-1(a5)
     a4e:	ff65                	bnez	a4,a46 <strlen+0x10>
     a50:	40a6853b          	subw	a0,a3,a0
     a54:	2505                	addiw	a0,a0,1
    ;
  return n;
}
     a56:	6422                	ld	s0,8(sp)
     a58:	0141                	addi	sp,sp,16
     a5a:	8082                	ret
  for(n = 0; s[n]; n++)
     a5c:	4501                	li	a0,0
     a5e:	bfe5                	j	a56 <strlen+0x20>

0000000000000a60 <memset>:

void*
memset(void *dst, int c, uint n)
{
     a60:	1141                	addi	sp,sp,-16
     a62:	e422                	sd	s0,8(sp)
     a64:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     a66:	ca19                	beqz	a2,a7c <memset+0x1c>
     a68:	87aa                	mv	a5,a0
     a6a:	1602                	slli	a2,a2,0x20
     a6c:	9201                	srli	a2,a2,0x20
     a6e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     a72:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     a76:	0785                	addi	a5,a5,1
     a78:	fee79de3          	bne	a5,a4,a72 <memset+0x12>
  }
  return dst;
}
     a7c:	6422                	ld	s0,8(sp)
     a7e:	0141                	addi	sp,sp,16
     a80:	8082                	ret

0000000000000a82 <strchr>:

char*
strchr(const char *s, char c)
{
     a82:	1141                	addi	sp,sp,-16
     a84:	e422                	sd	s0,8(sp)
     a86:	0800                	addi	s0,sp,16
  for(; *s; s++)
     a88:	00054783          	lbu	a5,0(a0)
     a8c:	cb99                	beqz	a5,aa2 <strchr+0x20>
    if(*s == c)
     a8e:	00f58763          	beq	a1,a5,a9c <strchr+0x1a>
  for(; *s; s++)
     a92:	0505                	addi	a0,a0,1
     a94:	00054783          	lbu	a5,0(a0)
     a98:	fbfd                	bnez	a5,a8e <strchr+0xc>
      return (char*)s;
  return 0;
     a9a:	4501                	li	a0,0
}
     a9c:	6422                	ld	s0,8(sp)
     a9e:	0141                	addi	sp,sp,16
     aa0:	8082                	ret
  return 0;
     aa2:	4501                	li	a0,0
     aa4:	bfe5                	j	a9c <strchr+0x1a>

0000000000000aa6 <gets>:

char*
gets(char *buf, int max)
{
     aa6:	711d                	addi	sp,sp,-96
     aa8:	ec86                	sd	ra,88(sp)
     aaa:	e8a2                	sd	s0,80(sp)
     aac:	e4a6                	sd	s1,72(sp)
     aae:	e0ca                	sd	s2,64(sp)
     ab0:	fc4e                	sd	s3,56(sp)
     ab2:	f852                	sd	s4,48(sp)
     ab4:	f456                	sd	s5,40(sp)
     ab6:	f05a                	sd	s6,32(sp)
     ab8:	ec5e                	sd	s7,24(sp)
     aba:	1080                	addi	s0,sp,96
     abc:	8baa                	mv	s7,a0
     abe:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     ac0:	892a                	mv	s2,a0
     ac2:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     ac4:	4aa9                	li	s5,10
     ac6:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     ac8:	89a6                	mv	s3,s1
     aca:	2485                	addiw	s1,s1,1
     acc:	0344d663          	bge	s1,s4,af8 <gets+0x52>
    cc = read(0, &c, 1);
     ad0:	4605                	li	a2,1
     ad2:	faf40593          	addi	a1,s0,-81
     ad6:	4501                	li	a0,0
     ad8:	242000ef          	jal	d1a <read>
    if(cc < 1)
     adc:	00a05e63          	blez	a0,af8 <gets+0x52>
    buf[i++] = c;
     ae0:	faf44783          	lbu	a5,-81(s0)
     ae4:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     ae8:	01578763          	beq	a5,s5,af6 <gets+0x50>
     aec:	0905                	addi	s2,s2,1
     aee:	fd679de3          	bne	a5,s6,ac8 <gets+0x22>
    buf[i++] = c;
     af2:	89a6                	mv	s3,s1
     af4:	a011                	j	af8 <gets+0x52>
     af6:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     af8:	99de                	add	s3,s3,s7
     afa:	00098023          	sb	zero,0(s3)
  return buf;
}
     afe:	855e                	mv	a0,s7
     b00:	60e6                	ld	ra,88(sp)
     b02:	6446                	ld	s0,80(sp)
     b04:	64a6                	ld	s1,72(sp)
     b06:	6906                	ld	s2,64(sp)
     b08:	79e2                	ld	s3,56(sp)
     b0a:	7a42                	ld	s4,48(sp)
     b0c:	7aa2                	ld	s5,40(sp)
     b0e:	7b02                	ld	s6,32(sp)
     b10:	6be2                	ld	s7,24(sp)
     b12:	6125                	addi	sp,sp,96
     b14:	8082                	ret

0000000000000b16 <stat>:

int
stat(const char *n, struct stat *st)
{
     b16:	1101                	addi	sp,sp,-32
     b18:	ec06                	sd	ra,24(sp)
     b1a:	e822                	sd	s0,16(sp)
     b1c:	e04a                	sd	s2,0(sp)
     b1e:	1000                	addi	s0,sp,32
     b20:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     b22:	4581                	li	a1,0
     b24:	21e000ef          	jal	d42 <open>
  if(fd < 0)
     b28:	02054263          	bltz	a0,b4c <stat+0x36>
     b2c:	e426                	sd	s1,8(sp)
     b2e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     b30:	85ca                	mv	a1,s2
     b32:	228000ef          	jal	d5a <fstat>
     b36:	892a                	mv	s2,a0
  close(fd);
     b38:	8526                	mv	a0,s1
     b3a:	1f0000ef          	jal	d2a <close>
  return r;
     b3e:	64a2                	ld	s1,8(sp)
}
     b40:	854a                	mv	a0,s2
     b42:	60e2                	ld	ra,24(sp)
     b44:	6442                	ld	s0,16(sp)
     b46:	6902                	ld	s2,0(sp)
     b48:	6105                	addi	sp,sp,32
     b4a:	8082                	ret
    return -1;
     b4c:	597d                	li	s2,-1
     b4e:	bfcd                	j	b40 <stat+0x2a>

0000000000000b50 <atoi>:

int
atoi(const char *s)
{
     b50:	1141                	addi	sp,sp,-16
     b52:	e422                	sd	s0,8(sp)
     b54:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     b56:	00054683          	lbu	a3,0(a0)
     b5a:	fd06879b          	addiw	a5,a3,-48
     b5e:	0ff7f793          	zext.b	a5,a5
     b62:	4625                	li	a2,9
     b64:	02f66863          	bltu	a2,a5,b94 <atoi+0x44>
     b68:	872a                	mv	a4,a0
  n = 0;
     b6a:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
     b6c:	0705                	addi	a4,a4,1
     b6e:	0025179b          	slliw	a5,a0,0x2
     b72:	9fa9                	addw	a5,a5,a0
     b74:	0017979b          	slliw	a5,a5,0x1
     b78:	9fb5                	addw	a5,a5,a3
     b7a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     b7e:	00074683          	lbu	a3,0(a4)
     b82:	fd06879b          	addiw	a5,a3,-48
     b86:	0ff7f793          	zext.b	a5,a5
     b8a:	fef671e3          	bgeu	a2,a5,b6c <atoi+0x1c>
  return n;
}
     b8e:	6422                	ld	s0,8(sp)
     b90:	0141                	addi	sp,sp,16
     b92:	8082                	ret
  n = 0;
     b94:	4501                	li	a0,0
     b96:	bfe5                	j	b8e <atoi+0x3e>

0000000000000b98 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     b98:	1141                	addi	sp,sp,-16
     b9a:	e422                	sd	s0,8(sp)
     b9c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     b9e:	02b57463          	bgeu	a0,a1,bc6 <memmove+0x2e>
    while(n-- > 0)
     ba2:	00c05f63          	blez	a2,bc0 <memmove+0x28>
     ba6:	1602                	slli	a2,a2,0x20
     ba8:	9201                	srli	a2,a2,0x20
     baa:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     bae:	872a                	mv	a4,a0
      *dst++ = *src++;
     bb0:	0585                	addi	a1,a1,1
     bb2:	0705                	addi	a4,a4,1
     bb4:	fff5c683          	lbu	a3,-1(a1)
     bb8:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     bbc:	fef71ae3          	bne	a4,a5,bb0 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     bc0:	6422                	ld	s0,8(sp)
     bc2:	0141                	addi	sp,sp,16
     bc4:	8082                	ret
    dst += n;
     bc6:	00c50733          	add	a4,a0,a2
    src += n;
     bca:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     bcc:	fec05ae3          	blez	a2,bc0 <memmove+0x28>
     bd0:	fff6079b          	addiw	a5,a2,-1
     bd4:	1782                	slli	a5,a5,0x20
     bd6:	9381                	srli	a5,a5,0x20
     bd8:	fff7c793          	not	a5,a5
     bdc:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     bde:	15fd                	addi	a1,a1,-1
     be0:	177d                	addi	a4,a4,-1
     be2:	0005c683          	lbu	a3,0(a1)
     be6:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     bea:	fee79ae3          	bne	a5,a4,bde <memmove+0x46>
     bee:	bfc9                	j	bc0 <memmove+0x28>

0000000000000bf0 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     bf0:	1141                	addi	sp,sp,-16
     bf2:	e422                	sd	s0,8(sp)
     bf4:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     bf6:	ca05                	beqz	a2,c26 <memcmp+0x36>
     bf8:	fff6069b          	addiw	a3,a2,-1
     bfc:	1682                	slli	a3,a3,0x20
     bfe:	9281                	srli	a3,a3,0x20
     c00:	0685                	addi	a3,a3,1
     c02:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
     c04:	00054783          	lbu	a5,0(a0)
     c08:	0005c703          	lbu	a4,0(a1)
     c0c:	00e79863          	bne	a5,a4,c1c <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
     c10:	0505                	addi	a0,a0,1
    p2++;
     c12:	0585                	addi	a1,a1,1
  while (n-- > 0) {
     c14:	fed518e3          	bne	a0,a3,c04 <memcmp+0x14>
  }
  return 0;
     c18:	4501                	li	a0,0
     c1a:	a019                	j	c20 <memcmp+0x30>
      return *p1 - *p2;
     c1c:	40e7853b          	subw	a0,a5,a4
}
     c20:	6422                	ld	s0,8(sp)
     c22:	0141                	addi	sp,sp,16
     c24:	8082                	ret
  return 0;
     c26:	4501                	li	a0,0
     c28:	bfe5                	j	c20 <memcmp+0x30>

0000000000000c2a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     c2a:	1141                	addi	sp,sp,-16
     c2c:	e406                	sd	ra,8(sp)
     c2e:	e022                	sd	s0,0(sp)
     c30:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
     c32:	f67ff0ef          	jal	b98 <memmove>
}
     c36:	60a2                	ld	ra,8(sp)
     c38:	6402                	ld	s0,0(sp)
     c3a:	0141                	addi	sp,sp,16
     c3c:	8082                	ret

0000000000000c3e <sbrk>:

char *
sbrk(int n) {
     c3e:	1141                	addi	sp,sp,-16
     c40:	e406                	sd	ra,8(sp)
     c42:	e022                	sd	s0,0(sp)
     c44:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
     c46:	4585                	li	a1,1
     c48:	142000ef          	jal	d8a <sys_sbrk>
}
     c4c:	60a2                	ld	ra,8(sp)
     c4e:	6402                	ld	s0,0(sp)
     c50:	0141                	addi	sp,sp,16
     c52:	8082                	ret

0000000000000c54 <sbrklazy>:

char *
sbrklazy(int n) {
     c54:	1141                	addi	sp,sp,-16
     c56:	e406                	sd	ra,8(sp)
     c58:	e022                	sd	s0,0(sp)
     c5a:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
     c5c:	4589                	li	a1,2
     c5e:	12c000ef          	jal	d8a <sys_sbrk>
}
     c62:	60a2                	ld	ra,8(sp)
     c64:	6402                	ld	s0,0(sp)
     c66:	0141                	addi	sp,sp,16
     c68:	8082                	ret

0000000000000c6a <thread_create>:
// thread_create allocates a page-sized stack, calls clone(fn, arg, stacktop).
// Returns the new thread's pid, or -1 on error.
// The stack is passed back via *stack so the caller can free it after join.
int
thread_create(void(*fn)(void*), void *arg, void **stack)
{
     c6a:	7179                	addi	sp,sp,-48
     c6c:	f406                	sd	ra,40(sp)
     c6e:	f022                	sd	s0,32(sp)
     c70:	e84a                	sd	s2,16(sp)
     c72:	e44e                	sd	s3,8(sp)
     c74:	e052                	sd	s4,0(sp)
     c76:	1800                	addi	s0,sp,48
     c78:	89aa                	mv	s3,a0
     c7a:	8a2e                	mv	s4,a1
     c7c:	8932                	mv	s2,a2
  char *s = malloc(PGSIZE);
     c7e:	6505                	lui	a0,0x1
     c80:	59e000ef          	jal	121e <malloc>
  if(s == 0)
     c84:	cd0d                	beqz	a0,cbe <thread_create+0x54>
     c86:	ec26                	sd	s1,24(sp)
     c88:	84aa                	mv	s1,a0
    return -1;
  *stack = s;
     c8a:	00a93023          	sd	a0,0(s2)
  // Stack grows downward- pass the top of the allocated region.
  int pid = clone(fn, arg, s + PGSIZE);
     c8e:	6605                	lui	a2,0x1
     c90:	962a                	add	a2,a2,a0
     c92:	85d2                	mv	a1,s4
     c94:	854e                	mv	a0,s3
     c96:	134000ef          	jal	dca <clone>
  if(pid < 0){
     c9a:	00054a63          	bltz	a0,cae <thread_create+0x44>
     c9e:	64e2                	ld	s1,24(sp)
    free(s);
    *stack = 0;
    return -1;
  }
  return pid;
}
     ca0:	70a2                	ld	ra,40(sp)
     ca2:	7402                	ld	s0,32(sp)
     ca4:	6942                	ld	s2,16(sp)
     ca6:	69a2                	ld	s3,8(sp)
     ca8:	6a02                	ld	s4,0(sp)
     caa:	6145                	addi	sp,sp,48
     cac:	8082                	ret
    free(s);
     cae:	8526                	mv	a0,s1
     cb0:	4ec000ef          	jal	119c <free>
    *stack = 0;
     cb4:	00093023          	sd	zero,0(s2)
    return -1;
     cb8:	557d                	li	a0,-1
     cba:	64e2                	ld	s1,24(sp)
     cbc:	b7d5                	j	ca0 <thread_create+0x36>
    return -1;
     cbe:	557d                	li	a0,-1
     cc0:	b7c5                	j	ca0 <thread_create+0x36>

0000000000000cc2 <thread_join>:
// Wait for any child thread to exit.
// If stack is non-null, frees the memory pointed to by *stack and clears it.
// Returns the joined thread's pid, or -1 Son error.
int
thread_join(void **stack)
{
     cc2:	1101                	addi	sp,sp,-32
     cc4:	ec06                	sd	ra,24(sp)
     cc6:	e822                	sd	s0,16(sp)
     cc8:	e426                	sd	s1,8(sp)
     cca:	e04a                	sd	s2,0(sp)
     ccc:	1000                	addi	s0,sp,32
     cce:	84aa                	mv	s1,a0
  int pid = join();
     cd0:	102000ef          	jal	dd2 <join>
  if(pid < 0)
     cd4:	02054163          	bltz	a0,cf6 <thread_join+0x34>
     cd8:	892a                	mv	s2,a0
    return -1;
  if(stack && *stack){
     cda:	c499                	beqz	s1,ce8 <thread_join+0x26>
     cdc:	6088                	ld	a0,0(s1)
     cde:	c509                	beqz	a0,ce8 <thread_join+0x26>
    free(*stack);
     ce0:	4bc000ef          	jal	119c <free>
    *stack = 0;
     ce4:	0004b023          	sd	zero,0(s1)
  }
  return pid;
}
     ce8:	854a                	mv	a0,s2
     cea:	60e2                	ld	ra,24(sp)
     cec:	6442                	ld	s0,16(sp)
     cee:	64a2                	ld	s1,8(sp)
     cf0:	6902                	ld	s2,0(sp)
     cf2:	6105                	addi	sp,sp,32
     cf4:	8082                	ret
    return -1;
     cf6:	597d                	li	s2,-1
     cf8:	bfc5                	j	ce8 <thread_join+0x26>

0000000000000cfa <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     cfa:	4885                	li	a7,1
 ecall
     cfc:	00000073          	ecall
 ret
     d00:	8082                	ret

0000000000000d02 <exit>:
.global exit
exit:
 li a7, SYS_exit
     d02:	4889                	li	a7,2
 ecall
     d04:	00000073          	ecall
 ret
     d08:	8082                	ret

0000000000000d0a <wait>:
.global wait
wait:
 li a7, SYS_wait
     d0a:	488d                	li	a7,3
 ecall
     d0c:	00000073          	ecall
 ret
     d10:	8082                	ret

0000000000000d12 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     d12:	4891                	li	a7,4
 ecall
     d14:	00000073          	ecall
 ret
     d18:	8082                	ret

0000000000000d1a <read>:
.global read
read:
 li a7, SYS_read
     d1a:	4895                	li	a7,5
 ecall
     d1c:	00000073          	ecall
 ret
     d20:	8082                	ret

0000000000000d22 <write>:
.global write
write:
 li a7, SYS_write
     d22:	48c1                	li	a7,16
 ecall
     d24:	00000073          	ecall
 ret
     d28:	8082                	ret

0000000000000d2a <close>:
.global close
close:
 li a7, SYS_close
     d2a:	48d5                	li	a7,21
 ecall
     d2c:	00000073          	ecall
 ret
     d30:	8082                	ret

0000000000000d32 <kill>:
.global kill
kill:
 li a7, SYS_kill
     d32:	4899                	li	a7,6
 ecall
     d34:	00000073          	ecall
 ret
     d38:	8082                	ret

0000000000000d3a <exec>:
.global exec
exec:
 li a7, SYS_exec
     d3a:	489d                	li	a7,7
 ecall
     d3c:	00000073          	ecall
 ret
     d40:	8082                	ret

0000000000000d42 <open>:
.global open
open:
 li a7, SYS_open
     d42:	48bd                	li	a7,15
 ecall
     d44:	00000073          	ecall
 ret
     d48:	8082                	ret

0000000000000d4a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     d4a:	48c5                	li	a7,17
 ecall
     d4c:	00000073          	ecall
 ret
     d50:	8082                	ret

0000000000000d52 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     d52:	48c9                	li	a7,18
 ecall
     d54:	00000073          	ecall
 ret
     d58:	8082                	ret

0000000000000d5a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     d5a:	48a1                	li	a7,8
 ecall
     d5c:	00000073          	ecall
 ret
     d60:	8082                	ret

0000000000000d62 <link>:
.global link
link:
 li a7, SYS_link
     d62:	48cd                	li	a7,19
 ecall
     d64:	00000073          	ecall
 ret
     d68:	8082                	ret

0000000000000d6a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     d6a:	48d1                	li	a7,20
 ecall
     d6c:	00000073          	ecall
 ret
     d70:	8082                	ret

0000000000000d72 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     d72:	48a5                	li	a7,9
 ecall
     d74:	00000073          	ecall
 ret
     d78:	8082                	ret

0000000000000d7a <dup>:
.global dup
dup:
 li a7, SYS_dup
     d7a:	48a9                	li	a7,10
 ecall
     d7c:	00000073          	ecall
 ret
     d80:	8082                	ret

0000000000000d82 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     d82:	48ad                	li	a7,11
 ecall
     d84:	00000073          	ecall
 ret
     d88:	8082                	ret

0000000000000d8a <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
     d8a:	48b1                	li	a7,12
 ecall
     d8c:	00000073          	ecall
 ret
     d90:	8082                	ret

0000000000000d92 <pause>:
.global pause
pause:
 li a7, SYS_pause
     d92:	48b5                	li	a7,13
 ecall
     d94:	00000073          	ecall
 ret
     d98:	8082                	ret

0000000000000d9a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     d9a:	48b9                	li	a7,14
 ecall
     d9c:	00000073          	ecall
 ret
     da0:	8082                	ret

0000000000000da2 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
     da2:	48d9                	li	a7,22
 ecall
     da4:	00000073          	ecall
 ret
     da8:	8082                	ret

0000000000000daa <lock_create>:
.global lock_create
lock_create:
 li a7, SYS_lock_create
     daa:	48dd                	li	a7,23
 ecall
     dac:	00000073          	ecall
 ret
     db0:	8082                	ret

0000000000000db2 <lock_acquire>:
.global lock_acquire
lock_acquire:
 li a7, SYS_lock_acquire
     db2:	48e1                	li	a7,24
 ecall
     db4:	00000073          	ecall
 ret
     db8:	8082                	ret

0000000000000dba <lock_release>:
.global lock_release
lock_release:
 li a7, SYS_lock_release
     dba:	48e5                	li	a7,25
 ecall
     dbc:	00000073          	ecall
 ret
     dc0:	8082                	ret

0000000000000dc2 <lock_destroy>:
.global lock_destroy
lock_destroy:
 li a7, SYS_lock_destroy
     dc2:	48e9                	li	a7,26
 ecall
     dc4:	00000073          	ecall
 ret
     dc8:	8082                	ret

0000000000000dca <clone>:
.global clone
clone:
 li a7, SYS_clone
     dca:	48ed                	li	a7,27
 ecall
     dcc:	00000073          	ecall
 ret
     dd0:	8082                	ret

0000000000000dd2 <join>:
.global join
join:
 li a7, SYS_join
     dd2:	48f1                	li	a7,28
 ecall
     dd4:	00000073          	ecall
 ret
     dd8:	8082                	ret

0000000000000dda <getprocessinfo>:
.global getprocessinfo
getprocessinfo:
 li a7, SYS_getprocessinfo
     dda:	48f5                	li	a7,29
 ecall
     ddc:	00000073          	ecall
 ret
     de0:	8082                	ret

0000000000000de2 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     de2:	1101                	addi	sp,sp,-32
     de4:	ec06                	sd	ra,24(sp)
     de6:	e822                	sd	s0,16(sp)
     de8:	1000                	addi	s0,sp,32
     dea:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     dee:	4605                	li	a2,1
     df0:	fef40593          	addi	a1,s0,-17
     df4:	f2fff0ef          	jal	d22 <write>
}
     df8:	60e2                	ld	ra,24(sp)
     dfa:	6442                	ld	s0,16(sp)
     dfc:	6105                	addi	sp,sp,32
     dfe:	8082                	ret

0000000000000e00 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
     e00:	715d                	addi	sp,sp,-80
     e02:	e486                	sd	ra,72(sp)
     e04:	e0a2                	sd	s0,64(sp)
     e06:	f84a                	sd	s2,48(sp)
     e08:	0880                	addi	s0,sp,80
     e0a:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
     e0c:	c299                	beqz	a3,e12 <printint+0x12>
     e0e:	0805c363          	bltz	a1,e94 <printint+0x94>
  neg = 0;
     e12:	4881                	li	a7,0
     e14:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
     e18:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
     e1a:	00000517          	auipc	a0,0x0
     e1e:	64e50513          	addi	a0,a0,1614 # 1468 <digits>
     e22:	883e                	mv	a6,a5
     e24:	2785                	addiw	a5,a5,1
     e26:	02c5f733          	remu	a4,a1,a2
     e2a:	972a                	add	a4,a4,a0
     e2c:	00074703          	lbu	a4,0(a4)
     e30:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
     e34:	872e                	mv	a4,a1
     e36:	02c5d5b3          	divu	a1,a1,a2
     e3a:	0685                	addi	a3,a3,1
     e3c:	fec773e3          	bgeu	a4,a2,e22 <printint+0x22>
  if(neg)
     e40:	00088b63          	beqz	a7,e56 <printint+0x56>
    buf[i++] = '-';
     e44:	fd078793          	addi	a5,a5,-48
     e48:	97a2                	add	a5,a5,s0
     e4a:	02d00713          	li	a4,45
     e4e:	fee78423          	sb	a4,-24(a5)
     e52:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
     e56:	02f05a63          	blez	a5,e8a <printint+0x8a>
     e5a:	fc26                	sd	s1,56(sp)
     e5c:	f44e                	sd	s3,40(sp)
     e5e:	fb840713          	addi	a4,s0,-72
     e62:	00f704b3          	add	s1,a4,a5
     e66:	fff70993          	addi	s3,a4,-1
     e6a:	99be                	add	s3,s3,a5
     e6c:	37fd                	addiw	a5,a5,-1
     e6e:	1782                	slli	a5,a5,0x20
     e70:	9381                	srli	a5,a5,0x20
     e72:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
     e76:	fff4c583          	lbu	a1,-1(s1)
     e7a:	854a                	mv	a0,s2
     e7c:	f67ff0ef          	jal	de2 <putc>
  while(--i >= 0)
     e80:	14fd                	addi	s1,s1,-1
     e82:	ff349ae3          	bne	s1,s3,e76 <printint+0x76>
     e86:	74e2                	ld	s1,56(sp)
     e88:	79a2                	ld	s3,40(sp)
}
     e8a:	60a6                	ld	ra,72(sp)
     e8c:	6406                	ld	s0,64(sp)
     e8e:	7942                	ld	s2,48(sp)
     e90:	6161                	addi	sp,sp,80
     e92:	8082                	ret
    x = -xx;
     e94:	40b005b3          	neg	a1,a1
    neg = 1;
     e98:	4885                	li	a7,1
    x = -xx;
     e9a:	bfad                	j	e14 <printint+0x14>

0000000000000e9c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     e9c:	711d                	addi	sp,sp,-96
     e9e:	ec86                	sd	ra,88(sp)
     ea0:	e8a2                	sd	s0,80(sp)
     ea2:	e0ca                	sd	s2,64(sp)
     ea4:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
     ea6:	0005c903          	lbu	s2,0(a1)
     eaa:	28090663          	beqz	s2,1136 <vprintf+0x29a>
     eae:	e4a6                	sd	s1,72(sp)
     eb0:	fc4e                	sd	s3,56(sp)
     eb2:	f852                	sd	s4,48(sp)
     eb4:	f456                	sd	s5,40(sp)
     eb6:	f05a                	sd	s6,32(sp)
     eb8:	ec5e                	sd	s7,24(sp)
     eba:	e862                	sd	s8,16(sp)
     ebc:	e466                	sd	s9,8(sp)
     ebe:	8b2a                	mv	s6,a0
     ec0:	8a2e                	mv	s4,a1
     ec2:	8bb2                	mv	s7,a2
  state = 0;
     ec4:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
     ec6:	4481                	li	s1,0
     ec8:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
     eca:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
     ece:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
     ed2:	06c00c93          	li	s9,108
     ed6:	a005                	j	ef6 <vprintf+0x5a>
        putc(fd, c0);
     ed8:	85ca                	mv	a1,s2
     eda:	855a                	mv	a0,s6
     edc:	f07ff0ef          	jal	de2 <putc>
     ee0:	a019                	j	ee6 <vprintf+0x4a>
    } else if(state == '%'){
     ee2:	03598263          	beq	s3,s5,f06 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
     ee6:	2485                	addiw	s1,s1,1
     ee8:	8726                	mv	a4,s1
     eea:	009a07b3          	add	a5,s4,s1
     eee:	0007c903          	lbu	s2,0(a5)
     ef2:	22090a63          	beqz	s2,1126 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
     ef6:	0009079b          	sext.w	a5,s2
    if(state == 0){
     efa:	fe0994e3          	bnez	s3,ee2 <vprintf+0x46>
      if(c0 == '%'){
     efe:	fd579de3          	bne	a5,s5,ed8 <vprintf+0x3c>
        state = '%';
     f02:	89be                	mv	s3,a5
     f04:	b7cd                	j	ee6 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
     f06:	00ea06b3          	add	a3,s4,a4
     f0a:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
     f0e:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
     f10:	c681                	beqz	a3,f18 <vprintf+0x7c>
     f12:	9752                	add	a4,a4,s4
     f14:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
     f18:	05878363          	beq	a5,s8,f5e <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
     f1c:	05978d63          	beq	a5,s9,f76 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
     f20:	07500713          	li	a4,117
     f24:	0ee78763          	beq	a5,a4,1012 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
     f28:	07800713          	li	a4,120
     f2c:	12e78963          	beq	a5,a4,105e <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
     f30:	07000713          	li	a4,112
     f34:	14e78e63          	beq	a5,a4,1090 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
     f38:	06300713          	li	a4,99
     f3c:	18e78e63          	beq	a5,a4,10d8 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
     f40:	07300713          	li	a4,115
     f44:	1ae78463          	beq	a5,a4,10ec <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
     f48:	02500713          	li	a4,37
     f4c:	04e79563          	bne	a5,a4,f96 <vprintf+0xfa>
        putc(fd, '%');
     f50:	02500593          	li	a1,37
     f54:	855a                	mv	a0,s6
     f56:	e8dff0ef          	jal	de2 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
     f5a:	4981                	li	s3,0
     f5c:	b769                	j	ee6 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
     f5e:	008b8913          	addi	s2,s7,8
     f62:	4685                	li	a3,1
     f64:	4629                	li	a2,10
     f66:	000ba583          	lw	a1,0(s7)
     f6a:	855a                	mv	a0,s6
     f6c:	e95ff0ef          	jal	e00 <printint>
     f70:	8bca                	mv	s7,s2
      state = 0;
     f72:	4981                	li	s3,0
     f74:	bf8d                	j	ee6 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
     f76:	06400793          	li	a5,100
     f7a:	02f68963          	beq	a3,a5,fac <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     f7e:	06c00793          	li	a5,108
     f82:	04f68263          	beq	a3,a5,fc6 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
     f86:	07500793          	li	a5,117
     f8a:	0af68063          	beq	a3,a5,102a <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
     f8e:	07800793          	li	a5,120
     f92:	0ef68263          	beq	a3,a5,1076 <vprintf+0x1da>
        putc(fd, '%');
     f96:	02500593          	li	a1,37
     f9a:	855a                	mv	a0,s6
     f9c:	e47ff0ef          	jal	de2 <putc>
        putc(fd, c0);
     fa0:	85ca                	mv	a1,s2
     fa2:	855a                	mv	a0,s6
     fa4:	e3fff0ef          	jal	de2 <putc>
      state = 0;
     fa8:	4981                	li	s3,0
     faa:	bf35                	j	ee6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
     fac:	008b8913          	addi	s2,s7,8
     fb0:	4685                	li	a3,1
     fb2:	4629                	li	a2,10
     fb4:	000bb583          	ld	a1,0(s7)
     fb8:	855a                	mv	a0,s6
     fba:	e47ff0ef          	jal	e00 <printint>
        i += 1;
     fbe:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
     fc0:	8bca                	mv	s7,s2
      state = 0;
     fc2:	4981                	li	s3,0
        i += 1;
     fc4:	b70d                	j	ee6 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     fc6:	06400793          	li	a5,100
     fca:	02f60763          	beq	a2,a5,ff8 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
     fce:	07500793          	li	a5,117
     fd2:	06f60963          	beq	a2,a5,1044 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
     fd6:	07800793          	li	a5,120
     fda:	faf61ee3          	bne	a2,a5,f96 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
     fde:	008b8913          	addi	s2,s7,8
     fe2:	4681                	li	a3,0
     fe4:	4641                	li	a2,16
     fe6:	000bb583          	ld	a1,0(s7)
     fea:	855a                	mv	a0,s6
     fec:	e15ff0ef          	jal	e00 <printint>
        i += 2;
     ff0:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
     ff2:	8bca                	mv	s7,s2
      state = 0;
     ff4:	4981                	li	s3,0
        i += 2;
     ff6:	bdc5                	j	ee6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
     ff8:	008b8913          	addi	s2,s7,8
     ffc:	4685                	li	a3,1
     ffe:	4629                	li	a2,10
    1000:	000bb583          	ld	a1,0(s7)
    1004:	855a                	mv	a0,s6
    1006:	dfbff0ef          	jal	e00 <printint>
        i += 2;
    100a:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
    100c:	8bca                	mv	s7,s2
      state = 0;
    100e:	4981                	li	s3,0
        i += 2;
    1010:	bdd9                	j	ee6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
    1012:	008b8913          	addi	s2,s7,8
    1016:	4681                	li	a3,0
    1018:	4629                	li	a2,10
    101a:	000be583          	lwu	a1,0(s7)
    101e:	855a                	mv	a0,s6
    1020:	de1ff0ef          	jal	e00 <printint>
    1024:	8bca                	mv	s7,s2
      state = 0;
    1026:	4981                	li	s3,0
    1028:	bd7d                	j	ee6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
    102a:	008b8913          	addi	s2,s7,8
    102e:	4681                	li	a3,0
    1030:	4629                	li	a2,10
    1032:	000bb583          	ld	a1,0(s7)
    1036:	855a                	mv	a0,s6
    1038:	dc9ff0ef          	jal	e00 <printint>
        i += 1;
    103c:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
    103e:	8bca                	mv	s7,s2
      state = 0;
    1040:	4981                	li	s3,0
        i += 1;
    1042:	b555                	j	ee6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
    1044:	008b8913          	addi	s2,s7,8
    1048:	4681                	li	a3,0
    104a:	4629                	li	a2,10
    104c:	000bb583          	ld	a1,0(s7)
    1050:	855a                	mv	a0,s6
    1052:	dafff0ef          	jal	e00 <printint>
        i += 2;
    1056:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
    1058:	8bca                	mv	s7,s2
      state = 0;
    105a:	4981                	li	s3,0
        i += 2;
    105c:	b569                	j	ee6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
    105e:	008b8913          	addi	s2,s7,8
    1062:	4681                	li	a3,0
    1064:	4641                	li	a2,16
    1066:	000be583          	lwu	a1,0(s7)
    106a:	855a                	mv	a0,s6
    106c:	d95ff0ef          	jal	e00 <printint>
    1070:	8bca                	mv	s7,s2
      state = 0;
    1072:	4981                	li	s3,0
    1074:	bd8d                	j	ee6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
    1076:	008b8913          	addi	s2,s7,8
    107a:	4681                	li	a3,0
    107c:	4641                	li	a2,16
    107e:	000bb583          	ld	a1,0(s7)
    1082:	855a                	mv	a0,s6
    1084:	d7dff0ef          	jal	e00 <printint>
        i += 1;
    1088:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
    108a:	8bca                	mv	s7,s2
      state = 0;
    108c:	4981                	li	s3,0
        i += 1;
    108e:	bda1                	j	ee6 <vprintf+0x4a>
    1090:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
    1092:	008b8d13          	addi	s10,s7,8
    1096:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    109a:	03000593          	li	a1,48
    109e:	855a                	mv	a0,s6
    10a0:	d43ff0ef          	jal	de2 <putc>
  putc(fd, 'x');
    10a4:	07800593          	li	a1,120
    10a8:	855a                	mv	a0,s6
    10aa:	d39ff0ef          	jal	de2 <putc>
    10ae:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    10b0:	00000b97          	auipc	s7,0x0
    10b4:	3b8b8b93          	addi	s7,s7,952 # 1468 <digits>
    10b8:	03c9d793          	srli	a5,s3,0x3c
    10bc:	97de                	add	a5,a5,s7
    10be:	0007c583          	lbu	a1,0(a5)
    10c2:	855a                	mv	a0,s6
    10c4:	d1fff0ef          	jal	de2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    10c8:	0992                	slli	s3,s3,0x4
    10ca:	397d                	addiw	s2,s2,-1
    10cc:	fe0916e3          	bnez	s2,10b8 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
    10d0:	8bea                	mv	s7,s10
      state = 0;
    10d2:	4981                	li	s3,0
    10d4:	6d02                	ld	s10,0(sp)
    10d6:	bd01                	j	ee6 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
    10d8:	008b8913          	addi	s2,s7,8
    10dc:	000bc583          	lbu	a1,0(s7)
    10e0:	855a                	mv	a0,s6
    10e2:	d01ff0ef          	jal	de2 <putc>
    10e6:	8bca                	mv	s7,s2
      state = 0;
    10e8:	4981                	li	s3,0
    10ea:	bbf5                	j	ee6 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
    10ec:	008b8993          	addi	s3,s7,8
    10f0:	000bb903          	ld	s2,0(s7)
    10f4:	00090f63          	beqz	s2,1112 <vprintf+0x276>
        for(; *s; s++)
    10f8:	00094583          	lbu	a1,0(s2)
    10fc:	c195                	beqz	a1,1120 <vprintf+0x284>
          putc(fd, *s);
    10fe:	855a                	mv	a0,s6
    1100:	ce3ff0ef          	jal	de2 <putc>
        for(; *s; s++)
    1104:	0905                	addi	s2,s2,1
    1106:	00094583          	lbu	a1,0(s2)
    110a:	f9f5                	bnez	a1,10fe <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
    110c:	8bce                	mv	s7,s3
      state = 0;
    110e:	4981                	li	s3,0
    1110:	bbd9                	j	ee6 <vprintf+0x4a>
          s = "(null)";
    1112:	00000917          	auipc	s2,0x0
    1116:	31e90913          	addi	s2,s2,798 # 1430 <malloc+0x212>
        for(; *s; s++)
    111a:	02800593          	li	a1,40
    111e:	b7c5                	j	10fe <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
    1120:	8bce                	mv	s7,s3
      state = 0;
    1122:	4981                	li	s3,0
    1124:	b3c9                	j	ee6 <vprintf+0x4a>
    1126:	64a6                	ld	s1,72(sp)
    1128:	79e2                	ld	s3,56(sp)
    112a:	7a42                	ld	s4,48(sp)
    112c:	7aa2                	ld	s5,40(sp)
    112e:	7b02                	ld	s6,32(sp)
    1130:	6be2                	ld	s7,24(sp)
    1132:	6c42                	ld	s8,16(sp)
    1134:	6ca2                	ld	s9,8(sp)
    }
  }
}
    1136:	60e6                	ld	ra,88(sp)
    1138:	6446                	ld	s0,80(sp)
    113a:	6906                	ld	s2,64(sp)
    113c:	6125                	addi	sp,sp,96
    113e:	8082                	ret

0000000000001140 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    1140:	715d                	addi	sp,sp,-80
    1142:	ec06                	sd	ra,24(sp)
    1144:	e822                	sd	s0,16(sp)
    1146:	1000                	addi	s0,sp,32
    1148:	e010                	sd	a2,0(s0)
    114a:	e414                	sd	a3,8(s0)
    114c:	e818                	sd	a4,16(s0)
    114e:	ec1c                	sd	a5,24(s0)
    1150:	03043023          	sd	a6,32(s0)
    1154:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    1158:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    115c:	8622                	mv	a2,s0
    115e:	d3fff0ef          	jal	e9c <vprintf>
}
    1162:	60e2                	ld	ra,24(sp)
    1164:	6442                	ld	s0,16(sp)
    1166:	6161                	addi	sp,sp,80
    1168:	8082                	ret

000000000000116a <printf>:

void
printf(const char *fmt, ...)
{
    116a:	711d                	addi	sp,sp,-96
    116c:	ec06                	sd	ra,24(sp)
    116e:	e822                	sd	s0,16(sp)
    1170:	1000                	addi	s0,sp,32
    1172:	e40c                	sd	a1,8(s0)
    1174:	e810                	sd	a2,16(s0)
    1176:	ec14                	sd	a3,24(s0)
    1178:	f018                	sd	a4,32(s0)
    117a:	f41c                	sd	a5,40(s0)
    117c:	03043823          	sd	a6,48(s0)
    1180:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    1184:	00840613          	addi	a2,s0,8
    1188:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    118c:	85aa                	mv	a1,a0
    118e:	4505                	li	a0,1
    1190:	d0dff0ef          	jal	e9c <vprintf>
}
    1194:	60e2                	ld	ra,24(sp)
    1196:	6442                	ld	s0,16(sp)
    1198:	6125                	addi	sp,sp,96
    119a:	8082                	ret

000000000000119c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    119c:	1141                	addi	sp,sp,-16
    119e:	e422                	sd	s0,8(sp)
    11a0:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    11a2:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    11a6:	00001797          	auipc	a5,0x1
    11aa:	e6a7b783          	ld	a5,-406(a5) # 2010 <freep>
    11ae:	a02d                	j	11d8 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    11b0:	4618                	lw	a4,8(a2)
    11b2:	9f2d                	addw	a4,a4,a1
    11b4:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    11b8:	6398                	ld	a4,0(a5)
    11ba:	6310                	ld	a2,0(a4)
    11bc:	a83d                	j	11fa <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    11be:	ff852703          	lw	a4,-8(a0)
    11c2:	9f31                	addw	a4,a4,a2
    11c4:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    11c6:	ff053683          	ld	a3,-16(a0)
    11ca:	a091                	j	120e <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    11cc:	6398                	ld	a4,0(a5)
    11ce:	00e7e463          	bltu	a5,a4,11d6 <free+0x3a>
    11d2:	00e6ea63          	bltu	a3,a4,11e6 <free+0x4a>
{
    11d6:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    11d8:	fed7fae3          	bgeu	a5,a3,11cc <free+0x30>
    11dc:	6398                	ld	a4,0(a5)
    11de:	00e6e463          	bltu	a3,a4,11e6 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    11e2:	fee7eae3          	bltu	a5,a4,11d6 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
    11e6:	ff852583          	lw	a1,-8(a0)
    11ea:	6390                	ld	a2,0(a5)
    11ec:	02059813          	slli	a6,a1,0x20
    11f0:	01c85713          	srli	a4,a6,0x1c
    11f4:	9736                	add	a4,a4,a3
    11f6:	fae60de3          	beq	a2,a4,11b0 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    11fa:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    11fe:	4790                	lw	a2,8(a5)
    1200:	02061593          	slli	a1,a2,0x20
    1204:	01c5d713          	srli	a4,a1,0x1c
    1208:	973e                	add	a4,a4,a5
    120a:	fae68ae3          	beq	a3,a4,11be <free+0x22>
    p->s.ptr = bp->s.ptr;
    120e:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    1210:	00001717          	auipc	a4,0x1
    1214:	e0f73023          	sd	a5,-512(a4) # 2010 <freep>
}
    1218:	6422                	ld	s0,8(sp)
    121a:	0141                	addi	sp,sp,16
    121c:	8082                	ret

000000000000121e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    121e:	7139                	addi	sp,sp,-64
    1220:	fc06                	sd	ra,56(sp)
    1222:	f822                	sd	s0,48(sp)
    1224:	f426                	sd	s1,40(sp)
    1226:	ec4e                	sd	s3,24(sp)
    1228:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    122a:	02051493          	slli	s1,a0,0x20
    122e:	9081                	srli	s1,s1,0x20
    1230:	04bd                	addi	s1,s1,15
    1232:	8091                	srli	s1,s1,0x4
    1234:	0014899b          	addiw	s3,s1,1
    1238:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    123a:	00001517          	auipc	a0,0x1
    123e:	dd653503          	ld	a0,-554(a0) # 2010 <freep>
    1242:	c915                	beqz	a0,1276 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1244:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    1246:	4798                	lw	a4,8(a5)
    1248:	08977a63          	bgeu	a4,s1,12dc <malloc+0xbe>
    124c:	f04a                	sd	s2,32(sp)
    124e:	e852                	sd	s4,16(sp)
    1250:	e456                	sd	s5,8(sp)
    1252:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    1254:	8a4e                	mv	s4,s3
    1256:	0009871b          	sext.w	a4,s3
    125a:	6685                	lui	a3,0x1
    125c:	00d77363          	bgeu	a4,a3,1262 <malloc+0x44>
    1260:	6a05                	lui	s4,0x1
    1262:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    1266:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    126a:	00001917          	auipc	s2,0x1
    126e:	da690913          	addi	s2,s2,-602 # 2010 <freep>
  if(p == SBRK_ERROR)
    1272:	5afd                	li	s5,-1
    1274:	a081                	j	12b4 <malloc+0x96>
    1276:	f04a                	sd	s2,32(sp)
    1278:	e852                	sd	s4,16(sp)
    127a:	e456                	sd	s5,8(sp)
    127c:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    127e:	00001797          	auipc	a5,0x1
    1282:	e0a78793          	addi	a5,a5,-502 # 2088 <base>
    1286:	00001717          	auipc	a4,0x1
    128a:	d8f73523          	sd	a5,-630(a4) # 2010 <freep>
    128e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    1290:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    1294:	b7c1                	j	1254 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
    1296:	6398                	ld	a4,0(a5)
    1298:	e118                	sd	a4,0(a0)
    129a:	a8a9                	j	12f4 <malloc+0xd6>
  hp->s.size = nu;
    129c:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    12a0:	0541                	addi	a0,a0,16
    12a2:	efbff0ef          	jal	119c <free>
  return freep;
    12a6:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    12aa:	c12d                	beqz	a0,130c <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    12ac:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    12ae:	4798                	lw	a4,8(a5)
    12b0:	02977263          	bgeu	a4,s1,12d4 <malloc+0xb6>
    if(p == freep)
    12b4:	00093703          	ld	a4,0(s2)
    12b8:	853e                	mv	a0,a5
    12ba:	fef719e3          	bne	a4,a5,12ac <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
    12be:	8552                	mv	a0,s4
    12c0:	97fff0ef          	jal	c3e <sbrk>
  if(p == SBRK_ERROR)
    12c4:	fd551ce3          	bne	a0,s5,129c <malloc+0x7e>
        return 0;
    12c8:	4501                	li	a0,0
    12ca:	7902                	ld	s2,32(sp)
    12cc:	6a42                	ld	s4,16(sp)
    12ce:	6aa2                	ld	s5,8(sp)
    12d0:	6b02                	ld	s6,0(sp)
    12d2:	a03d                	j	1300 <malloc+0xe2>
    12d4:	7902                	ld	s2,32(sp)
    12d6:	6a42                	ld	s4,16(sp)
    12d8:	6aa2                	ld	s5,8(sp)
    12da:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    12dc:	fae48de3          	beq	s1,a4,1296 <malloc+0x78>
        p->s.size -= nunits;
    12e0:	4137073b          	subw	a4,a4,s3
    12e4:	c798                	sw	a4,8(a5)
        p += p->s.size;
    12e6:	02071693          	slli	a3,a4,0x20
    12ea:	01c6d713          	srli	a4,a3,0x1c
    12ee:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    12f0:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    12f4:	00001717          	auipc	a4,0x1
    12f8:	d0a73e23          	sd	a0,-740(a4) # 2010 <freep>
      return (void*)(p + 1);
    12fc:	01078513          	addi	a0,a5,16
  }
}
    1300:	70e2                	ld	ra,56(sp)
    1302:	7442                	ld	s0,48(sp)
    1304:	74a2                	ld	s1,40(sp)
    1306:	69e2                	ld	s3,24(sp)
    1308:	6121                	addi	sp,sp,64
    130a:	8082                	ret
    130c:	7902                	ld	s2,32(sp)
    130e:	6a42                	ld	s4,16(sp)
    1310:	6aa2                	ld	s5,8(sp)
    1312:	6b02                	ld	s6,0(sp)
    1314:	b7f5                	j	1300 <malloc+0xe2>
