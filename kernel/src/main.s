# =============================================================================== #
#   OMNIX BIOS Bootloader Copyright (C) 2026 Ethan Temperley                      #
#   This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.    #
#   This is free software, and you are welcome to redistribute it                 #
#   under certain conditions; type `show c' for details.                          #
# =============================================================================== #

.section .text
	.code64
	.globl kernel_main

	kernel_main:
		cli
	1:	hlt
		jmp 1b
		ret
