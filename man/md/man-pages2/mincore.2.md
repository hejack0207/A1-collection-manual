# mincore(2) - determine whether pages are resident in memory

Linux, 2017-09-15

```
#include <unistd.h>
#include <sys/mman.h> 
 int mincore(void *addr, size_t length, unsigned char *vec); 
 .in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in 
 mincore():     Since glibc 2.19:         _DEFAULT_SOURCE     Glibc 2.19 and earlier:         _BSD_SOURCE || _SVID_SOURCE
```

<a name="description"></a>

# Description

**mincore**()
returns a vector that indicates whether pages
of the calling process's virtual memory are resident in core (RAM),
and so will not cause a disk access (page fault) if referenced.
The kernel returns residency information about the pages
starting at the address
_addr_,
and continuing for
_length_
bytes.

The
_addr_
argument must be a multiple of the system page size.
The
_length_
argument need not be a multiple of the page size,
but since residency information is returned for whole pages,
_length_
is effectively rounded up to the next multiple of the page size.
One may obtain the page size
(**PAGE_SIZE**)
using
_sysconf(_SC_PAGESIZE)_.

The
_vec_
argument must point to an array containing at least
_(length+PAGE_SIZE-1) / PAGE_SIZE_
bytes.
On return,
the least significant bit of each byte will be set if
the corresponding page is currently resident in memory,
and be clear otherwise.
(The settings of the other bits in each byte are undefined;
these bits are reserved for possible later use.)
Of course the information returned in
_vec_
is only a snapshot: pages that are not
locked in memory can come and go at any moment, and the contents of
_vec_
may already be stale by the time this call returns.

<a name="return-value"></a>

# Return Value

On success,
**mincore**()
returns zero.
On error, -1 is returned, and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors

**EAGAIN**
kernel is temporarily out of resources.

* **EFAULT**  
  _vec_
  points to an invalid address.
* **EINVAL**  
  _addr_
  is not a multiple of the page size.
* **ENOMEM**  
  _length_
  is greater than
  (_TASK_SIZE_ - _addr_).
  (This could occur if a negative value is specified for
  _length_,
  since that value will be interpreted as a large
  unsigned integer.)
  In Linux 2.6.11 and earlier, the error
  **EINVAL**
  was returned for this condition.
* **ENOMEM**  
  _addr_
  to
  _addr_
  +
  _length_
  contained unmapped memory.

<a name="versions"></a>

# Versions

Available since Linux 2.3.99pre1 and glibc 2.2.

<a name="conforming-to"></a>

# Conforming to

**mincore**()
is not specified in POSIX.1,
and it is not available on all UNIX implementations.







<a name="bugs"></a>

# Bugs

Before kernel 2.6.21,
**mincore**()
did not return correct information for
**MAP_PRIVATE**
mappings, or for nonlinear mappings (established using
**remap_file_pages**(2)).
















<a name="see-also"></a>

# See Also

**fincore**(1),
**madvise**(2),
**mlock**(2),
**mmap**(2),
**posix_fadvise**(2),
**posix_madvise**(3)

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
