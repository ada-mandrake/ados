package body VGA is
   VGA_Row : Integer range 0 .. 24;
   VGA_Column : Integer range 0 .. 79;

   procedure Initialise_VGA is
      VColour : VGA_Colour;
      VEntry : VGA_Entry;
   begin
      VColour := (
         Foreground => 0,
         Background => 0,
         Bright_F => False,
         Bright_B => False
      );
      VEntry := (C => ' ', Attribute => VColour);
      for I in 0 .. VGA_ROWS loop
         for J in 0 .. VGA_COLUMNS loop
            VGA_Memory (I * VGA_COLUMNS + J) := VEntry;
         end loop;
      end loop;
   end Initialise_VGA;
   procedure Write_Char (C : Character) is
   begin
      Put_Char (C, VGA_Column, VGA_Row);
      if VGA_Column = 79 then
         VGA_Column := 0;
         if VGA_Row = 24 then
            VGA_Row := 0;
         else
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
      VColour : VGA_Colour;
      VEntry : VGA_Entry;
   begin
      VColour := (
         Foreground => 7,
         Background => 0,
         Bright_F => False,
         Bright_B => False
      );
      VEntry := (C => C, Attribute => VColour);

      VGA_Memory (Y * VGA_COLUMNS + X) := VEntry;
   end Put_Char;
end VGA;
