/* Mandrake Ada operating system */
/* Copyright (C) 2026  Winterer, Mathis Aaron */
/**/
/* This program is free software: you can redistribute it and/or modify */
/* it under the terms of the GNU General Public License as published by */
/* the Free Software Foundation, either version 3 of the License, or */
/* (at your option) any later version. */
/**/
/* This program is distributed in the hope that it will be useful, */
/* but WITHOUT ANY WARRANTY; without even the implied warranty of */
/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the */
/* GNU General Public License for more details. */
/**/
/* You should have received a copy of the GNU General Public License */
/* along with this program.  If not, see <https://www.gnu.org/licenses/>. */

OUTPUT_FORMAT(elf32-i386)
ENTRY(_start)

SECTIONS {
  . = 2M;

  .multiboot : {
    KEEP(*(.multiboot))
  }

  .boot : {
    KEEP(*(.init))
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
    *(.comment)
  }
}
