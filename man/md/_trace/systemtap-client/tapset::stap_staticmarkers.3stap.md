# tapset::stap_staticmarkers(3stap) - systemtap stap_staticmarkers tapset

SystemTap Tapset Reference, May 2021


<a name="description"></a>

# Description


* 

* **stap.pass0**  
  Starting stap pass0 (parsing command line arguments)
*  See 
  _probe::stap.pass0_(3stap)
   for details.


* **stap.pass0.end**  
  Finished stap pass0 (parsing command line arguments)
*  See 
  _probe::stap.pass0.end_(3stap)
   for details.


* **stap.pass1a**  
  Starting stap pass1 (parsing user script)
*  See 
  _probe::stap.pass1a_(3stap)
   for details.


* **stap.pass1b**  
  Starting stap pass1 (parsing library scripts)
*  See 
  _probe::stap.pass1b_(3stap)
   for details.


* **stap.pass1.end**  
  Finished stap pass1 (parsing scripts)
*  See 
  _probe::stap.pass1.end_(3stap)
   for details.


* **stap.pass2**  
  Starting stap pass2 (elaboration)
*  See 
  _probe::stap.pass2_(3stap)
   for details.


* **stap.pass2.end**  
  Finished stap pass2 (elaboration)
*  See 
  _probe::stap.pass2.end_(3stap)
   for details.


* **stap.pass3**  
  Starting stap pass3 (translation to C)
*  See 
  _probe::stap.pass3_(3stap)
   for details.


* **stap.pass3.end**  
  Finished stap pass3 (translation to C)
*  See 
  _probe::stap.pass3.end_(3stap)
   for details.


* **stap.pass4**  
  Starting stap pass4 (compile C code into kernel module)
*  See 
  _probe::stap.pass4_(3stap)
   for details.


* **stap.pass4.end**  
  Finished stap pass4 (compile C code into kernel module)
*  See 
  _probe::stap.pass4.end_(3stap)
   for details.


* **stap.pass5**  
  Starting stap pass5 (running the instrumentation)
*  See 
  _probe::stap.pass5_(3stap)
   for details.


* **stap.pass5.end**  
  Finished stap pass5 (running the instrumentation)
*  See 
  _probe::stap.pass5.end_(3stap)
   for details.


* **stap.pass6**  
  Starting stap pass6 (cleanup)
*  See 
  _probe::stap.pass6_(3stap)
   for details.


* **stap.pass6.end**  
  Finished stap pass6 (cleanup)
*  See 
  _probe::stap.pass6.end_(3stap)
   for details.


* **stap.cache_clean**  
  Removing file from stap cache
*  See 
  _probe::stap.cache_clean_(3stap)
   for details.


* **stap.cache_add_mod**  
  Adding kernel instrumentation module to cache
*  See 
  _probe::stap.cache_add_mod_(3stap)
   for details.


* **stap.cache_add_src**  
  Adding C code translation to cache
*  See 
  _probe::stap.cache_add_src_(3stap)
   for details.


* **stap.cache_add_nss**  
  Add NSS (Network Security Services) information to cache
*  See 
  _probe::stap.cache_add_nss_(3stap)
   for details.


* **stap.cache_get**  
  Found item in stap cache
*  See 
  _probe::stap.cache_get_(3stap)
   for details.


* **stap.system**  
  Starting a command from stap
*  See 
  _probe::stap.system_(3stap)
   for details.


* **stap.system.spawn**  
  stap spawned new process
*  See 
  _probe::stap.system.spawn_(3stap)
   for details.


* **stap.system.return**  
  Finished a command from stap
*  See 
  _probe::stap.system.return_(3stap)
   for details.


* **staprun.insert_module**  
  Inserting SystemTap instrumentation module
*  See 
  _probe::staprun.insert_module_(3stap)
   for details.


* **staprun.remove_module**  
  Removing SystemTap instrumentation module
*  See 
  _probe::staprun.remove_module_(3stap)
   for details.


* **staprun.send_control_message**  
  Sending a control message
*  See 
  _probe::staprun.send_control_message_(3stap)
   for details.


* **stapio.receive_control_message**  
  Received a control message
*  See 
  _probe::stapio.receive_control_message_(3stap)
   for details.
  

<a name="see-also"></a>

# See Also
  
_probe::stap.pass0_(3stap),  
_probe::stap.pass0.end_(3stap),  
_probe::stap.pass1a_(3stap),  
_probe::stap.pass1b_(3stap),  
_probe::stap.pass1.end_(3stap),  
_probe::stap.pass2_(3stap),  
_probe::stap.pass2.end_(3stap),  
_probe::stap.pass3_(3stap),  
_probe::stap.pass3.end_(3stap),  
_probe::stap.pass4_(3stap),  
_probe::stap.pass4.end_(3stap),  
_probe::stap.pass5_(3stap),  
_probe::stap.pass5.end_(3stap),  
_probe::stap.pass6_(3stap),  
_probe::stap.pass6.end_(3stap),  
_probe::stap.cache_clean_(3stap),  
_probe::stap.cache_add_mod_(3stap),  
_probe::stap.cache_add_src_(3stap),  
_probe::stap.cache_add_nss_(3stap),  
_probe::stap.cache_get_(3stap),  
_probe::stap.system_(3stap),  
_probe::stap.system.spawn_(3stap),  
_probe::stap.system.return_(3stap),  
_probe::staprun.insert_module_(3stap),  
_probe::staprun.remove_module_(3stap),  
_probe::staprun.send_control_message_(3stap),  
_probe::stapio.receive_control_message_(3stap),  
_stap_(1),
_stapprobes_(3stap)
