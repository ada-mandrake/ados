OUTPUT_FORMAT("elf64-littleriscv")
OUTPUT_ARCH("riscv");
ENTRY("_start");

SECTIONS {
  . = 0x80000000;

  .text : ALIGN(4K) {
    KEEP(*(.init))
    *(.text);
    *(.text.*);
  }

  .rodata : ALIGN(4K) {
    *(.rodata);
    *(.rodata.*);
  }

  .data : ALIGN(4K) {
    *(.data);
    *(.data.*);
  }

  .bss : ALIGN(4K) {
    *(.bss);
    *(.bss.*);
    *(COMMON);
    . = ALIGN(16);
    PROVIDE(stack_top = .);
    . += 4096;
    PROVIDE(global_pointer = .);
  }

  /DISCARD/ : {
    *(.comment)
  }

  . = ALIGN(8);
  __end = .;
}
