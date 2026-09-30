format pe64 dll efi
entry main

section '.text' code executable readable

include 'uefi.inc'

main:
	InitializeLib
	jc @f

	uefi_call_wrapper ConOut, OutputString, ConOut, _hi
@@: mov eax, EFI_SUCCESS
	retn

section '.data' data readable writeable

_hello                                  du 'Hello World',13,10,0

section '.reloc' fixups data discardable
