with x86.Port_IO; use x86.Port_IO;

package body VGA is
   VGA_Row : Integer range 0 .. 25;
   VGA_Column : Integer range 0 .. 80;

   procedure Enable_Cursor is
   begin
      Outb (System'To_Address (16#3D4#), 16#0A#);
      Outb (
         System'To_Address (16#3D5#),
         (Inb (System'To_Address (16#3D5#)) and 16#C0#) or 16#D#
      );

      Outb (System'To_Address (16#3D4#), 16#0B#);
      Outb (
         System'To_Address (16#3D5#),
         (Inb (System'To_Address (16#3D5#)) and 16#E0#) or 16#F#
      );
   end Enable_Cursor;

   procedure Disable_Cursor is
   begin
      Outb (System'To_Address (16#3D4#), 16#0A#);
      Outb (System'To_Address (16#3D5#), 16#20#);
   end Disable_Cursor;

   procedure Set_Cursor_Shape (Cursor_Start, Cursor_End : Unsigned_8) is
   begin
      Outb (System'To_Address (16#3D4#), 16#0A#);
      Outb (
         System'To_Address (16#3D5#),
         (Inb (System'To_Address (16#3D5#)) and 16#C0#) or Cursor_Start
      );

      Outb (System'To_Address (16#3D4#), 16#0B#);
      Outb (
         System'To_Address (16#3D5#),
         (Inb (System'To_Address (16#3D5#)) and 16#E0#) or Cursor_End
      );
   end Set_Cursor_Shape;

   procedure Set_Cursor (X, Y : Integer) is
      Position : constant Unsigned_16 := Unsigned_16 (Y * VGA_COLUMNS + X);
   begin
      Outb (System'To_Address (16#3D4#), 16#0F#);
      Outb (
         System'To_Address (16#3D5#),
         Unsigned_8 (Position and 16#FF#)
      );
      Outb (System'To_Address (16#3D4#), 16#0E#);
      Outb (
         System'To_Address (16#3D5#),
         Unsigned_8 (Shift_Right (Position, 8) and 16#FF#));
   end Set_Cursor;

   procedure Set_Colour (Fg, Bg : Colours) is
   begin
      Current_Colour := (
         Foreground => Colours'Pos (Fg),
         Background => Colours'Pos (Bg)
      );
   end Set_Colour;

   function Get_Colour return VGA_Colour is
   begin
      return Current_Colour;
   end Get_Colour;

   procedure Initialise_VGA is
      VEntry : VGA_Entry;
   begin
      Set_Colour (Black, Black);
      Enable_Cursor;

      VEntry := (C => ' ', Attribute => Current_Colour);
      for I in 0 .. VGA_ROWS loop
         for J in 0 .. VGA_COLUMNS loop
            VGA_Memory (I * VGA_COLUMNS + J) := VEntry;
         end loop;
      end loop;
      Set_Colour (White, Black);
   end Initialise_VGA;

   procedure Write_Char (C : Character) is
   begin
      Put_Char (C, VGA_Column, VGA_Row);
      --  Last character
      if VGA_Column = 79 then
         --  Carriage return
         VGA_Column := 0;
         --  Last row
         if VGA_Row = 25 then
            for Y in 0 .. VGA_ROWS - 1 loop
               for X in 0 .. VGA_COLUMNS - 1 loop
                  VGA_Memory (Y * VGA_COLUMNS + X) :=
                     VGA_Memory ((Y + 1) * VGA_COLUMNS + X);
               end loop;
            end loop;
         else
            --  Line feed
            VGA_Row := VGA_Row + 1;
         end if;
      else
         VGA_Column := VGA_Column + 1;
      end if;
   end Write_Char;

   procedure Write_String (S : String) is
      C : Integer := S'First;
   begin
      while C <= S'Last loop
         if S (C) = '\' and then C < S'Last then
            case S (C + 1) is
               when 'n' =>
                  VGA_Column := 0;
                  VGA_Row := VGA_Row + 1;
               when 'r' => VGA_Column := 0;
               when 't' => VGA_Column := VGA_Column + 4;
               when '\' => Write_Char ('\');
               when others => null;
            end case;
            C := C + 2;
         else
            Write_Char (S (C));
            C := C + 1;
         end if;
      end loop;
   end Write_String;

   procedure Put_Char (C : Character; X, Y : Natural) is
      VEntry : VGA_Entry;
   begin
      VEntry := (C => C, Attribute => Current_Colour);

      VGA_Memory (Y * VGA_COLUMNS + X) := VEntry;
      Set_Cursor (X, Y);
   end Put_Char;
end VGA;
