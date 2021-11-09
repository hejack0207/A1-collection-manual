# tapset::netfilter(3stap) - systemtap netfilter tapset

SystemTap Tapset Reference, May 2021


<a name="description"></a>

# Description


* 

* **netfilter.ip.pre_routing**  
  Called before an IP packet is routed
*  See 
  _probe::netfilter.ip.pre_routing_(3stap)
   for details.


* **netfilter.ip.local_in**  
  Called on an incoming IP packet addressed to the local computer
*  See 
  _probe::netfilter.ip.local_in_(3stap)
   for details.


* **netfilter.ip.forward**  
  Called on an incoming IP packet addressed to some other computer
*  See 
  _probe::netfilter.ip.forward_(3stap)
   for details.


* **netfilter.ip.local_out**  
  Called on an outgoing IP packet
*  See 
  _probe::netfilter.ip.local_out_(3stap)
   for details.


* **netfilter.ip.post_routing**  
  Called immediately before an outgoing IP packet leaves the computer
*  See 
  _probe::netfilter.ip.post_routing_(3stap)
   for details.


* **netfilter.bridge.local_in**  
  Called on a bridging packet destined for the local computer
*  See 
  _probe::netfilter.bridge.local_in_(3stap)
   for details.


* **netfilter.bridge.forward**  
  Called on an incoming bridging packet destined for some other computer
*  See 
  _probe::netfilter.bridge.forward_(3stap)
   for details.


* **netfilter.bridge.local_out**  
  Called on a bridging packet coming from a local process
*  See 
  _probe::netfilter.bridge.local_out_(3stap)
   for details.
  

<a name="see-also"></a>

# See Also
  
_probe::netfilter.ip.pre_routing_(3stap),  
_probe::netfilter.ip.local_in_(3stap),  
_probe::netfilter.ip.forward_(3stap),  
_probe::netfilter.ip.local_out_(3stap),  
_probe::netfilter.ip.post_routing_(3stap),  
_probe::netfilter.arp.in_(3stap),  
_probe::netfilter.arp.out_(3stap),  
_probe::netfilter.arp.forward_(3stap),  
_probe::netfilter.bridge.pre_routing_(3stap),  
_probe::netfilter.bridge.local_in_(3stap),  
_probe::netfilter.bridge.forward_(3stap),  
_probe::netfilter.bridge.local_out_(3stap),  
_probe::netfilter.bridge.post_routing_(3stap),  
_stap_(1),
_stapprobes_(3stap)
