with Boot;
with Serial;
pragma Unreferenced (Boot);

procedure Main is
begin
   for C in Character'Range loop
      Serial.Write_Char (Serial.COM1, C);
   end loop;
   loop
      null;
   end loop;
end Main;
