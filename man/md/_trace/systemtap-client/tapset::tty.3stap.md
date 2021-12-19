# tapset::tty(3stap) - systemtap tty tapset

SystemTap Tapset Reference, May 2021


<a name="description"></a>

# Description


* 

* **tty.open**  
  Called when a tty is opened
*  See 
  _probe::tty.open_(3stap)
   for details.


* **tty.release**  
  Called when the tty is closed
*  See 
  _probe::tty.release_(3stap)
   for details.


* **tty.resize**  
  Called when a terminal resize happens
*  See 
  _probe::tty.resize_(3stap)
   for details.


* **tty.ioctl**  
  called when a ioctl is request to the tty
*  See 
  _probe::tty.ioctl_(3stap)
   for details.


* **tty.init**  
  Called when a tty is being initalized
*  See 
  _probe::tty.init_(3stap)
   for details.


* **tty.register**  
  Called when a tty device is registred
*  See 
  _probe::tty.register_(3stap)
   for details.


* **tty.unregister**  
  Called when a tty device is being unregistered
*  See 
  _probe::tty.unregister_(3stap)
   for details.


* **tty.poll**  
  Called when a tty device is being polled
*  See 
  _probe::tty.poll_(3stap)
   for details.


* **tty.receive**  
  called when a tty receives a message
*  See 
  _probe::tty.receive_(3stap)
   for details.


* **tty.write**  
  write to the tty line
*  See 
  _probe::tty.write_(3stap)
   for details.


* **tty.read**  
  called when a tty line will be read
*  See 
  _probe::tty.read_(3stap)
   for details.
  

<a name="see-also"></a>

# See Also
  
_probe::tty.open_(3stap),  
_probe::tty.release_(3stap),  
_probe::tty.resize_(3stap),  
_probe::tty.ioctl_(3stap),  
_probe::tty.init_(3stap),  
_probe::tty.register_(3stap),  
_probe::tty.unregister_(3stap),  
_probe::tty.poll_(3stap),  
_probe::tty.receive_(3stap),  
_probe::tty.write_(3stap),  
_probe::tty.read_(3stap),  
_stap_(1),
_stapprobes_(3stap)
