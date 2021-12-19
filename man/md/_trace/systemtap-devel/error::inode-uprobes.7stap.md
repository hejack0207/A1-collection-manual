# error::inode-uprobes(7stap) - limitations of inode-uprobes


<a name="description"></a>

# Description


The uprobes kernel facility introduced in Linux 3.5 aims to supplant the
earlier out-of-tree utrace patch to enable user-space probing.  There
have been some functional limitations in inode-uprobes that preclude
some systemtap constructs.  Over time, we hope these regressions will
be corrected.


* function.return probes  
  _process.function().return_
  probes require "return-probes" or "uretprobes" functionality, which was not
  implemented in the builtin inode-uprobes until kernel 3.10.  If you cannot
  upgrade your kernel, consider using
  _process.statement()_
  probes placed on source line numbers at the function's return statements.
  
* function.statement.absolute probes  
  In utrace-equipped kernels, systemtap made it possible to address probes
  by literal addresses in the process virtual memory address space.  The 
  new inode-uprobes does not have this capability.
  
  

<a name="see-also"></a>

# See Also

.nh
    stap(1),
    http://kernelnewbies.org/Linux_3.5,
    http://sourceware.org/systemtap/wiki/utrace,
    error::reporting(7stap)
