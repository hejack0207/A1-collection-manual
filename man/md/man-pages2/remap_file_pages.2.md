# remap_file_pages(2) - create a nonlinear file mapping

Linux, 2017-09-15

    #define _GNU_SOURCE         /* See feature_test_macros(7) */
    #include <sys/mman.h>
    
    int remap_file_pages(void *addr, size_t size, int prot,
                         size_t pgoff, int flags);

<a name="description"></a>

# Description

**Note**:


this system call was marked as deprecated starting with Linux 3.16.
In Linux 4.0, the implementation was replaced

by a slower in-kernel emulation.
Those few applications that use this system call should
consider migrating to alternatives.
This change was made because the kernel code for this system call was complex,
and it is believed to be little used or perhaps even completely unused.
While it had some use cases in database applications on 32-bit systems,
those use cases don't exist on 64-bit systems.

The
**remap_file_pages**()
system call is used to create a nonlinear mapping, that is, a mapping
in which the pages of the file are mapped into a nonsequential order
in memory.
The advantage of using
**remap_file_pages**()
over using repeated calls to
**mmap**(2)
is that the former approach does not require the kernel to create
additional VMA (Virtual Memory Area) data structures.

To create a nonlinear mapping we perform the following steps:

* 1.  
  Use
  **mmap**(2)
  to create a mapping (which is initially linear).
  This mapping must be created with the
  **MAP_SHARED**
  flag.
* 2.  
  Use one or more calls to
  **remap_file_pages**()
  to rearrange the correspondence between the pages of the mapping
  and the pages of the file.
  It is possible to map the same page of a file
  into multiple locations within the mapped region.

The
_pgoff_
and
_size_
arguments specify the region of the file that is to be relocated
within the mapping:
_pgoff_
is a file offset in units of the system page size;
_size_
is the length of the region in bytes.

The
_addr_
argument serves two purposes.
First, it identifies the mapping whose pages we want to rearrange.
Thus,
_addr_
must be an address that falls within
a region previously mapped by a call to
**mmap**(2).
Second,
_addr_
specifies the address at which the file pages
identified by
_pgoff_
and
_size_
will be placed.

The values specified in
_addr_
and
_size_
should be multiples of the system page size.
If they are not, then the kernel rounds
_both_
values
_down_
to the nearest multiple of the page size.




The
_prot_
argument must be specified as 0.

The
_flags_
argument has the same meaning as for
**mmap**(2),
but all flags other than
**MAP_NONBLOCK**
are ignored.

<a name="return-value"></a>

# Return Value

On success,
**remap_file_pages**()
returns 0.
On error, -1 is returned, and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **EINVAL**  
  _addr_
  does not refer to a valid mapping
  created with the
  **MAP_SHARED**
  flag.
* **EINVAL**  
  _addr_,
  _size_,
  _prot_,
  or
  _pgoff_
  is invalid.
  

<a name="versions"></a>

# Versions

The
**remap_file_pages**()
system call appeared in Linux 2.5.46;
glibc support was added in version 2.3.3.

<a name="conforming-to"></a>

# Conforming to

The
**remap_file_pages**()
system call is Linux-specific.

<a name="notes"></a>

# Notes

Since Linux 2.6.23,

**remap_file_pages**()
creates non-linear mappings only
on in-memory filesystems such as
**tmpfs**(5),
hugetlbfs or ramfs.
On filesystems with a backing store,
**remap_file_pages**()
is not much more efficient than using
**mmap**(2)
to adjust which parts of the file are mapped to which addresses.

<a name="see-also"></a>

# See Also

**getpagesize**(2),
**mmap**(2),
**mmap2**(2),
**mprotect**(2),
**mremap**(2),
**msync**(2)

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
