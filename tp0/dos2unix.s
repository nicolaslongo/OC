	.file	1 "dos2unix.c"
	.section .mdebug.abi32
	.previous
	.abicalls
	.globl	CR
	.rdata
	.type	CR, @object
	.size	CR, 1
CR:
	.byte	13
	.globl	LF
	.type	LF, @object
	.size	LF, 1
LF:
	.byte	10
	.align	2
$LC0:
	.ascii	"Los par\303\241metros ingresados no son v\303\241lidos.\n"
	.ascii	"\000"
	.text
	.align	2
	.globl	mostrarMensajeErrorParametrosInvalidos
	.ent	mostrarMensajeErrorParametrosInvalidos
mostrarMensajeErrorParametrosInvalidos:
	.frame	$fp,40,$ra		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$ra,32($sp)
	sw	$fp,28($sp)
	sw	$gp,24($sp)
	move	$fp,$sp
	la	$a0,__sF+176
	la	$a1,$LC0
	la	$t9,fprintf
	jal	$ra,$t9
	li	$v0,-1			# 0xffffffffffffffff
	move	$sp,$fp
	lw	$ra,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$ra
	.end	mostrarMensajeErrorParametrosInvalidos
	.size	mostrarMensajeErrorParametrosInvalidos, .-mostrarMensajeErrorParametrosInvalidos
	.align	2
	.globl	windowsToLinux
	.ent	windowsToLinux
windowsToLinux:
	.frame	$fp,48,$ra		# vars= 8, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$ra,40($sp)
	sw	$fp,36($sp)
	sw	$gp,32($sp)
	move	$fp,$sp
	sw	$a0,48($fp)
	sw	$a1,52($fp)
$L19:
	lw	$a0,48($fp)
	la	$t9,fgetc
	jal	$ra,$t9
	sw	$v0,24($fp)
	lw	$v1,24($fp)
	li	$v0,-1			# 0xffffffffffffffff
	bne	$v1,$v0,$L21
	b	$L18
$L21:
	lb	$v1,CR
	lw	$v0,24($fp)
	bne	$v0,$v1,$L22
	lw	$a0,48($fp)
	la	$t9,fgetc
	jal	$ra,$t9
	sw	$v0,28($fp)
	lw	$v1,28($fp)
	li	$v0,-1			# 0xffffffffffffffff
	bne	$v1,$v0,$L23
	lb	$v0,CR
	move	$a0,$v0
	lw	$a1,52($fp)
	la	$t9,fputc
	jal	$ra,$t9
	b	$L18
$L23:
	lb	$v1,LF
	lw	$v0,28($fp)
	bne	$v0,$v1,$L25
	lb	$v0,LF
	move	$a0,$v0
	lw	$a1,52($fp)
	la	$t9,fputc
	jal	$ra,$t9
	b	$L19
$L25:
	lb	$v0,CR
	move	$a0,$v0
	lw	$a1,52($fp)
	la	$t9,fputc
	jal	$ra,$t9
	lw	$a0,28($fp)
	lw	$a1,52($fp)
	la	$t9,fputc
	jal	$ra,$t9
	b	$L19
$L22:
	lw	$a0,24($fp)
	lw	$a1,52($fp)
	la	$t9,fputc
	jal	$ra,$t9
	b	$L19
$L18:
	move	$sp,$fp
	lw	$ra,40($sp)
	lw	$fp,36($sp)
	addu	$sp,$sp,48
	j	$ra
	.end	windowsToLinux
	.size	windowsToLinux, .-windowsToLinux
	.rdata
	.align	2
$LC1:
	.ascii	"-i\000"
	.align	2
$LC2:
	.ascii	"-\000"
	.align	2
$LC3:
	.ascii	"-o\000"
	.align	2
$LC4:
	.ascii	"rt\000"
	.align	2
$LC5:
	.ascii	"No se pudo abrir el archivo de entrada\n\000"
	.align	2
$LC6:
	.ascii	"wt\000"
	.align	2
$LC7:
	.ascii	"No se pudo abrir el archivo de salida\n\000"
	.text
	.align	2
	.globl	main
	.ent	main
main:
	.frame	$fp,72,$ra		# vars= 32, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,72
	.cprestore 16
	sw	$ra,64($sp)
	sw	$fp,60($sp)
	sw	$gp,56($sp)
	move	$fp,$sp
	sw	$a0,72($fp)
	sw	$a1,76($fp)
	sw	$zero,24($fp)
	sw	$zero,28($fp)
	sw	$zero,32($fp)
	sw	$zero,36($fp)
	lw	$v0,72($fp)
	slt	$v0,$v0,6
	beq	$v0,$zero,$L30
	lw	$v1,72($fp)
	li	$v0,4			# 0x4
	beq	$v1,$v0,$L30
	lw	$v1,72($fp)
	li	$v0,2			# 0x2
	beq	$v1,$v0,$L30
	b	$L29
$L30:
	la	$t9,mostrarMensajeErrorParametrosInvalidos
	jal	$ra,$t9
	sw	$v0,48($fp)
	b	$L28
$L29:
	lw	$v0,72($fp)
	slt	$v0,$v0,3
	bne	$v0,$zero,$L31
	lw	$v0,76($fp)
	addu	$v0,$v0,4
	lw	$a0,0($v0)
	la	$a1,$LC1
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L32
	lw	$v0,76($fp)
	addu	$v0,$v0,8
	lw	$a0,0($v0)
	la	$a1,$LC2
	la	$t9,strcmp
	jal	$ra,$t9
	beq	$v0,$zero,$L34
	lw	$v0,76($fp)
	addu	$v0,$v0,8
	lw	$v0,0($v0)
	sw	$v0,32($fp)
	li	$v0,1			# 0x1
	sw	$v0,24($fp)
	b	$L34
$L32:
	lw	$v0,76($fp)
	addu	$v0,$v0,4
	lw	$a0,0($v0)
	la	$a1,$LC3
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L35
	lw	$v0,76($fp)
	addu	$v0,$v0,8
	lw	$a0,0($v0)
	la	$a1,$LC2
	la	$t9,strcmp
	jal	$ra,$t9
	beq	$v0,$zero,$L34
	lw	$v0,76($fp)
	addu	$v0,$v0,8
	lw	$v0,0($v0)
	sw	$v0,36($fp)
	li	$v0,1			# 0x1
	sw	$v0,28($fp)
	b	$L34
$L35:
	la	$t9,mostrarMensajeErrorParametrosInvalidos
	jal	$ra,$t9
	sw	$v0,48($fp)
	b	$L28
$L34:
	lw	$v0,72($fp)
	slt	$v0,$v0,5
	bne	$v0,$zero,$L31
	lw	$v0,24($fp)
	beq	$v0,$zero,$L39
	lw	$v0,76($fp)
	addu	$v0,$v0,12
	lw	$a0,0($v0)
	la	$a1,$LC3
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L40
	lw	$v0,76($fp)
	addu	$v0,$v0,16
	lw	$a0,0($v0)
	la	$a1,$LC2
	la	$t9,strcmp
	jal	$ra,$t9
	beq	$v0,$zero,$L31
	lw	$v0,76($fp)
	addu	$v0,$v0,16
	lw	$v0,0($v0)
	sw	$v0,36($fp)
	li	$v0,1			# 0x1
	sw	$v0,28($fp)
	b	$L31
$L40:
	la	$t9,mostrarMensajeErrorParametrosInvalidos
	jal	$ra,$t9
	sw	$v0,48($fp)
	b	$L28
$L39:
	lw	$v0,28($fp)
	beq	$v0,$zero,$L31
	lw	$v0,76($fp)
	addu	$v0,$v0,12
	lw	$a0,0($v0)
	la	$a1,$LC1
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L45
	lw	$v0,76($fp)
	addu	$v0,$v0,16
	lw	$a0,0($v0)
	la	$a1,$LC2
	la	$t9,strcmp
	jal	$ra,$t9
	beq	$v0,$zero,$L31
	lw	$v0,76($fp)
	addu	$v0,$v0,16
	lw	$v0,0($v0)
	sw	$v0,32($fp)
	li	$v0,1			# 0x1
	sw	$v0,24($fp)
	b	$L31
$L45:
	la	$t9,mostrarMensajeErrorParametrosInvalidos
	jal	$ra,$t9
	sw	$v0,48($fp)
	b	$L28
$L31:
	lw	$v0,32($fp)
	beq	$v0,$zero,$L48
	lw	$a0,32($fp)
	la	$a1,$LC4
	la	$t9,fopen
	jal	$ra,$t9
	sw	$v0,40($fp)
	lw	$v0,40($fp)
	bne	$v0,$zero,$L50
	la	$a0,__sF+176
	la	$a1,$LC5
	la	$t9,fprintf
	jal	$ra,$t9
	li	$v0,-1			# 0xffffffffffffffff
	sw	$v0,48($fp)
	b	$L28
$L48:
	la	$v0,__sF
	sw	$v0,40($fp)
$L50:
	lw	$v0,36($fp)
	beq	$v0,$zero,$L51
	lw	$a0,36($fp)
	la	$a1,$LC6
	la	$t9,fopen
	jal	$ra,$t9
	sw	$v0,44($fp)
	lw	$v0,44($fp)
	bne	$v0,$zero,$L53
	la	$a0,__sF+176
	la	$a1,$LC7
	la	$t9,fprintf
	jal	$ra,$t9
	li	$v0,-1			# 0xffffffffffffffff
	sw	$v0,48($fp)
	b	$L28
$L51:
	la	$v0,__sF+88
	sw	$v0,44($fp)
$L53:
	lw	$a0,40($fp)
	lw	$a1,44($fp)
	la	$t9,windowsToLinux
	jal	$ra,$t9
	lw	$a0,40($fp)
	la	$t9,fclose
	jal	$ra,$t9
	lw	$a0,44($fp)
	la	$t9,fclose
	jal	$ra,$t9
	sw	$zero,48($fp)
$L28:
	lw	$v0,48($fp)
	move	$sp,$fp
	lw	$ra,64($sp)
	lw	$fp,60($sp)
	addu	$sp,$sp,72
	j	$ra
	.end	main
	.size	main, .-main
	.ident	"GCC: (GNU) 3.3.3 (NetBSD nb3 20040520)"
