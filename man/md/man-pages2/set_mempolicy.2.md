# set_mempolicy(2) - set default NUMA memory policy for a thread and its children

Linux, 2017-09-15

    "#include <numaif.h>"
    
    long set_mempolicy(int mode, const unsigned long *nodemask,
                       unsigned long maxnode);
    
    Link with -lnuma.

<a name="description"></a>

# Description

**set_mempolicy**()
sets the NUMA memory policy of the calling thread,
which consists of a policy mode and zero or more nodes,
to the values specified by the
_mode_,
_nodemask_
and
_maxnode_
arguments.

A NUMA machine has different
memory controllers with different distances to specific CPUs.
The memory policy defines from which node memory is allocated for
the thread.

This system call defines the default policy for the thread.
The thread policy governs allocation of pages in the process's
address space outside of memory ranges
controlled by a more specific policy set by
**mbind**(2).
The thread default policy also controls allocation of any pages for
memory-mapped files mapped using the
**mmap**(2)
call with the
**MAP_PRIVATE**
flag and that are only read (loaded) from by the thread
and of memory-mapped files mapped using the
**mmap**(2)
call with the
**MAP_SHARED**
flag, regardless of the access type.
The policy is applied only when a new page is allocated
for the thread.
For anonymous memory this is when the page is first
touched by the thread.

The
_mode_
argument must specify one of
**MPOL_DEFAULT**,
**MPOL_BIND**,
**MPOL_INTERLEAVE**,
**MPOL_PREFERRED**,
or
**MPOL_LOCAL**
(which are described in detail below).
All modes except
**MPOL_DEFAULT**
require the caller to specify the node or nodes to which the mode applies,
via the
_nodemask_
argument.

The
_mode_
argument may also include an optional
_mode flag_.
The supported
_mode flags_
are:

* **MPOL_F_STATIC_NODES** (since Linux 2.6.26)  
  A nonempty
  _nodemask_
  specifies physical node IDs.
  Linux will not remap the
  _nodemask_
  when the process moves to a different cpuset context,
  nor when the set of nodes allowed by the process's
  current cpuset context changes.
* **MPOL_F_RELATIVE_NODES** (since Linux 2.6.26)  
  A nonempty
  _nodemask_
  specifies node IDs that are relative to the set of
  node IDs allowed by the process's current cpuset.

_nodemask_
points to a bit mask of node IDs that contains up to
_maxnode_
bits.
The bit mask size is rounded to the next multiple of
_sizeof(unsigned long)_,
but the kernel will use bits only up to
_maxnode_.
A NULL value of
_nodemask_
or a
_maxnode_
value of zero specifies the empty set of nodes.
If the value of
_maxnode_
is zero,
the
_nodemask_
argument is ignored.

Where a
_nodemask_
is required, it must contain at least one node that is on-line,
allowed by the process's current cpuset context,
(unless the
**MPOL_F_STATIC_NODES**
mode flag is specified),
and contains memory.
If the
**MPOL_F_STATIC_NODES**
is set in
_mode_
and a required
_nodemask_
contains no nodes that are allowed by the process's current cpuset context,
the memory policy reverts to
_local allocation_.
This effectively overrides the specified policy until the process's
cpuset context includes one or more of the nodes specified by
_nodemask_.

The
_mode_
argument must include one of the following values:

* **MPOL_DEFAULT**  
  This mode specifies that any nondefault thread memory policy be removed,
  so that the memory policy "falls back" to the system default policy.
  The system default policy is "local allocation"—that is,
  allocate memory on the node of the CPU that triggered the allocation.
  _nodemask_
  must be specified as NULL.
  If the "local node" contains no free memory, the system will
  attempt to allocate memory from a "near by" node.
* **MPOL_BIND**  
  This mode defines a strict policy that restricts memory allocation to the
  nodes specified in
  _nodemask_.
  If
  _nodemask_
  specifies more than one node, page allocations will come from
  the node with the lowest numeric node ID first, until that node
  contains no free memory.
  Allocations will then come from the node with the next highest
  node ID specified in
  _nodemask_
  and so forth, until none of the specified nodes contain free memory.
  Pages will not be allocated from any node not specified in the
  _nodemask_.
* * **MPOL_INTERLEAVE**  
  This mode interleaves page allocations across the nodes specified in
  _nodemask_
  in numeric node ID order.
  This optimizes for bandwidth instead of latency
  by spreading out pages and memory accesses to those pages across
  multiple nodes.
  However, accesses to a single page will still be limited to
  the memory bandwidth of a single node.
  
  
  
  
* **MPOL_PREFERRED**  
  This mode sets the preferred node for allocation.
  The kernel will try to allocate pages from this node first
  and fall back to "near by" nodes if the preferred node is low on free
  memory.
  If
  _nodemask_
  specifies more than one node ID, the first node in the
  mask will be selected as the preferred node.
  If the
  _nodemask_
  and
  _maxnode_
  arguments specify the empty set, then the policy
  specifies "local allocation"
  (like the system default policy discussed above).
* **MPOL_LOCAL** (since Linux 3.8)  
  
  
  This mode specifies "local allocation"; the memory is allocated on
  the node of the CPU that triggered the allocation (the "local node").
  The
  _nodemask_
  and
  _maxnode_
  arguments must specify the empty set.
  If the "local node" is low on free memory,
  the kernel will try to allocate memory from other nodes.
  The kernel will allocate memory from the "local node"
  whenever memory for this node is available.
  If the "local node" is not allowed by the process's current cpuset context,
  the kernel will try to allocate memory from other nodes.
  The kernel will allocate memory from the "local node" whenever
  it becomes allowed by the process's current cpuset context.

The thread memory policy is preserved across an
**execve**(2),
and is inherited by child threads created using
**fork**(2)
or
**clone**(2).

<a name="return-value"></a>

# Return Value

On success,
**set_mempolicy**()
returns 0;
on error, -1 is returned and
_errno_
is set to indicate the error.

<a name="errors"></a>

# Errors


* **EFAULT**  
  Part of all of the memory range specified by
  _nodemask_
  and
  _maxnode_
  points outside your accessible address space.
* **EINVAL**  
  _mode_
  is invalid.
  Or,
  _mode_
  is
  **MPOL_DEFAULT**
  and
  _nodemask_
  is nonempty,
  or
  _mode_
  is
  **MPOL_BIND**
  or
  **MPOL_INTERLEAVE**
  and
  _nodemask_
  is empty.
  Or,
  _maxnode_
  specifies more than a page worth of bits.
  Or,
  _nodemask_
  specifies one or more node IDs that are
  greater than the maximum supported node ID.
  Or, none of the node IDs specified by
  _nodemask_
  are on-line and allowed by the process's current cpuset context,
  or none of the specified nodes contain memory.
  Or, the
  _mode_
  argument specified both
  **MPOL_F_STATIC_NODES**
  and
  **MPOL_F_RELATIVE_NODES**.
* **ENOMEM**  
  Insufficient kernel memory was available.

<a name="versions"></a>

# Versions

The
**set_mempolicy**()
system call was added to the Linux kernel in version 2.6.7.

<a name="conforming-to"></a>

# Conforming to

This system call is Linux-specific.

<a name="notes"></a>

# Notes

Memory policy is not remembered if the page is swapped out.
When such a page is paged back in, it will use the policy of
the thread or memory range that is in effect at the time the
page is allocated.

For information on library support, see
**numa**(7).

<a name="see-also"></a>

# See Also

**get_mempolicy**(2),
**getcpu**(2),
**mbind**(2),
**mmap**(2),
**numa**(3),
**cpuset**(7),
**numa**(7),
**numactl**(8)

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
