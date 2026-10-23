# =============================================================================== #
#	OMNIX BIOS Bootloader Copyright (C) 2026 Temperlius                           #
#	This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.    #
#	This is free software, and you are welcome to redistribute it                 #
#	under certain conditions; type `show c' for details.                          #
# =============================================================================== #

.section .text
	.set PRESENT 1 << 7
	.set NOT_SYS 1 << 4
	.set EXEC 1 << 3
	.set DC 1 << 2
	.set RW 1 << 1
	.set ACCESSED 1 << 0

	.set GRAN_4K 1 << 7
	.set SZ_32 1 << 6
	.set LONG_MODE 1 << 5

	.globl GDT
	GDT:
		.NULL:
		.Code:
		.Data:
		.Pointer:
			.word . GDT - 1
			.quad GDT
