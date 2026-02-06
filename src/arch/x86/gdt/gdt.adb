with TSS;

with System.Machine_Code; use System.Machine_Code;
with System.Storage_Elements; use System.Storage_Elements;

package body GDT is
   function Create_Flags (
      Long_Mode : Boolean := False;
      Size : Boolean;
      Granularity : Boolean
   ) return Flags is
      Flags : GDT.Flags;
   begin
      Flags := (
         Reserved => False,
         Long_Mode => Long_Mode,
         Size => Size,
         Granularity => Granularity
      );
      return Flags;
   end Create_Flags;

   function Create_Access_Byte (
      Accessed : Boolean;
      Readable_Writable : Boolean;
      Direction_Conforming : Boolean;
      Executable : Boolean;
      Descriptor_Type : Boolean;
      Privilege_Level : Unsigned_3;
      Present : Boolean
   ) return Access_Byte is
      Access_Byte : GDT.Access_Byte;
   begin
      Access_Byte := (
         Accessed => Accessed,
         Readable_Writable => Readable_Writable,
         Direction_Conforming => Direction_Conforming,
         Executable => Executable,
         Descriptor_Type => Descriptor_Type,
         Privilege_Level => Privilege_Level,
         Present => Present
      );
      return Access_Byte;
   end Create_Access_Byte;

   function Create_Segment_Descriptor (
      Limit : Unsigned_20;
      Base : Unsigned_32;
      Access_Byte : GDT.Access_Byte;
      Flags : GDT.Flags
   ) return Segment_Descriptor is
      Segment_Descriptor : GDT.Segment_Descriptor;
   begin
      Segment_Descriptor.Limit_Low := Unsigned_16 (Limit and 16#FFFF#);
      Segment_Descriptor.Base_Low := Unsigned_16 (Base and 16#FFFF#);
      Segment_Descriptor.Base_Middle := Unsigned_8 ((Base / 2**16) and 16#FF#);
      Segment_Descriptor.Access_Byte := Access_Byte;
      Segment_Descriptor.Limit_High := Unsigned_4 ((Limit / 2**16) and 16#F#);
      Segment_Descriptor.Flags := Flags;
      Segment_Descriptor.Base_High := Unsigned_8 ((Base / 2**24) and 16#FF#);

      return Segment_Descriptor;
   end Create_Segment_Descriptor;

   procedure Initialise_GDT is
      Segment : Segment_Descriptor;
      Access_Byte : GDT.Access_Byte;
      Flags : GDT.Flags;
   begin
      --  Null segment
      Flags := Create_Flags (False, False, False);
      Access_Byte := Create_Access_Byte (
         False,
         False,
         False,
         False,
         False,
         0,
         False
      );
      Segment := Create_Segment_Descriptor (
         0,
         0,
         Access_Byte,
         Flags
      );

      Table (0) := Segment;

      --  Kernel code segment
      Flags := Create_Flags (False, True, True);
      Access_Byte := Create_Access_Byte (
         False,
         True,
         False,
         True,
         True,
         0,
         True
      );
      Segment := Create_Segment_Descriptor (
         16#FFFFF#,
         0,
         Access_Byte,
         Flags
      );

      Table (1) := Segment;

      --  Kernel data segment
      Flags := Create_Flags (False, True, True);
      Access_Byte := Create_Access_Byte (
         False,
         True,
         False,
         False,
         True,
         0,
         True
      );
      Segment := Create_Segment_Descriptor (
         16#FFFFF#,
         0,
         Access_Byte,
         Flags
      );

      Table (2) := Segment;

      --  User code segment
      Flags := Create_Flags (False, True, True);
      Access_Byte := Create_Access_Byte (
         False,
         True,
         False,
         True,
         True,
         3,
         True
      );
      Segment := Create_Segment_Descriptor (
         16#FFFFF#,
         0,
         Access_Byte,
         Flags
      );

      Table (3) := Segment;

      --  User data segment
      Flags := Create_Flags (False, True, True);
      Access_Byte := Create_Access_Byte (
         False,
         True,
         False,
         False,
         True,
         3,
         True
      );
      Segment := Create_Segment_Descriptor (
         16#FFFFF#,
         0,
         Access_Byte,
         Flags
      );

      Table (4) := Segment;

      --  Task state segment
      Flags := Create_Flags (False, False, False);
      Access_Byte := Create_Access_Byte (
         True,
         False,
         False,
         True,
         False,
         0,
         True
      );
      Segment := Create_Segment_Descriptor (
         TSS.TSS'Size / 8,
         Unsigned_32 (To_Integer (TSS.Task_State_Segment'Address)),
         Access_Byte,
         Flags
      );

      Table (5) := Segment;

      Pointer.Size := Unsigned_16 (Table'Length * 8 - 1);
      Pointer.Offset := Table'Address;

      Asm (
         Template =>
            "cli" & ASCII.LF &
            "lgdt %0" & ASCII.LF &
            "ljmp $0x08, $.reload_cs" & ASCII.LF &
            ".reload_cs:" & ASCII.LF &
            "movw $0x10, %%ax" & ASCII.LF &
            "movw %%ax, %%ds" & ASCII.LF &
            "movw %%ax, %%es" & ASCII.LF &
            "movw %%ax, %%fs" & ASCII.LF &
            "movw %%ax, %%gs" & ASCII.LF &
            "movw %%ax, %%ss",
         Inputs => GDTR'Asm_Input ("m", Pointer),
         Volatile => True,
         Clobber => "ax,memory"
      );
   end Initialise_GDT;
end GDT;
