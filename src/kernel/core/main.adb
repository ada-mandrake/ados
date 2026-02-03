with x86.Boot;
with Serial;
with VGA;
with x86.GDT;
with x86.TSS;

with System;
with System.Machine_Code; use System.Machine_Code;

pragma Unreferenced (x86.Boot);

procedure Main is
   ESP, EBP : System.Address;
begin
   Asm (
      Template =>
         "movl $stack_top, %%esp" & ASCII.LF &
         "movl %%esp, %%ebp" & ASCII.LF &
         "pushl $0" & ASCII.LF &
         "popf",
      Clobber => "memory",
      Volatile => True
   );

   if Serial.Initialise_Serial (Serial.COM1) /= 0 then
      Serial.Write_String (Serial.COM1, "Serial Error\n");
   else
      Serial.Write_String (Serial.COM1, "Serial\tLoaded\n");
   end if;

   VGA.Initialise_VGA;
   VGA.Set_Cursor_Shape (16#D#, 16#F#);

   VGA.Set_Colour (VGA.Light_Green, VGA.Black);
   VGA.Write_String ("VGA Loaded");
   Serial.Write_String (Serial.COM1, "VGA\tLoaded\n");

   x86.GDT.Initialise_GDT;
   Serial.Write_String (Serial.COM1, "GDT\tLoaded\n");

   x86.TSS.Initialise_TSS;
   Serial.Write_String (Serial.COM1, "TSS\tLoaded\n");

   Asm (
      Template =>
         "movl %%esp, %0",
      Outputs => System.Address'Asm_Output ("=r", ESP),
      Volatile => True
   );

   Asm (
      Template =>
         "movl %%ebp, %0",
      Outputs => System.Address'Asm_Output ("=r", EBP),
      Volatile => True
   );

   Serial.Write_String (
      Serial.COM1,
      "ESP0:\t" & x86.TSS.Task_State_Segment.ESP0'Image & "\n"
   );
   Serial.Write_String (Serial.COM1, "ESP:\t" & ESP'Image & "\n");
   Serial.Write_String (Serial.COM1, "EBP:\t" & EBP'Image & "\n");

   loop
      null;
   end loop;
end Main;
