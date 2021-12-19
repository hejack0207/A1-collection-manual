# tapset::task(3stap) - systemtap task tapset

SystemTap Tapset Reference, May 2021


<a name="description"></a>

# Description


* 

* **task_current**  
  The current task_struct of the current task
* See 
  _function::task_current_(3stap)
   for details.


* **task_parent**  
  The task_struct of the parent task
* See 
  _function::task_parent_(3stap)
   for details.


* **task_state**  
  The state of the task
* See 
  _function::task_state_(3stap)
   for details.


* **task_execname**  
  The name of the task
* See 
  _function::task_execname_(3stap)
   for details.


* **task_pid**  
  The process identifier of the task
* See 
  _function::task_pid_(3stap)
   for details.


* **task_ns_pid**  
  The process identifier of the task
* See 
  _function::task_ns_pid_(3stap)
   for details.


* **pid2task**  
  The task_struct of the given process identifier
* See 
  _function::pid2task_(3stap)
   for details.


* **pid2execname**  
  The name of the given process identifier
* See 
  _function::pid2execname_(3stap)
   for details.


* **task_tid**  
  The thread identifier of the task
* See 
  _function::task_tid_(3stap)
   for details.


* **task_ns_tid**  
  The thread identifier of the task as seen in a namespace
* See 
  _function::task_ns_tid_(3stap)
   for details.


* **task_gid**  
  The group identifier of the task
* See 
  _function::task_gid_(3stap)
   for details.


* **task_ns_gid**  
  The group identifier of the task as seen in a namespace
* See 
  _function::task_ns_gid_(3stap)
   for details.


* **task_egid**  
  The effective group identifier of the task
* See 
  _function::task_egid_(3stap)
   for details.


* **task_ns_egid**  
  The effective group identifier of the task
* See 
  _function::task_ns_egid_(3stap)
   for details.


* **task_uid**  
  The user identifier of the task
* See 
  _function::task_uid_(3stap)
   for details.


* **task_ns_uid**  
  The user identifier of the task
* See 
  _function::task_ns_uid_(3stap)
   for details.


* **task_euid**  
  The effective user identifier of the task
* See 
  _function::task_euid_(3stap)
   for details.


* **task_ns_euid**  
  The effective user identifier of the task
* See 
  _function::task_ns_euid_(3stap)
   for details.


* **task_prio**  
  The priority value of the task
* See 
  _function::task_prio_(3stap)
   for details.


* **task_nice**  
  The nice value of the task
* See 
  _function::task_nice_(3stap)
   for details.


* **task_cpu**  
  The scheduled cpu of the task
* See 
  _function::task_cpu_(3stap)
   for details.


* **task_open_file_handles**  
  The number of open files of the task
* See 
  _function::task_open_file_handles_(3stap)
   for details.


* **task_max_file_handles**  
  The max number of open files for the task
* See 
  _function::task_max_file_handles_(3stap)
   for details.
  

<a name="see-also"></a>

# See Also
  
_function::task_current_(3stap),  
_function::task_parent_(3stap),  
_function::task_state_(3stap),  
_function::task_execname_(3stap),  
_function::task_pid_(3stap),  
_function::task_ns_pid_(3stap),  
_function::pid2task_(3stap),  
_function::pid2execname_(3stap),  
_function::task_tid_(3stap),  
_function::task_ns_tid_(3stap),  
_function::task_gid_(3stap),  
_function::task_ns_gid_(3stap),  
_function::task_egid_(3stap),  
_function::task_ns_egid_(3stap),  
_function::task_uid_(3stap),  
_function::task_ns_uid_(3stap),  
_function::task_euid_(3stap),  
_function::task_ns_euid_(3stap),  
_function::task_prio_(3stap),  
_function::task_nice_(3stap),  
_function::task_cpu_(3stap),  
_function::task_open_file_handles_(3stap),  
_function::task_max_file_handles_(3stap),  
_stap_(1),
_stapprobes_(3stap)
