# tapset::tcpmib(3stap) - systemtap tcpmib tapset

SystemTap Tapset Reference, May 2021


<a name="description"></a>

# Description


* 

* **tcpmib_get_state**  
  Get a socket's state
* See 
  _function::tcpmib_get_state_(3stap)
   for details.


* **tcpmib_local_addr**  
  Get the source address
* See 
  _function::tcpmib_local_addr_(3stap)
   for details.


* **tcpmib_remote_addr**  
  Get the remote address
* See 
  _function::tcpmib_remote_addr_(3stap)
   for details.


* **tcpmib_local_port**  
  Get the local port
* See 
  _function::tcpmib_local_port_(3stap)
   for details.


* **tcpmib_remote_port**  
  Get the remote port
* See 
  _function::tcpmib_remote_port_(3stap)
   for details.


* **tcpmib.ActiveOpens**  
  Count an active opening of a socket
*  See 
  _probe::tcpmib.ActiveOpens_(3stap)
   for details.


* **tcpmib.AttemptFails**  
  Count a failed attempt to open a socket
*  See 
  _probe::tcpmib.AttemptFails_(3stap)
   for details.


* **tcpmib.CurrEstab**  
  Update the count of open sockets
*  See 
  _probe::tcpmib.CurrEstab_(3stap)
   for details.


* **tcpmib.EstabResets**  
  Count the reset of a socket
*  See 
  _probe::tcpmib.EstabResets_(3stap)
   for details.


* **tcpmib.InSegs**  
  Count an incoming tcp segment
*  See 
  _probe::tcpmib.InSegs_(3stap)
   for details.


* **tcpmib.OutRsts**  
  Count the sending of a reset packet
*  See 
  _probe::tcpmib.OutRsts_(3stap)
   for details.


* **tcpmib.OutSegs**  
  Count the sending of a TCP segment
*  See 
  _probe::tcpmib.OutSegs_(3stap)
   for details.


* **tcpmib.PassiveOpens**  
  Count the passive creation of a socket
*  See 
  _probe::tcpmib.PassiveOpens_(3stap)
   for details.


* **tcpmib.RetransSegs**  
  Count the retransmission of a TCP segment
*  See 
  _probe::tcpmib.RetransSegs_(3stap)
   for details.
  

<a name="see-also"></a>

# See Also
  
_function::tcpmib_get_state_(3stap),  
_function::tcpmib_local_addr_(3stap),  
_function::tcpmib_remote_addr_(3stap),  
_function::tcpmib_local_port_(3stap),  
_function::tcpmib_remote_port_(3stap),  
_probe::tcpmib.ActiveOpens_(3stap),  
_probe::tcpmib.AttemptFails_(3stap),  
_probe::tcpmib.CurrEstab_(3stap),  
_probe::tcpmib.EstabResets_(3stap),  
_probe::tcpmib.InSegs_(3stap),  
_probe::tcpmib.OutRsts_(3stap),  
_probe::tcpmib.OutSegs_(3stap),  
_probe::tcpmib.PassiveOpens_(3stap),  
_probe::tcpmib.RetransSegs_(3stap),  
_stap_(1),
_stapprobes_(3stap)
