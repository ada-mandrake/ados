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
