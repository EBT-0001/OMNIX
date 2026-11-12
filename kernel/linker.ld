OUTPUT_FORMAT(binary)
STARTUP(main.o)
ENTRY(kernel_main)

SECTIONS {
	. = 100000;

	.text : *{.text}
}

