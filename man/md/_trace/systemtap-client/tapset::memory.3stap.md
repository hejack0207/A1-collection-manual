# tapset::memory(3stap) - systemtap memory tapset

SystemTap Tapset Reference, May 2021


<a name="description"></a>

# Description


 This family of probe points is used to probe memory-related events. 


* 

* **vm_fault_contains**  
  Test return value for page fault reason
* See 
  _function::vm_fault_contains_(3stap)
   for details.


* **vm.pagefault**  
  Records that a page fault occurred
*  See 
  _probe::vm.pagefault_(3stap)
   for details.


* **vm.pagefault.return**  
  Indicates what type of fault occurred
*  See 
  _probe::vm.pagefault.return_(3stap)
   for details.


* **addr_to_node**  
  Returns which node a given address belongs to within a NUMA system
* See 
  _function::addr_to_node_(3stap)
   for details.


* **vm.write_shared**  
  Attempts at writing to a shared page
*  See 
  _probe::vm.write_shared_(3stap)
   for details.


* **vm.write_shared_copy**  
  Page copy for shared page write
*  See 
  _probe::vm.write_shared_copy_(3stap)
   for details.


* **vm.mmap**  
  Fires when an mmap is requested
*  See 
  _probe::vm.mmap_(3stap)
   for details.


* **vm.munmap**  
  Fires when an munmap is requested
*  See 
  _probe::vm.munmap_(3stap)
   for details.


* **vm.brk**  
  Fires when a brk is requested (i.e. the heap will be resized)
*  See 
  _probe::vm.brk_(3stap)
   for details.


* **vm.oom_kill**  
  Fires when a thread is selected for termination by the OOM killer
*  See 
  _probe::vm.oom_kill_(3stap)
   for details.


* **vm.kmalloc**  
  Fires when kmalloc is requested
*  See 
  _probe::vm.kmalloc_(3stap)
   for details.


* **vm.kmem_cache_alloc**  
  Fires when kmem_cache_alloc is requested
*  See 
  _probe::vm.kmem_cache_alloc_(3stap)
   for details.


* **vm.kmalloc_node**  
  Fires when kmalloc_node is requested
*  See 
  _probe::vm.kmalloc_node_(3stap)
   for details.


* **vm.kmem_cache_alloc_node**  
  Fires when kmem_cache_alloc_node is requested
*  See 
  _probe::vm.kmem_cache_alloc_node_(3stap)
   for details.


* **vm.kfree**  
  Fires when kfree is requested
*  See 
  _probe::vm.kfree_(3stap)
   for details.


* **vm.kmem_cache_free**  
  Fires when kmem_cache_free is requested
*  See 
  _probe::vm.kmem_cache_free_(3stap)
   for details.
  

<a name="see-also"></a>

# See Also
  
_function::vm_fault_contains_(3stap),  
_function::addr_to_node_(3stap),  
_probe::vm.pagefault_(3stap),  
_probe::vm.pagefault.return_(3stap),  
_probe::vm.write_shared_(3stap),  
_probe::vm.write_shared_copy_(3stap),  
_probe::vm.mmap_(3stap),  
_probe::vm.munmap_(3stap),  
_probe::vm.brk_(3stap),  
_probe::vm.oom_kill_(3stap),  
_probe::vm.kmalloc_(3stap),  
_probe::vm.kmem_cache_alloc_(3stap),  
_probe::vm.kmalloc_node_(3stap),  
_probe::vm.kmem_cache_alloc_node_(3stap),  
_probe::vm.kfree_(3stap),  
_probe::vm.kmem_cache_free_(3stap),  
_stap_(1),
_stapprobes_(3stap)
