# sendfile(2) - transfer data between file descriptors

Linux, 2017-09-15

```
#include <sys/sendfile.h> 
 ssize_t sendfile(int out_fd, int in_fd, off_t *offset, size_t count);
```





















<a name="description"></a>

# Description

**sendfile**()
copies data between one file descriptor and another.
Because this copying is done within the kernel,
**sendfile**()
is more efficient than the combination of
**read**(2)
and
**write**(2),
which would require transferring data to and from user space.

_in_fd_
should be a file descriptor opened for reading and
_out_fd_
should be a descriptor opened for writing.

If
_offset_
is not NULL, then it points
to a variable holding the file offset from which
**sendfile**()
will start reading data from
_in_fd_.
When
**sendfile**()
returns, this variable
will be set to the offset of the byte following the last byte that was read.
If
_offset_
is not NULL, then
**sendfile**()
does not modify the file offset of
_in_fd_;
otherwise the file offset is adjusted to reflect
the number of bytes read from
_in_fd_.

If
_offset_
is NULL, then data will be read from
_in_fd_
starting at the file offset,
and the file offset will be updated by the call.

_count_
is the number of bytes to copy between the file descriptors.

The
_in_fd_
argument must correspond to a file which supports
**mmap**(2)-like
operations
(i.e., it cannot be a socket).

In Linux kernels before 2.6.33,
_out_fd_
must refer to a socket.
Since Linux 2.6.33 it can be any file.
If it is a regular file, then
**sendfile**()
changes the file offset appropriately.

<a name="return-value"></a>

# Return Value

If the transfer was successful, the number of bytes written to
_out_fd_
is returned.
Note that a successful call to
**sendfile**()
may write fewer bytes than requested;
the caller should be prepared to retry the call if there were unsent bytes.
See also NOTES.

On error, -1 is returned, and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **EAGAIN**  
  Nonblocking I/O has been selected using
  **O_NONBLOCK**
  and the write would block.
* **EBADF**  
  The input file was not opened for reading or the output file
  was not opened for writing.
* **EFAULT**  
  Bad address.
* **EINVAL**  
  Descriptor is not valid or locked, or an
  **mmap**(2)-like
  operation is not available for
  _in_fd_,
  or
  _count_
  is negative.
* **EINVAL**  
  _out_fd_
  has the
  **O_APPEND**
  flag set.
  This is not currently supported by
  **sendfile**().
* **EIO**  
  Unspecified error while reading from
  _in_fd_.
* **ENOMEM**  
  Insufficient memory to read from
  _in_fd_.
* **EOVERFLOW**  
  _count_
  is too large, the operation would result in exceeding the maximum size of either
  the input file or the output file.
* **ESPIPE**  
  _offset_
  is not NULL but the input file is not
  **seek**(2)-able.

<a name="versions"></a>

# Versions

**sendfile**()
first appeared in Linux 2.2.
The include file
_&lt;sys/sendfile.h&gt;_
is present since glibc 2.1.

<a name="conforming-to"></a>

# Conforming to

Not specified in POSIX.1-2001, nor in other standards.

Other UNIX systems implement
**sendfile**()
with different semantics and prototypes.
It should not be used in portable programs.

<a name="notes"></a>

# Notes

**sendfile**()
will transfer at most 0x7ffff000 (2,147,479,552) bytes,
returning the number of bytes actually transferred.

(This is true on both 32-bit and 64-bit systems.)

If you plan to use
**sendfile**()
for sending files to a TCP socket, but need
to send some header data in front of the file contents, you will find
it useful to employ the
**TCP_CORK**
option, described in
**tcp**(7),
to minimize the number of packets and to tune performance.

In Linux 2.4 and earlier,
_out_fd_
could also refer to a regular file;
this possibility went away in the Linux 2.6.x kernel series,
but was restored in Linux 2.6.33.

The original Linux
**sendfile**()
system call was not designed to handle large file offsets.
Consequently, Linux 2.4 added
**sendfile64**(),
with a wider type for the
_offset_
argument.
The glibc
**sendfile**()
wrapper function transparently deals with the kernel differences.

Applications may wish to fall back to
**read**(2)/**write**(2)
in the case where
**sendfile**()
fails with
**EINVAL**
or
**ENOSYS**.

If
_out_fd_
refers to a socket or pipe with zero-copy support, callers must ensure the
transferred portions of the file referred to by
_in_fd_
remain unmodified until the reader on the other end of
_out_fd_
has consumed the transferred data.

The Linux-specific
**splice**(2)
call supports transferring data between arbitrary file descriptors
provided one (or both) of them is a pipe.

<a name="see-also"></a>

# See Also

**copy_file_range**(2),
**mmap**(2),
**open**(2),
**socket**(2),
**splice**(2)

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
