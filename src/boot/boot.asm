bits 16

mov ah, 0x0e
mov al, 'H'
int 0x10
mov al, 'i'
int 0x10

loop:
	jmp loop

times 510 - ($ - $$) db 0

dw 0xaa55 ; make bootloader bootable
