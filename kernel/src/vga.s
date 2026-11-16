# =============================================================================== #
#   OMNIX KERNEL IO Copyright (C) 2026 Ethan Temperley                            #
#   This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.    #
#   This is free software, and you are welcome to redistribute it                 #
#   under certain conditions; type `show c' for details.                          #
# =============================================================================== #

.section .text
	.code64

	.globl putchar_vga
	.globl putcolor_vga
	.globl getchar_vga
	.globl getcolor_vga

	.set screen_buffer, 0xB8000
	# the vga_textmode screen buffer begins at address 0xB8000

	putchar_vga:
		movq $screen_width, %rax
		mulq %rdx
		addq %rsi, %rax
		movq %rdi, (screen_buffer, %rax, 2)
		# puts character in rdi into the screen buffer at x: rsi, y: rdx with scale factor of 2
		ret

	putcolor_vga:
		movq $screen_width, %rax
		mulq %rdx
		addq %rsi, %rax
		movq %rdi, 1(screen_buffer, %rax, 2)
		# puts color in rdi into the screen buffer at x: rsi, y: rdx with scale factor of 2 displaced by 1
		ret

	getchar_vga:
		movq $screen_width, %rax
		mulq %rsi
		addq %rdi, %rax
		movq (screen_buffer, %rax, 2), %rax
		# gets character located at x: rdi, y: rsi in the screen buffer with scale factor of 2, and stores it in rax
		ret

	getcolor_vga:
		movq $screen_width, %rax
		mulq %rsi
		addq %rdi, %rax
		movq 1(screen_buffer, %rax, 2), %rax
		# gets color located at x: rdi, y: rsi in the screen buffer with scale factor of 2, displaced by 1, and stores it in rax
		ret

.section .data
	.align 8

	.globl screen_x
	.globl screen_y

	screen_x:
		.byte 0

	screen_y:
		.byte 0

.section .rodata
	.align 8

	.globl screen_width
	.globl screen_height
	.globl default_color

	screen_width:
		.byte 80
	screen_height:
		.byte 25
	default_color:
		.byte 0x07
