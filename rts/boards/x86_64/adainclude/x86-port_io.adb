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
