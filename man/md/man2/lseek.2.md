# lseek(2) - reposition read/write file offset

Linux, 2017-09-15

```
#include <sys/types.h>
#include <unistd.h> 
 off_t lseek(int fd, off_t offset, int whence);
```

<a name="description"></a>

# Description

**lseek**()
repositions the file offset of the open file description
associated with the file descriptor
_fd_
to the argument
_offset_
according to the directive
_whence_
as follows:

* **SEEK_SET**  
  The file offset is set to
  _offset_
  bytes.
* **SEEK_CUR**  
  The file offset is set to its current location plus
  _offset_
  bytes.
* **SEEK_END**  
  The file offset is set to the size of the file plus
  _offset_
  bytes.

**lseek**()
allows the file offset to be set beyond the end
of the file (but this does not change the size of the file).
If data is later written at this point, subsequent reads of the data
in the gap (a "hole") return null bytes ('\\0') until
data is actually written into the gap.

<a name="seeking-file-data-and-holes"></a>

### Seeking file data and holes

Since version 3.1, Linux supports the following additional values for
_whence_:

* **SEEK_DATA**  
  Adjust the file offset to the next location
  in the file greater than or equal to
  _offset_
  containing data.
  If
  _offset_
  points to data,
  then the file offset is set to
  _offset_.
* **SEEK_HOLE**  
  Adjust the file offset to the next hole in the file
  greater than or equal to
  _offset_.
  If
  _offset_
  points into the middle of a hole,
  then the file offset is set to
  _offset_.
  If there is no hole past
  _offset_,
  then the file offset is adjusted to the end of the file
  (i.e., there is an implicit hole at the end of any file).

In both of the above cases,
**lseek**()
fails if
_offset_
points past the end of the file.

These operations allow applications to map holes in a sparsely
allocated file.
This can be useful for applications such as file backup tools,
which can save space when creating backups and preserve holes,
if they have a mechanism for discovering holes.

For the purposes of these operations, a hole is a sequence of zeros that
(normally) has not been allocated in the underlying file storage.
However, a filesystem is not obliged to report holes,
so these operations are not a guaranteed mechanism for
mapping the storage space actually allocated to a file.
(Furthermore, a sequence of zeros that actually has been written
to the underlying storage may not be reported as a hole.)
In the simplest implementation,
a filesystem can support the operations by making
**SEEK_HOLE**
always return the offset of the end of the file,
and making
**SEEK_DATA**
always return
_offset_
(i.e., even if the location referred to by
_offset_
is a hole,
it can be considered to consist of data that is a sequence of zeros).




The
**_GNU_SOURCE**
feature test macro must be defined in order to obtain the definitions of
**SEEK_DATA**
and
**SEEK_HOLE**
from
_&lt;unistd.h&gt;_.

The
**SEEK_HOLE**
and
**SEEK_DATA**
operations are supported for the following filesystems:

* *  
  Btrfs (since Linux 3.1)
* *  
  OCFS (since Linux 3.2)
  
* *  
  XFS (since Linux 3.5)
* *  
  ext4 (since Linux 3.8)
* *  
  **tmpfs**(5) (since Linux 3.8)
* *  
  NFS (since Linux 3.18)
  
  
* *  
  FUSE (since Linux 4.5)
  

<a name="return-value"></a>

# Return Value

Upon successful completion,
**lseek**()
returns the resulting offset location as measured in bytes from the
beginning of the file.
On error, the value _(off_t)&nbsp;-1_ is returned and
_errno_
is set to indicate the error.

<a name="errors"></a>

# Errors


* **EBADF**  
  _fd_
  is not an open file descriptor.
* **EINVAL**  
  _whence_
  is not valid.
  Or: the resulting file offset would be negative,
  or beyond the end of a seekable device.
  
  
* **ENXIO**  
  _whence_
  is
  **SEEK_DATA**
  or
  **SEEK_HOLE**,
  and the file offset is beyond the end of the file.
* **EOVERFLOW**  
  
  The resulting file offset cannot be represented in an
  _off_t_.
* **ESPIPE**  
  _fd_
  is associated with a pipe, socket, or FIFO.

<a name="conforming-to"></a>

# Conforming to

POSIX.1-2001, POSIX.1-2008, SVr4, 4.3BSD.

**SEEK_DATA**
and
**SEEK_HOLE**
are nonstandard extensions also present in Solaris,
FreeBSD, and DragonFly BSD;
they are proposed for inclusion in the next POSIX revision (Issue 8).


<a name="notes"></a>

# Notes

See
**open**(2)
for a discussion of the relationship between file descriptors,
open file descriptions, and files.

If the
**O_APPEND**
file status flag is set on the open file description,
then a
**write**(2)
_always_
moves the file offset to the end of the file, regardless of the use of
**lseek**().

The
_off_t_
data type is a signed integer data type specified by POSIX.1.

Some devices are incapable of seeking and POSIX does not specify which
devices must support
**lseek**().

On Linux, using
**lseek**()
on a terminal device fails with the error
**ESPIPE**.



<a name="see-also"></a>

# See Also

**dup**(2),
**fallocate**(2),
**fork**(2),
**open**(2),
**fseek**(3),
**lseek64**(3),
**posix_fallocate**(3)

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
