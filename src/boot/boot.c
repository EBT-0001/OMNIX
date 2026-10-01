#include <efi.h>
#include <efilib.h>

EFI_STATUS efi_main(EFI_HANDLE ImageHandle, EFI_SYSTEM_TABLE* SystemTable) {
	InitializeLib(ImageHandle, SystemTable);
	Print(L"OMNIX Project by Temperlius\n");
	Print(L"Press any key to continue...\n");

	EFI_INPUT_KEY key;
	SystemTable->ConIn->Reset(SystemTable->ConIn, false);
	UINTN EventIndex;

	SystemTable->BootServices->WaitForEvent(1, &SystemTable->ConIn->WaitForKey,
	SystemTable->ConIn->ReadKeyStroke(SystemTable->ConIN, &key))

	return EFI_SUCCESS;
}
