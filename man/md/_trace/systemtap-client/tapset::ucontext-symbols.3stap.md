# tapset::ucontext-symbols(3stap) - systemtap ucontext-symbols tapset

SystemTap Tapset Reference, May 2021


<a name="description"></a>

# Description


 User context symbol functions provide additional information about
 addresses from an application. These functions can provide
 information about the user space map (library) that the event occurred or
 the function symbol of an address.


* 

* **ustack**  
  Return address at given depth of user stack backtrace
* See 
  _function::ustack_(3stap)
   for details.


* **usymname**  
  Return the symbol of an address in the current task.
* See 
  _function::usymname_(3stap)
   for details.


* **usymdata**  
  Return the symbol and module offset of an address.
* See 
  _function::usymdata_(3stap)
   for details.


* **print_ustack**  
  Print out stack for the current task from string.
* See 
  _function::print_ustack_(3stap)
   for details.


* **print_usyms**  
  Print out user stack from string
* See 
  _function::print_usyms_(3stap)
   for details.


* **sprint_ustack**  
  Return stack for the current task from string.
* See 
  _function::sprint_ustack_(3stap)
   for details.


* **sprint_usyms**  
  Return stack for user addresses from string
* See 
  _function::sprint_usyms_(3stap)
   for details.


* **usymfileline**  
  Return the file name and line number of an address.
* See 
  _function::usymfileline_(3stap)
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
  
_function::ustack_(3stap),  
_function::usymname_(3stap),  
_function::usymdata_(3stap),  
_function::print_ustack_(3stap),  
_function::print_usyms_(3stap),  
_function::sprint_ustack_(3stap),  
_function::sprint_usyms_(3stap),  
_function::usymfileline_(3stap),  
_function::usymfile_(3stap),  
_function::usymline_(3stap),  
_stap_(1),
_stapprobes_(3stap)
