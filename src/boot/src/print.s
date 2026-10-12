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
