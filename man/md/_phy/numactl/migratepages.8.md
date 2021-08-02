# migratepages(8) - Migrate the physical location a processes pages

SGI, Jan 2005

```
migratepages pid from-nodes to-nodes
```

<a name="description"></a>

# Description

**migratepages**
moves the physical location of a processes pages without any changes of the
virtual address space of the process. Moving the pages allows one to change
the distances of a process to its memory. Performance may be optimized by moving
a processes pages to the node where it is executing.

If multiple nodes are specified for from-nodes or to-nodes then
an attempt is made to preserve the relative location of
each page in each nodeset.

For example if we move from nodes 2-5 to 7,9,12-13 then the preferred mode of
operation is to move pages from 2-&gt;7, 3-&gt;9, 4-&gt;12 and 5-&gt;13. However, this
is only posssible if enough memory is available.

* Valid node specifiers  
  .TS
  tab(:);
  l l. 
  all:All nodes
  number:Node number
  number1{,number2}:Node number1 and Node number2
  number1-number2:Nodes from number1 to number2
  ! nodes:Invert selection of the following specification.
  .TE

<a name="notes"></a>

# Notes

Requires an NUMA policy aware kernel with support for page migration
(linux 2.6.16 and later).

migratepages will only move pages that are not shared with other
processes if called by a user without administrative priviledges (but
with the right to modify the process).

migratepages will move all pages if invoked from root (or a user with
administrative priviledges).


<a name="files"></a>

# Files

_/proc/&lt;pid&gt;/numa_maps_
for information about the NUMA memory use of a process.

<a name="copyright"></a>

# Copyright

Copyright 2005-2006 Christoph Lameter, Silicon Graphics, Inc.
migratepages is under the GNU General Public License, v.2


<a name="see-also"></a>

# See Also

_numactl(8)_
,
_set_mempolicy(2)_
,
_get_mempolicy(2)_
,
_mbind(2)_
,
_sched_setaffinity(2)_
, 
_sched_getaffinity(2)_
,
_proc(5)_
, 
_ftok(3)_
,
_shmat(2)_
,
_taskset(1)_

