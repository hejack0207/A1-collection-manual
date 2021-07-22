# readahead(2) - initiate file readahead into page cache

Linux, 2017-09-15

    #define _GNU_SOURCE             /* See feature_test_macros(7) */
    #include <fcntl.h>
    
    ssize_t readahead(int fd, off64_t offset, size_t count);

<a name="description"></a>

# Description

**readahead**()
initiates readahead on a file so that subsequent reads from that file will
be satisfied from the cache, and not block on disk I/O
(assuming the readahead was initiated early enough and that other activity
on the system did not in the meantime flush pages from the cache).

The
_fd_
argument is a file descriptor identifying the file which is
to be read.
The
_offset_
argument specifies the starting point from which data is to be read
and
_count_
specifies the number of bytes to be read.
I/O is performed in whole pages, so that
_offset_
is effectively rounded down to a page boundary
and bytes are read up to the next page boundary greater than or
equal to
_(offset+count)_.
**readahead**()
does not read beyond the end of the file.
The file offset of the open file description referred to by
_fd_
is left unchanged.

<a name="return-value"></a>

# Return Value

On success,
**readahead**()
returns 0; on failure, -1 is returned, with
_errno_
set to indicate the cause of the error.

<a name="errors"></a>

# Errors


* **EBADF**  
  _fd_
  is not a valid file descriptor or is not open for reading.
* **EINVAL**  
  _fd_
  does not refer to a file type to which
  **readahead**()
  can be applied.

<a name="versions"></a>

# Versions

The
**readahead**()
system call appeared in Linux 2.4.13;
glibc support has been provided since version 2.3.

<a name="conforming-to"></a>

# Conforming to

The
**readahead**()
system call is Linux-specific, and its use should be avoided
in portable applications.

<a name="notes"></a>

# Notes

On some 32-bit architectures,
the calling signature for this system call differs,
for the reasons described in
**syscall**(2).

<a name="bugs"></a>

# Bugs

**readahead**()
attempts to schedule the reads in the background and return immediately.
However, it may block while it reads the filesystem metadata needed
to locate the requested blocks.
This occurs frequently with ext[234] on large files
using indirect blocks instead of extents,
giving the appearance that the call blocks until the requested data has
been read.

<a name="see-also"></a>

# See Also

**lseek**(2),
**madvise**(2),
**mmap**(2),
**posix_fadvise**(2),
**read**(2)

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
