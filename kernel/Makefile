AS := as
LD := ld

SRC := $(wildcard src/*.s)
BUILD := build
OBJ := $(patsubst src/%.s, $(BUILD)/%.o, $(SRC))
KERNEL := $(BUILD)/kernel.bin

ASFLAGS := --64
LDFLAGS := -melf_x86_64 --nostdlib -O2 -Ttext=0x100000 --oformat binary

all: $(KERNEL)

$(KERNEL): $(OBJ)
	$(LD) $(LDFLAGS) -o $@ $<

$(BUILD)/%.o: src/%.s | $(BUILD)
	$(AS) $(ASFLAGS) -o $@ $<

$(BUILD):
	mkdir -p $@

clean:
	rm -rf $(BUILD)

.PHONY: all clean
