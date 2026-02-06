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

with Interfaces; use Interfaces;

package Serial is
   COM1 : constant := 16#3F8#;
   COM2 : constant := 16#2F8#;
   COM3 : constant := 16#3E8#;
   COM4 : constant := 16#2E8#;
   COM5 : constant := 16#5F8#;
   COM6 : constant := 16#4F8#;
   COM7 : constant := 16#5E8#;
   COM8 : constant := 16#4E8#;

   function Initialise_Serial (Port : Integer) return Integer;
   procedure Write_Char (Port : Unsigned_16; C : Character);
   procedure Write_String (Port : Unsigned_16; S : String);
end Serial;
