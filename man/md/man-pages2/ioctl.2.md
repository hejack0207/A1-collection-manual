# ioctl(2) - control device

Linux, 2017-05-03

```
#include <sys/ioctl.h> 
 int ioctl(int fd, unsigned long request, ...);
```



<a name="description"></a>

# Description

The
**ioctl**()
system call manipulates the underlying device parameters of special files.
In particular, many operating characteristics of character special files
(e.g., terminals) may be controlled with
**ioctl**()
requests.
The argument
_fd_
must be an open file descriptor.

The second argument is a device-dependent request code.
The third argument is an untyped pointer to memory.
It's traditionally
**char ***_argp_
(from the days before
**void ***
was valid C), and will be so named for this discussion.

An
**ioctl**()
_request_
has encoded in it whether the argument is an
_in_
parameter or
_out_
parameter, and the size of the argument
_argp_
in bytes.
Macros and defines used in specifying an
**ioctl**()
_request_
are located in the file
_&lt;sys/ioctl.h&gt;_.

<a name="return-value"></a>

# Return Value

Usually, on success zero is returned.
A few
**ioctl**()
requests use the return value as an output parameter
and return a nonnegative value on success.
On error, -1 is returned, and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **EBADF**  
  _fd_
  is not a valid file descriptor.
* **EFAULT**  
  _argp_
  references an inaccessible memory area.
* **EINVAL**  
  _request_
  or
  _argp_
  is not valid.
* **ENOTTY**  
  _fd_
  is not associated with a character special device.
* **ENOTTY**  
  The specified request does not apply to the kind of object that the
  file descriptor
  _fd_
  references.

<a name="conforming-to"></a>

# Conforming to

No single standard.
Arguments, returns, and semantics of
**ioctl**()
vary according to the device driver in question (the call is used as a
catch-all for operations that don't cleanly fit the UNIX stream I/O
model).
See
**ioctl_list**(2)
for a list of many of the known
**ioctl**()
calls.
The
**ioctl**()
system call appeared in Version 7 AT&T UNIX.

<a name="notes"></a>

# Notes

In order to use this call, one needs an open file descriptor.
Often the
**open**(2)
call has unwanted side effects, that can be avoided under Linux
by giving it the
**O_NONBLOCK**
flag.

<a name="see-also"></a>

# See Also

**execve**(2),
**fcntl**(2),
**ioctl_console**(2),
**ioctl_fat**(2),
**ioctl_ficlonerange**(2),
**ioctl_fideduperange**(2),
**ioctl_getfsmap**(2),
**ioctl_iflags**(2),
**ioctl_list**(2),
**ioctl_ns**(2),
**ioctl_tty**(2),
**ioctl_userfaultfd**(2),
**open**(2),

**sd**(4),
**tty**(4)

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
