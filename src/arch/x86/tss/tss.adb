with Stack;

with System.Storage_Elements; use System.Storage_Elements;
with System.Machine_Code; use System.Machine_Code;

package body TSS is
   procedure Initialise_TSS is
   begin
      Task_State_Segment.Link := 0;
      Task_State_Segment.SS0 := 16#10#;
      Task_State_Segment.ESP0 := Stack.Stack'Address + Storage_Count (8191);

      Flush_TSS;
   end Initialise_TSS;

   procedure Flush_TSS is
   begin
      Asm (
         Template =>
            "xor %%eax, %%eax" & ASCII.LF &
            --  TODO:
            --  This points to the GDT Entry at offset 0x28, make this portable
            "mov $0x28, %%ax" & ASCII.LF &
            "ltr %%ax",
         Clobber => "eax",
         Volatile => True
      );
   end Flush_TSS;

   procedure Set_Kernel_Stack (Stack : System.Address) is
   begin
      Task_State_Segment.ESP0 := Stack;
   end Set_Kernel_Stack;
end TSS;
