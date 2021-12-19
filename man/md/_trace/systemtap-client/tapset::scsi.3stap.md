# tapset::scsi(3stap) - systemtap scsi tapset

SystemTap Tapset Reference, May 2021


<a name="description"></a>

# Description


 This family of probe points is used to probe SCSI activities.


* 

* **scsi.ioentry**  
  Prepares a SCSI mid-layer request
*  See 
  _probe::scsi.ioentry_(3stap)
   for details.


* **scsi.iodispatching**  
  SCSI mid-layer dispatched low-level SCSI command
*  See 
  _probe::scsi.iodispatching_(3stap)
   for details.


* **scsi.iodone**  
  SCSI command completed by low level driver and enqueued into the done queue.
*  See 
  _probe::scsi.iodone_(3stap)
   for details.


* **scsi.iocompleted**  
  SCSI mid-layer running the completion processing for block device I/O requests
*  See 
  _probe::scsi.iocompleted_(3stap)
   for details.


* **scsi.ioexecute**  
  Create mid-layer SCSI request and wait for the result
*  See 
  _probe::scsi.ioexecute_(3stap)
   for details.


* **scsi.set_state**  
  Order SCSI device state change
*  See 
  _probe::scsi.set_state_(3stap)
   for details.
  

<a name="see-also"></a>

# See Also
  
_probe::scsi.ioentry_(3stap),  
_probe::scsi.iodispatching_(3stap),  
_probe::scsi.iodone_(3stap),  
_probe::scsi.iocompleted_(3stap),  
_probe::scsi.ioexecute_(3stap),  
_probe::scsi.set_state_(3stap),  
_stap_(1),
_stapprobes_(3stap)
