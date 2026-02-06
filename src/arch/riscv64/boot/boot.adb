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

with Main;
with CPU;

with System.Machine_Code; use System.Machine_Code;

package body Boot is
   procedure Start is
   begin
      Asm (
         Template =>
            ".option norvc" & ASCII.LF &

            ".option push" & ASCII.LF &
            ".option norelax" & ASCII.LF &
            "la gp, global_pointer" & ASCII.LF &
            ".option pop" & ASCII.LF &

            "csrw satp, zero" & ASCII.LF &
            "la sp, stack_top",
         Volatile => True
      );
      CPU.Setup_CPU;
      Main;
   end Start;
end Boot;
