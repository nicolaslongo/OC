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
	.cprestore 28		# salvo gp en 20
	sw $fp, 24(sp)		# salvo fp en 16
	sw ra, 32(sp)		# salvo ra en 24
	move $fp, sp		# a partir de acá trabajo con fp

# me guardo los parámetros que no guardo la caller (por convención de ABI)
	sw a0, 40($fp)		# salvo posicion actual del buffer
	sw a1, 44($fp)		# salvo el char a escribir (ex a3)


#Aca borre todo

_return:		# ya tengo en v0 la pos_actual nueva
	lw ra, 32(sp)
	lw $fp, 24(sp)
	lw gp, 28(sp)
	addu sp, sp, 40
	jr ra

.end putch


