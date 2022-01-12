# tapset::panic(3stap) - systemtap panic tapset

SystemTap Tapset Reference, May 2021


<a name="description"></a>

# Description


 Functions in the panic tapset allow a probe handler to invoke
 the system panic routine with a user-specified message.

 This may be used with a crash dump collection facility such as 
 kexec/kdump in order to capture data for post-mortem debugging.

 Due to the fact that this will bring the system to an immediate
 halt the functions in this tapset require guru mode.


* 

* **panic**  
  trigger a panic
* See 
  _function::panic_(3stap)
   for details.
  

<a name="see-also"></a>

# See Also
  
_function::panic_(3stap),  
_stap_(1),
_stapprobes_(3stap)
