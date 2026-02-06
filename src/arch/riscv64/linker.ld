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
