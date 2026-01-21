with System;
with x86.Port_IO; use x86.Port_IO;

package body Serial is
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
