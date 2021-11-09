# tapset::nfs_proc(3stap) - systemtap nfs_proc tapset

SystemTap Tapset Reference, May 2021


<a name="description"></a>

# Description


* 

* **nfs.proc.lookup**  
  NFS client opens/searches a file on server
*  See 
  _probe::nfs.proc.lookup_(3stap)
   for details.


* **nfs.proc.read**  
  NFS client synchronously reads file from server
*  See 
  _probe::nfs.proc.read_(3stap)
   for details.


* **nfs.proc.write**  
  NFS client synchronously writes file to server
*  See 
  _probe::nfs.proc.write_(3stap)
   for details.


* **nfs.proc.commit**  
  NFS client committing data on server
*  See 
  _probe::nfs.proc.commit_(3stap)
   for details.


* **nfs.proc.read_setup**  
  NFS client setting up a read RPC task
*  See 
  _probe::nfs.proc.read_setup_(3stap)
   for details.


* **nfs.proc.read_done**  
  NFS client response to a read RPC task
*  See 
  _probe::nfs.proc.read_done_(3stap)
   for details.


* **nfs.proc.write_setup**  
  NFS client setting up a write RPC task
*  See 
  _probe::nfs.proc.write_setup_(3stap)
   for details.


* **nfs.proc.write_done**  
  NFS client response to a write RPC task
*  See 
  _probe::nfs.proc.write_done_(3stap)
   for details.


* **nfs.proc.commit_setup**  
  NFS client setting up a commit RPC task
*  See 
  _probe::nfs.proc.commit_setup_(3stap)
   for details.


* **nfs.proc.commit_done**  
  NFS client response to a commit RPC task
*  See 
  _probe::nfs.proc.commit_done_(3stap)
   for details.


* **nfs.proc.rename_setup**  
  NFS client setting up a rename RPC task
*  See 
  _probe::nfs.proc.rename_setup_(3stap)
   for details.


* **nfs.proc.rename_done**  
  NFS client response to a rename RPC task
*  See 
  _probe::nfs.proc.rename_done_(3stap)
   for details.


* **nfs.proc.open**  
  NFS client allocates file read/write context information
*  See 
  _probe::nfs.proc.open_(3stap)
   for details.


* **nfs.proc.release**  
   NFS client releases file read/write context information
*  See 
  _probe::nfs.proc.release_(3stap)
   for details.


* **nfs.proc.handle_exception**  
  NFS client handling an NFSv4 exception
*  See 
  _probe::nfs.proc.handle_exception_(3stap)
   for details.


* **nfs.proc.create**  
  NFS client creating file on server
*  See 
  _probe::nfs.proc.create_(3stap)
   for details.


* **nfs.proc.remove**  
  NFS client removes a file on server
*  See 
  _probe::nfs.proc.remove_(3stap)
   for details.


* **nfs.proc.rename**  
  NFS client renames a file on server
*  See 
  _probe::nfs.proc.rename_(3stap)
   for details.
  

<a name="see-also"></a>

# See Also
  
_probe::nfs.proc.lookup_(3stap),  
_probe::nfs.proc.read_(3stap),  
_probe::nfs.proc.write_(3stap),  
_probe::nfs.proc.commit_(3stap),  
_probe::nfs.proc.read_setup_(3stap),  
_probe::nfs.proc.read_done_(3stap),  
_probe::nfs.proc.write_setup_(3stap),  
_probe::nfs.proc.write_done_(3stap),  
_probe::nfs.proc.commit_setup_(3stap),  
_probe::nfs.proc.commit_done_(3stap),  
_probe::nfs.proc.rename_setup_(3stap),  
_probe::nfs.proc.rename_done_(3stap),  
_probe::nfs.proc.open_(3stap),  
_probe::nfs.proc.release_(3stap),  
_probe::nfs.proc.handle_exception_(3stap),  
_probe::nfs.proc.create_(3stap),  
_probe::nfs.proc.remove_(3stap),  
_probe::nfs.proc.rename_(3stap),  
_stap_(1),
_stapprobes_(3stap)
