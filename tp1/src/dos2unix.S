#include <mips/regdef.h>
#include <sys/syscall.h>
.text #Lo que viene es codigo
.abicalls #Voy a usar la convencion abi
.globl main
.ent main


main:
	.frame $fp, 32, ra
	.set noreorder #RECETA magica no explicada
	.cpload t9 #RECETA magica no explicada
	.set reorder #RECETA magica no explicada

	subu sp, sp, 32 	# pido espacio para mi Stack Frame
	.cprestore 20		# guardo gp en 20
	sw $fp, 16(sp)		# guardo fp en 16
	sw ra, 24(sp)		# guardo ra en 32
	move $fp, sp		# a partir de acá trabajo con fp

# hago una lectura:
_lectura:

	# Cargo el primer argumento
	la a0, BUFFER

	# Llamo a getch
	jal getch # en v0 me devuelve el byte leído

	li t0, -1
	beq v0, t0, _eof

	# me fijo si tengo un CR
	la a0, BUFFER
	jal isCR

	li t0, 1
	beq v0, t0, _checkNextIsEOF

	la a0, BUFFER
	jal putch

	b _lectura

_eof:
_return:
	lw ra, 24(sp)
	lw $fp, 16(sp)
	lw gp, 20(sp)
	addu sp, sp, 32
	li a0, 0
	li v0, SYS_exit
	syscall

_checkNextIsEOF:
	# Llamo a getch
	jal getch # en v0 me devuelve el byte leído


	li t0, -1
	beq v0, t0, _putCRandBreak


	# me fijo si tengo un LF
	la a0, BUFFER
	jal isLF

	li t0, 1
	beq v0, t0, _putLF

	la a0, CR
	jal putch


	la a0, BUFFER
	jal putch

	b _lectura

_putCRandBreak:
	la a0, CR
	jal putch

	b _eof # break;

_putLF:
	la a0, LF
	jal putch

	b _lectura

.end main

.data
BUFFER: .space 1
CR: .byte 13
LF: .byte 10
