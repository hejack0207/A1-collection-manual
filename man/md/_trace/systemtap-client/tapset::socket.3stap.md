# tapset::socket(3stap) - systemtap socket tapset

SystemTap Tapset Reference, May 2021


<a name="description"></a>

# Description


 This family of probe points is used to probe socket activities.


* 

* **socket.send**  
  Message sent on a socket.
*  See 
  _probe::socket.send_(3stap)
   for details.


* **socket.receive**  
  Message received on a socket.
*  See 
  _probe::socket.receive_(3stap)
   for details.


* **socket.sendmsg**  
  Message is currently being sent on a socket.
*  See 
  _probe::socket.sendmsg_(3stap)
   for details.


* **socket.sendmsg.return**  
  Return from socket.sendmsg.
*  See 
  _probe::socket.sendmsg.return_(3stap)
   for details.


* **socket.recvmsg**  
  Message being received on socket
*  See 
  _probe::socket.recvmsg_(3stap)
   for details.


* **socket.recvmsg.return**  
  Return from Message being received on socket
*  See 
  _probe::socket.recvmsg.return_(3stap)
   for details.


* **socket.aio_write**  
  Message send via sock_aio_write()
*  See 
  _probe::socket.aio_write_(3stap)
   for details.


* **socket.aio_write.return**  
  Conclusion of message send via sock_aio_write()
*  See 
  _probe::socket.aio_write.return_(3stap)
   for details.


* **socket.aio_read**  
  Receiving message via sock_aio_read()
*  See 
  _probe::socket.aio_read_(3stap)
   for details.


* **socket.aio_read.return**  
  Conclusion of message received via sock_aio_read()
*  See 
  _probe::socket.aio_read.return_(3stap)
   for details.


* **socket.write_iter**  
  Message send via sock_write_iter()
*  See 
  _probe::socket.write_iter_(3stap)
   for details.


* **socket.write_iter.return**  
  Conclusion of message send via sock_write_iter()
*  See 
  _probe::socket.write_iter.return_(3stap)
   for details.


* **socket.read_iter**  
  Receiving message via sock_read_iter()
*  See 
  _probe::socket.read_iter_(3stap)
   for details.


* **socket.read_iter.return**  
  Conclusion of message received via sock_read_iter()
*  See 
  _probe::socket.read_iter.return_(3stap)
   for details.


* **socket.writev**  
  Message sent via socket_writev()
*  See 
  _probe::socket.writev_(3stap)
   for details.


* **socket.writev.return**  
  Conclusion of message sent via socket_writev()
*  See 
  _probe::socket.writev.return_(3stap)
   for details.


* **socket.readv**  
  Receiving a message via sock_readv()
*  See 
  _probe::socket.readv_(3stap)
   for details.


* **socket.readv.return**  
  Conclusion of receiving a message via sock_readv()
*  See 
  _probe::socket.readv.return_(3stap)
   for details.


* **socket.create**  
  Creation of a socket
*  See 
  _probe::socket.create_(3stap)
   for details.


* **socket.create.return**  
  Return from Creation of a socket
*  See 
  _probe::socket.create.return_(3stap)
   for details.


* **socket.close**  
  Close a socket
*  See 
  _probe::socket.close_(3stap)
   for details.


* **socket.close.return**  
  Return from closing a socket
*  See 
  _probe::socket.close.return_(3stap)
   for details.


* **sock_prot_num2str**  
  Given a protocol number, return a string representation
* See 
  _function::sock_prot_num2str_(3stap)
   for details.


* **sock_prot_str2num**  
  Given a protocol name (string), return the corresponding protocol number
* See 
  _function::sock_prot_str2num_(3stap)
   for details.


* **sock_fam_num2str**  
  Given a protocol family number, return a string representation
* See 
  _function::sock_fam_num2str_(3stap)
   for details.


* **sock_fam_str2num**  
  Given a protocol family name (string), return the corresponding protocol family number
* See 
  _function::sock_fam_str2num_(3stap)
   for details.


* **sock_state_num2str**  
  Given a socket state number, return a string representation
* See 
  _function::sock_state_num2str_(3stap)
   for details.


* **sock_state_str2num**  
  Given a socket state string, return the corresponding state number
* See 
  _function::sock_state_str2num_(3stap)
   for details.
  

<a name="see-also"></a>

# See Also
  
_function::sock_prot_num2str_(3stap),  
_function::sock_prot_str2num_(3stap),  
_function::sock_fam_num2str_(3stap),  
_function::sock_fam_str2num_(3stap),  
_function::sock_state_num2str_(3stap),  
_function::sock_state_str2num_(3stap),  
_probe::socket.send_(3stap),  
_probe::socket.receive_(3stap),  
_probe::socket.sendmsg_(3stap),  
_probe::socket.sendmsg.return_(3stap),  
_probe::socket.recvmsg_(3stap),  
_probe::socket.recvmsg.return_(3stap),  
_probe::socket.aio_write_(3stap),  
_probe::socket.aio_write.return_(3stap),  
_probe::socket.aio_read_(3stap),  
_probe::socket.aio_read.return_(3stap),  
_probe::socket.write_iter_(3stap),  
_probe::socket.write_iter.return_(3stap),  
_probe::socket.read_iter_(3stap),  
_probe::socket.read_iter.return_(3stap),  
_probe::socket.writev_(3stap),  
_probe::socket.writev.return_(3stap),  
_probe::socket.readv_(3stap),  
_probe::socket.readv.return_(3stap),  
_probe::socket.create_(3stap),  
_probe::socket.create.return_(3stap),  
_probe::socket.close_(3stap),  
_probe::socket.close.return_(3stap),  
_stap_(1),
_stapprobes_(3stap)
