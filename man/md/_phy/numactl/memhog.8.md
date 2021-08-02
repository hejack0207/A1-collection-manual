# memhog(8) - Allocates memory with policy for testing

SuSE Labs, 2003,2004

```
memhog  [ -r<NUM> ] [ size kmg ] [ policy nodeset ] [ -f<filename> ]
```

<a name="description"></a>

# Description

**memhog**
mmaps a memory region for a given size and sets the numa policy (if specified). 
It then updates the memory region for the given number of iterations using memset.
.TS
tab(|);
l l.
-r&lt;num&gt;|Repeat memset NUM times
-f&lt;file&gt;|Open file for mmap backing
-H|Disable transparent hugepages
-size|Allocation size in bytes, may have case-insensitive order 
|suffix (G=gigabyte, M=megabyte, K=kilobyte)
.TE

Supported numa-policies:

* **interleave**  
  Memory will be allocated using round robin on nodes. When
  memory cannot be allocated on the current interleave, target fall back 
  to other nodes.  Multiple nodes may be specified.
* **membind**  
  Only  allocate  memory  from  nodes. Allocation will fail 
  when there is not enough memory available on these nodes. Multiple 
  nodes  may be specified.
* **preferred**  
  Preferably allocate memory on node, but if memory cannot be
  allocated  there  fall  back  to other nodes.  This option takes only a 
  single node number.
* **default**  
  Memory will be allocated on the local node (the node the 
  thread is running on)
  

<a name="examples"></a>

# Examples


* # Allocate a 1G region, mmap backed by memhog.mmap file, membind to node 0, repeat test 6 times  
  memhog -r6 1G --membind 0 -fmemhog.mmap
* # Allocate a 1G region, iterleave across nodes 0,1,2,3, repeat test 4 times  
  memhog -r4 1G --interleave 0-3
* # Allocate a 1G region, (implicit) default policy, repeat test 8 times  
  memhog -r8 1G
  

<a name="authors"></a>

# Authors

Andi Kleen ([ak@suse.de](mailto:ak@suse.de))


<a name="license"></a>

# License

GPL v2


<a name="see-also"></a>

# See Also

_mmap(2), memset(3), numactl(8), numastat(8)_
