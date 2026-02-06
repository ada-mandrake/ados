--  Mandrake Ada operating system
--  Copyright (C) 2026  Winterer, Mathis Aaron
--
--  This program is free software: you can redistribute it and/or modify
--  it under the terms of the GNU General Public License as published by
--  the Free Software Foundation, either version 3 of the License, or
--  (at your option) any later version.
--
--  This program is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU General Public License for more details.
--
--  You should have received a copy of the GNU General Public License
--  along with this program.  If not, see <https://www.gnu.org/licenses/>.

with GDT;
with TSS;
with Serial;
with VGA;

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
