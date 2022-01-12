# tapset::queue_stats(3stap) - systemtap queue_stats tapset

SystemTap Tapset Reference, May 2021


<a name="description"></a>

# Description


* 

* **qs_wait**  
  Function to record enqueue requests
* See 
  _function::qs_wait_(3stap)
   for details.


* **qs_run**  
  Function to record being moved from wait queue to being serviced 
* See 
  _function::qs_run_(3stap)
   for details.


* **qs_done**  
  Function to record finishing request 
* See 
  _function::qs_done_(3stap)
   for details.


* **qsq_start**  
  Function to reset the stats for a queue
* See 
  _function::qsq_start_(3stap)
   for details.


* **qsq_utilization**  
  Fraction of time that any request was being serviced 
* See 
  _function::qsq_utilization_(3stap)
   for details.


* **qsq_blocked**  
  Returns the time reqest was on the wait queue 
* See 
  _function::qsq_blocked_(3stap)
   for details.


* **qsq_wait_queue_length**  
  length of wait queue 
* See 
  _function::qsq_wait_queue_length_(3stap)
   for details.


* **qsq_service_time**  
  Amount of time per request service 
* See 
  _function::qsq_service_time_(3stap)
   for details.


* **qsq_wait_time**  
  Amount of time in queue + service per request
* See 
  _function::qsq_wait_time_(3stap)
   for details.


* **qsq_throughput**  
  Number of requests served per unit time 
* See 
  _function::qsq_throughput_(3stap)
   for details.


* **qsq_print**  
  Prints a line of statistics for the given queue
* See 
  _function::qsq_print_(3stap)
   for details.
  

<a name="see-also"></a>

# See Also
  
_function::qs_wait_(3stap),  
_function::qs_run_(3stap),  
_function::qs_done_(3stap),  
_function::qsq_start_(3stap),  
_function::qsq_utilization_(3stap),  
_function::qsq_blocked_(3stap),  
_function::qsq_wait_queue_length_(3stap),  
_function::qsq_service_time_(3stap),  
_function::qsq_wait_time_(3stap),  
_function::qsq_throughput_(3stap),  
_function::qsq_print_(3stap),  
_stap_(1),
_stapprobes_(3stap)
