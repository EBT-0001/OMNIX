AS = nasm
QEMU = qemu-system-x86_64

SRC = src/main.s
BUILD = build/
BOOT = $(BUILD)/boot.bin

FLAGS = -f bin

all: $(BOOT)
	mkdir -p build
	$(AS) $(FLAGS) $< -o build/boot.bin

clean:
	rm -rf $(BUILD)

.PHONY: all clean
