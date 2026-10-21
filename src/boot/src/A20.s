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
