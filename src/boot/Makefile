AS := as
LD := ld

SRC := $(wildcard src/*.s)
BUILD := build
OBJ := $(patsubst src/%.s, $(BUILD)/%.o, $(SRC))
BOOT := $(BUILD)/boot.bin

ASFLAGS := --64
LDFLAGS := -melf_x86_64 -Ttext 0x7C00 --oformat binary

all: $(BOOT)

$(BOOT): $(OBJ)
	$(LD) $(LDFLAGS) $(OBJ) -o $@

$(BUILD)/%.o: src/%.s | $(BUILD)
	$(AS) $(ASFLAGS) -o $@ $<

$(BUILD):
	mkdir -p $@

clean:
	rm -rf $(BUILD)

.PHONY: all clean
