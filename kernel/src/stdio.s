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
		movq %rdi,%rax
		movq %rcx, %rbx
		movq $0, %rdi
		movq $0, %rcx
		.print_loop:
			movb (%rax, %rcx, 1), %rdi
			cmpq %rdi, $0x00
			je .print_end
			addq $1, %rcx
			cmpq %rdi, $0x25
			je .print_arg

			call putchar
			jmp .print_loop
		.print_arg:
			movb (%rax, %rcx, 1), %rdi
			cmpq %rdi, $0x63
			jne .end_c
			movq %rsi, %rdi
			# adjust for System V ABI
			call putchar
			.end_c:
			
		.print_end:
			ret

	putchar:
		movq $screen_x, %rsi
		movq $screen_y, %rdx

		call putchar_vga

		ret
