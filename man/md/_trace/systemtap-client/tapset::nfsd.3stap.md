# tapset::nfsd(3stap) - systemtap nfsd tapset

SystemTap Tapset Reference, May 2021


<a name="description"></a>

# Description


* 

* **nfsd.dispatch**  
  NFS server receives an operation from client 
*  See 
  _probe::nfsd.dispatch_(3stap)
   for details.


* **nfsd.proc.lookup**  
  NFS server opening or searching for a file for client
*  See 
  _probe::nfsd.proc.lookup_(3stap)
   for details.


* **nfsd.proc.read**  
  NFS server reading file for client
*  See 
  _probe::nfsd.proc.read_(3stap)
   for details.


* **nfsd.proc.write**  
  NFS server writing data to file for client
*  See 
  _probe::nfsd.proc.write_(3stap)
   for details.


* **nfsd.proc.commit**  
  NFS server performing a commit operation for client
*  See 
  _probe::nfsd.proc.commit_(3stap)
   for details.


* **nfsd.proc.create**  
  NFS server creating a file for client
*  See 
  _probe::nfsd.proc.create_(3stap)
   for details.


* **nfsd.proc.remove**  
  NFS server removing a file for client
*  See 
  _probe::nfsd.proc.remove_(3stap)
   for details.


* **nfsd.proc.rename**  
  NFS Server renaming a file for client
*  See 
  _probe::nfsd.proc.rename_(3stap)
   for details.


* **nfsd.open**  
  NFS server opening a file for client
*  See 
  _probe::nfsd.open_(3stap)
   for details.


* **nfsd.close**  
  NFS server closing a file for client
*  See 
  _probe::nfsd.close_(3stap)
   for details.


* **nfsd.read**  
  NFS server reading data from a file for client
*  See 
  _probe::nfsd.read_(3stap)
   for details.


* **nfsd.write**  
  NFS server writing data to a file for client
*  See 
  _probe::nfsd.write_(3stap)
   for details.


* **nfsd.commit**  
  NFS server committing all pending writes to stable storage
*  See 
  _probe::nfsd.commit_(3stap)
   for details.


* **nfsd.lookup**  
  NFS server opening or searching file for a file for client
*  See 
  _probe::nfsd.lookup_(3stap)
   for details.


* **nfsd.create**  
  NFS server creating a file(regular,dir,device,fifo) for client
*  See 
  _probe::nfsd.create_(3stap)
   for details.


* **nfsd.createv3**  
  NFS server creating a regular file or set file attributes for client
*  See 
  _probe::nfsd.createv3_(3stap)
   for details.


* **nfsd.unlink**  
  NFS server removing a file or a directory for client
*  See 
  _probe::nfsd.unlink_(3stap)
   for details.
  

<a name="see-also"></a>

# See Also
  
_probe::nfsd.dispatch_(3stap),  
_probe::nfsd.proc.lookup_(3stap),  
_probe::nfsd.proc.read_(3stap),  
_probe::nfsd.proc.write_(3stap),  
_probe::nfsd.proc.commit_(3stap),  
_probe::nfsd.proc.create_(3stap),  
_probe::nfsd.proc.remove_(3stap),  
_probe::nfsd.proc.rename_(3stap),  
_probe::nfsd.open_(3stap),  
_probe::nfsd.close_(3stap),  
_probe::nfsd.read_(3stap),  
_probe::nfsd.write_(3stap),  
_probe::nfsd.commit_(3stap),  
_probe::nfsd.lookup_(3stap),  
_probe::nfsd.create_(3stap),  
_probe::nfsd.createv3_(3stap),  
_probe::nfsd.unlink_(3stap),  
_probe::nfsd.rename_(3stap),  
_stap_(1),
_stapprobes_(3stap)
