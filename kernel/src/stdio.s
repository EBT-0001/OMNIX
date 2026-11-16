# =============================================================================== #
#   OMNIX KERNEL IO Copyright (C) 2026 Ethan Temperley                            #
#   This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.    #
#   This is free software, and you are welcome to redistribute it                 #
#   under certain conditions; type `show c' for details.                          #
# =============================================================================== #

.section .text
	.code64
	.globl printf
	.type printf, @function
	.globl putchar
	.type putchar, @function

	printf:
		ret

	putchar:
		movq $screen_x, %rsi
		movq $screen_y, %rdx

		call putchar_vga

		ret
