with Interfaces; use Interfaces;

package Stack is
   type Stack_Array is array (0 .. 8191) of aliased Unsigned_8;

   Stack : aliased Stack_Array
      with Export => True,
           Convention => C,
           External_Name => "tss_stack",
           Size => 8192 * 8;
end Stack;
