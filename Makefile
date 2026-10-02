BUILD_DIR = build/
PROGRAM_NAME = OMNIX

SRC = $(wildcard src/*.c)
INCLUDE = 
OBJ = $(patsubst src/%.c,$(BUILD_DIR)/%.o,$(SRC))

all: OMNIX

run: OMNIX
	./$(BUILD_DIR)/$(PROGRAM_NAME)

OMNIX: $(OBJ)
	gcc $(OBJ) -o $(BUILD_DIR)/$(PROGRAM_NAME)

build/%.o: src/%.c | build
	gcc -fno-stack-protector -fpic -fshort-wchar -mno-red-zone -DGNU_EFI_USE_MS_ABI -Wall -c $< -o $@

build:
	mkdir -p $(BUILD_DIR)

clean: 
	rm -r $(BUILD_DIR)
