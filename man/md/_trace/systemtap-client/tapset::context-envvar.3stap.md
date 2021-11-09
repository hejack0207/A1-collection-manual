# tapset::context-envvar(3stap) - systemtap context-envvar tapset

SystemTap Tapset Reference, May 2021


<a name="description"></a>

# Description


 Context functions provide additional information about where an event occurred. These functions can
provide information such as a backtrace to where the event occurred and the current register values for the
processor.


* 

* **env_var**  
  Fetch environment variable from current process
* See 
  _function::env_var_(3stap)
   for details.
  

<a name="see-also"></a>

# See Also
  
_function::env_var_(3stap),  
_stap_(1),
_stapprobes_(3stap)
