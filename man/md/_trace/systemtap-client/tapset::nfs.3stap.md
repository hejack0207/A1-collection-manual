# tapset::nfs(3stap) - systemtap nfs tapset

SystemTap Tapset Reference, May 2021


<a name="description"></a>

# Description


* 

* **nfs.fop.llseek**  
  NFS client llseek operation
*  See 
  _probe::nfs.fop.llseek_(3stap)
   for details.


* **nfs.fop.read**  
  NFS client read operation
*  See 
  _probe::nfs.fop.read_(3stap)
   for details.


* **nfs.fop.write**  
  NFS client write operation
*  See 
  _probe::nfs.fop.write_(3stap)
   for details.


* **nfs.fop.aio_read**  
  NFS client aio_read file operation
*  See 
  _probe::nfs.fop.aio_read_(3stap)
   for details.


* **nfs.fop.read_iter**  
  NFS client read_iter file operation
*  See 
  _probe::nfs.fop.read_iter_(3stap)
   for details.


* **nfs.fop.aio_write**  
  NFS client aio_write file operation
*  See 
  _probe::nfs.fop.aio_write_(3stap)
   for details.


* **nfs.fop.write_iter**  
  NFS client write_iter file operation
*  See 
  _probe::nfs.fop.write_iter_(3stap)
   for details.


* **nfs.fop.mmap**  
  NFS client mmap operation
*  See 
  _probe::nfs.fop.mmap_(3stap)
   for details.


* **nfs.fop.open**  
  NFS client file open operation
*  See 
  _probe::nfs.fop.open_(3stap)
   for details.


* **nfs.fop.flush**  
  NFS client flush file operation
*  See 
  _probe::nfs.fop.flush_(3stap)
   for details.


* **nfs.fop.release**  
  NFS client release page operation
*  See 
  _probe::nfs.fop.release_(3stap)
   for details.


* **nfs.fop.fsync**  
  NFS client fsync operation
*  See 
  _probe::nfs.fop.fsync_(3stap)
   for details.


* **nfs.fop.lock**  
  NFS client file lock operation
*  See 
  _probe::nfs.fop.lock_(3stap)
   for details.


* **nfs.fop.sendfile**  
  NFS client send file operation
*  See 
  _probe::nfs.fop.sendfile_(3stap)
   for details.


* **nfs.fop.check_flags**  
  NFS client checking flag operation
*  See 
  _probe::nfs.fop.check_flags_(3stap)
   for details.


* **nfs.aop.readpage**  
  NFS client synchronously reading a page
*  See 
  _probe::nfs.aop.readpage_(3stap)
   for details.


* **nfs.aop.readpages**  
  NFS client reading multiple pages
*  See 
  _probe::nfs.aop.readpages_(3stap)
   for details.


* **nfs.aop.set_page_dirty**  
  NFS client marking page as dirty
*  See 
  _probe::nfs.aop.set_page_dirty_(3stap)
   for details.


* **nfs.aop.writepage**  
  NFS client writing a mapped page to the NFS server
*  See 
  _probe::nfs.aop.writepage_(3stap)
   for details.


* **nfs.aop.writepages**  
  NFS client writing several dirty pages to the NFS server
*  See 
  _probe::nfs.aop.writepages_(3stap)
   for details.


* **nfs.aop.write_begin**  
  NFS client begin to write data
*  See 
  _probe::nfs.aop.write_begin_(3stap)
   for details.


* **nfs.aop.write_end**  
  NFS client complete writing data
*  See 
  _probe::nfs.aop.write_end_(3stap)
   for details.


* **nfs.aop.release_page**  
  NFS client releasing page
*  See 
  _probe::nfs.aop.release_page_(3stap)
   for details.
  

<a name="see-also"></a>

# See Also
  
_probe::nfs.fop.llseek_(3stap),  
_probe::nfs.fop.read_(3stap),  
_probe::nfs.fop.write_(3stap),  
_probe::nfs.fop.aio_read_(3stap),  
_probe::nfs.fop.read_iter_(3stap),  
_probe::nfs.fop.aio_write_(3stap),  
_probe::nfs.fop.write_iter_(3stap),  
_probe::nfs.fop.mmap_(3stap),  
_probe::nfs.fop.open_(3stap),  
_probe::nfs.fop.flush_(3stap),  
_probe::nfs.fop.release_(3stap),  
_probe::nfs.fop.fsync_(3stap),  
_probe::nfs.fop.lock_(3stap),  
_probe::nfs.fop.sendfile_(3stap),  
_probe::nfs.fop.check_flags_(3stap),  
_probe::nfs.aop.readpage_(3stap),  
_probe::nfs.aop.readpages_(3stap),  
_probe::nfs.aop.set_page_dirty_(3stap),  
_probe::nfs.aop.writepage_(3stap),  
_probe::nfs.aop.writepages_(3stap),  
_probe::nfs.aop.write_begin_(3stap),  
_probe::nfs.aop.write_end_(3stap),  
_probe::nfs.aop.release_page_(3stap),  
_stap_(1),
_stapprobes_(3stap)
