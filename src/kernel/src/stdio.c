int printf(const char* restrict, ...) {
	__asm__(
		[BITS 64]

		VIDEO_MEMORY equ 0xb8000
		WHITE_ON_BLACK equ 0x0f
	);
}
