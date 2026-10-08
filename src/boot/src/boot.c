#include <efi.h>
#include <efilib.h>

EFI_STATUS efi_main(EFI_HANDLE ImageHandle, EFI_SYSTEM_TABLE* SystemTable) {
	EFI_STATUS Status;

	InitializeLib(ImageHandle, SystemTable);

	SystemTable->BootServices->SetWatchdogTimer(0, 0, 0, NULL);

	Status = SystemTable->ConOut->ClearScreen(SystemTable->ConOut);
	if (EFI_ERROR(Status)) return Status;

	Print(L"OMNIX Project by Temperlius\n");
	Print(L"Press any key to continue...\n");

	EFI_INPUT_KEY key;
	SystemTable->ConIn->Reset(SystemTable->ConIn, false);
	UINTN EventIndex;

	SystemTable->BootServices->WaitForEvent(1, &SystemTable->ConIn->WaitForKey, &EventIndex);
	SystemTable->ConIn->ReadKeyStroke(SystemTable->ConIn, &key);

	return Status;
}
