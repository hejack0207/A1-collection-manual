# tapset::context(3stap) - systemtap context tapset

SystemTap Tapset Reference, May 2021


<a name="description"></a>

# Description


 Context functions provide additional information about where an event occurred. These functions can
provide information such as a backtrace to where the event occurred and the current register values for the
processor.


* 

* **print_regs**  
  Print a register dump
* See 
  _function::print_regs_(3stap)
   for details.


* **pp**  
  Returns the active probe point
* See 
  _function::pp_(3stap)
   for details.


* **ppfunc**  
  Returns the function name parsed from pp()
* See 
  _function::ppfunc_(3stap)
   for details.


* **probe_type**  
  The low level probe handler type of the current probe.
* See 
  _function::probe_type_(3stap)
   for details.


* **execname**  
  Returns the execname of a target process (or group of processes)
* See 
  _function::execname_(3stap)
   for details.


* **pexecname**  
  Returns the execname of a target process's parent process
* See 
  _function::pexecname_(3stap)
   for details.


* **pid**  
  Returns the ID of a target process
* See 
  _function::pid_(3stap)
   for details.


* **ns_pid**  
  Returns the ID of a target process as seen in a pid namespace
* See 
  _function::ns_pid_(3stap)
   for details.


* **tid**  
  Returns the thread ID of a target process
* See 
  _function::tid_(3stap)
   for details.


* **ns_tid**  
  Returns the thread ID of a target process as seen in a pid namespace
* See 
  _function::ns_tid_(3stap)
   for details.


* **ppid**  
  Returns the process ID of a target process's parent process
* See 
  _function::ppid_(3stap)
   for details.


* **ns_ppid**  
  Returns the process ID of a target process's parent process as seen in a pid namespace
* See 
  _function::ns_ppid_(3stap)
   for details.


* **pgrp**  
  Returns the process group ID of the current process
* See 
  _function::pgrp_(3stap)
   for details.


* **ns_pgrp**  
  Returns the process group ID of the current process as seen in a pid namespace
* See 
  _function::ns_pgrp_(3stap)
   for details.


* **sid**  
  Returns the session ID of the current process
* See 
  _function::sid_(3stap)
   for details.


* **ns_sid**  
  Returns the session ID of the current process as seen in a pid namespace
* See 
  _function::ns_sid_(3stap)
   for details.


* **gid**  
  Returns the group ID of a target process
* See 
  _function::gid_(3stap)
   for details.


* **ns_gid**  
  Returns the group ID of a target process as seen in a user namespace
* See 
  _function::ns_gid_(3stap)
   for details.


* **egid**  
  Returns the effective gid of a target process
* See 
  _function::egid_(3stap)
   for details.


* **ns_egid**  
  Returns the effective gid of a target process as seen in a user namespace
* See 
  _function::ns_egid_(3stap)
   for details.


* **uid**  
  Returns the user ID of a target process
* See 
  _function::uid_(3stap)
   for details.


* **ns_uid**  
  Returns the user ID of a target process as seen in a user namespace
* See 
  _function::ns_uid_(3stap)
   for details.


* **euid**  
  Return the effective uid of a target process
* See 
  _function::euid_(3stap)
   for details.


* **ns_euid**  
  Returns the effective user ID of a target process as seen in a user namespace
* See 
  _function::ns_euid_(3stap)
   for details.


* **is_myproc**  
  Determines if the current probe point has occurred in the user's own process
* See 
  _function::is_myproc_(3stap)
   for details.


* **cpuid**  
  Returns the current cpu number
* See 
  _function::cpuid_(3stap)
   for details.


* **cpu**  
  Returns the current cpu number
* See 
  _function::cpu_(3stap)
   for details.


* **registers_valid**  
  Determines validity of register() and u_register() in current context
* See 
  _function::registers_valid_(3stap)
   for details.


* **user_mode**  
  Determines if probe point occurs in user-mode
* See 
  _function::user_mode_(3stap)
   for details.


* **is_return**  
  Whether the current probe context is a return probe
* See 
  _function::is_return_(3stap)
   for details.


* **target**  
  Return the process ID of the target process
* See 
  _function::target_(3stap)
   for details.


* **module_name**  
  The module name of the current script
* See 
  _function::module_name_(3stap)
   for details.


* **module_size**  
  The module size of the current script
* See 
  _function::module_size_(3stap)
   for details.


* **stp_pid**  
  The process id of the stapio process
* See 
  _function::stp_pid_(3stap)
   for details.


* **remote_id**  
  The index of this instance in a remote execution.
* See 
  _function::remote_id_(3stap)
   for details.


* **remote_uri**  
  The name of this instance in a remote execution.
* See 
  _function::remote_uri_(3stap)
   for details.


* **stack_size**  
  Return the size of the kernel stack
* See 
  _function::stack_size_(3stap)
   for details.


* **stack_used**  
  Returns the amount of kernel stack used
* See 
  _function::stack_used_(3stap)
   for details.


* **stack_unused**  
  Returns the amount of kernel stack currently available
* See 
  _function::stack_unused_(3stap)
   for details.


* **addr**  
  Address of the current probe point.
* See 
  _function::addr_(3stap)
   for details.


* **uaddr**  
  User space address of current running task
* See 
  _function::uaddr_(3stap)
   for details.


* **cmdline_args**  
  Fetch command line arguments from current process
* See 
  _function::cmdline_args_(3stap)
   for details.


* **cmdline_arg**  
  Fetch a command line argument
* See 
  _function::cmdline_arg_(3stap)
   for details.


* **cmdline_str**  
  Fetch all command line arguments from current process
* See 
  _function::cmdline_str_(3stap)
   for details.
  

<a name="see-also"></a>

# See Also
  
_function::print_regs_(3stap),  
_function::pp_(3stap),  
_function::ppfunc_(3stap),  
_function::probe_type_(3stap),  
_function::execname_(3stap),  
_function::pexecname_(3stap),  
_function::pid_(3stap),  
_function::ns_pid_(3stap),  
_function::tid_(3stap),  
_function::ns_tid_(3stap),  
_function::ppid_(3stap),  
_function::ns_ppid_(3stap),  
_function::pgrp_(3stap),  
_function::ns_pgrp_(3stap),  
_function::sid_(3stap),  
_function::ns_sid_(3stap),  
_function::gid_(3stap),  
_function::ns_gid_(3stap),  
_function::egid_(3stap),  
_function::ns_egid_(3stap),  
_function::uid_(3stap),  
_function::ns_uid_(3stap),  
_function::euid_(3stap),  
_function::ns_euid_(3stap),  
_function::is_myproc_(3stap),  
_function::cpuid_(3stap),  
_function::cpu_(3stap),  
_function::registers_valid_(3stap),  
_function::user_mode_(3stap),  
_function::is_return_(3stap),  
_function::target_(3stap),  
_function::module_name_(3stap),  
_function::module_size_(3stap),  
_function::stp_pid_(3stap),  
_function::remote_id_(3stap),  
_function::remote_uri_(3stap),  
_function::stack_size_(3stap),  
_function::stack_used_(3stap),  
_function::stack_unused_(3stap),  
_function::addr_(3stap),  
_function::uaddr_(3stap),  
_function::cmdline_args_(3stap),  
_function::cmdline_arg_(3stap),  
_function::cmdline_str_(3stap),  
_stap_(1),
_stapprobes_(3stap)
