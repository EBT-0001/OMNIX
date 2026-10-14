AS = NASM
CC = gcc

ENTRY = src/kernel_entry.s
SRC = src/(wildcard *.c)
BUILD = build/
KERNEL = $(BUILD)/kernel.bin

all: $(KERNEL)

$(KERNEL): $(BUILD)/kernel_entry.o $(BUILD)/kernel.o
	ld -m elf_i386 -o $@ -Ttext 0x1000 $^ --oformat binary

$(BUILD)/kernel_entry.o: $(ENTRY) $(BUILD)
	nasm $< -f elf -o $@

$(BUILD)/kernel.o: $(SRC) $(BUILD)
	CC -m32 -ffreestanding -Ilib -c $< -o $@

$(BUILD):
	mkdir -p /build

clean:
	rm -rf $(BUILD)

.PHONY: all clean
