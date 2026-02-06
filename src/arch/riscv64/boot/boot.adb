with Main;
with CPU;

with System.Machine_Code; use System.Machine_Code;

package body Boot is
   procedure Start is
   begin
      Asm (
         Template =>
            ".option norvc" & ASCII.LF &

            ".option push" & ASCII.LF &
            ".option norelax" & ASCII.LF &
            "la gp, global_pointer" & ASCII.LF &
            ".option pop" & ASCII.LF &

            "csrw satp, zero" & ASCII.LF &
            "la sp, stack_top",
         Volatile => True
      );
      CPU.Setup_CPU;
      Main;
   end Start;
end Boot;
