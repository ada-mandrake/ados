package body VGA is
   VGA_Row : Integer range 0 .. 25;
   VGA_Column : Integer range 0 .. 79;

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
   begin
      for C of S loop
         Write_Char (C);
      end loop;
   end Write_String;

   procedure Put_Char (C : Character; X, Y : Natural) is
      VEntry : VGA_Entry;
   begin
      VEntry := (C => C, Attribute => Current_Colour);

      VGA_Memory (Y * VGA_COLUMNS + X) := VEntry;
   end Put_Char;
end VGA;
