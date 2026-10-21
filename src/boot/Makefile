AS := gas

SRC := src/(wildcard *.s)
BUILD := build/
BOOT := $(BUILD)/boot.bin

FLAGS := -f bin

all: $(BOOT)

$(BOOT): $(SRC) $(BUILD)
	$(AS) $(FLAGS) $< -o $@

$(BUILD):
	mkdir -p build

clean:
	rm -rf $(BUILD)

.PHONY: all clean
