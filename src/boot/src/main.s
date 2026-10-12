;	OMNIX Copyright (C) 2026  Temperlius
;	This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
;	This is free software, and you are welcome to redistribute it
;	under certain conditions; type `show c' for details.

[BITS 16]
[ORG 0x7C00]

KERNEL_OFFSET equ 0x1000

mov [BOOT_DRIVE], dl
mov bp, 0x9000
mov sp, bp

call load_kernel
call switch_to_64bit
jmp $

%include "src/disk.s"
%include "src/print.s"

load_kernel:
	xor ax, ax
	mov ds, ax
	mov es, ax
	mov ss, ax
	mov sp, 0x7C00

	mov ax, 0x0000
	mov es, ax
	mov bx, KERNEL_OFFSET
	mov dl, [BOOT_DRIVE]
	msg db "Loading From Disk...", 0
	mov si, msg
	call printf
	call disk_load

	ret
switch_to_64bit:
	cli
	lgdt [gdt_descriptor]
	mov eax, cr0
	or eax, 0x1
	mov cr0, eax
	jmp CODE_SEG:init_64bit
[BITS 64]
init_64bit:
	mov ax, DATA_SEG
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	mov ebp, 0x90000
	mov esp, ebp

	call BEGIN_64BIT
BEGIN_64BIT:
	call KERNEL_OFFSET
	jmp $
	
BOOT_DRIVE db 0

times 510 - ($ - $$) db 0
dw 0xAA55
