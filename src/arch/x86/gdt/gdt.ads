with System;
with Interfaces; use Interfaces;

package GDT is
   type Unsigned_3 is mod 2**2;
   type Unsigned_4 is mod 2**4;
   type Unsigned_20 is mod 2**20;

   type Access_Byte is record
      Accessed : Boolean;
      Readable_Writable : Boolean;
      Direction_Conforming : Boolean;
      Executable : Boolean;
      Descriptor_Type : Boolean;
      Privilege_Level : Unsigned_3;
      Present : Boolean;
   end record;
   for Access_Byte'Size use 8;
   for Access_Byte'Alignment use 1;
   pragma Pack (Access_Byte);

   type Flags is record
      Reserved : Boolean;
      Long_Mode : Boolean;
      Size : Boolean;
      Granularity : Boolean;
   end record;
   for Flags'Size use 4;
   for Flags'Alignment use 1;
   pragma Pack (Flags);

   type Segment_Descriptor is record
      Limit_Low : Unsigned_16;
      Base_Low : Unsigned_16;
      Base_Middle : Unsigned_8;
      Access_Byte : GDT.Access_Byte;
      Limit_High : Unsigned_4;
      Flags : GDT.Flags;
      Base_High : Unsigned_8;
   end record;
   for Segment_Descriptor'Size use 64;
   for Segment_Descriptor'Alignment use 1;
   pragma Pack (Segment_Descriptor);

   type GDTR is record
      Size : Unsigned_16;
      Offset : System.Address;
   end record;
   for GDTR'Size use 48;
   for GDTR'Alignment use 1;
   pragma Pack (GDTR);

   type Global_Descriptor_Table is
      array (Natural range 0 .. 8191) of aliased Segment_Descriptor;

   Table : Global_Descriptor_Table;
   Pointer : GDTR;

   function Create_Flags (
      Long_Mode : Boolean := False;
      Size : Boolean;
      Granularity : Boolean
   ) return Flags;

   function Create_Access_Byte (
      Accessed : Boolean;
      Readable_Writable : Boolean;
      Direction_Conforming : Boolean;
      Executable : Boolean;
      Descriptor_Type : Boolean;
      Privilege_Level : Unsigned_3;
      Present : Boolean
   ) return Access_Byte;

   function Create_Segment_Descriptor (
      Limit : Unsigned_20;
      Base : Unsigned_32;
      Access_Byte : GDT.Access_Byte;
      Flags : GDT.Flags
   ) return Segment_Descriptor;

   procedure Initialise_GDT;
end GDT;
