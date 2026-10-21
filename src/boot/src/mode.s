# =============================================================================== #
#	OMNIX BIOS Bootloader Copyright (C) 2026 Temperlius                           #
#	This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.    #
#	This is free software, and you are welcome to redistribute it                 #
#	under certain conditions; type `show c' for details.                          #
# =============================================================================== #

.section .text
	.code16
	.globl setMode

	.set EFLAGS_ID 1 << 21
	.set CPUID_EXTENSIONS 0x80000000
	.set CPUID_EXT_FEATURES 0x80000001
	.set CPUID_EDX_EXT_FEAT_LM 1 << 29

	.set PML4T_ADDR 0x1000
	.set PDPT_ADDR 0x2000
	.set PDT_ADDR 0x3000
	.set PT_ADDR 0x4000

	.set PT_ADDR_MASK 0xffffffffff000
	.set PT_PRESENT 1
	.set PT_READABLE 2

	.set SIZEOF_PAGE_TABLE 4096

	setMode:
		call checkCPUID
		cmpl %ax, $0x01
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
		jc enableProtectedMode

		movl $CPUID_EXT_FEATURES, %eax
		cpuid
		test $CPUID_EDX_EXT_FEAT_LM, %edx
		jnz enableProtectedMode
		jmp enableLongMode

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

	enableProtectedMode:
		
