ENTRY(_start)

. = 0x80000000;

SECTIONS {
  .boot : ALIGN(4K) {
    KEEP(*(.boot))
  }

  .text : ALIGN(4K) {
    *(.text);
    *(.text.*);
  }

  .bss : ALIGN(4K) {
    PROVIDE(bss_start = .);
    *(.bss);
    *(COMMON);
    . += 4096;
    PROVIDE(stack_top = .);
    . += 4096;
    PROVIDE(global_pointer = .);
    PROVIDE(bss_end = . );
  } 

  .rodata : ALIGN(4K) {
    *(.rodata);
    *(.rodata*);
  } 

  .data : ALIGN(4K) {
    *(.data);
    *(.data*);
  } 

  /DISCARD/ : {
    *(.eh_frame);
    *(.comment);
  }
}
