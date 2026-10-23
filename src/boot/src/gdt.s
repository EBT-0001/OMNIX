# =============================================================================== #
#	OMNIX BIOS Bootloader Copyright (C) 2026 Temperlius                           #
#	This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.    #
#	This is free software, and you are welcome to redistribute it                 #
#	under certain conditions; type `show c' for details.                          #
# =============================================================================== #

.section .rodata
.align 8
	.set PRESENT, (1 << 7)
	.set NOT_SYS, (1 << 4)
	.set EXEC, (1 << 3)
	.set DC, (1 << 2)
	.set RW, (1 << 1)
	.set ACCESSED, (1 << 0)

	.set GRAN_4K, (1 << 7)
	.set SZ_32, (1 << 6)
	.set LONG_MODE, (1 << 5)

	.globl GDT
	.globl GDT_END
	.globl GDT_DESCRIPTOR

	GDT:
		.Null = . - GDT
			.quad 0
			
		.Code = .set . - GDT
			.Code.limit.lo: .word 0xffff
			.Code.base_lo: .word 0
			.Code.base_mid: .byte 0
			.Code.access: .byte PRESENT | NOT_SYS | EXEC | RW
			.Code.flags: .byte  GRAN_4K | LONG_MODE | 0xf
			.Code.base_hi: .byte 0
			
		.Data = .set . - GDT
			.Data.limit_lo: .word 0xffff
			.Data.base_lo: .word 0
			.Data.base_mid: .byte 0
			.Data.access: .byte PRESENT | NOT_SYS | RW
			.Data.flags: .byte GRAN_4K | SZ_32 | 0xf
			.Data.base_hi: .byte 0
			
	GDT_END:

	GDT_DESCRIPTOR:
		.word . GDT_END GDT - 1
		.quad GDT
