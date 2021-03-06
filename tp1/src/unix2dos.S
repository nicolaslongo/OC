#include <mips/regdef.h>
#include <sys/syscall.h>
.text
.abicalls
.globl main
.ent main

main:
	.frame $fp, 32, ra
	.set noreorder
	.cpload t9
	.set reorder

	subu sp, sp, 32 	# pido espacio para mi Stack Frame
	.cprestore 20		# guardo gp en 20
	sw $fp, 16(sp)		# guardo fp en 16
	sw ra, 24(sp)		# guardo ra en 24
	move $fp, sp		# a partir de acá trabajo con fp

# hago una lectura:
_lectura:

	la a0, BUFFER
	jal getch

	# en v0 me devuelve el byte leído
	li t0, -1
	beq v0, t0, _eof

	# me fijo si tengo un LF
	la a0, BUFFER
	jal isLF

	li t0, 1
	beq v0, t0, _replace_LF

	la a0, BUFFER
	jal putch

	b _lectura

_eof:
_return:
	lw ra, 24(sp)
	lw $fp, 16(sp)
	lw gp, 20(sp)
	addu sp, sp, 32
	li v0, SYS_exit
	li a0, 0
	syscall

_replace_LF:
	la a0, CR
	jal putch

	la a0, BUFFER		# acá sigo teniendo LF
	jal putch

	b _lectura

.end main

.data
BUFFER: .space 1
CR: .byte 13
