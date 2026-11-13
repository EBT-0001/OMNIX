STARTUP(main.o)
SEARCH_DIR(../libc)

ENTRY(kernel_main)

MEMORY {
	ROM (rx) : ORIGIN = 0, LENGTH = 256k
	RAM (wx) : org = 0x00100000, len = 1M
}

SECTIONS {
	. = 100000;

	.text.start () : {

	}
	.text : ALIGN(CONSTANT(MAXPAGESIZE)) {
		_TEXT_START_ = .;
			*(.text)
		_TEXT_END_ = .;
	}
	.data : ALIGN(CONSTANT(MAXPAGESIZE)) {
		_DATA_START_ = .;
			*(.data)
		_DATA_END_ = .;
	}
	.bss : ALIGN(CONSTANT(MAXPAGESIZE)) {
		_BSS_START_ = .;
			*(.bss)
		_BSS_END_ = .;
	}
}
