with Boot;
with Serial;
with VGA;
with GDT;
pragma Unreferenced (Boot);

procedure Main is
begin
   if Serial.Initialise_Serial (Serial.COM1) /= 0 then
      Serial.Write_Char (Serial.COM1, 'X');
   else
      Serial.Write_Char (Serial.COM1,  'Y');
   end if;
   for C in Character'Range loop
      Serial.Write_Char (Serial.COM1, C);
   end loop;

   VGA.Initialise_VGA;
   VGA.Write_String ("AAAAAAAAAAAAAAAAAAAAAAA");
   VGA.Write_String ("AAAAAAAAAAAAAAAAAAAAAAA");
   VGA.Write_String ("AAAAAAAAAAAAAAAAAAAAAAA");
   VGA.Write_String ("AAAAAAAAAAX");
   VGA.Write_String ("Y");

   GDT.Initialise_GDT;

   VGA.Write_String ("GDT Loaded GG");
   loop
      null;
   end loop;
end Main;
