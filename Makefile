QEMU = qemu-system-x86_64

OMNIX = build/OMNIX.bin
BOOT = boot/build/boot.bin
KERNEL = kernel/build/kernel.bin
BUILD = build/

all: $(OMNIX)

run: $(OMNIX)
	$(QEMU) -drive format=raw,file=$<

$(OMNIX):  $(BOOT) $(KERNEL) $(BUILD)
	cat $(BOOT) $(KERNEL) > $(OMNIX)

$(BOOT):
	$(MAKE) -C boot/

$(KERNEL):
	$(MAKE) -C kernel/

$(BUILD):
	mkdir -p build

clean:
	rm -rf $(BUILD) boot/build/ kernel/build/

.PHONY: all clean run
