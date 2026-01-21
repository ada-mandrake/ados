with Interfaces; use Interfaces;

package Serial is
   COM1 : constant := 16#3F8#;

   procedure Write_Char (Port : Unsigned_16; C : Character);
   procedure Write_String (Port : Unsigned_16; S : String);
end Serial;
