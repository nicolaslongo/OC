#include <mips/regdef.h>
#include <sys/syscall.h>
.text #Lo que viene es codigo
.abicalls #Voy a usar la convencion abi
.globl main
.ent main


main:
	.frame $fp, 40, ra
	.set noreorder #RECETA magica no explicada
	.cpload t9 #RECETA magica no explicada
	.set reorder #RECETA magica no explicada

	subu sp, sp, 40 	# pido espacio para mi Stack Frame
	.cprestore 28		# guardo gp en 28
	sw $fp, 24(sp)		# guardo fp en 24
	sw ra, 32(sp)		# guardo ra en 32
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

	la t0, STDOUT
	lw a0, 0(t0)		# STDOUT
	la a1, CR
	la t0, BYTE
	lw a2, 0(t0)		# 1 byte
	jal putch

	la t0, STDOUT
	lw a0, 0(t0)		# STDOUT
	la a1, BUFFER
	la t0, BYTE
	lw a2, 0(t0)		# 1 byte
	jal putch

	b _lectura

_putCRandBreak:
	la t0, STDOUT
	lw a0, 0(t0)		# STDOUT
	la a1, CR
	la t0, BYTE
	lw a2, 0(t0)		# 1 byte
	jal putch

	b _eof # break;

_putLF:
	la t0, STDOUT
	lw a0, 0(t0)		# STDOUT
	la a1, LF
	la t0, BYTE
	lw a2, 0(t0)		# 1 byte
	jal putch

	b _lectura

.end main

.data
BUFFER: .space 1
CR: .byte 13
LF: .byte 10
STDIN: .word 0
STDOUT: .word 1
BYTE: .byte 1
