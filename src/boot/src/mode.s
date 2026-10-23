# =============================================================================== #
#	OMNIX BIOS Bootloader Copyright (C) 2026 Temperlius                           #
#	This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.    #
#	This is free software, and you are welcome to redistribute it                 #
#	under certain conditions; type `show c' for details.                          #
# =============================================================================== #

.section .text
	.code16
	.globl setMode

	.set EFLAGS_ID, (1 << 21)
	.set CPUID_EXTENSIONS, 0x80000000
	.set CPUID_EXT_FEATURES, 0x80000001
	.set CPUID_EDX_EXT_FEAT_LM, (1 << 29)

	.set PML4T_ADDR, 0x1000
	.set PDPT_ADDR, 0x2000
	.set PDT_ADDR, 0x3000
	.set PT_ADDR, 0x4000

	.set PT_ADDR_MASK, 0xffffffffff000
	.set PT_PRESENT, 1
	.set PT_READABLE, 2

	.set SIZEOF_PAGE_TABLE, 4096
	.set ENTRIES_PER_PT, 512
	.set SIZEOF_PT_ENTRY, 8
	.set PAGE_SIZE, 0x1000

	.set CR4_PAE_ENABLE, (1 << 5)

	.set EFER_MSR, 0xc0000080
	.set EFER_LM_ENABLE, (1 << 8)

	.set CR0_PM_ENABLE, (1 << 0)
	.set CR0_PG_ENABLE, (1 << 31)

	setMode:
		call checkCPUID
		cmpl %ax, $0x01
		jne .exit
		je queryLongMode

		ret

	checkCPUID:
		pushfd
		popl %eax

		movl %eax, %ecx
		xorl $EFLAGS_ID, %eax

		pushl %eax
		popfd
		pushfd
		pop %eax

		pushl %ecx
		popfd

		xorl %ecx, %eax
		jnz .supported

		.notsupported:
			movw $0x00, %ax
			ret
		.supported:
			movw $0x01, %ax
			ret

	queryLongMode:
		movl $CPUID_EXTENSIONS, %eax
		cpuid
		cmpl $CPUID_EXT_FEATURES, %eax
		jnc enableProtectedMode

		movl $CPUID_EXT_FEATURES, %eax
		cpuid
		test $CPUID_EDX_EXT_FEAT_LM, %edx
		jz enableLongMode
		ret

	enableLongMode:
		movl $PML4T_ADDR, %edi
		movl %edi, %cr3

		xorl %eax, %eax
		mov $SIZEOF_PAGE_TABLE, %ecx
		rep stosd
		movl %cr3, %edi

		movl $(PDPT_ADDR & PT_ADDR_MASK | PT_PRESENT | PT_READABLE), (%edi)
		movl $PDPT_ADDR, %edi
		movl $(PDT_ADDR & PT_ADDR_MASK | PT_PRESENT | PT_READABLE), (%edi)
		movl $PDT_ADDR, %edi
		movl $(PT_ADDR & PT_ADDR_MASK | PT_PRESENT | PT_READABLE), %edi
		movl $PT_ADDR, %edi

		movl $(PT_PRESENT | PT_READABLE), %ebx
		movl $ENTRIES_PER_PT, %ecx

		.SetEntry:
			movl %ebx, (%edi)
			addl $PAGE_SIZE, %ebx
			addl $SIZEOF_PT_ENTRY, %edi
			loop .SetEntry

		movl %cr4, %eax
		orl $CR4_PAE_ENABLE, %eax
		movl %eax, %cr4

		movl $EFER_MSR, %ecx
		rdmsr
		orl $EFER_LM_ENABLE, %eax
		wrmsr

		movl %cr0, %eax
		orl $(CR0_PG_ENABLE | CR0_PM_ENABLE), %eax

		movl %eax, %cr0

		lgdt (GDT_DESCRIPTOR)
		ljmp GDT.Code:LongMode
	.exit:
		cli
		hlt
		jmp .exit
		
