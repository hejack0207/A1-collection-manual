# tapset::ioblock(3stap) - systemtap ioblock tapset

SystemTap Tapset Reference, May 2021


<a name="description"></a>

# Description


* 

* **ioblock.request**  
  Fires whenever making a generic block I/O request.
*  See 
  _probe::ioblock.request_(3stap)
   for details.


* **ioblock.end**  
  Fires whenever a block I/O transfer is complete.
*  See 
  _probe::ioblock.end_(3stap)
   for details.


* **ioblock_trace.bounce**  
  Fires whenever a buffer bounce is needed for at least one page of a block IO request.
*  See 
  _probe::ioblock_trace.bounce_(3stap)
   for details.


* **ioblock_trace.request**  
  Fires just as a generic block I/O request is created for a bio.
*  See 
  _probe::ioblock_trace.request_(3stap)
   for details.


* **ioblock_trace.end**  
  Fires whenever a block I/O transfer is complete.
*  See 
  _probe::ioblock_trace.end_(3stap)
   for details.
  

<a name="see-also"></a>

# See Also
  
_probe::ioblock.request_(3stap),  
_probe::ioblock.end_(3stap),  
_probe::ioblock_trace.bounce_(3stap),  
_probe::ioblock_trace.request_(3stap),  
_probe::ioblock_trace.end_(3stap),  
_stap_(1),
_stapprobes_(3stap)
