# =============================================================================== #
#	OMNIX BIOS Bootloader Copyright (C) 2026 Temperlius                           #
#	This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.    #
#	This is free software, and you are welcome to redistribute it                 #
#	under certain conditions; type `show c' for details.                          #
# =============================================================================== #

.section .text
	.code16
	.org 0x0
	.globl _start

	.set EFLAGS_ID,  (1 << 21)

	_start:
		cli
		cld

		xorw %ax, %ax
		movw %ax, %ss
		movw %ax, %ds
		movw %ax, %es

		call setMode
		call enableA20
	.fill 510-(.-_start), 1, 0
	.word 0xaa55
