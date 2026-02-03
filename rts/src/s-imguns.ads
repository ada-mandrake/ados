with System.Unsigned_Types;

package System.Img_Uns is
   pragma Pure;

   procedure Image_Unsigned (
      V : System.Unsigned_Types.Unsigned;
      S : in out String;
      P : out Natural
   )
   with Inline;

   procedure Set_Image_Unsigned (
      V : System.Unsigned_Types.Unsigned;
      S : in out String;
      P : in out Natural
   );
end System.Img_Uns;
