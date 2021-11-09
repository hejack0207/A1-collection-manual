# tapset::context-unwind(3stap) - systemtap context-unwind tapset

SystemTap Tapset Reference, May 2021


<a name="description"></a>

# Description


 Context functions provide additional information about where an event occurred. These functions can 
provide information such as a backtrace to where the event occurred and the current register values for the 
processor.


* 

* **print_backtrace**  
  Print kernel stack back trace
* See 
  _function::print_backtrace_(3stap)
   for details.


* **print_backtrace_fileline**  
  Print kernel stack back trace
* See 
  _function::print_backtrace_fileline_(3stap)
   for details.


* **sprint_backtrace**  
  Return stack back trace as string
* See 
  _function::sprint_backtrace_(3stap)
   for details.


* **backtrace**  
  Hex backtrace of current kernel stack
* See 
  _function::backtrace_(3stap)
   for details.


* **task_backtrace**  
  Hex backtrace of an arbitrary task
* See 
  _function::task_backtrace_(3stap)
   for details.
  

<a name="see-also"></a>

# See Also
  
_function::print_backtrace_(3stap),  
_function::print_backtrace_fileline_(3stap),  
_function::sprint_backtrace_(3stap),  
_function::backtrace_(3stap),  
_function::task_backtrace_(3stap),  
_stap_(1),
_stapprobes_(3stap)
