AS = nasm
QEMU = qemu-system-x86_64

SRC = src/main.s
BUILD = build/
BOOT = $(BUILD)/boot.bin

FLAGS = -f bin

all: $(BOOT)
	mkdir -p build
	$(AS) $(FLAGS) $< -o build/boot.bin

run: all
	$(QEMU) -boot a -fda boot.bin

clean:
	rm -rf $(BUILD)

.PHONY: all run clean
