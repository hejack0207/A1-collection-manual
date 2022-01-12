# tapset::scheduler(3stap) - systemtap scheduler tapset

SystemTap Tapset Reference, May 2021


<a name="description"></a>

# Description


* 

* **scheduler.cpu_off**  
  Process is about to stop running on a cpu
*  See 
  _probe::scheduler.cpu_off_(3stap)
   for details.


* **scheduler.cpu_on**  
  Process is beginning execution on a cpu
*  See 
  _probe::scheduler.cpu_on_(3stap)
   for details.


* **scheduler.tick**  
  Schedulers internal tick, a processes timeslice accounting is updated
*  See 
  _probe::scheduler.tick_(3stap)
   for details.


* **scheduler.balance**  
  A cpu attempting to find more work.
*  See 
  _probe::scheduler.balance_(3stap)
   for details.


* **scheduler.ctxswitch**  
  A context switch is occuring.
*  See 
  _probe::scheduler.ctxswitch_(3stap)
   for details.


* **scheduler.kthread_stop**  
  A thread created by kthread_create is being stopped
*  See 
  _probe::scheduler.kthread_stop_(3stap)
   for details.


* **scheduler.kthread_stop.return**  
  A kthread is stopped and gets the return value
*  See 
  _probe::scheduler.kthread_stop.return_(3stap)
   for details.


* **scheduler.wait_task**  
  Waiting on a task to unschedule (become inactive)
*  See 
  _probe::scheduler.wait_task_(3stap)
   for details.


* **scheduler.wakeup**  
  Task is woken up 
*  See 
  _probe::scheduler.wakeup_(3stap)
   for details.


* **scheduler.wakeup_new**  
  Newly created task is woken up for the first time
*  See 
  _probe::scheduler.wakeup_new_(3stap)
   for details.


* **scheduler.migrate**  
  Task migrating across cpus
*  See 
  _probe::scheduler.migrate_(3stap)
   for details.


* **scheduler.process_free**  
  Scheduler freeing a data structure for a process
*  See 
  _probe::scheduler.process_free_(3stap)
   for details.


* **scheduler.process_exit**  
  Process exiting
*  See 
  _probe::scheduler.process_exit_(3stap)
   for details.


* **scheduler.process_wait**  
  Scheduler starting to wait on a process
*  See 
  _probe::scheduler.process_wait_(3stap)
   for details.


* **scheduler.process_fork**  
  Process forked
*  See 
  _probe::scheduler.process_fork_(3stap)
   for details.


* **scheduler.signal_send**  
  Sending a signal
*  See 
  _probe::scheduler.signal_send_(3stap)
   for details.
  

<a name="see-also"></a>

# See Also
  
_probe::scheduler.cpu_off_(3stap),  
_probe::scheduler.cpu_on_(3stap),  
_probe::scheduler.tick_(3stap),  
_probe::scheduler.balance_(3stap),  
_probe::scheduler.ctxswitch_(3stap),  
_probe::scheduler.kthread_stop_(3stap),  
_probe::scheduler.kthread_stop.return_(3stap),  
_probe::scheduler.wait_task_(3stap),  
_probe::scheduler.wakeup_(3stap),  
_probe::scheduler.wakeup_new_(3stap),  
_probe::scheduler.migrate_(3stap),  
_probe::scheduler.process_free_(3stap),  
_probe::scheduler.process_exit_(3stap),  
_probe::scheduler.process_wait_(3stap),  
_probe::scheduler.process_fork_(3stap),  
_probe::scheduler.signal_send_(3stap),  
_stap_(1),
_stapprobes_(3stap)
