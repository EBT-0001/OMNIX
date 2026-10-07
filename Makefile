CC = gcc
LD = ld
OBJCOPY = objcopy
QEMU = qemu-system-x86_64

EFI_INCLUDE = /usr/include/efi
EFI_LIB = /usr/lib

SRC = main.c
OBJ = main.o
SO = main.so
EFI = main.efi
NSH = startup.nsh

CFLAGS = -I$(EFI_INCLUDE) -I$(EFI_INCLUDE)/x86_64 \
-fno-stack-protector -fpic -fshort-wchar -mno-red-zone \
-DGNU_EFI_USE_MS_ABI -Wall -Wextra -c

LDFLAGS = -nostdlib -znocombreloc -T $(EFI_LIB)/elf_x86_64_efi.lds \
-shared -Bsymbolic $(EFI_LIB)/crt0-efi-x86_64.o \
-L$(EFI_LIB) -lefi -lgnuefi

OBJCOPY_FLAGS = -j .text -j .sdata -j .data \
-j .dynamic -j .dynsym -j .rel \
-j .rela -j .reloc \
--output-target=pei-x86_64 --subsystem=10

all: $(EFI)

$(OBJ): $(SRC)
	$(CC) $(CFLAGS) $< -o $@

$(SO): $(OBJ)
	$(LD) $(LDFLAGS) $(OBJ) -o $@

$(EFI): $(SO)
	$(OBJCOPY) $(OBJCOPY_FLAGS) $< $@

$(NSH): $(EFI)
	echo "$(EFI)" > $(NSH)

run: $(EFI) $(NSH)
	$(QEMU) -bios /usr/share/ovmf/OVMF.fd \
	-drive format=raw,file=fat:rw:. \
	-net none

clean:
	rm -f $(OBJ) $(SO) $(EFI) $(NSH)  # ← This line MUST start with TAB, rmv space

.PHONY: all run clean
