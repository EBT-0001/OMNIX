[BITS 16]

read_sector:
	mov ah, 0x02
	mov al, 0x01

	int 0x13
	jc .fail
	ret

.fail:
	mov si, error_msg
	call printf
	jmp $
error_msg db "Disk Read Error", 0
