# migspeed(8) - Test the speed of page migration

SGI, April 2005

```
migspeed -p pages from-nodes to-nodes
```

<a name="description"></a>

# Description

**migspeed**
attempts to move a sample of pages from the indicated node to the target node
and measures the time it takes to perform the move.

**-p pages**

The default sample is 1000 pages. Override that with another number.


<a name="notes"></a>

# Notes

Requires an NUMA policy aware kernel with support for page migration
(Linux 2.6.16 and later).


<a name="copyright"></a>

# Copyright

Copyright 2007 Christoph Lameter, Silicon Graphics, Inc.
migratepages is under the GNU General Public License, v.2


<a name="see-also"></a>

# See Also

_numactl(8)_

