# =============================================================================== #
#	OMNIX BIOS Bootloader Copyright (C) 2026 Temperlius                           #
#	This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.    #
#	This is free software, and you are welcome to redistribute it                 #
#	under certain conditions; type `show c' for details.                          #
# =============================================================================== #

.section .text
	.code16
	.globl setMode

	.set EFLAGS_ID 1 << 21

	setMode:
		call checkCPUID

		ret

	checkCPUID:
		pushfd
		popl %eax

		movl %eax, %ecx
		xorl $EFLAGS_ID, %eax

		pushl %eax
		popfd
		pushfd
		pop %eax

		pushl %ecx
		popfd

		xorl %ecx, %eax
		jnz .supported
