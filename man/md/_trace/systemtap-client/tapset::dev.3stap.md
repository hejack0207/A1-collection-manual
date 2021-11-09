# tapset::dev(3stap) - systemtap dev tapset

SystemTap Tapset Reference, May 2021


<a name="description"></a>

# Description


* 

* **MAJOR**  
  Extract major device number from a kernel device number (kdev_t)
* See 
  _function::MAJOR_(3stap)
   for details.


* **MINOR**  
  Extract minor device number from a kernel device number (kdev_t)
* See 
  _function::MINOR_(3stap)
   for details.


* **MKDEF**  
  Creates a value that can be compared to a kernel device number (kdev_t)
* See 
  _function::MKDEF_(3stap)
   for details.


* **usrdev2kerndev**  
  Converts a user-space device number into the format used in the kernel
* See 
  _function::usrdev2kerndev_(3stap)
   for details.
  

<a name="see-also"></a>

# See Also
  
_function::MAJOR_(3stap),  
_function::MINOR_(3stap),  
_function::MKDEF_(3stap),  
_function::usrdev2kerndev_(3stap),  
_stap_(1),
_stapprobes_(3stap)
