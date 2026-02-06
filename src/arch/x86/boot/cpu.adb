with GDT;
with TSS;

with Serial;
with VGA;

--  with System;
--  with System.Machine_Code; use System.Machine_Code;

package body CPU is
   procedure Setup_CPU is
   begin
      if Serial.Initialise_Serial (Serial.COM1) /= 0 then
         Serial.Write_String (Serial.COM1, "Serial Error\n");
      else
         Serial.Write_String (Serial.COM1, "Serial\tLoaded\n");
      end if;

      VGA.Initialise_VGA;
      VGA.Set_Cursor_Shape (16#D#, 16#F#);

      VGA.Set_Colour (VGA.Light_Green, VGA.Black);
      VGA.Write_String ("VGA Loaded\n");
      Serial.Write_String (Serial.COM1, "VGA\tLoaded\n");

      GDT.Initialise_GDT;
      Serial.Write_String (Serial.COM1, "GDT\tLoaded\n");

      TSS.Initialise_TSS;
      Serial.Write_String (Serial.COM1, "TSS\tLoaded\n");

      Serial.Write_String (
         Serial.COM1,
         "ESP0\t" & TSS.Task_State_Segment.ESP0'Image & "\n" &
         "SS0\t" & TSS.Task_State_Segment.SS0'Image & "\n"
      );
   end Setup_CPU;
end CPU;
