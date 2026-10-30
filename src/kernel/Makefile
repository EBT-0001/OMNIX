AS = gas
LD = ld

SRC = $(wildcard src/*.s) $(wildcard src/stdio/*.s)
BUILD = build/
OBJ = $(wildcard $(BUILD)/*.o)
KERNEL = $(BUILD)/kernel.bin

all: $(KERNEL)

$(KERNEL): $(OBJ)
	$(LD) -m elf_i386 -Ttext=0x7c00 --nostdlib -o $@ $<

$(OBJ): $(SRC)
	$(AS) --64 -o $@ $<

$(BUILD):
	mkdir -p /build

clean:
	rm -rf $(BUILD)

.PHONY: all clean
