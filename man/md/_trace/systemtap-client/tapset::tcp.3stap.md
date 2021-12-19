# tapset::tcp(3stap) - systemtap tcp tapset

SystemTap Tapset Reference, May 2021


<a name="description"></a>

# Description


 This family of probe points is used to probe events that occur in the TCP layer, 


* 

* **tcp.sendmsg**  
  Sending a tcp message
*  See 
  _probe::tcp.sendmsg_(3stap)
   for details.


* **tcp.sendmsg.return**  
   Sending TCP message is done
*  See 
  _probe::tcp.sendmsg.return_(3stap)
   for details.


* **tcp.recvmsg**  
  Receiving TCP message
*  See 
  _probe::tcp.recvmsg_(3stap)
   for details.


* **tcp.recvmsg.return**  
  Receiving TCP message complete
*  See 
  _probe::tcp.recvmsg.return_(3stap)
   for details.


* **tcp.disconnect**  
  TCP socket disconnection
*  See 
  _probe::tcp.disconnect_(3stap)
   for details.


* **tcp.disconnect.return**  
  TCP socket disconnection complete
*  See 
  _probe::tcp.disconnect.return_(3stap)
   for details.


* **tcp.setsockopt**  
  Call to setsockopt()
*  See 
  _probe::tcp.setsockopt_(3stap)
   for details.


* **tcp.setsockopt.return**  
   Return from setsockopt()
*  See 
  _probe::tcp.setsockopt.return_(3stap)
   for details.


* **tcp.receive**  
  Called when a TCP packet is received
*  See 
  _probe::tcp.receive_(3stap)
   for details.
  

<a name="see-also"></a>

# See Also
  
_probe::tcp.sendmsg_(3stap),  
_probe::tcp.sendmsg.return_(3stap),  
_probe::tcp.recvmsg_(3stap),  
_probe::tcp.recvmsg.return_(3stap),  
_probe::tcp.disconnect_(3stap),  
_probe::tcp.disconnect.return_(3stap),  
_probe::tcp.setsockopt_(3stap),  
_probe::tcp.setsockopt.return_(3stap),  
_probe::tcp.receive_(3stap),  
_stap_(1),
_stapprobes_(3stap)
