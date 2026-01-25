with System;
with x86.Port_IO; use x86.Port_IO;

package body Serial is

   function Initialise_Serial (Port : Integer) return Integer is
   begin
      Outb (System'To_Address (Port + 1), 16#00#);
      --  Disable all interrupts
      Outb (System'To_Address (Port + 3), 16#80#);
      --  Enable DLAB
      Outb (System'To_Address (Port + 0), 16#03#);
      --  Set divisor to 3 (lo byte) 38400 baud
      Outb (System'To_Address (Port + 1), 16#00#);
      --                  (hi byte)
      Outb (System'To_Address (Port + 3), 16#03#);
      --  8 bits, no parity, one stop bit
      Outb (System'To_Address (Port + 2), 16#C7#);
      --  Enable FIFO, clear them, with a 14-byte threshold
      Outb (System'To_Address (Port + 4), 16#0B#);
      --  IRQs enabled, RTS/DSR set
      Outb (System'To_Address (Port + 4), 16#1E#);
      --  Set in loopback mode, test the serial chip
      Outb (System'To_Address (Port + 0), 16#AE#);
      --  Test serial chip
      --  (send byte 0xAE and check if serial returns the same byte)

      if Inb (System'To_Address (Port)) /= 16#AE# then
         return 1;
      end if;

      Outb (System'To_Address (Port + 4), 16#0F#);
      return 0;
   end Initialise_Serial;

   procedure Write_Char (Port : Unsigned_16; C : Character) is
   begin
      Outb (System'To_Address (Port), Character'Pos (C));
   end Write_Char;

   procedure Write_String (Port : Unsigned_16; S : String) is
   begin
      for C of S loop
         Write_Char (Port, C);
      end loop;
   end Write_String;
end Serial;
