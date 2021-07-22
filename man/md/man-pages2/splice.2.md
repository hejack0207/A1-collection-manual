# splice(2) - splice data to/from a pipe

Linux, 2017-09-15

    #define _GNU_SOURCE         /* See feature_test_macros(7) */
    #include <fcntl.h>
    
    ssize_t splice(int fd_in, loff_t *off_in, int fd_out,
                   loff_t *off_out, size_t len, unsigned int flags);
    

<a name="description"></a>

# Description

**splice**()
moves data between two file descriptors
without copying between kernel address space and user address space.
It transfers up to
_len_
bytes of data from the file descriptor
_fd_in_
to the file descriptor
_fd_out_,
where one of the file descriptors must refer to a pipe.

The following semantics apply for
_fd_in_
and
_off_in_:

* *  
  If
  _fd_in_
  refers to a pipe, then
  _off_in_
  must be NULL.
* *  
  If
  _fd_in_
  does not refer to a pipe and
  _off_in_
  is NULL, then bytes are read from
  _fd_in_
  starting from the file offset,
  and the file offset is adjusted appropriately.
* *  
  If
  _fd_in_
  does not refer to a pipe and
  _off_in_
  is not NULL, then
  _off_in_
  must point to a buffer which specifies the starting
  offset from which bytes will be read from
  _fd_in_;
  in this case, the file offset of
  _fd_in_
  is not changed.

Analogous statements apply for
_fd_out_
and
_off_out_.

The
_flags_
argument is a bit mask that is composed by ORing together
zero or more of the following values:

* **SPLICE_F_MOVE**  
  Attempt to move pages instead of copying.
  This is only a hint to the kernel:
  pages may still be copied if the kernel cannot move the
  pages from the pipe, or if
  the pipe buffers don't refer to full pages.
  The initial implementation of this flag was buggy:
  therefore starting in Linux 2.6.21 it is a no-op
  (but is still permitted in a
  **splice**()
  call);
  in the future, a correct implementation may be restored.
* **SPLICE_F_NONBLOCK**  
  Do not block on I/O.
  This makes the splice pipe operations nonblocking, but
  **splice**()
  may nevertheless block because the file descriptors that
  are spliced to/from may block (unless they have the
  **O_NONBLOCK**
  flag set).
* **SPLICE_F_MORE**  
  More data will be coming in a subsequent splice.
  This is a helpful hint when
  the
  _fd_out_
  refers to a socket (see also the description of
  **MSG_MORE**
  in
  **send**(2),
  and the description of
  **TCP_CORK**
  in
  **tcp**(7)).
* **SPLICE_F_GIFT**  
  Unused for
  **splice**();
  see
  **vmsplice**(2).

<a name="return-value"></a>

# Return Value

Upon successful completion,
**splice**()
returns the number of bytes
spliced to or from the pipe.

A return value of 0 means end of input.
If
_fd_in_
refers to a pipe, then this means that there was no data to transfer,
and it would not make sense to block because there are no writers
connected to the write end of the pipe.

On error,
**splice**()
returns -1 and
_errno_
is set to indicate the error.

<a name="errors"></a>

# Errors


* **EAGAIN**  
  **SPLICE_F_NONBLOCK**
  was specified in
  _flags_,
  and the operation would block.
* **EBADF**  
  One or both file descriptors are not valid,
  or do not have proper read-write mode.
* **EINVAL**  
  The target filesystem doesn't support splicing.
* **EINVAL**  
  The target file is opened in append mode.
  
  
* **EINVAL**  
  Neither of the file descriptors refers to a pipe.
* **EINVAL**  
  An offset was given for nonseekable device (e.g., a pipe).
* **EINVAL**  
  _fd_in_
  and
  _fd_out_
  refer to the same pipe.
* **ENOMEM**  
  Out of memory.
* **ESPIPE**  
  Either
  _off_in_
  or
  _off_out_
  was not NULL, but the corresponding file descriptor refers to a pipe.

<a name="versions"></a>

# Versions

The
**splice**()
system call first appeared in Linux 2.6.17;
library support was added to glibc in version 2.5.

<a name="conforming-to"></a>

# Conforming to

This system call is Linux-specific.

<a name="notes"></a>

# Notes

The three system calls
**splice**(),
**vmsplice**(2),
and
**tee**(2),
provide user-space programs with full control over an arbitrary
kernel buffer, implemented within the kernel using the same type
of buffer that is used for a pipe.
In overview, these system calls perform the following tasks:

* **splice**()  
  moves data from the buffer to an arbitrary file descriptor, or vice versa,
  or from one buffer to another.
* **tee**(2)  
  "copies" the data from one buffer to another.
* **vmsplice**(2)  
  "copies" data from user space into the buffer.

Though we talk of copying, actual copies are generally avoided.
The kernel does this by implementing a pipe buffer as a set
of reference-counted pointers to pages of kernel memory.
The kernel creates "copies" of pages in a buffer by creating new
pointers (for the output buffer) referring to the pages,
and increasing the reference counts for the pages:
only pointers are copied, not the pages of the buffer.
























In Linux 2.6.30 and earlier,
exactly one of
_fd_in_
and
_fd_out_
was required to be a pipe.
Since Linux 2.6.31,

both arguments may refer to pipes.

<a name="example"></a>

# Example

See
**tee**(2).

<a name="see-also"></a>

# See Also

**copy_file_range**(2),
**sendfile**(2),
**tee**(2),
**vmsplice**(2),
**pipe**(7)

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
