# migrate_pages(2) - move all pages in a process to another set of nodes

Linux, 2017-09-15

    #include <numaif.h>
    
    long migrate_pages(int pid, unsigned long maxnode,
                       const unsigned long *old_nodes,
                       const unsigned long *new_nodes);
```

 Link with -lnuma.
```

<a name="description"></a>

# Description

**migrate_pages**()
attempts to move all pages of the process
_pid_
that are in memory nodes
_old_nodes_
to the memory nodes in
_new_nodes_.
Pages not located in any node in
_old_nodes_
will not be migrated.
As far as possible,
the kernel maintains the relative topology relationship inside
_old_nodes_
during the migration to
_new_nodes_.

The
_old_nodes_
and
_new_nodes_
arguments are pointers to bit masks of node numbers, with up to
_maxnode_
bits in each mask.
These masks are maintained as arrays of unsigned
_long_
integers (in the last
_long_
integer, the bits beyond those specified by
_maxnode_
are ignored).
The
_maxnode_
argument is the maximum node number in the bit mask plus one (this is the same
as in
**mbind**(2),
but different from
**select**(2)).

The
_pid_
argument is the ID of the process whose pages are to be moved.
To move pages in another process,
the caller must be privileged
(**CAP_SYS_NICE**)
or the real or effective user ID of the calling process must match the
real or saved-set user ID of the target process.
If
_pid_
is 0, then
**migrate_pages**()
moves pages of the calling process.

Pages shared with another process will be moved only if the initiating
process has the
**CAP_SYS_NICE**
privilege.

<a name="return-value"></a>

# Return Value

On success
**migrate_pages**()
returns the number of pages that could not be moved
(i.e., a return of zero means that all pages were successfully moved).
On error, it returns -1, and sets
_errno_
to indicate the error.

<a name="errors"></a>

# Errors


* **EFAULT**  
  Part or all of the memory range specified by
  _old_nodes_/_new_nodes_
  and
  _maxnode_
  points outside your accessible address space.
* **EINVAL**  
  The value specified by
  _maxnode_
  exceeds a kernel-imposed limit.
  
  
  Or,
  _old_nodes_
  or
  _new_nodes_
  specifies one or more node IDs that are
  greater than the maximum supported node ID.
  Or, none of the node IDs specified by
  _new_nodes_
  are on-line and allowed by the process's current cpuset context,
  or none of the specified nodes contain memory.
* **EPERM**  
  Insufficient privilege
  (**CAP_SYS_NICE**)
  to move pages of the process specified by
  _pid_,
  or insufficient privilege
  (**CAP_SYS_NICE**)
  to access the specified target nodes.
* **ESRCH**  
  No process matching
  _pid_
  could be found.
  

<a name="versions"></a>

# Versions

The
**migrate_pages**()
system call first appeared on Linux in version 2.6.16.

<a name="conforming-to"></a>

# Conforming to

This system call is Linux-specific.

<a name="notes"></a>

# Notes

For information on library support, see
**numa**(7).

Use
**get_mempolicy**(2)
with the
**MPOL_F_MEMS_ALLOWED**
flag to obtain the set of nodes that are allowed by
the calling process's cpuset.
Note that this information is subject to change at any
time by manual or automatic reconfiguration of the cpuset.

Use of
**migrate_pages**()
may result in pages whose location
(node) violates the memory policy established for the
specified addresses (see
**mbind**(2))
and/or the specified process (see
**set_mempolicy**(2)).
That is, memory policy does not constrain the destination
nodes used by
**migrate_pages**().

The
_&lt;numaif.h&gt;_
header is not included with glibc, but requires installing
_libnuma-devel_
or a similar package.

<a name="see-also"></a>

# See Also

**get_mempolicy**(2),
**mbind**(2),
**set_mempolicy**(2),
**numa**(3),
**numa_maps**(5),
**cpuset**(7),
**numa**(7),
**migratepages**(8),
**numastat**(8)

_Documentation/vm/page_migration_
in the Linux kernel source tree

<a name="colophon"></a>

# Colophon

This page is part of release 4.16 of the Linux
_man-pages_
project.
A description of the project,
information about reporting bugs,
and the latest version of this page,
can be found at
https://www.kernel.org/doc/man-pages/.
