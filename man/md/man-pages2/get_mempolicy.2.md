# get_mempolicy(2) - retrieve NUMA memory policy for a thread

Linux, 2017-09-15

```
"#include <numaif.h>"
```
    
    long get_mempolicy(int *mode, unsigned long *nodemask,
                      unsigned long maxnode, void *addr,
                      unsigned long flags);
    
    Link with -lnuma.

<a name="description"></a>

# Description

**get_mempolicy**()
retrieves the NUMA policy of the calling thread or of a memory address,
depending on the setting of
_flags_.

A NUMA machine has different
memory controllers with different distances to specific CPUs.
The memory policy defines from which node memory is allocated for
the thread.

If
_flags_
is specified as 0,
then information about the calling thread's default policy
(as set by
**set_mempolicy**(2))
is returned, in the buffers pointed to by
_mode_
and
_nodemask_.
The value returned in these arguments
may be used to restore the thread's policy to its state at
the time of the call to
**get_mempolicy**()
using
**set_mempolicy**(2).
When
_flags_
is 0,
_addr_
must be specified as NULL.

If
_flags_
specifies
**MPOL_F_MEMS_ALLOWED**
(available since Linux 2.6.24), the
_mode_
argument is ignored and the set of nodes (memories) that the
thread is allowed to specify in subsequent calls to
**mbind**(2)
or
**set_mempolicy**(2)
(in the absence of any
_mode flags_)
is returned in
_nodemask_.
It is not permitted to combine
**MPOL_F_MEMS_ALLOWED**
with either
**MPOL_F_ADDR**
or
**MPOL_F_NODE**.

If
_flags_
specifies
**MPOL_F_ADDR**,
then information is returned about the policy governing the memory
address given in
_addr_.
This policy may be different from the thread's default policy if
**mbind**(2)
or one of the helper functions described in
**numa**(3)
has been used to establish a policy for the memory range containing
_addr_.

If the
_mode_
argument is not NULL, then
**get_mempolicy**()
will store the policy mode and any optional
_mode flags_
of the requested NUMA policy in the location pointed to by this argument.
If
_nodemask_
is not NULL, then the nodemask associated with the policy will be stored
in the location pointed to by this argument.
_maxnode_
specifies the number of node IDs
that can be stored into
_nodemask_—that
is, the maximum node ID plus one.
The value specified by
_maxnode_
is always rounded to a multiple of
_sizeof(unsigned&nbsp;long)*8_.

If
_flags_
specifies both
**MPOL_F_NODE**
and
**MPOL_F_ADDR**,
**get_mempolicy**()
will return the node ID of the node on which the address
_addr_
is allocated into the location pointed to by
_mode_.
If no page has yet been allocated for the specified address,
**get_mempolicy**()
will allocate a page as if the thread had performed a read
(load) access to that address, and return the ID of the node
where that page was allocated.

If
_flags_
specifies
**MPOL_F_NODE**,
but not
**MPOL_F_ADDR**,
and the thread's current policy is
**MPOL_INTERLEAVE**,
then
**get_mempolicy**()
will return in the location pointed to by a non-NULL
_mode_
argument,
the node ID of the next node that will be used for
interleaving of internal kernel pages allocated on behalf of the thread.

These allocations include pages for memory-mapped files in
process memory ranges mapped using the
**mmap**(2)
call with the
**MAP_PRIVATE**
flag for read accesses, and in memory ranges mapped with the
**MAP_SHARED**
flag for all accesses.

Other flag values are reserved.

For an overview of the possible policies see
**set_mempolicy**(2).

<a name="return-value"></a>

# Return Value

On success,
**get_mempolicy**()
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
  The value specified by
  _maxnode_
  is less than the number of node IDs supported by the system.
  Or
  _flags_
  specified values other than
  **MPOL_F_NODE**
  or
  **MPOL_F_ADDR**;
  or
  _flags_
  specified
  **MPOL_F_ADDR**
  and
  _addr_
  is NULL,
  or
  _flags_
  did not specify
  **MPOL_F_ADDR**
  and
  _addr_
  is not NULL.
  Or,
  _flags_
  specified
  **MPOL_F_NODE**
  but not
  **MPOL_F_ADDR**
  and the current thread policy is not
  **MPOL_INTERLEAVE**.
  Or,
  _flags_
  specified
  **MPOL_F_MEMS_ALLOWED**
  with either
  **MPOL_F_ADDR**
  or
  **MPOL_F_NODE**.
  (And there are other
  **EINVAL**
  cases.)

<a name="versions"></a>

# Versions

The
**get_mempolicy**()
system call was added to the Linux kernel in version 2.6.7.

<a name="conforming-to"></a>

# Conforming to

This system call is Linux-specific.

<a name="notes"></a>

# Notes

For information on library support, see
**numa**(7).

<a name="see-also"></a>

# See Also

**getcpu**(2),
**mbind**(2),
**mmap**(2),
**set_mempolicy**(2),
**numa**(3),
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
