# tapset::context-symbols(3stap) - systemtap context-symbols tapset

SystemTap Tapset Reference, May 2021


<a name="description"></a>

# Description


 Context functions provide additional information about where an event occurred. These functions can 
provide information such as a backtrace to where the event occurred and the current register values for the 
processor.


* 

* **stack**  
  Return address at given depth of kernel stack backtrace
* See 
  _function::stack_(3stap)
   for details.


* **print_stack**  
  Print out kernel stack from string
* See 
  _function::print_stack_(3stap)
   for details.


* **sprint_stack**  
  Return stack for kernel addresses from string
* See 
  _function::sprint_stack_(3stap)
   for details.


* **probefunc**  
  Return the probe point's function name, if known
* See 
  _function::probefunc_(3stap)
   for details.


* **probemod**  
  Return the probe point's kernel module name
* See 
  _function::probemod_(3stap)
   for details.


* **modname**  
  Return the kernel module name loaded at the address
* See 
  _function::modname_(3stap)
   for details.


* **symname**  
  Return the kernel symbol associated with the given address
* See 
  _function::symname_(3stap)
   for details.


* **symdata**  
  Return the kernel symbol and module offset for the address
* See 
  _function::symdata_(3stap)
   for details.


* **print_syms**  
  Print out kernel stack from string
* See 
  _function::print_syms_(3stap)
   for details.


* **sprint_syms**  
  Return stack for kernel addresses from string
* See 
  _function::sprint_syms_(3stap)
   for details.


* **symfileline**  
  Return the file name and line number of an address.
* See 
  _function::symfileline_(3stap)
   for details.


* **usymfile**  
  Return the file name of a given address.
* See 
  _function::usymfile_(3stap)
   for details.


* **usymline**  
  Return the line number of an address.
* See 
  _function::usymline_(3stap)
   for details.
  

<a name="see-also"></a>

# See Also
  
_function::stack_(3stap),  
_function::print_stack_(3stap),  
_function::sprint_stack_(3stap),  
_function::probefunc_(3stap),  
_function::probemod_(3stap),  
_function::modname_(3stap),  
_function::symname_(3stap),  
_function::symdata_(3stap),  
_function::print_syms_(3stap),  
_function::sprint_syms_(3stap),  
_function::symfileline_(3stap),  
_function::usymfile_(3stap),  
_function::usymline_(3stap),  
_stap_(1),
_stapprobes_(3stap)
