with System.Machine_Code; use System.Machine_Code;

package body CPU is
   --  This procedure would perform further CPU initialisation
   --  as well as set up all CPU structures and devices
   procedure Setup_CPU is
   begin
      Asm (
         Template =>
            "" & ASCII.LF &
            "li a0, 'X'"  & ASCII.LF &
            "li a1, 0x10000000" & ASCII.LF &
            "li t0, 0x20" & ASCII.LF &
            "1: lb t1, 5(a1)" & ASCII.LF &
            "and t1, t1, t0" & ASCII.LF &
            "beqz t1, 1b" & ASCII.LF &
            "sb a0, 0(a1)",
         Clobber => "a0,a1,t0,t1",
         Volatile => True
      );
   end Setup_CPU;
end CPU;
