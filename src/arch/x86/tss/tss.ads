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

with System;
with Interfaces; use Interfaces;

package TSS is
   type Unsigned_2 is range 0 .. 1;
   type Unsigned_13 is range 0 .. 12;

   type Segment_Selector is record
      Privilege_Level : Unsigned_2;
      TI : Boolean;
      Index : Unsigned_13;
   end record;
   for Segment_Selector'Alignment use 1;
   pragma Pack (Segment_Selector);

   type TSS is record
      Link : Unsigned_16;
      Reserved_0 : Unsigned_16;
      ESP0 : System.Address;
      SS0 : Unsigned_16;
      Reserved_1 : Unsigned_16;
      ESP1 : System.Address;
      SS1 : Unsigned_16;
      Reserved_2 : Unsigned_16;
      ESP2 : System.Address;
      SS2 : Unsigned_16;
      Reserved_3 : Unsigned_16;
      CR3 : Unsigned_32;
      EIP : Unsigned_32;
      EFLAGS : Unsigned_32;
      EAX : Unsigned_32;
      ECX : Unsigned_32;
      EDX : Unsigned_32;
      EBX : Unsigned_32;
      ESP : Unsigned_32;
      EBP : Unsigned_32;
      ESI : Unsigned_32;
      EDI : Unsigned_32;
      ES : Unsigned_16;
      Reserved_4 : Unsigned_16;
      CS : Unsigned_16;
      Reserved_5 : Unsigned_16;
      SS : Unsigned_16;
      Reserved_6 : Unsigned_16;
      DS : Unsigned_16;
      Reserved_7 : Unsigned_16;
      FS : Unsigned_16;
      Reserved_8 : Unsigned_16;
      GS : Unsigned_16;
      Reserved_9 : Unsigned_16;
      LDTR : Unsigned_16;
      Reserved_10 : Unsigned_16;
      Debug_Trap : Unsigned_16;
      IOPB : Unsigned_16;
   end record;
   for TSS'Size use 832;
   for TSS'Alignment use 16;
   pragma Pack (TSS);

   Task_State_Segment : TSS;

   Stack_Top : Unsigned_32;
   pragma Import (Asm, Stack_Top, "stack_top");

   Stack_Bottom : Unsigned_32;
   pragma Import (Asm, Stack_Bottom, "stack_bottom");

   procedure Initialise_TSS;
   procedure Flush_TSS;
   procedure Set_Kernel_Stack (Stack : System.Address);
end TSS;
