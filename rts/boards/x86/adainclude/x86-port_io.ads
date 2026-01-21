with Interfaces; use Interfaces;
with System;

package x86.Port_IO is
   pragma Preelaborate (x86.Port_IO);

   function Inb (Port : System.Address) return Unsigned_8;
   procedure Outb (
      Port : System.Address;
      Data : Unsigned_8
   );
end x86.Port_IO;
