with Boot;
with Serial;
with VGA;
with GDT;

pragma Unreferenced (Boot);

procedure Main is
begin
   if Serial.Initialise_Serial (Serial.COM1) /= 0 then
      Serial.Write_String (Serial.COM1, "Serial Error\n");
   else
      Serial.Write_String (Serial.COM1, "Serial\tLoaded\n");
   end if;

   VGA.Initialise_VGA;
   VGA.Set_Colour (VGA.Light_Green, VGA.Yellow);
   --  VGA.Write_String ("VGA Loaded");
   Serial.Write_String (Serial.COM1, "VGA\tLoaded\n");

   GDT.Initialise_GDT;
   Serial.Write_String (Serial.COM1, "GDT\tLoaded\n");

   for I in 0 .. 10 loop
      for X in 0 .. 79 loop
         VGA.Write_String ("Y");
      end loop;
   end loop;

   VGA.Set_Colour (VGA.Light_Blue, VGA.Red);
   for I in 0 .. 10 loop
      for X in 0 .. 79 loop
         VGA.Write_String ("X");
      end loop;
   end loop;
   loop
      null;
   end loop;
end Main;
