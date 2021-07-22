# fsync(2) - synchronize a file's in-core state with storage device

Linux, 2017-09-15

```
#include <unistd.h> 
 int fsync(int fd); 
 int fdatasync(int fd); 
 .in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in 
 fsync():     Glibc 2.16 and later:         No feature test macros need be defined     Glibc up to and including 2.15:         _BSD_SOURCE || _XOPEN_SOURCE             || /* since glibc 2.8: */ _POSIX_C_SOURCE&nbsp;>=&nbsp;200112L
fdatasync():     _POSIX_C_SOURCE&nbsp;>=&nbsp;199309L || _XOPEN_SOURCE&nbsp;>=&nbsp;500
```

<a name="description"></a>

# Description

**fsync**()
transfers ("flushes") all modified in-core data of
(i.e., modified buffer cache pages for) the
file referred to by the file descriptor
_fd_
to the disk device (or other permanent storage device) so that all
changed information can be retrieved even if the system crashes or
is rebooted.
This includes writing through or flushing a disk cache if present.
The call blocks until the device reports that the transfer has completed.

As well as flushing the file data,
**fsync**()
also flushes the metadata information associated with the file (see
**inode**(7)).

Calling
**fsync**()
does not necessarily ensure
that the entry in the directory containing the file has also reached disk.
For that an explicit
**fsync**()
on a file descriptor for the directory is also needed.

**fdatasync**()
is similar to
**fsync**(),
but does not flush modified metadata unless that metadata
is needed in order to allow a subsequent data retrieval to be
correctly handled.
For example, changes to
_st_atime_
or
_st_mtime_
(respectively, time of last access and
time of last modification; see
**inode**(7))
do not require flushing because they are not necessary for
a subsequent data read to be handled correctly.
On the other hand, a change to the file size
(_st_size_,
as made by say
**ftruncate**(2)),
would require a metadata flush.

The aim of
**fdatasync**()
is to reduce disk activity for applications that do not
require all metadata to be synchronized with the disk.

<a name="return-value"></a>

# Return Value

On success, these system calls return zero.
On error, -1 is returned, and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **EBADF**  
  _fd_
  is not a valid open file descriptor.
* **EIO**  
  An error occurred during synchronization.
  This error may relate to data written to some other file descriptor
  on the same file.
  Since Linux 4.13,
  
  errors from write-back will be reported to
  all file descriptors that might have written the data which triggered
  the error.
  Some filesystems (e.g., NFS) keep close track of which data
  came through which file descriptor, and give more precise reporting.
  Other filesystems (e.g., most local filesystems) will report errors to
  all file descriptors that where open on the file when the error was recorded.
* **ENOSPC**  
  Disk space was exhausted while synchronizing.
* **EROFS**, **EINVAL**  
  _fd_
  is bound to a special file (e.g., a pipe, FIFO, or socket)
  which does not support synchronization.
* **ENOSPC**, **EDQUOT**  
  _fd_
  is bound to a file on NFS or another filesystem which does not allocate
  space at the time of a
  **write**(2)
  system call, and some previous write failed due to insufficient
  storage space.

<a name="conforming-to"></a>

# Conforming to

POSIX.1-2001, POSIX.1-2008, 4.3BSD.

<a name="availability"></a>

# Availability

On POSIX systems on which
**fdatasync**()
is available,
**_POSIX_SYNCHRONIZED_IO**
is defined in
_&lt;unistd.h&gt;_
to a value greater than 0.
(See also
**sysconf**(3).)




<a name="notes"></a>

# Notes

On some UNIX systems (but not Linux),
_fd_
must be a
_writable_
file descriptor.

In Linux 2.2 and earlier,
**fdatasync**()
is equivalent to
**fsync**(),
and so has no performance advantage.

The
**fsync**()
implementations in older kernels and lesser used filesystems
does not know how to flush disk caches.
In these cases disk caches need to be disabled using
**hdparm**(8)
or
**sdparm**(8)
to guarantee safe operation.

<a name="see-also"></a>

# See Also

**sync**(1),
**bdflush**(2),
**open**(2),
**posix_fadvise**(2),
**pwritev**(2),
**sync**(2),
**sync_file_range**(2),
**fflush**(3),
**fileno**(3),
**hdparm**(8),
**mount**(8)

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
