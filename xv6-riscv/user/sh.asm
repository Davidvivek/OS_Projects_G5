
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
      16:	23e58593          	addi	a1,a1,574 # 1250 <malloc+0xfa>
      1a:	4509                	li	a0,2
      1c:	477000ef          	jal	c92 <write>
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
      58:	20c58593          	addi	a1,a1,524 # 1260 <malloc+0x10a>
      5c:	4509                	li	a0,2
      5e:	01a010ef          	jal	1078 <fprintf>
  exit(1);
      62:	4505                	li	a0,1
      64:	40f000ef          	jal	c72 <exit>

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
      70:	3fb000ef          	jal	c6a <fork>
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
      86:	1e650513          	addi	a0,a0,486 # 1268 <malloc+0x112>
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
      b0:	2bc70713          	addi	a4,a4,700 # 1368 <malloc+0x212>
      b4:	97ba                	add	a5,a5,a4
      b6:	439c                	lw	a5,0(a5)
      b8:	97ba                	add	a5,a5,a4
      ba:	8782                	jr	a5
      bc:	eca6                	sd	s1,88(sp)
      be:	e8ca                	sd	s2,80(sp)
    exit(1);
      c0:	4505                	li	a0,1
      c2:	3b1000ef          	jal	c72 <exit>
    panic("runcmd");
      c6:	00001517          	auipc	a0,0x1
      ca:	1aa50513          	addi	a0,a0,426 # 1270 <malloc+0x11a>
      ce:	f7dff0ef          	jal	4a <panic>
    if(ecmd->argv[0] == 0)
      d2:	6508                	ld	a0,8(a0)
      d4:	c905                	beqz	a0,104 <runcmd+0x76>
    exec(ecmd->argv[0], ecmd->argv);
      d6:	00848913          	addi	s2,s1,8
      da:	85ca                	mv	a1,s2
      dc:	3cf000ef          	jal	caa <exec>
    if(ecmd->argv[0][0] != '/') {
      e0:	6488                	ld	a0,8(s1)
      e2:	00054703          	lbu	a4,0(a0)
      e6:	02f00793          	li	a5,47
      ea:	02f71063          	bne	a4,a5,10a <runcmd+0x7c>
    fprintf(2, "exec %s failed\n", ecmd->argv[0]);
      ee:	6490                	ld	a2,8(s1)
      f0:	00001597          	auipc	a1,0x1
      f4:	18858593          	addi	a1,a1,392 # 1278 <malloc+0x122>
      f8:	4509                	li	a0,2
      fa:	77f000ef          	jal	1078 <fprintf>
  exit(0);
      fe:	4501                	li	a0,0
     100:	373000ef          	jal	c72 <exit>
      exit(1);
     104:	4505                	li	a0,1
     106:	36d000ef          	jal	c72 <exit>
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
     134:	377000ef          	jal	caa <exec>
     138:	bf5d                	j	ee <runcmd+0x60>
    close(rcmd->fd);
     13a:	5148                	lw	a0,36(a0)
     13c:	35f000ef          	jal	c9a <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     140:	508c                	lw	a1,32(s1)
     142:	6888                	ld	a0,16(s1)
     144:	36f000ef          	jal	cb2 <open>
     148:	00054563          	bltz	a0,152 <runcmd+0xc4>
    runcmd(rcmd->cmd);
     14c:	6488                	ld	a0,8(s1)
     14e:	f41ff0ef          	jal	8e <runcmd>
      fprintf(2, "open %s failed\n", rcmd->file);
     152:	6890                	ld	a2,16(s1)
     154:	00001597          	auipc	a1,0x1
     158:	13458593          	addi	a1,a1,308 # 1288 <malloc+0x132>
     15c:	4509                	li	a0,2
     15e:	71b000ef          	jal	1078 <fprintf>
      exit(1);
     162:	4505                	li	a0,1
     164:	30f000ef          	jal	c72 <exit>
    if(fork1() == 0)
     168:	f01ff0ef          	jal	68 <fork1>
     16c:	e501                	bnez	a0,174 <runcmd+0xe6>
      runcmd(lcmd->left);
     16e:	6488                	ld	a0,8(s1)
     170:	f1fff0ef          	jal	8e <runcmd>
    wait(0);
     174:	4501                	li	a0,0
     176:	305000ef          	jal	c7a <wait>
    runcmd(lcmd->right);
     17a:	6888                	ld	a0,16(s1)
     17c:	f13ff0ef          	jal	8e <runcmd>
    if(pipe(p) < 0)
     180:	fd840513          	addi	a0,s0,-40
     184:	2ff000ef          	jal	c82 <pipe>
     188:	02054763          	bltz	a0,1b6 <runcmd+0x128>
    if(fork1() == 0){
     18c:	eddff0ef          	jal	68 <fork1>
     190:	e90d                	bnez	a0,1c2 <runcmd+0x134>
      close(1);
     192:	4505                	li	a0,1
     194:	307000ef          	jal	c9a <close>
      dup(p[1]);
     198:	fdc42503          	lw	a0,-36(s0)
     19c:	34f000ef          	jal	cea <dup>
      close(p[0]);
     1a0:	fd842503          	lw	a0,-40(s0)
     1a4:	2f7000ef          	jal	c9a <close>
      close(p[1]);
     1a8:	fdc42503          	lw	a0,-36(s0)
     1ac:	2ef000ef          	jal	c9a <close>
      runcmd(pcmd->left);
     1b0:	6488                	ld	a0,8(s1)
     1b2:	eddff0ef          	jal	8e <runcmd>
      panic("pipe");
     1b6:	00001517          	auipc	a0,0x1
     1ba:	0e250513          	addi	a0,a0,226 # 1298 <malloc+0x142>
     1be:	e8dff0ef          	jal	4a <panic>
    if(fork1() == 0){
     1c2:	ea7ff0ef          	jal	68 <fork1>
     1c6:	e115                	bnez	a0,1ea <runcmd+0x15c>
      close(0);
     1c8:	2d3000ef          	jal	c9a <close>
      dup(p[0]);
     1cc:	fd842503          	lw	a0,-40(s0)
     1d0:	31b000ef          	jal	cea <dup>
      close(p[0]);
     1d4:	fd842503          	lw	a0,-40(s0)
     1d8:	2c3000ef          	jal	c9a <close>
      close(p[1]);
     1dc:	fdc42503          	lw	a0,-36(s0)
     1e0:	2bb000ef          	jal	c9a <close>
      runcmd(pcmd->right);
     1e4:	6888                	ld	a0,16(s1)
     1e6:	ea9ff0ef          	jal	8e <runcmd>
    close(p[0]);
     1ea:	fd842503          	lw	a0,-40(s0)
     1ee:	2ad000ef          	jal	c9a <close>
    close(p[1]);
     1f2:	fdc42503          	lw	a0,-36(s0)
     1f6:	2a5000ef          	jal	c9a <close>
    wait(0);
     1fa:	4501                	li	a0,0
     1fc:	27f000ef          	jal	c7a <wait>
    wait(0);
     200:	4501                	li	a0,0
     202:	279000ef          	jal	c7a <wait>
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
     224:	733000ef          	jal	1156 <malloc>
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
     266:	6f1000ef          	jal	1156 <malloc>
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
     2b8:	69f000ef          	jal	1156 <malloc>
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
     2f6:	661000ef          	jal	1156 <malloc>
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
     330:	627000ef          	jal	1156 <malloc>
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
     514:	db0a8a93          	addi	s5,s5,-592 # 12c0 <malloc+0x16a>
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
     526:	d7e50513          	addi	a0,a0,-642 # 12a0 <malloc+0x14a>
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
     5e2:	cea60613          	addi	a2,a2,-790 # 12c8 <malloc+0x172>
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
     612:	cdab0b13          	addi	s6,s6,-806 # 12e8 <malloc+0x192>
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
     63c:	c9850513          	addi	a0,a0,-872 # 12d0 <malloc+0x17a>
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
     68e:	c4e50513          	addi	a0,a0,-946 # 12d8 <malloc+0x182>
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
     6cc:	c2860613          	addi	a2,a2,-984 # 12f0 <malloc+0x19a>
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
     728:	bd4a0a13          	addi	s4,s4,-1068 # 12f8 <malloc+0x1a2>
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
     752:	bb260613          	addi	a2,a2,-1102 # 1300 <malloc+0x1aa>
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
     7a8:	b2460613          	addi	a2,a2,-1244 # 12c8 <malloc+0x172>
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
     7cc:	b5060613          	addi	a2,a2,-1200 # 1318 <malloc+0x1c2>
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
     802:	b0a50513          	addi	a0,a0,-1270 # 1308 <malloc+0x1b2>
     806:	845ff0ef          	jal	4a <panic>
    panic("syntax - missing )");
     80a:	00001517          	auipc	a0,0x1
     80e:	b1650513          	addi	a0,a0,-1258 # 1320 <malloc+0x1ca>
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
     836:	b4e70713          	addi	a4,a4,-1202 # 1380 <malloc+0x22a>
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
     8c2:	99a60613          	addi	a2,a2,-1638 # 1258 <malloc+0x102>
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
     8f0:	a4c58593          	addi	a1,a1,-1460 # 1338 <malloc+0x1e2>
     8f4:	4509                	li	a0,2
     8f6:	782000ef          	jal	1078 <fprintf>
    panic("syntax");
     8fa:	00001517          	auipc	a0,0x1
     8fe:	9d650513          	addi	a0,a0,-1578 # 12d0 <malloc+0x17a>
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
     91e:	a2e48493          	addi	s1,s1,-1490 # 1348 <malloc+0x1f2>
     922:	4589                	li	a1,2
     924:	8526                	mv	a0,s1
     926:	38c000ef          	jal	cb2 <open>
     92a:	00054763          	bltz	a0,938 <main+0x32>
    if(fd >= 3){
     92e:	4789                	li	a5,2
     930:	fea7d9e3          	bge	a5,a0,922 <main+0x1c>
      close(fd);
     934:	366000ef          	jal	c9a <close>
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
     978:	302000ef          	jal	c7a <wait>
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
     9b4:	32e000ef          	jal	ce2 <chdir>
     9b8:	fc0552e3          	bgez	a0,97c <main+0x76>
        fprintf(2, "cannot cd %s\n", cmd+3);
     9bc:	8626                	mv	a2,s1
     9be:	00001597          	auipc	a1,0x1
     9c2:	99258593          	addi	a1,a1,-1646 # 1350 <malloc+0x1fa>
     9c6:	4509                	li	a0,2
     9c8:	6b0000ef          	jal	1078 <fprintf>
     9cc:	bf45                	j	97c <main+0x76>
        runcmd(parsecmd(cmd));
     9ce:	8526                	mv	a0,s1
     9d0:	ec7ff0ef          	jal	896 <parsecmd>
     9d4:	ebaff0ef          	jal	8e <runcmd>
  exit(0);
     9d8:	4501                	li	a0,0
     9da:	298000ef          	jal	c72 <exit>

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
     9ea:	288000ef          	jal	c72 <exit>

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
     ad8:	1b2000ef          	jal	c8a <read>
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
     b24:	18e000ef          	jal	cb2 <open>
  if(fd < 0)
     b28:	02054263          	bltz	a0,b4c <stat+0x36>
     b2c:	e426                	sd	s1,8(sp)
     b2e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     b30:	85ca                	mv	a1,s2
     b32:	198000ef          	jal	cca <fstat>
     b36:	892a                	mv	s2,a0
  close(fd);
     b38:	8526                	mv	a0,s1
     b3a:	160000ef          	jal	c9a <close>
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
     c48:	0b2000ef          	jal	cfa <sys_sbrk>
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
     c5e:	09c000ef          	jal	cfa <sys_sbrk>
}
     c62:	60a2                	ld	ra,8(sp)
     c64:	6402                	ld	s0,0(sp)
     c66:	0141                	addi	sp,sp,16
     c68:	8082                	ret

0000000000000c6a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     c6a:	4885                	li	a7,1
 ecall
     c6c:	00000073          	ecall
 ret
     c70:	8082                	ret

0000000000000c72 <exit>:
.global exit
exit:
 li a7, SYS_exit
     c72:	4889                	li	a7,2
 ecall
     c74:	00000073          	ecall
 ret
     c78:	8082                	ret

0000000000000c7a <wait>:
.global wait
wait:
 li a7, SYS_wait
     c7a:	488d                	li	a7,3
 ecall
     c7c:	00000073          	ecall
 ret
     c80:	8082                	ret

0000000000000c82 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     c82:	4891                	li	a7,4
 ecall
     c84:	00000073          	ecall
 ret
     c88:	8082                	ret

0000000000000c8a <read>:
.global read
read:
 li a7, SYS_read
     c8a:	4895                	li	a7,5
 ecall
     c8c:	00000073          	ecall
 ret
     c90:	8082                	ret

0000000000000c92 <write>:
.global write
write:
 li a7, SYS_write
     c92:	48c1                	li	a7,16
 ecall
     c94:	00000073          	ecall
 ret
     c98:	8082                	ret

0000000000000c9a <close>:
.global close
close:
 li a7, SYS_close
     c9a:	48d5                	li	a7,21
 ecall
     c9c:	00000073          	ecall
 ret
     ca0:	8082                	ret

0000000000000ca2 <kill>:
.global kill
kill:
 li a7, SYS_kill
     ca2:	4899                	li	a7,6
 ecall
     ca4:	00000073          	ecall
 ret
     ca8:	8082                	ret

0000000000000caa <exec>:
.global exec
exec:
 li a7, SYS_exec
     caa:	489d                	li	a7,7
 ecall
     cac:	00000073          	ecall
 ret
     cb0:	8082                	ret

0000000000000cb2 <open>:
.global open
open:
 li a7, SYS_open
     cb2:	48bd                	li	a7,15
 ecall
     cb4:	00000073          	ecall
 ret
     cb8:	8082                	ret

0000000000000cba <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     cba:	48c5                	li	a7,17
 ecall
     cbc:	00000073          	ecall
 ret
     cc0:	8082                	ret

0000000000000cc2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     cc2:	48c9                	li	a7,18
 ecall
     cc4:	00000073          	ecall
 ret
     cc8:	8082                	ret

0000000000000cca <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     cca:	48a1                	li	a7,8
 ecall
     ccc:	00000073          	ecall
 ret
     cd0:	8082                	ret

0000000000000cd2 <link>:
.global link
link:
 li a7, SYS_link
     cd2:	48cd                	li	a7,19
 ecall
     cd4:	00000073          	ecall
 ret
     cd8:	8082                	ret

0000000000000cda <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     cda:	48d1                	li	a7,20
 ecall
     cdc:	00000073          	ecall
 ret
     ce0:	8082                	ret

0000000000000ce2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     ce2:	48a5                	li	a7,9
 ecall
     ce4:	00000073          	ecall
 ret
     ce8:	8082                	ret

0000000000000cea <dup>:
.global dup
dup:
 li a7, SYS_dup
     cea:	48a9                	li	a7,10
 ecall
     cec:	00000073          	ecall
 ret
     cf0:	8082                	ret

0000000000000cf2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     cf2:	48ad                	li	a7,11
 ecall
     cf4:	00000073          	ecall
 ret
     cf8:	8082                	ret

0000000000000cfa <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
     cfa:	48b1                	li	a7,12
 ecall
     cfc:	00000073          	ecall
 ret
     d00:	8082                	ret

0000000000000d02 <pause>:
.global pause
pause:
 li a7, SYS_pause
     d02:	48b5                	li	a7,13
 ecall
     d04:	00000073          	ecall
 ret
     d08:	8082                	ret

0000000000000d0a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     d0a:	48b9                	li	a7,14
 ecall
     d0c:	00000073          	ecall
 ret
     d10:	8082                	ret

0000000000000d12 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
     d12:	48d9                	li	a7,22
 ecall
     d14:	00000073          	ecall
 ret
     d18:	8082                	ret

0000000000000d1a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     d1a:	1101                	addi	sp,sp,-32
     d1c:	ec06                	sd	ra,24(sp)
     d1e:	e822                	sd	s0,16(sp)
     d20:	1000                	addi	s0,sp,32
     d22:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     d26:	4605                	li	a2,1
     d28:	fef40593          	addi	a1,s0,-17
     d2c:	f67ff0ef          	jal	c92 <write>
}
     d30:	60e2                	ld	ra,24(sp)
     d32:	6442                	ld	s0,16(sp)
     d34:	6105                	addi	sp,sp,32
     d36:	8082                	ret

0000000000000d38 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
     d38:	715d                	addi	sp,sp,-80
     d3a:	e486                	sd	ra,72(sp)
     d3c:	e0a2                	sd	s0,64(sp)
     d3e:	f84a                	sd	s2,48(sp)
     d40:	0880                	addi	s0,sp,80
     d42:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
     d44:	c299                	beqz	a3,d4a <printint+0x12>
     d46:	0805c363          	bltz	a1,dcc <printint+0x94>
  neg = 0;
     d4a:	4881                	li	a7,0
     d4c:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
     d50:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
     d52:	00000517          	auipc	a0,0x0
     d56:	64650513          	addi	a0,a0,1606 # 1398 <digits>
     d5a:	883e                	mv	a6,a5
     d5c:	2785                	addiw	a5,a5,1
     d5e:	02c5f733          	remu	a4,a1,a2
     d62:	972a                	add	a4,a4,a0
     d64:	00074703          	lbu	a4,0(a4)
     d68:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
     d6c:	872e                	mv	a4,a1
     d6e:	02c5d5b3          	divu	a1,a1,a2
     d72:	0685                	addi	a3,a3,1
     d74:	fec773e3          	bgeu	a4,a2,d5a <printint+0x22>
  if(neg)
     d78:	00088b63          	beqz	a7,d8e <printint+0x56>
    buf[i++] = '-';
     d7c:	fd078793          	addi	a5,a5,-48
     d80:	97a2                	add	a5,a5,s0
     d82:	02d00713          	li	a4,45
     d86:	fee78423          	sb	a4,-24(a5)
     d8a:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
     d8e:	02f05a63          	blez	a5,dc2 <printint+0x8a>
     d92:	fc26                	sd	s1,56(sp)
     d94:	f44e                	sd	s3,40(sp)
     d96:	fb840713          	addi	a4,s0,-72
     d9a:	00f704b3          	add	s1,a4,a5
     d9e:	fff70993          	addi	s3,a4,-1
     da2:	99be                	add	s3,s3,a5
     da4:	37fd                	addiw	a5,a5,-1
     da6:	1782                	slli	a5,a5,0x20
     da8:	9381                	srli	a5,a5,0x20
     daa:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
     dae:	fff4c583          	lbu	a1,-1(s1)
     db2:	854a                	mv	a0,s2
     db4:	f67ff0ef          	jal	d1a <putc>
  while(--i >= 0)
     db8:	14fd                	addi	s1,s1,-1
     dba:	ff349ae3          	bne	s1,s3,dae <printint+0x76>
     dbe:	74e2                	ld	s1,56(sp)
     dc0:	79a2                	ld	s3,40(sp)
}
     dc2:	60a6                	ld	ra,72(sp)
     dc4:	6406                	ld	s0,64(sp)
     dc6:	7942                	ld	s2,48(sp)
     dc8:	6161                	addi	sp,sp,80
     dca:	8082                	ret
    x = -xx;
     dcc:	40b005b3          	neg	a1,a1
    neg = 1;
     dd0:	4885                	li	a7,1
    x = -xx;
     dd2:	bfad                	j	d4c <printint+0x14>

0000000000000dd4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     dd4:	711d                	addi	sp,sp,-96
     dd6:	ec86                	sd	ra,88(sp)
     dd8:	e8a2                	sd	s0,80(sp)
     dda:	e0ca                	sd	s2,64(sp)
     ddc:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
     dde:	0005c903          	lbu	s2,0(a1)
     de2:	28090663          	beqz	s2,106e <vprintf+0x29a>
     de6:	e4a6                	sd	s1,72(sp)
     de8:	fc4e                	sd	s3,56(sp)
     dea:	f852                	sd	s4,48(sp)
     dec:	f456                	sd	s5,40(sp)
     dee:	f05a                	sd	s6,32(sp)
     df0:	ec5e                	sd	s7,24(sp)
     df2:	e862                	sd	s8,16(sp)
     df4:	e466                	sd	s9,8(sp)
     df6:	8b2a                	mv	s6,a0
     df8:	8a2e                	mv	s4,a1
     dfa:	8bb2                	mv	s7,a2
  state = 0;
     dfc:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
     dfe:	4481                	li	s1,0
     e00:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
     e02:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
     e06:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
     e0a:	06c00c93          	li	s9,108
     e0e:	a005                	j	e2e <vprintf+0x5a>
        putc(fd, c0);
     e10:	85ca                	mv	a1,s2
     e12:	855a                	mv	a0,s6
     e14:	f07ff0ef          	jal	d1a <putc>
     e18:	a019                	j	e1e <vprintf+0x4a>
    } else if(state == '%'){
     e1a:	03598263          	beq	s3,s5,e3e <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
     e1e:	2485                	addiw	s1,s1,1
     e20:	8726                	mv	a4,s1
     e22:	009a07b3          	add	a5,s4,s1
     e26:	0007c903          	lbu	s2,0(a5)
     e2a:	22090a63          	beqz	s2,105e <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
     e2e:	0009079b          	sext.w	a5,s2
    if(state == 0){
     e32:	fe0994e3          	bnez	s3,e1a <vprintf+0x46>
      if(c0 == '%'){
     e36:	fd579de3          	bne	a5,s5,e10 <vprintf+0x3c>
        state = '%';
     e3a:	89be                	mv	s3,a5
     e3c:	b7cd                	j	e1e <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
     e3e:	00ea06b3          	add	a3,s4,a4
     e42:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
     e46:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
     e48:	c681                	beqz	a3,e50 <vprintf+0x7c>
     e4a:	9752                	add	a4,a4,s4
     e4c:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
     e50:	05878363          	beq	a5,s8,e96 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
     e54:	05978d63          	beq	a5,s9,eae <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
     e58:	07500713          	li	a4,117
     e5c:	0ee78763          	beq	a5,a4,f4a <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
     e60:	07800713          	li	a4,120
     e64:	12e78963          	beq	a5,a4,f96 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
     e68:	07000713          	li	a4,112
     e6c:	14e78e63          	beq	a5,a4,fc8 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
     e70:	06300713          	li	a4,99
     e74:	18e78e63          	beq	a5,a4,1010 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
     e78:	07300713          	li	a4,115
     e7c:	1ae78463          	beq	a5,a4,1024 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
     e80:	02500713          	li	a4,37
     e84:	04e79563          	bne	a5,a4,ece <vprintf+0xfa>
        putc(fd, '%');
     e88:	02500593          	li	a1,37
     e8c:	855a                	mv	a0,s6
     e8e:	e8dff0ef          	jal	d1a <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
     e92:	4981                	li	s3,0
     e94:	b769                	j	e1e <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
     e96:	008b8913          	addi	s2,s7,8
     e9a:	4685                	li	a3,1
     e9c:	4629                	li	a2,10
     e9e:	000ba583          	lw	a1,0(s7)
     ea2:	855a                	mv	a0,s6
     ea4:	e95ff0ef          	jal	d38 <printint>
     ea8:	8bca                	mv	s7,s2
      state = 0;
     eaa:	4981                	li	s3,0
     eac:	bf8d                	j	e1e <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
     eae:	06400793          	li	a5,100
     eb2:	02f68963          	beq	a3,a5,ee4 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     eb6:	06c00793          	li	a5,108
     eba:	04f68263          	beq	a3,a5,efe <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
     ebe:	07500793          	li	a5,117
     ec2:	0af68063          	beq	a3,a5,f62 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
     ec6:	07800793          	li	a5,120
     eca:	0ef68263          	beq	a3,a5,fae <vprintf+0x1da>
        putc(fd, '%');
     ece:	02500593          	li	a1,37
     ed2:	855a                	mv	a0,s6
     ed4:	e47ff0ef          	jal	d1a <putc>
        putc(fd, c0);
     ed8:	85ca                	mv	a1,s2
     eda:	855a                	mv	a0,s6
     edc:	e3fff0ef          	jal	d1a <putc>
      state = 0;
     ee0:	4981                	li	s3,0
     ee2:	bf35                	j	e1e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
     ee4:	008b8913          	addi	s2,s7,8
     ee8:	4685                	li	a3,1
     eea:	4629                	li	a2,10
     eec:	000bb583          	ld	a1,0(s7)
     ef0:	855a                	mv	a0,s6
     ef2:	e47ff0ef          	jal	d38 <printint>
        i += 1;
     ef6:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
     ef8:	8bca                	mv	s7,s2
      state = 0;
     efa:	4981                	li	s3,0
        i += 1;
     efc:	b70d                	j	e1e <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     efe:	06400793          	li	a5,100
     f02:	02f60763          	beq	a2,a5,f30 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
     f06:	07500793          	li	a5,117
     f0a:	06f60963          	beq	a2,a5,f7c <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
     f0e:	07800793          	li	a5,120
     f12:	faf61ee3          	bne	a2,a5,ece <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
     f16:	008b8913          	addi	s2,s7,8
     f1a:	4681                	li	a3,0
     f1c:	4641                	li	a2,16
     f1e:	000bb583          	ld	a1,0(s7)
     f22:	855a                	mv	a0,s6
     f24:	e15ff0ef          	jal	d38 <printint>
        i += 2;
     f28:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
     f2a:	8bca                	mv	s7,s2
      state = 0;
     f2c:	4981                	li	s3,0
        i += 2;
     f2e:	bdc5                	j	e1e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
     f30:	008b8913          	addi	s2,s7,8
     f34:	4685                	li	a3,1
     f36:	4629                	li	a2,10
     f38:	000bb583          	ld	a1,0(s7)
     f3c:	855a                	mv	a0,s6
     f3e:	dfbff0ef          	jal	d38 <printint>
        i += 2;
     f42:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
     f44:	8bca                	mv	s7,s2
      state = 0;
     f46:	4981                	li	s3,0
        i += 2;
     f48:	bdd9                	j	e1e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
     f4a:	008b8913          	addi	s2,s7,8
     f4e:	4681                	li	a3,0
     f50:	4629                	li	a2,10
     f52:	000be583          	lwu	a1,0(s7)
     f56:	855a                	mv	a0,s6
     f58:	de1ff0ef          	jal	d38 <printint>
     f5c:	8bca                	mv	s7,s2
      state = 0;
     f5e:	4981                	li	s3,0
     f60:	bd7d                	j	e1e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
     f62:	008b8913          	addi	s2,s7,8
     f66:	4681                	li	a3,0
     f68:	4629                	li	a2,10
     f6a:	000bb583          	ld	a1,0(s7)
     f6e:	855a                	mv	a0,s6
     f70:	dc9ff0ef          	jal	d38 <printint>
        i += 1;
     f74:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
     f76:	8bca                	mv	s7,s2
      state = 0;
     f78:	4981                	li	s3,0
        i += 1;
     f7a:	b555                	j	e1e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
     f7c:	008b8913          	addi	s2,s7,8
     f80:	4681                	li	a3,0
     f82:	4629                	li	a2,10
     f84:	000bb583          	ld	a1,0(s7)
     f88:	855a                	mv	a0,s6
     f8a:	dafff0ef          	jal	d38 <printint>
        i += 2;
     f8e:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
     f90:	8bca                	mv	s7,s2
      state = 0;
     f92:	4981                	li	s3,0
        i += 2;
     f94:	b569                	j	e1e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
     f96:	008b8913          	addi	s2,s7,8
     f9a:	4681                	li	a3,0
     f9c:	4641                	li	a2,16
     f9e:	000be583          	lwu	a1,0(s7)
     fa2:	855a                	mv	a0,s6
     fa4:	d95ff0ef          	jal	d38 <printint>
     fa8:	8bca                	mv	s7,s2
      state = 0;
     faa:	4981                	li	s3,0
     fac:	bd8d                	j	e1e <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
     fae:	008b8913          	addi	s2,s7,8
     fb2:	4681                	li	a3,0
     fb4:	4641                	li	a2,16
     fb6:	000bb583          	ld	a1,0(s7)
     fba:	855a                	mv	a0,s6
     fbc:	d7dff0ef          	jal	d38 <printint>
        i += 1;
     fc0:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
     fc2:	8bca                	mv	s7,s2
      state = 0;
     fc4:	4981                	li	s3,0
        i += 1;
     fc6:	bda1                	j	e1e <vprintf+0x4a>
     fc8:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
     fca:	008b8d13          	addi	s10,s7,8
     fce:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
     fd2:	03000593          	li	a1,48
     fd6:	855a                	mv	a0,s6
     fd8:	d43ff0ef          	jal	d1a <putc>
  putc(fd, 'x');
     fdc:	07800593          	li	a1,120
     fe0:	855a                	mv	a0,s6
     fe2:	d39ff0ef          	jal	d1a <putc>
     fe6:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     fe8:	00000b97          	auipc	s7,0x0
     fec:	3b0b8b93          	addi	s7,s7,944 # 1398 <digits>
     ff0:	03c9d793          	srli	a5,s3,0x3c
     ff4:	97de                	add	a5,a5,s7
     ff6:	0007c583          	lbu	a1,0(a5)
     ffa:	855a                	mv	a0,s6
     ffc:	d1fff0ef          	jal	d1a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1000:	0992                	slli	s3,s3,0x4
    1002:	397d                	addiw	s2,s2,-1
    1004:	fe0916e3          	bnez	s2,ff0 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
    1008:	8bea                	mv	s7,s10
      state = 0;
    100a:	4981                	li	s3,0
    100c:	6d02                	ld	s10,0(sp)
    100e:	bd01                	j	e1e <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
    1010:	008b8913          	addi	s2,s7,8
    1014:	000bc583          	lbu	a1,0(s7)
    1018:	855a                	mv	a0,s6
    101a:	d01ff0ef          	jal	d1a <putc>
    101e:	8bca                	mv	s7,s2
      state = 0;
    1020:	4981                	li	s3,0
    1022:	bbf5                	j	e1e <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
    1024:	008b8993          	addi	s3,s7,8
    1028:	000bb903          	ld	s2,0(s7)
    102c:	00090f63          	beqz	s2,104a <vprintf+0x276>
        for(; *s; s++)
    1030:	00094583          	lbu	a1,0(s2)
    1034:	c195                	beqz	a1,1058 <vprintf+0x284>
          putc(fd, *s);
    1036:	855a                	mv	a0,s6
    1038:	ce3ff0ef          	jal	d1a <putc>
        for(; *s; s++)
    103c:	0905                	addi	s2,s2,1
    103e:	00094583          	lbu	a1,0(s2)
    1042:	f9f5                	bnez	a1,1036 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
    1044:	8bce                	mv	s7,s3
      state = 0;
    1046:	4981                	li	s3,0
    1048:	bbd9                	j	e1e <vprintf+0x4a>
          s = "(null)";
    104a:	00000917          	auipc	s2,0x0
    104e:	31690913          	addi	s2,s2,790 # 1360 <malloc+0x20a>
        for(; *s; s++)
    1052:	02800593          	li	a1,40
    1056:	b7c5                	j	1036 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
    1058:	8bce                	mv	s7,s3
      state = 0;
    105a:	4981                	li	s3,0
    105c:	b3c9                	j	e1e <vprintf+0x4a>
    105e:	64a6                	ld	s1,72(sp)
    1060:	79e2                	ld	s3,56(sp)
    1062:	7a42                	ld	s4,48(sp)
    1064:	7aa2                	ld	s5,40(sp)
    1066:	7b02                	ld	s6,32(sp)
    1068:	6be2                	ld	s7,24(sp)
    106a:	6c42                	ld	s8,16(sp)
    106c:	6ca2                	ld	s9,8(sp)
    }
  }
}
    106e:	60e6                	ld	ra,88(sp)
    1070:	6446                	ld	s0,80(sp)
    1072:	6906                	ld	s2,64(sp)
    1074:	6125                	addi	sp,sp,96
    1076:	8082                	ret

0000000000001078 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    1078:	715d                	addi	sp,sp,-80
    107a:	ec06                	sd	ra,24(sp)
    107c:	e822                	sd	s0,16(sp)
    107e:	1000                	addi	s0,sp,32
    1080:	e010                	sd	a2,0(s0)
    1082:	e414                	sd	a3,8(s0)
    1084:	e818                	sd	a4,16(s0)
    1086:	ec1c                	sd	a5,24(s0)
    1088:	03043023          	sd	a6,32(s0)
    108c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    1090:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    1094:	8622                	mv	a2,s0
    1096:	d3fff0ef          	jal	dd4 <vprintf>
}
    109a:	60e2                	ld	ra,24(sp)
    109c:	6442                	ld	s0,16(sp)
    109e:	6161                	addi	sp,sp,80
    10a0:	8082                	ret

00000000000010a2 <printf>:

void
printf(const char *fmt, ...)
{
    10a2:	711d                	addi	sp,sp,-96
    10a4:	ec06                	sd	ra,24(sp)
    10a6:	e822                	sd	s0,16(sp)
    10a8:	1000                	addi	s0,sp,32
    10aa:	e40c                	sd	a1,8(s0)
    10ac:	e810                	sd	a2,16(s0)
    10ae:	ec14                	sd	a3,24(s0)
    10b0:	f018                	sd	a4,32(s0)
    10b2:	f41c                	sd	a5,40(s0)
    10b4:	03043823          	sd	a6,48(s0)
    10b8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    10bc:	00840613          	addi	a2,s0,8
    10c0:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    10c4:	85aa                	mv	a1,a0
    10c6:	4505                	li	a0,1
    10c8:	d0dff0ef          	jal	dd4 <vprintf>
}
    10cc:	60e2                	ld	ra,24(sp)
    10ce:	6442                	ld	s0,16(sp)
    10d0:	6125                	addi	sp,sp,96
    10d2:	8082                	ret

00000000000010d4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    10d4:	1141                	addi	sp,sp,-16
    10d6:	e422                	sd	s0,8(sp)
    10d8:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    10da:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    10de:	00001797          	auipc	a5,0x1
    10e2:	f327b783          	ld	a5,-206(a5) # 2010 <freep>
    10e6:	a02d                	j	1110 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    10e8:	4618                	lw	a4,8(a2)
    10ea:	9f2d                	addw	a4,a4,a1
    10ec:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    10f0:	6398                	ld	a4,0(a5)
    10f2:	6310                	ld	a2,0(a4)
    10f4:	a83d                	j	1132 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    10f6:	ff852703          	lw	a4,-8(a0)
    10fa:	9f31                	addw	a4,a4,a2
    10fc:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    10fe:	ff053683          	ld	a3,-16(a0)
    1102:	a091                	j	1146 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1104:	6398                	ld	a4,0(a5)
    1106:	00e7e463          	bltu	a5,a4,110e <free+0x3a>
    110a:	00e6ea63          	bltu	a3,a4,111e <free+0x4a>
{
    110e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1110:	fed7fae3          	bgeu	a5,a3,1104 <free+0x30>
    1114:	6398                	ld	a4,0(a5)
    1116:	00e6e463          	bltu	a3,a4,111e <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    111a:	fee7eae3          	bltu	a5,a4,110e <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
    111e:	ff852583          	lw	a1,-8(a0)
    1122:	6390                	ld	a2,0(a5)
    1124:	02059813          	slli	a6,a1,0x20
    1128:	01c85713          	srli	a4,a6,0x1c
    112c:	9736                	add	a4,a4,a3
    112e:	fae60de3          	beq	a2,a4,10e8 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    1132:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    1136:	4790                	lw	a2,8(a5)
    1138:	02061593          	slli	a1,a2,0x20
    113c:	01c5d713          	srli	a4,a1,0x1c
    1140:	973e                	add	a4,a4,a5
    1142:	fae68ae3          	beq	a3,a4,10f6 <free+0x22>
    p->s.ptr = bp->s.ptr;
    1146:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    1148:	00001717          	auipc	a4,0x1
    114c:	ecf73423          	sd	a5,-312(a4) # 2010 <freep>
}
    1150:	6422                	ld	s0,8(sp)
    1152:	0141                	addi	sp,sp,16
    1154:	8082                	ret

0000000000001156 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1156:	7139                	addi	sp,sp,-64
    1158:	fc06                	sd	ra,56(sp)
    115a:	f822                	sd	s0,48(sp)
    115c:	f426                	sd	s1,40(sp)
    115e:	ec4e                	sd	s3,24(sp)
    1160:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1162:	02051493          	slli	s1,a0,0x20
    1166:	9081                	srli	s1,s1,0x20
    1168:	04bd                	addi	s1,s1,15
    116a:	8091                	srli	s1,s1,0x4
    116c:	0014899b          	addiw	s3,s1,1
    1170:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    1172:	00001517          	auipc	a0,0x1
    1176:	e9e53503          	ld	a0,-354(a0) # 2010 <freep>
    117a:	c915                	beqz	a0,11ae <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    117c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    117e:	4798                	lw	a4,8(a5)
    1180:	08977a63          	bgeu	a4,s1,1214 <malloc+0xbe>
    1184:	f04a                	sd	s2,32(sp)
    1186:	e852                	sd	s4,16(sp)
    1188:	e456                	sd	s5,8(sp)
    118a:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    118c:	8a4e                	mv	s4,s3
    118e:	0009871b          	sext.w	a4,s3
    1192:	6685                	lui	a3,0x1
    1194:	00d77363          	bgeu	a4,a3,119a <malloc+0x44>
    1198:	6a05                	lui	s4,0x1
    119a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    119e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    11a2:	00001917          	auipc	s2,0x1
    11a6:	e6e90913          	addi	s2,s2,-402 # 2010 <freep>
  if(p == SBRK_ERROR)
    11aa:	5afd                	li	s5,-1
    11ac:	a081                	j	11ec <malloc+0x96>
    11ae:	f04a                	sd	s2,32(sp)
    11b0:	e852                	sd	s4,16(sp)
    11b2:	e456                	sd	s5,8(sp)
    11b4:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    11b6:	00001797          	auipc	a5,0x1
    11ba:	ed278793          	addi	a5,a5,-302 # 2088 <base>
    11be:	00001717          	auipc	a4,0x1
    11c2:	e4f73923          	sd	a5,-430(a4) # 2010 <freep>
    11c6:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    11c8:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    11cc:	b7c1                	j	118c <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
    11ce:	6398                	ld	a4,0(a5)
    11d0:	e118                	sd	a4,0(a0)
    11d2:	a8a9                	j	122c <malloc+0xd6>
  hp->s.size = nu;
    11d4:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    11d8:	0541                	addi	a0,a0,16
    11da:	efbff0ef          	jal	10d4 <free>
  return freep;
    11de:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    11e2:	c12d                	beqz	a0,1244 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    11e4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    11e6:	4798                	lw	a4,8(a5)
    11e8:	02977263          	bgeu	a4,s1,120c <malloc+0xb6>
    if(p == freep)
    11ec:	00093703          	ld	a4,0(s2)
    11f0:	853e                	mv	a0,a5
    11f2:	fef719e3          	bne	a4,a5,11e4 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
    11f6:	8552                	mv	a0,s4
    11f8:	a47ff0ef          	jal	c3e <sbrk>
  if(p == SBRK_ERROR)
    11fc:	fd551ce3          	bne	a0,s5,11d4 <malloc+0x7e>
        return 0;
    1200:	4501                	li	a0,0
    1202:	7902                	ld	s2,32(sp)
    1204:	6a42                	ld	s4,16(sp)
    1206:	6aa2                	ld	s5,8(sp)
    1208:	6b02                	ld	s6,0(sp)
    120a:	a03d                	j	1238 <malloc+0xe2>
    120c:	7902                	ld	s2,32(sp)
    120e:	6a42                	ld	s4,16(sp)
    1210:	6aa2                	ld	s5,8(sp)
    1212:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    1214:	fae48de3          	beq	s1,a4,11ce <malloc+0x78>
        p->s.size -= nunits;
    1218:	4137073b          	subw	a4,a4,s3
    121c:	c798                	sw	a4,8(a5)
        p += p->s.size;
    121e:	02071693          	slli	a3,a4,0x20
    1222:	01c6d713          	srli	a4,a3,0x1c
    1226:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    1228:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    122c:	00001717          	auipc	a4,0x1
    1230:	dea73223          	sd	a0,-540(a4) # 2010 <freep>
      return (void*)(p + 1);
    1234:	01078513          	addi	a0,a5,16
  }
}
    1238:	70e2                	ld	ra,56(sp)
    123a:	7442                	ld	s0,48(sp)
    123c:	74a2                	ld	s1,40(sp)
    123e:	69e2                	ld	s3,24(sp)
    1240:	6121                	addi	sp,sp,64
    1242:	8082                	ret
    1244:	7902                	ld	s2,32(sp)
    1246:	6a42                	ld	s4,16(sp)
    1248:	6aa2                	ld	s5,8(sp)
    124a:	6b02                	ld	s6,0(sp)
    124c:	b7f5                	j	1238 <malloc+0xe2>
