OUTPUT_FORMAT(elf32-i386)
ENTRY(_start)

SECTIONS {
  . = 2M;

  .multiboot : {
    KEEP(*(.multiboot))
  }

  .text BLOCK(4K) : ALIGN(4K) {
    *(.text)
    *(.text.*)
  }

  . = ALIGN(CONSTANT(COMMONPAGESIZE));

  .rodata BLOCK(4K) : ALIGN(4K) {
    *(.rodata)
    *(.rodata*)
  }

  . = ALIGN(CONSTANT(COMMONPAGESIZE));

  .data BLOCK(4K) : ALIGN(4K) {
    *(.data)
    *(.data*)
  }

  . = ALIGN(CONSTANT(COMMONPAGESIZE));

  .bss BLOCK(4K) : ALIGN(4K) {
    *(COMMON)
    *(.bss)
  }

  . = ALIGN(CONSTANT(COMMONPAGESIZE));

  . = ALIGN(16);
  stack_bottom = .;
  . += 0x4000;
  stack_top = .;

  /DISCARD/ : {
    *(.eh_frame)
    *(.comment)
  }
}
