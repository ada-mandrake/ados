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
