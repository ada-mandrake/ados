--
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

with System.Machine_Code; use System.Machine_Code;

package body x86.Port_IO is
   function Inb (Port : System.Address) return Unsigned_8 is
      Data : Unsigned_8;
   begin
      Asm (
         Template => "inb %w1, %0",
         Inputs => (System.Address'Asm_Input ("Nd", Port)),
         Outputs => (Unsigned_8'Asm_Output ("=a", Data)),
         Volatile => True
      );
      return Data;
   end Inb;

   procedure Outb (
      Port : System.Address;
      Data : Unsigned_8
   ) is
   begin
      Asm (
         Template => "outb %0, %w1",
         Inputs => (
            Unsigned_8'Asm_Input ("a", Data),
            System.Address'Asm_Input ("Nd", Port)),
         Volatile => True
      );
   end Outb;
end x86.Port_IO;
