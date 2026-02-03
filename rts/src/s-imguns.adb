with System.Unsigned_Types; use System.Unsigned_Types;

package body System.Img_Uns is
   procedure Image_Unsigned (
      V : Unsigned;
      S : in out String;
      P : out Natural
   ) is
      pragma Assert (S'First = 1);
      pragma Suppress (All_Checks);
   begin
      S (1) := ' ';
      P := 1;
      Set_Image_Unsigned (V, S, P);
   end Image_Unsigned;

   procedure Set_Image_Unsigned (
      V : Unsigned;
      S : in out String;
      P : in out Natural
   ) is
      Digit_Count : Natural := 0;
      pragma Suppress (All_Checks);
   begin
      Get_Digit_Count :
         declare
            V2 : Unsigned := V;
         begin
            while V2 /= 0 loop
               Digit_Count := Digit_Count + 1;
               V2 := V2 / 10;
            end loop;
         end Get_Digit_Count;

      Write_To_String :
         begin
            if Digit_Count = 0 then
               P := P + 1;
               S (P) := '0';
            else
               for I in reverse 0 .. Digit_Count - 1 loop
                  P := P + 1;
                  S (P) := Character'Val (48 + (V / 10 ** I) rem 10);
               end loop;
            end if;
         end Write_To_String;
   end Set_Image_Unsigned;
end System.Img_Uns;
