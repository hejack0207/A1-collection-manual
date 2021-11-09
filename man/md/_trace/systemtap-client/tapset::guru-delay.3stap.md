# tapset::guru-delay(3stap) - systemtap guru-delay tapset

SystemTap Tapset Reference, May 2021


<a name="description"></a>

# Description


 Functions in the guru-delay tapset allow a probe handler to insert
 deliberate delays.  This is sometimes useful as a fault-injection
 aid.  Due to its likelihood of interference with the kernel, guru
 mode is required, and overload-prevention is suppressed.


* 

* **mdelay**  
  millisecond delay
* See 
  _function::mdelay_(3stap)
   for details.


* **udelay**  
  microsecond delay
* See 
  _function::udelay_(3stap)
   for details.
  

<a name="see-also"></a>

# See Also
  
_function::mdelay_(3stap),  
_function::udelay_(3stap),  
_stap_(1),
_stapprobes_(3stap)
