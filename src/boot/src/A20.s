# =============================================================================== #
#	OMNIX BIOS Bootloader Copyright (C) 2026 Temperlius                           #
#	This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.    #
#	This is free software, and you are welcome to redistribute it                 #
#	under certain conditions; type `show c' for details.                          #
# =============================================================================== #

.section .text
	.code16
	.globl enableA20

	enableA20:
		call checkA20
		testb %al, %al
		jnz .exit

		call A20wait
		movb $0xad, %al
		outb %al, $0x64

		call A20wait
		movb $0xd0, %al
		outb %al, $0x64

		call A20wait2
		inb $0x60, %al
		pushw %ax

		call A20wait
		movb $0xd1, %al
		outb %al, $0x64

		call A20wait
		popw %ax
		orb $0x02, %al
		outb %al, $0x60

		call A20wait
		movb $0xae, %al
		outb %al, $0x64

		call A20wait
		ret

	checkA20:
		pushf
		pushw %si
		pushw %di
		pushw %ds
		pushw %es

		cli

		xorw %ax, %ax
		movw %ax, %ds
		movw $0x0500, %si

		notw %ax
		movw %ax, %es
		movw $0x0510, %di

		movb %ds:(%si), %al
		movb %al, .OverMB
		movb %es:(%di), %al
		movb %al, .UnderMB

		movb $1, %ah
		movb $0, %ds:(%si)
		movb $1, %es:(%di)
		movb %ds:(%si), %al

		cmpb %es:(%di), %al
		jne .exit
		dec %ah
	.exit:
		movb .OverMB, %al
		movb %al, %ds:(%si)
		movb .UnderMB, %al
		movb %al, %es:(%di)
		shrw $8, %ax

		popw %es
		popw %ds
		popw %di
		popw %si
		popf

		ret

	A20wait:
		inb $0x64, %al
		testb $2, %al
		jnz A20wait
		ret

	A20wait2:
		inb $0x64, %al
		testb $1, %al
		jz A20wait2
		ret

.section .data
	.OverMB:
		.byte 0
	.UnderMB:
		.byte 0
