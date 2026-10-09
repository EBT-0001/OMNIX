;	OMNIX Copyright (C) 2026  Temperlius
;	This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
;	This is free software, and you are welcome to redistribute it
;	under certain conditions; type `show c' for details.

[BITS 16]
[ORG 0x7C00]

start:
	xor ax, ax
	mov ds, ax
	mov es, ax
	mov ss, ax
	mov sp, 0x7C00

	mov ax, 0x0000
	mov es, ax
	mov bx, 0x0500
	mov dl, 0x00
	mov ch, 0x00
	mov cl, 0x02
	mov dh, 0x00
	call read_sector

	jmp $
%include "src/boot/src/disk.s"
times 510 - ($ - $$) db 0
dw 0xAA55
