# tapset::context-caller(3stap) - systemtap context-caller tapset

SystemTap Tapset Reference, May 2021


<a name="description"></a>

# Description


 Provides caller and caller_addr function for context for kernel and user
 space.


* 

* **callers**  
  Return first n elements of kernel stack backtrace
* See 
  _function::callers_(3stap)
   for details.


* **caller**  
  Return name and address of calling function
* See 
  _function::caller_(3stap)
   for details.


* **caller_addr**  
  Return caller address
* See 
  _function::caller_addr_(3stap)
   for details.
  

<a name="see-also"></a>

# See Also
  
_function::callers_(3stap),  
_function::caller_(3stap),  
_function::caller_addr_(3stap),  
_stap_(1),
_stapprobes_(3stap)
