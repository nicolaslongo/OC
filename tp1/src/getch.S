#include <mips/regdef.h>
#include <sys/syscall.h>
.text
.abicalls
.globl getch
.ent getch

getch:
	.frame $fp, 40, ra
	.set noreorder
	.cpload t9
	.set reorder

	subu sp, sp, 40 	# pido espacio para mi Stack Frame
	.cprestore 28		# salvo gp en 28
	sw $fp, 24(sp)		# salvo fp en 24
	sw ra, 32(sp)		# salvo ra en 32
	move $fp, sp		# a partir de acá trabajo con fp

# me guardo los parámetros que no guardo la caller (por convención de ABI)
	sw a0, 40($fp)		# salvo el buffer adonde va lo leído (en este caso es un int)

# Se supone que el file descriptor es STDIN (0) y la cantidad de bytes es 1
# hago la lectura propiamente dicha:
_lectura:
	la a0, 0			# STDIN
	lw a1, 40($fp) 		# buffer de lo leido
	li a2, 1			# (1 acá es 1 byte)
	li v0, SYS_read
	syscall
	#move a1, v1

_comprobacion:
	bltz a3, _error		# si a3 es -1, falló la lectura del byte -> acá debería haber un catch del error, probablemente
	beqz v0, _eof			# (en a3 ya tengo un 0) si en v0 tengo un 0, entonces EOF
	li t0, 1
	beq t0, v0, _return		# esto ya es obvio, en realidad

_return:
# tengo en v0 la posición en memoria del char (leído) y
# me lo llevo con lb -> mucho muy importante, porque es un char
	lb v0, 40($fp)			# en v0 guardo el char (leído) que es lo que voy a devolver (o -1 si terminó)
# Devolvemos las cosas a su lugar
	lw ra, 32(sp)
	lw $fp, 24(sp)
	lw gp, 28(sp)
	addu sp, sp, 40
	jr	ra

_eof:
	li t0, -1
	sw t0, 40($fp)
	b _return

_error:		# en caso de error, aborto el programa con código 1
	li a0, 1
	li v0, SYS_exit
	syscall


.end getch
