#include <mips/regdef.h>
#include <sys/syscall.h>
.text
.abicalls
.globl putch
.ent putch

putch:
	.frame $fp, 8, ra
	.set noreorder
	.cpload t9
	.set reorder

	subu sp, sp, 8 	# pido espacio para mi Stack Frame
	.cprestore 4		# guardo gp en 28
	sw $fp, 0(sp)		# guardo fp en 24
	# sw ra, 32(sp)		# guardo ra en 32
	move $fp, sp		# a partir de acá trabajo con fp

# me guardo los parámetros que no guardo la caller (por convención de ABI)
# EL CHAR QUE LLEGA A ÉSTA ALTURA TIENE QUE HABER SIDO CARGADO CON lb !!!!!!!
	sw a0, 8($fp)		# guardo el char a escribir

_escritura:
	la a0, 1			# stdout
	lw t0, 8($fp)
	la a1, 0(t0)
	li a2, 1			# cantidad de bytes
	li v0, SYS_write
	syscall

	bnez a3, _escritura 		# Si da error intentamos de nuevo

_return:
	#lw ra, 32(sp)
	lw $fp, 0(sp)
	lw gp, 4(sp)
	addu sp, sp, 8
	jr ra

.end putch
