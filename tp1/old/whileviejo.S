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

	#ESTO ES COPLETAMENTE TEMPORAL:
	sw a0, 40($fp)		# guardo el puntero c a 40

_lectura:
	li a0, 1			# cargo en a0 el valor de STDIN
	la a1, BYTE_ACTUAL	# acá voy a guardar el byte leído --> guardo la POSICION de memoria
	#la t0, CANT_BYTES
	#lw a2, 0(t0)		# cargo en a2 la cantidad de bytes (1)
	li a2, 1
	jal getch
	la t0, BYTE_ACTUAL	# en byte actual tengo el byte leído
	sb v0, 0(t0)		# lo saco de memoria y lo cargo
	# t0, 16($fp)		# me lo guardo a 16 de fp -> para después

_check_eof:
	li t0, -1
	beq v0, t0, _eof
	# Si no es -1, entonces hay un char y me meto en el loop

_loop:
	la a0, 1			# cargo en a0 el valor de STDOUT
	lb a1, 16($fp)		# cargo el char a escribir en a1
	la t0, CANT_BYTES
	lw a2, 0(t0)		# cargo en a2 la cantidad de bytes (1)
	jal putch

	# vuelvo a la lectura y repito el ciclo
	b _lectura


_eof:
	lw ra, 32(sp)
	lw $fp, 24(sp)
	lw gp, 28(sp)
	addu sp, sp, 40
	jr	ra

.end my_while

.data
	STDIN: .word 0
	STDOUT: .word 1
	STDERR: .word 2

	CANT_BYTES: .word 1
	BYTE_ACTUAL: .byte 0
