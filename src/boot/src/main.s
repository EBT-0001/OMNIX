[BITS 16]
[ORG 0x7C00]

start:
	xor ax, ax

	mov ax, 0x0000
	mov es, ax
	mov bx, 0x0500
	mov dl, 0x00
	mov ch, 0x00
	mov cl, 0x02
	mov dh, 0x00
	call read_sector
%include "src/boot/src/disk.s"
times 510 - ($ - $$) db 0
dw 0xAA55
