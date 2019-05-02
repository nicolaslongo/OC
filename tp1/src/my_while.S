#include <mips/regdef.h>
#include <sys/syscall.h>
.text
.abicalls
.globl my_while
.ent my_while

my_while:
	.frame $fp, 40, ra
	.set noreorder
	.cpload t9
	.set reorder

	subu sp, sp, 40 	# pido espacio para mi Stack Frame
	.cprestore 28		# guardo gp en 28
	sw $fp, 24(sp)		# guardo fp en 24
	sw ra, 32(sp)		# guardo ra en 32
	move $fp, sp		# a partir de acá trabajo con fp

# hago una lectura:
_lectura:

	la t0, STDIN
	lw a0, 0(t0)		# STDIN
	la a1, BUFFER
	la t0, BYTE
	lw a2, 0(t0)		# 1 byte
	jal getch

	# en v0 me devuelve el byte leído
	li t0, -1
	beq v0, t0, _eof

	# me fijo si tengo un LF
	la a0, BUFFER
	jal isLF

	li t0, 1
	beq v0, t0, _replace_LF

	la t0, STDOUT
	lw a0, 0(t0)		# STDOUT
	la a1, BUFFER		
	la t0, BYTE
	lw a2, 0(t0)		# 1 byte
	jal putch

	b _lectura

_eof:
_return:
	lw ra, 32(sp)
	lw $fp, 24(sp)
	lw gp, 28(sp)
	addu sp, sp, 40
	jr	ra

_replace_LF:
	la t0, STDOUT
	lw a0, 0(t0)		# STDOUT
	la a1, CR			
	la t0, BYTE
	lw a2, 0(t0)		# 1 byte
	jal putch

	la t0, STDOUT
	lw a0, 0(t0)		# STDOUT
	la a1, BUFFER		# acá sigo teniendo LF
	la t0, BYTE
	lw a2, 0(t0)		# 1 byte
	jal putch

	b _lectura

.end my_while

.data 
BUFFER: .space 1
CR: .byte 13
STDIN: .word 0
STDOUT: .word 1
BYTE: .byte 1
