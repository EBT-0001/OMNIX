# =============================================================================== #
#   OMNIX BIOS Bootloader Copyright (C) 2026 Ethan Temperley                      #
#   This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.    #
#   This is free software, and you are welcome to redistribute it                 #
#   under certain conditions; type `show c' for details.                          #
# =============================================================================== #

.section .text
.code64

.globl kernel_entry
kernel_entry:
	movw $GDT_DATA, %ax
	movw %ax, %ds
	movw %ax, %es
	movw %ax, %ss
	movw %ax, %fs
	movw %ax, %gs

	movabsq $100000, %rdi
	jmp *%rdi

	cli
	.halt:
		hlt
		jmp .halt
		
