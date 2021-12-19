# tapset::udp(3stap) - systemtap udp tapset

SystemTap Tapset Reference, May 2021


<a name="description"></a>

# Description


 This family of probe points is used to probe events that occur in the UDP layer. 


* 

* **udp.sendmsg**  
  Fires whenever a process sends a UDP message  
*  See 
  _probe::udp.sendmsg_(3stap)
   for details.


* **udp.sendmsg.return**  
  Fires whenever an attempt to send a UDP message is completed
*  See 
  _probe::udp.sendmsg.return_(3stap)
   for details.


* **udp.recvmsg**  
  Fires whenever a UDP message is received
*  See 
  _probe::udp.recvmsg_(3stap)
   for details.


* **udp.recvmsg.return**  
  Fires whenever an attempt to receive a UDP message received is completed
*  See 
  _probe::udp.recvmsg.return_(3stap)
   for details.


* **udp.disconnect**  
  Fires when a process requests for a UDP disconnection
*  See 
  _probe::udp.disconnect_(3stap)
   for details.


* **udp.disconnect.return**  
  UDP has been disconnected successfully
*  See 
  _probe::udp.disconnect.return_(3stap)
   for details.
  

<a name="see-also"></a>

# See Also
  
_probe::udp.sendmsg_(3stap),  
_probe::udp.sendmsg.return_(3stap),  
_probe::udp.recvmsg_(3stap),  
_probe::udp.recvmsg.return_(3stap),  
_probe::udp.disconnect_(3stap),  
_probe::udp.disconnect.return_(3stap),  
_stap_(1),
_stapprobes_(3stap)
