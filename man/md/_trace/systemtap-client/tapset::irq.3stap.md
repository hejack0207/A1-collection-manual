# tapset::irq(3stap) - systemtap irq tapset

SystemTap Tapset Reference, May 2021


<a name="description"></a>

# Description


* 

* **workqueue.create**  
  Creating a new workqueue
*  See 
  _probe::workqueue.create_(3stap)
   for details.


* **workqueue.insert**  
  Queuing work on a workqueue
*  See 
  _probe::workqueue.insert_(3stap)
   for details.


* **workqueue.execute**  
  Executing deferred work
*  See 
  _probe::workqueue.execute_(3stap)
   for details.


* **workqueue.destroy**  
  Destroying workqueue
*  See 
  _probe::workqueue.destroy_(3stap)
   for details.


* **irq_handler.entry**  
  Execution of interrupt handler starting
*  See 
  _probe::irq_handler.entry_(3stap)
   for details.


* **irq_handler.exit**  
  Execution of interrupt handler completed
*  See 
  _probe::irq_handler.exit_(3stap)
   for details.


* **softirq.entry**  
  Execution of handler for a pending softirq starting
*  See 
  _probe::softirq.entry_(3stap)
   for details.


* **softirq.exit**  
  Execution of handler for a pending softirq completed
*  See 
  _probe::softirq.exit_(3stap)
   for details.
  

<a name="see-also"></a>

# See Also
  
_probe::workqueue.create_(3stap),  
_probe::workqueue.insert_(3stap),  
_probe::workqueue.execute_(3stap),  
_probe::workqueue.destroy_(3stap),  
_probe::irq_handler.entry_(3stap),  
_probe::irq_handler.exit_(3stap),  
_probe::softirq.entry_(3stap),  
_probe::softirq.exit_(3stap),  
_stap_(1),
_stapprobes_(3stap)
