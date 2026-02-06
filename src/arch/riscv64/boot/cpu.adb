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

package body CPU is
   --  This procedure would perform further CPU initialisation
   --  as well as set up all CPU structures and devices
   procedure Setup_CPU is
   begin
      Asm (
         Template =>
            "" & ASCII.LF &
            "li a0, 'X'"  & ASCII.LF &
            "li a1, 0x10000000" & ASCII.LF &
            "li t0, 0x20" & ASCII.LF &
            "1: lb t1, 5(a1)" & ASCII.LF &
            "and t1, t1, t0" & ASCII.LF &
            "beqz t1, 1b" & ASCII.LF &
            "sb a0, 0(a1)",
         Clobber => "a0,a1,t0,t1",
         Volatile => True
      );
   end Setup_CPU;
end CPU;
