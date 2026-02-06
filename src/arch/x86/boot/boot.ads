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

package Boot is
   type Multiboot_Header is record
      Magic : Unsigned_32;
      Flags : Unsigned_32;
      Checksum : Unsigned_32;
   end record;
   pragma Pack (Multiboot_Header);

   Header : constant Multiboot_Header := (
      Magic => 16#1BADB002#,
      Flags => 0,
      Checksum => -(16#1BADB002# + 16#00#)
   );
   pragma Linker_Section (Header, ".multiboot");

   procedure Start
   with
      Export,
      Convention => Assembler,
      External_Name => "_start";
   pragma Machine_Attribute (Start, "naked");
   pragma Linker_Section (Start, ".init");
end Boot;
