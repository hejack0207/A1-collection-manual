# tapset::ioscheduler(3stap) - systemtap ioscheduler tapset

SystemTap Tapset Reference, May 2021


<a name="description"></a>

# Description


 This family of probe points is used to probe IO scheduler activities. 


* 

* **ioscheduler.elv_next_request**  
  Fires when a request is retrieved from the request queue
*  See 
  _probe::ioscheduler.elv_next_request_(3stap)
   for details.


* **ioscheduler.elv_next_request.return**  
  Fires when a request retrieval issues a return signal
*  See 
  _probe::ioscheduler.elv_next_request.return_(3stap)
   for details.


* **ioscheduler.elv_completed_request**  
  Fires when a request is completed
*  See 
  _probe::ioscheduler.elv_completed_request_(3stap)
   for details.


* **ioscheduler.elv_add_request.kp**  
  kprobe based probe to indicate that a request was added to the request queue
*  See 
  _probe::ioscheduler.elv_add_request.kp_(3stap)
   for details.


* **ioscheduler.elv_add_request.tp**  
  tracepoint based probe to indicate a request is added to the request queue.
*  See 
  _probe::ioscheduler.elv_add_request.tp_(3stap)
   for details.


* **ioscheduler.elv_add_request**  
  probe to indicate request is added to the request queue.
*  See 
  _probe::ioscheduler.elv_add_request_(3stap)
   for details.


* **ioscheduler_trace.elv_completed_request**  
  Fires when a request is
*  See 
  _probe::ioscheduler_trace.elv_completed_request_(3stap)
   for details.


* **ioscheduler_trace.elv_issue_request**  
  Fires when a request is
*  See 
  _probe::ioscheduler_trace.elv_issue_request_(3stap)
   for details.


* **ioscheduler_trace.elv_requeue_request**  
  Fires when a request is
*  See 
  _probe::ioscheduler_trace.elv_requeue_request_(3stap)
   for details.


* **ioscheduler_trace.elv_abort_request**  
  Fires when a request is aborted.
*  See 
  _probe::ioscheduler_trace.elv_abort_request_(3stap)
   for details.


* **ioscheduler_trace.plug**  
  Fires when a request queue is plugged;
*  See 
  _probe::ioscheduler_trace.plug_(3stap)
   for details.


* **ioscheduler_trace.unplug_io**  
  Fires when a request queue is unplugged;
*  See 
  _probe::ioscheduler_trace.unplug_io_(3stap)
   for details.


* **ioscheduler_trace.unplug_timer**  
  Fires when unplug timer associated
*  See 
  _probe::ioscheduler_trace.unplug_timer_(3stap)
   for details.
  

<a name="see-also"></a>

# See Also
  
_probe::ioscheduler.elv_next_request_(3stap),  
_probe::ioscheduler.elv_next_request.return_(3stap),  
_probe::ioscheduler.elv_completed_request_(3stap),  
_probe::ioscheduler.elv_add_request.kp_(3stap),  
_probe::ioscheduler.elv_add_request.tp_(3stap),  
_probe::ioscheduler.elv_add_request_(3stap),  
_probe::ioscheduler_trace.elv_completed_request_(3stap),  
_probe::ioscheduler_trace.elv_issue_request_(3stap),  
_probe::ioscheduler_trace.elv_requeue_request_(3stap),  
_probe::ioscheduler_trace.elv_abort_request_(3stap),  
_probe::ioscheduler_trace.plug_(3stap),  
_probe::ioscheduler_trace.unplug_io_(3stap),  
_probe::ioscheduler_trace.unplug_timer_(3stap),  
_stap_(1),
_stapprobes_(3stap)
