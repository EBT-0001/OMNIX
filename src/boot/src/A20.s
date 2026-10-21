# =============================================================================== #
#	OMNIX BIOS Bootloader Copyright (C) 2026 Temperlius                           #
#	This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.    #
#	This is free software, and you are welcome to redistribute it                 #
#	under certain conditions; type `show c' for details.                          #
# =============================================================================== #

.section .text
	.code64
	.globl enableA20

	enableA20:
		call checkA20

		call A20wait
		movb $0xad, %al
		outb %al, $0x64

		call A20wait
		movb $0xd0, %al
		outb %al, $0x64

		call A20wait2
		movb $0x60, %al
		pushl %eax

		call A20wait
		movb $0xd1, %al
		outb %al, $0x64

		call A20wait
		pop %eax
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

		movw $0x0000, %ax
		movw %ax, %ds
		movw $0x0500, %si

		notw %ax
		movw %ax, %es
		movw $0x0510, %di

		movb %ds:(%si), %al
		movb %al, .OverMB
		movb %es:(%di), %al
		movb %al, .UnderMB

		movb %ah, $0x01
		movb $0x00, %ds:(%si)
		movb $0x01, %es:(%di)
		jne .exit
		dec %ah

	A20wait:
		inb $0x64, %al
		test $2, %al
		jnz A20wait
		ret

	A20wait2:
		inb $0x64, %al
		test $1, %al
		jz A20wait
		ret

	.exit:
		movb .UnderMB, %al
		movb %al, %ds:(%si)
		movb .OverMB, %al
		movb %al, %es:(%di)

		shrw $8, %ax

		popw es
		popw ds
		popw si
		popw di
		popf

		ret

.section .data
	.OverMB:
		.byte $0x00
	.UnderMB:
		.byte $0x00
