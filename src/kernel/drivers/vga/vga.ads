with System;

package VGA is
   VGA_ROWS : constant Natural := 25;
   VGA_COLUMNS : constant Natural := 80;

   type Colours is (
      Black,
      Blue,
      Green,
      Cyan,
      Red,
      Magenta,
      Brown,
      Light_Grey,
      Dark_Grey,
      Light_Blue,
      Light_Green,
      Light_Cyan,
      Light_Red,
      Light_Magenta,
      Yellow,
      White
   );

   type VGA_Colour is record
      Foreground : Integer range 0 .. 15;
      Background : Integer range 0 .. 15;
   end record;

   for VGA_Colour use record
      Foreground at 0 range 0 .. 3;
      Background at 0 range 4 .. 7;
   end record;
   for VGA_Colour'Size use 8;
   for VGA_Colour'Alignment use 1;

   type VGA_Entry is record
      C : Character;
      Attribute : VGA_Colour;
   end record;

   for VGA_Entry use record
      C at 0 range 0 .. 7;
      Attribute at 1 range 0 .. 7;
   end record;
   for VGA_Entry'Size use 16;
   for VGA_Entry'Alignment use 1;

   type VGA_Array is
      array (Natural range 0 .. 3999)
      of aliased VGA_Entry;
   for VGA_Array'Alignment use 2;

   VGA_Memory : VGA_Array;
   for VGA_Memory'Address use System'To_Address (16#B8000#);

   procedure Initialise_VGA;
   procedure Set_Colour (Fg, Bg : Colours);
   function Get_Colour return VGA_Colour;
   procedure Write_Char (C : Character);
   procedure Write_String (S : String);

private
   Current_Colour : VGA_Colour := (
      Foreground => Colours'Pos (White),
      Background => Colours'Pos (Black)
   );

   procedure Put_Char (C : Character; X, Y : Natural);
end VGA;
