# tapset::ipmib(3stap) - systemtap ipmib tapset

SystemTap Tapset Reference, May 2021


<a name="description"></a>

# Description


* 

* **ipmib_remote_addr**  
  Get the remote ip address
* See 
  _function::ipmib_remote_addr_(3stap)
   for details.


* **ipmib_local_addr**  
  Get the local ip address
* See 
  _function::ipmib_local_addr_(3stap)
   for details.


* **ipmib_tcp_remote_port**  
  Get the remote tcp port
* See 
  _function::ipmib_tcp_remote_port_(3stap)
   for details.


* **ipmib_tcp_local_port**  
  Get the local tcp port
* See 
  _function::ipmib_tcp_local_port_(3stap)
   for details.


* **ipmib_get_proto**  
  Get the protocol value
* See 
  _function::ipmib_get_proto_(3stap)
   for details.


* **ipmib.InReceives**  
  Count an arriving packet
*  See 
  _probe::ipmib.InReceives_(3stap)
   for details.


* **ipmib.InNoRoutes**  
  Count an arriving packet with no matching socket
*  See 
  _probe::ipmib.InNoRoutes_(3stap)
   for details.


* **ipmib.InAddrErrors**  
  Count arriving packets with an incorrect address
*  See 
  _probe::ipmib.InAddrErrors_(3stap)
   for details.


* **ipmib.InUnknownProtos**  
  Count arriving packets with an unbound proto
*  See 
  _probe::ipmib.InUnknownProtos_(3stap)
   for details.


* **ipmib.InDiscards**  
  Count discarded inbound packets
*  See 
  _probe::ipmib.InDiscards_(3stap)
   for details.


* **ipmib.ForwDatagrams**  
  Count forwarded packet
*  See 
  _probe::ipmib.ForwDatagrams_(3stap)
   for details.


* **ipmib.OutRequests**  
  Count a request to send a packet
*  See 
  _probe::ipmib.OutRequests_(3stap)
   for details.


* **ipmib.ReasmTimeout**  
  Count Reassembly Timeouts
*  See 
  _probe::ipmib.ReasmTimeout_(3stap)
   for details.


* **ipmib.ReasmReqds**  
  Count number of packet fragments reassembly requests
*  See 
  _probe::ipmib.ReasmReqds_(3stap)
   for details.


* **ipmib.FragOKs**  
  Count datagram fragmented successfully
*  See 
  _probe::ipmib.FragOKs_(3stap)
   for details.


* **ipmib.FragFails**  
  Count datagram fragmented unsuccessfully
*  See 
  _probe::ipmib.FragFails_(3stap)
   for details.
  

<a name="see-also"></a>

# See Also
  
_function::ipmib_remote_addr_(3stap),  
_function::ipmib_local_addr_(3stap),  
_function::ipmib_tcp_remote_port_(3stap),  
_function::ipmib_tcp_local_port_(3stap),  
_function::ipmib_get_proto_(3stap),  
_probe::ipmib.InReceives_(3stap),  
_probe::ipmib.InNoRoutes_(3stap),  
_probe::ipmib.InAddrErrors_(3stap),  
_probe::ipmib.InUnknownProtos_(3stap),  
_probe::ipmib.InDiscards_(3stap),  
_probe::ipmib.ForwDatagrams_(3stap),  
_probe::ipmib.OutRequests_(3stap),  
_probe::ipmib.ReasmTimeout_(3stap),  
_probe::ipmib.ReasmReqds_(3stap),  
_probe::ipmib.FragOKs_(3stap),  
_probe::ipmib.FragFails_(3stap),  
_stap_(1),
_stapprobes_(3stap)
