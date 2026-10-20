# ===============================================================================
#	OMNIX BIOS Bootloader Copyright (C) 2026 Temperlius
#	This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
#	This is free software, and you are welcome to redistribute it
#	under certain conditions; type `show c' for details.
# ===============================================================================

.section .text
	.global _start
	_start:
		.code16

		cli
		cld

		xorw %ax, %ax
		movw %ax, %ss
		movw %ax, %ds
		movw %ax, %es

		. = _start + 510
		.word 0xaa55
