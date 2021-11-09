# tapset::networking(3stap) - systemtap networking tapset

SystemTap Tapset Reference, May 2021


<a name="description"></a>

# Description


 This family of probe points is used to probe the activities of the network device. 


* 

* **netdev.receive**  
  Data received from network device.
*  See 
  _probe::netdev.receive_(3stap)
   for details.


* **netdev.transmit**  
  Network device transmitting buffer
*  See 
  _probe::netdev.transmit_(3stap)
   for details.


* **netdev.change_mtu**  
  Called when the netdev MTU is changed
*  See 
  _probe::netdev.change_mtu_(3stap)
   for details.


* **netdev.open**  
  Called when the device is opened
*  See 
  _probe::netdev.open_(3stap)
   for details.


* **netdev.close**  
  Called when the device is closed
*  See 
  _probe::netdev.close_(3stap)
   for details.


* **netdev.hard_transmit**  
  Called when the devices is going to TX (hard)
*  See 
  _probe::netdev.hard_transmit_(3stap)
   for details.


* **netdev.rx**  
  Called when the device is going to receive a packet
*  See 
  _probe::netdev.rx_(3stap)
   for details.


* **netdev.change_rx_flag**  
  Called when the device RX flag will be changed
*  See 
  _probe::netdev.change_rx_flag_(3stap)
   for details.


* **netdev.set_promiscuity**  
  Called when the device enters/leaves promiscuity
*  See 
  _probe::netdev.set_promiscuity_(3stap)
   for details.


* **netdev.ioctl**  
  Called when the device suffers an IOCTL
*  See 
  _probe::netdev.ioctl_(3stap)
   for details.


* **netdev.register**  
  Called when the device is registered
*  See 
  _probe::netdev.register_(3stap)
   for details.


* **netdev.unregister**  
  Called when the device is being unregistered
*  See 
  _probe::netdev.unregister_(3stap)
   for details.


* **netdev.get_stats**  
  Called when someone asks the device statistics
*  See 
  _probe::netdev.get_stats_(3stap)
   for details.


* **netdev.change_mac**  
  Called when the netdev_name has the MAC changed
*  See 
  _probe::netdev.change_mac_(3stap)
   for details.
  

<a name="see-also"></a>

# See Also
  
_probe::netdev.receive_(3stap),  
_probe::netdev.transmit_(3stap),  
_probe::netdev.change_mtu_(3stap),  
_probe::netdev.open_(3stap),  
_probe::netdev.close_(3stap),  
_probe::netdev.hard_transmit_(3stap),  
_probe::netdev.rx_(3stap),  
_probe::netdev.change_rx_flag_(3stap),  
_probe::netdev.set_promiscuity_(3stap),  
_probe::netdev.ioctl_(3stap),  
_probe::netdev.register_(3stap),  
_probe::netdev.unregister_(3stap),  
_probe::netdev.get_stats_(3stap),  
_probe::netdev.change_mac_(3stap),  
_stap_(1),
_stapprobes_(3stap)
