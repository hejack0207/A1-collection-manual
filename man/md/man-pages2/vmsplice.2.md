# vmsplice(2) - splice user pages into a pipe

Linux, 2017-09-15

    #define _GNU_SOURCE         /* See feature_test_macros(7) */
    #include <fcntl.h>
    #include <sys/uio.h>
    
    ssize_t vmsplice(int fd, const struct iovec *iov,
                     unsigned long nr_segs, unsigned int flags);


<a name="description"></a>

# Description








The
**vmsplice**()
system call maps
_nr_segs_
ranges of user memory described by
_iov_
into a pipe.
The file descriptor
_fd_
must refer to a pipe.

The pointer
_iov_
points to an array of
_iovec_
structures as defined in
_&lt;sys/uio.h&gt;_:

.in +4n
.EX
struct iovec {
    void  *iov_base;        /* Starting address */
    size_t iov_len;         /* Number of bytes */
};
.EE
.in

The
_flags_
argument is a bit mask that is composed by ORing together
zero or more of the following values:

* **SPLICE_F_MOVE**  
  Unused for
  **vmsplice**();
  see
  **splice**(2).
* **SPLICE_F_NONBLOCK**  
  
  
  Do not block on I/O; see
  **splice**(2)
  for further details.
* **SPLICE_F_MORE**  
  Currently has no effect for
  **vmsplice**(),
  but may be implemented in the future; see
  **splice**(2).
* **SPLICE_F_GIFT**  
  The user pages are a gift to the kernel.
  The application may not modify this memory ever,
  
  otherwise the page cache and on-disk data may differ.
  Gifting pages to the kernel means that a subsequent
  **splice**(2)
  **SPLICE_F_MOVE**
  can successfully move the pages;
  if this flag is not specified, then a subsequent
  **splice**(2)
  **SPLICE_F_MOVE**
  must copy the pages.
  Data must also be properly page aligned, both in memory and length.
  
  
  
  
  

<a name="return-value"></a>

# Return Value

Upon successful completion,
**vmsplice**()
returns the number of bytes transferred to the pipe.
On error,
**vmsplice**()
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
  _fd_
  either not valid, or doesn't refer to a pipe.
* **EINVAL**  
  _nr_segs_
  is greater than
  **IOV_MAX**;
  or memory not aligned if
  **SPLICE_F_GIFT**
  set.
* **ENOMEM**  
  Out of memory.

<a name="versions"></a>

# Versions

The
**vmsplice**()
system call first appeared in Linux 2.6.17;
library support was added to glibc in version 2.5.

<a name="conforming-to"></a>

# Conforming to

This system call is Linux-specific.

<a name="notes"></a>

# Notes

**vmsplice**()
follows the other vectorized read/write type functions when it comes to
limitations on the number of segments being passed in.
This limit is
**IOV_MAX**
as defined in
_&lt;limits.h&gt;_.
Currently,

this limit is 1024.

<a name="see-also"></a>

# See Also

**splice**(2),
**tee**(2),
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
