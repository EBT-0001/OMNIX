QEMU = qemu-system-i386

OMNIX = build/OMNIX.bin
BOOT = src/boot/build/boot.bin
KERNEL = src/kernel/build/kernel.bin
BUILD = build/

all: $(OMNIX)

run: $(OMNIX)
	$(QEMU) -fda  $<

$(OMNIX):  $(BOOT) $(KERNEL) $(BUILD)
	cat $(BOOT) $(KERNEL) > $(OMNIX)

$(BOOT):
	$(MAKE) -C src/boot/

$(KERNEL):
	$(MAKE) -C src/kernel/

$(BUILD):
	mkdir -p build

clean:
	rm -rf $(BUILD) src/boot/build/ src/kernel/build/

.PHONY: all clean run
