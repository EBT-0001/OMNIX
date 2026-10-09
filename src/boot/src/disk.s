[BITS 16]

read_sector:
	mov ah, 0x02
	mov al, 0x01

	int 0x13
	jc .fail
	ret

.fail:
	jmp $
