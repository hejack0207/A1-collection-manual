# tapset::timestamp(3stap) - systemtap timestamp tapset

SystemTap Tapset Reference, May 2021


<a name="description"></a>

# Description


 Each timestamp function returns a value to indicate when a function is executed. These 
returned values can then be used to indicate when an event occurred, provide an ordering for events, 
or compute the amount of time elapsed between two time stamps.


* 

* **get_cycles**  
  Processor cycle count
* See 
  _function::get_cycles_(3stap)
   for details.


* **jiffies**  
  Kernel jiffies count
* See 
  _function::jiffies_(3stap)
   for details.


* **HZ**  
  Kernel HZ
* See 
  _function::HZ_(3stap)
   for details.
  

<a name="see-also"></a>

# See Also
  
_function::get_cycles_(3stap),  
_function::jiffies_(3stap),  
_function::HZ_(3stap),  
_stap_(1),
_stapprobes_(3stap)
