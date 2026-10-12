;	OMNIX Copyright (C) 2026  Temperlius
;	This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
;	This is free software, and you are welcome to redistribute it
;	under certain conditions; type `show c' for details.

[BITS 16]

disk_load:
	pusha
	push dx

	mov ah, 0x02
	mov al, dh
	mov cl, 0x02
	mov ch, 0x00
	mov dh, 0x00

	int 0x13
	jc .fail

	pop dx
	cmp al, dl
	jne .fail
	popa

	ret

.fail:
	mov si, error_msg
	call printf
	jmp $
error_msg db "Disk Read Error", 0
