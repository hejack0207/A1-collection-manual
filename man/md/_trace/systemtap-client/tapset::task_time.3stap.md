# tapset::task_time(3stap) - systemtap task_time tapset

SystemTap Tapset Reference, May 2021


<a name="description"></a>

# Description


 Task time query and utility functions provide information about
 the time resource usage of the current task. These functions provide
 information about the user time and system time of the current
 task. And provide utility functions to turn the reported times
 into miliseconds and create human readable string representations
 of task time used. The reported times are approximates and should
 be used for "coarse grained" measurements only. The reported user
 and system time are only for the current task, not for the process
 as a whole nor of any time spend by children of the current task.


* 

* **task_utime**  
  User time of the task
* See 
  _function::task_utime_(3stap)
   for details.


* **task_utime**  
  User time of the task
* See 
  _function::task_utime_(3stap)
   for details.


* **task_stime**  
  System time of the task
* See 
  _function::task_stime_(3stap)
   for details.


* **task_stime**  
  System time of the task
* See 
  _function::task_stime_(3stap)
   for details.


* **task_start_time**  
  Start time of the given task
* See 
  _function::task_start_time_(3stap)
   for details.


* **cputime_to_msecs**  
  Translates the given cputime into milliseconds
* See 
  _function::cputime_to_msecs_(3stap)
   for details.


* **cputime_to_usecs**  
  Translates the given cputime into microseconds
* See 
  _function::cputime_to_usecs_(3stap)
   for details.


* **msecs_to_string**  
  Human readable string for given milliseconds
* See 
  _function::msecs_to_string_(3stap)
   for details.


* **usecs_to_string**  
  Human readable string for given microseconds
* See 
  _function::usecs_to_string_(3stap)
   for details.


* **nsecs_to_string**  
  Human readable string for given nanoseconds
* See 
  _function::nsecs_to_string_(3stap)
   for details.


* **cputime_to_string**  
  Human readable string for given cputime
* See 
  _function::cputime_to_string_(3stap)
   for details.


* **task_time_string**  
  Human readable string of task time usage
* See 
  _function::task_time_string_(3stap)
   for details.


* **task_time_string_tid**  
  Human readable string of task time usage
* See 
  _function::task_time_string_tid_(3stap)
   for details.
  

<a name="see-also"></a>

# See Also
  
_function::task_utime_(3stap),  
_function::task_stime_(3stap),  
_function::task_start_time_(3stap),  
_function::cputime_to_msecs_(3stap),  
_function::cputime_to_usecs_(3stap),  
_function::msecs_to_string_(3stap),  
_function::usecs_to_string_(3stap),  
_function::nsecs_to_string_(3stap),  
_function::cputime_to_string_(3stap),  
_function::task_time_string_(3stap),  
_function::task_time_string_tid_(3stap),  
_stap_(1),
_stapprobes_(3stap)
