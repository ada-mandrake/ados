with System;
with x86.Port_IO; use x86.Port_IO;

package body Serial is

   function Initialise_Serial (Port : Integer) return Integer is
   begin
      --  Disable all interrupts
      Outb (System'To_Address (Port + 1), 16#00#);
      --  Enable DLAB
      Outb (System'To_Address (Port + 3), 16#80#);
      --  Set divisor to 3 (lo byte) 38400 baud
      Outb (System'To_Address (Port + 0), 16#03#);
      --                  (hi byte)
      Outb (System'To_Address (Port + 1), 16#00#);
      --  8 bits, no parity, one stop bit
      Outb (System'To_Address (Port + 3), 16#03#);
      --  Enable FIFO, clear them, with a 14-byte threshold
      Outb (System'To_Address (Port + 2), 16#C7#);
      --  IRQs enabled, RTS/DSR set
      Outb (System'To_Address (Port + 4), 16#0B#);
      --  Set in loopback mode, test the serial chip
      Outb (System'To_Address (Port + 4), 16#1E#);
      --  Test serial chip
      --  (send byte 0xAE and check if serial returns the same byte)
      Outb (System'To_Address (Port + 0), 16#AE#);

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
      C : Integer := S'First;
   begin
      while C <= S'Last loop
         if S (C) = '\' and then C < S'Last then
            case S (C + 1) is
               when 'a' => Write_Char (Port, ASCII.BEL);
               when 'b' => Write_Char (Port, ASCII.BS);
               when 'e' => Write_Char (Port, ASCII.ESC);
               when 'f' => Write_Char (Port, ASCII.FF);
               when 'n' =>
                  Write_Char (Port, ASCII.CR);
                  Write_Char (Port, ASCII.LF);
               when 'r' => Write_Char (Port, ASCII.CR);
               when 't' => Write_Char (Port, ASCII.HT);
               when 'v' => Write_Char (Port, ASCII.VT);
               when '\' => Write_Char (Port, '\');
               when others => null;
            end case;
            C := C + 2;
         else
            Write_Char (Port, S (C));
            C := C + 1;
         end if;
      end loop;
   end Write_String;
end Serial;
