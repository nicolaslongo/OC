#include <mips/regdef.h>
#include <sys/syscall.h>
.text
.abicalls
.globl isLF
.ent isLF

isLF:
	.frame $fp, 16, ra
	.set noreorder
	.cpload t9
	.set reorder

	subu sp, sp, 16 	# pido espacio para mi Stack Frame
	.cprestore 12		# guardo gp en 20
	sw $fp, 8(sp)		# guardo fp en 16
	#sw ra, 32(sp)		# guardo ra en 24
	move $fp, sp		# a partir de acá trabajo con fp

	sw a0, 16($fp)		# me guardo el char a comparar a 40 de fp, aunque sea innecesario
	lb t1, 0(a0)		# cargo el char en sí ES UN BYTE
	la t0, LF			
	lb t2, 0(t0)		# cargo el valor de LF según código ASCII

	beq t1, t2, _true
	b _false

_true:
	li t0, 1
	sb t0, 0($fp)
	b _end

_false:
	li v0, 0
	sb t0, 0($fp)

_end:
	# cargo en v0 el vaLor del booleano
	lb v0, 0($fp)
	#lw ra, 32(sp)
	lw $fp, 8(sp)
	lw gp, 12(sp)
	addu sp, sp, 16
	jr	ra

.end isLF

.data

LF: .byte 10
