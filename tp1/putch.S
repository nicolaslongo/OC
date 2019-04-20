#include <mips/regdef.h>
#include <sys/syscall.h>
.text
.abicalls
.globl putch
.ent putch

putch:
	.frame $fp, 40, ra
	.set noreorder
	.cpload t9
	.set reorder

	subu sp, sp, 40 	# pido espacio para mi Stack Frame
	.cprestore 28		# guardo gp en 20
	sw $fp, 24(sp)		# guardo fp en 16
	sw ra, 32(sp)		# guardo ra en 24
	move $fp, sp		# a partir de acá trabajo con fp

# me guardo los parámetros que no guardo la caller (por convención de ABI)
# EL CHAR QUE LLEGA A ÉSTA ALTURA TIENE QUE HABER SIDO CARGADO CON lb !!!!!!!
	sw a0, 40($fp)		# guardo FD (que debería ser 1, stdout)
	sw a1, 44($fp)		# guardo el char a escribir
	sw a2, 48($fp)		# guardo size a escribir (va a ser 1)

_escritura:
	la a0, 1			# stdout
	lw t0, 44($fp)
	la a1, 0(t0)
	li a2, 1			# cantidad de bytes
	li v0, SYS_write
	syscall

	bnez a3, _escritura

_return:
	lw ra, 32(sp)
	lw $fp, 24(sp)
	lw gp, 28(sp)
	addu sp, sp, 40
	jr ra

.end putch


