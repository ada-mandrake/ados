with System;

package VGA is
   type Colours is (
      BLACK,
      BLUE,
      GREEN,
      CYAN,
      RED,
      MAGENTA,
      BROWN,
      LIGHT_GREY,
      DARK_GREY,
      LIGHT_BLUE,
      LIGHT_GREEN,
      LIGHT_CYAN,
      LIGHT_RED,
      LIGHT_MAGENTA,
      LIGHT_BROWN,
      WHITE
   );
   for Colours use (
      BLACK => 0,
      BLUE => 1,
      GREEN => 2,
      CYAN => 3,
      RED => 4,
      MAGENTA => 5,
      BROWN => 6,
      LIGHT_GREY => 7,
      DARK_GREY => 8,
      LIGHT_BLUE => 9,
      LIGHT_GREEN => 10,
      LIGHT_CYAN => 11,
      LIGHT_RED => 12,
      LIGHT_MAGENTA => 13,
      LIGHT_BROWN => 14,
      WHITE => 15
   );

   type VGA_Colour is record
      Foreground : Integer range 0 .. 7;
      Bright_F : Boolean;
      Background : Integer range 0 .. 7;
      Bright_B : Boolean;
   end record;

   for VGA_Colour use record
      Foreground at 0 range 0 .. 2;
      Bright_F at 0 range 3 .. 3;
      Background at 0 range 4 .. 6;
      Bright_B at 0 range 7 .. 7;
   end record;

   type VGA_Entry is record
      C : Character;
      Attribute : VGA_Colour;
   end record;

   for VGA_Entry use record
      C at 0 range 0 .. 7;
      Attribute at 1 range 0 .. 7;
   end record;

   type VGA_Array is array (Natural range <>) of VGA_Entry;

   VGA_Memory : VGA_Array (0 .. 3999);
   for VGA_Memory'Address use System'To_Address (16#B8000#);

   VGA_ROWS : constant Natural := 25;
   VGA_COLUMNS : constant Natural := 80;

   procedure Initialise_VGA;
   procedure Write_Char (C : Character);
   procedure Write_String (S : String);

private
   procedure Put_Char (C : Character; X, Y : Natural);
end VGA;
