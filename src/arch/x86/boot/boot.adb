with Main;
with CPU;

with System.Machine_Code; use System.Machine_Code;

package body Boot is
   procedure Start is
   begin
      Asm (
         Template =>
            "movl $stack_top, %%esp" & ASCII.LF &
            "movl %%esp, %%ebp" & ASCII.LF &
            "pushl $0" & ASCII.LF &
            "popf",
         Clobber => "memory",
         Volatile => True
      );
      CPU.Setup_CPU;
      Main;
   end Start;
end Boot;
