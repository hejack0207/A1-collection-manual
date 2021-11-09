# tapset::rpc(3stap) - systemtap rpc tapset

SystemTap Tapset Reference, May 2021


<a name="description"></a>

# Description


* 

* **sunrpc.clnt.create_client**  
  Create an RPC client
*  See 
  _probe::sunrpc.clnt.create_client_(3stap)
   for details.


* **sunrpc.clnt.clone_client**  
  Clone an RPC client structure
*  See 
  _probe::sunrpc.clnt.clone_client_(3stap)
   for details.


* **sunrpc.clnt.shutdown_client**  
  Shutdown an RPC client
*  See 
  _probe::sunrpc.clnt.shutdown_client_(3stap)
   for details.


* **sunrpc.clnt.bind_new_program**  
  Bind a new RPC program to an existing client
*  See 
  _probe::sunrpc.clnt.bind_new_program_(3stap)
   for details.


* **sunrpc.clnt.call_sync**  
  Make a synchronous RPC call
*  See 
  _probe::sunrpc.clnt.call_sync_(3stap)
   for details.


* **sunrpc.clnt.call_async**  
  Make an asynchronous RPC call
*  See 
  _probe::sunrpc.clnt.call_async_(3stap)
   for details.


* **sunrpc.clnt.restart_call**  
  Restart an asynchronous RPC call
*  See 
  _probe::sunrpc.clnt.restart_call_(3stap)
   for details.


* **sunrpc.svc.register**  
  Register an RPC service with the local portmapper
*  See 
  _probe::sunrpc.svc.register_(3stap)
   for details.


* **sunrpc.svc.create**  
  Create an RPC service
*  See 
  _probe::sunrpc.svc.create_(3stap)
   for details.


* **sunrpc.svc.destroy**  
  Destroy an RPC service
*  See 
  _probe::sunrpc.svc.destroy_(3stap)
   for details.


* **sunrpc.svc.process**  
  Process an RPC request
*  See 
  _probe::sunrpc.svc.process_(3stap)
   for details.


* **sunrpc.svc.authorise**  
  An RPC request is to be authorised
*  See 
  _probe::sunrpc.svc.authorise_(3stap)
   for details.


* **sunrpc.svc.recv**  
  Listen for the next RPC request on any socket
*  See 
  _probe::sunrpc.svc.recv_(3stap)
   for details.


* **sunrpc.svc.send**  
  Return reply to RPC client
*  See 
  _probe::sunrpc.svc.send_(3stap)
   for details.


* **sunrpc.svc.drop**  
  Drop RPC request
*  See 
  _probe::sunrpc.svc.drop_(3stap)
   for details.


* **sunrpc.sched.new_task**  
  Create new task for the specified client
*  See 
  _probe::sunrpc.sched.new_task_(3stap)
   for details.


* **sunrpc.sched.release_task**  
  Release all resources associated with a task
*  See 
  _probe::sunrpc.sched.release_task_(3stap)
   for details.


* **sunrpc.sched.execute**  
  Execute the RPC \`scheduler' 
*  See 
  _probe::sunrpc.sched.execute_(3stap)
   for details.


* **sunrpc.sched.delay**  
  Delay an RPC task
*  See 
  _probe::sunrpc.sched.delay_(3stap)
   for details.
  

<a name="see-also"></a>

# See Also
  
_probe::sunrpc.clnt.create_client_(3stap),  
_probe::sunrpc.clnt.clone_client_(3stap),  
_probe::sunrpc.clnt.shutdown_client_(3stap),  
_probe::sunrpc.clnt.bind_new_program_(3stap),  
_probe::sunrpc.clnt.call_sync_(3stap),  
_probe::sunrpc.clnt.call_async_(3stap),  
_probe::sunrpc.clnt.restart_call_(3stap),  
_probe::sunrpc.svc.register_(3stap),  
_probe::sunrpc.svc.create_(3stap),  
_probe::sunrpc.svc.destroy_(3stap),  
_probe::sunrpc.svc.process_(3stap),  
_probe::sunrpc.svc.authorise_(3stap),  
_probe::sunrpc.svc.recv_(3stap),  
_probe::sunrpc.svc.send_(3stap),  
_probe::sunrpc.svc.drop_(3stap),  
_probe::sunrpc.sched.new_task_(3stap),  
_probe::sunrpc.sched.release_task_(3stap),  
_probe::sunrpc.sched.execute_(3stap),  
_probe::sunrpc.sched.delay_(3stap),  
_stap_(1),
_stapprobes_(3stap)
