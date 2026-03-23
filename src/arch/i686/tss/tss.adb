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

with Stack;

with System.Storage_Elements; use System.Storage_Elements;
with System.Machine_Code; use System.Machine_Code;

package body TSS is
   procedure Initialise_TSS is
   begin
      Task_State_Segment.Link := 0;
      Task_State_Segment.SS0 := 16#10#;
      Task_State_Segment.ESP0 := Stack.Stack'Address + Storage_Count (8191);

      Flush_TSS;
   end Initialise_TSS;

   procedure Flush_TSS is
   begin
      Asm (
         Template =>
            "xor %%eax, %%eax" & ASCII.LF &
            --  TODO:
            --  This points to the GDT Entry at offset 0x28, make this portable
            "mov $0x28, %%ax" & ASCII.LF &
            "ltr %%ax",
         Clobber => "eax",
         Volatile => True
      );
   end Flush_TSS;

   procedure Set_Kernel_Stack (Stack : System.Address) is
   begin
      Task_State_Segment.ESP0 := Stack;
   end Set_Kernel_Stack;
end TSS;
