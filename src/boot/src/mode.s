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
		cmpl %ax, $0x01
		je queryLongMode

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

		.notsupported:
			movw $0x00, %ax
			ret
		.supported:
			movw $0x01, %ax
			ret

	queryLongMode:
		movl $
