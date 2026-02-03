OUTPUT_FORMAT(elf32-i386)
ENTRY(_start)

SECTIONS {
  . = 2M;

  .multiboot : {
    KEEP(*(.multiboot))
  }

  .text BLOCK(4K) : ALIGN(4K) {
    *(.text)
  }

  .rodata BLOCK(4K) : ALIGN(4K) {
    *(.rodata)
  }

  .data BLOCK(4K) : ALIGN(4K) {
    *(.data)
  }

  .bss BLOCK(4K) : ALIGN(4K) {
    *(COMMON)
    *(.bss)
  }

  . = ALIGN(16);
  stack_bottom = .;
  . += 0x4000;
  stack_top = .;

  /DISCARD/ : {
    *(.eh_frame)
    *(.comment)
  }
}
