AS = gas

SRC = src/main.s
BUILD = build/
BOOT = $(BUILD)/boot.bin

FLAGS = -f bin

all: $(BOOT)

$(BOOT): $(SRC) $(BUILD)
	$(AS) $(FLAGS) $< -o $@

$(BUILD):
	mkdir -p build

clean:
	rm -rf $(BUILD)

.PHONY: all clean
