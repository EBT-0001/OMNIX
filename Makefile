QEMU = qemu-system-i386

OMNIX = build/OMNIX.bin
BUILD = build/

all: $(OMNIX)

run: $(OMNIX)
  $(QEMU) -fda  $<

$(OMNIX): $(BUILD)

clean:
	rm -rf 

.PHONY: all clean run
