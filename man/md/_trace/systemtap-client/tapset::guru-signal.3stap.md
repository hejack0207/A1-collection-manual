# tapset::guru-signal(3stap) - systemtap guru-signal tapset

SystemTap Tapset Reference, May 2021


<a name="description"></a>

# Description


 Functions in the guru-signal tapset allow a probe handler to queue
 a user-space signals.  Such operations may only be safe from some 
 kinds of probe points, therefore are guru-mode only.


* 

* **raise**  
  raise a signal in the current thread
* See 
  _function::raise_(3stap)
   for details.
  

<a name="see-also"></a>

# See Also
  
_function::raise_(3stap),  
_stap_(1),
_stapprobes_(3stap)
