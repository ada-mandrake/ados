package Boot is
   procedure Start
   with
      Export,
      Convention => Assembler,
      External_Name => "_start";
   pragma Machine_Attribute (Start, "naked");
   pragma Linker_Section (Start, ".init");
end Boot;
