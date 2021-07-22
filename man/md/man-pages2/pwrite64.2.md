# pread(2) - read from or write to a file descriptor at a given offset

Linux, 2017-09-15

```
#include <unistd.h> 
 ssize_t pread(int fd, void *buf, size_t count, off_t offset); 
 ssize_t pwrite(int fd, const void *buf, size_t count, off_t offset); 
 .in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in 
 pread(), pwrite(): .RS 4 _XOPEN_SOURCE&nbsp;>=&nbsp;500
|| /* Since glibc 2.12: */ _POSIX_C_SOURCE&nbsp;>=&nbsp;200809L .RE
```

<a name="description"></a>

# Description

**pread**()
reads up to
_count_
bytes from file descriptor
_fd_
at offset
_offset_
(from the start of the file) into the buffer starting at
_buf_.
The file offset is not changed.

**pwrite**()
writes up to
_count_
bytes from the buffer starting at
_buf_
to the file descriptor
_fd_
at offset
_offset_.
The file offset is not changed.

The file referenced by
_fd_
must be capable of seeking.

<a name="return-value"></a>

# Return Value

On success,
**pread**()
returns the number of bytes read
(a return of zero indicates end of file)
and
**pwrite**()
returns the number of bytes written.

Note that is not an error for a successful call to transfer fewer bytes
than requested (see
**read**(2)
and
**write**(2)).

On error, -1 is returned and
_errno_
is set to indicate the cause of the error.

<a name="errors"></a>

# Errors

**pread**()
can fail and set
_errno_
to any error specified for
**read**(2)
or
**lseek**(2).
**pwrite**()
can fail and set
_errno_
to any error specified for
**write**(2)
or
**lseek**(2).

<a name="versions"></a>

# Versions

The
**pread**()
and
**pwrite**()
system calls were added to Linux in
version 2.1.60; the entries in the i386 system call table were added
in 2.1.69.
C library support (including emulation using
**lseek**(2)
on older kernels without the system calls) was added in glibc 2.1.

<a name="conforming-to"></a>

# Conforming to

POSIX.1-2001, POSIX.1-2008.

<a name="notes"></a>

# Notes

The
**pread**()
and
**pwrite**()
system calls are especially useful in multithreaded applications.
They allow multiple threads to perform I/O on the same file descriptor
without being affected by changes to the file offset by other threads.


<a name="c-librarykernel-differences"></a>

### C library/kernel differences

On Linux, the underlying system calls were renamed
in kernel 2.6:
**pread**()
became
**pread64**(),
and
**pwrite**()
became
**pwrite64**().
The system call numbers remained the same.
The glibc
**pread**()
and
**pwrite**()
wrapper functions transparently deal with the change.

On some 32-bit architectures,
the calling signature for these system calls differ,
for the reasons described in
**syscall**(2).

<a name="bugs"></a>

# Bugs

POSIX requires that opening a file with the
**O_APPEND**
flag should have no effect on the location at which
**pwrite**()
writes data.
However, on Linux, if a file is opened with

**O_APPEND**,
**pwrite**()
appends data to the end of the file, regardless of the value of
_offset_.

<a name="see-also"></a>

# See Also

**lseek**(2),
**read**(2),
**readv**(2),
**write**(2)

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
