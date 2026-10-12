;	OMNIX Copyright (C) 2026  Temperlius
;	This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
;	This is free software, and you are welcome to redistribute it
;	under certain conditions; type `show c' for details.

[BITS 16]

printf:
	.loop:
		lodsb
		cmp al, 0
		je .end
		mov ah, 0x0E
		mov bh, 0x00
		mov bl, 0x07
		int 0x10
		jmp .loop
	.end:
		ret
