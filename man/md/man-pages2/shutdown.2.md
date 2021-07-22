# shutdown(2) - shut down part of a full-duplex connection

Linux, 2018-04-30

```
#include <sys/socket.h> 
 int shutdown(int sockfd, int how);
```

<a name="description"></a>

# Description

The
**shutdown**()
call causes all or part of a full-duplex connection on the socket
associated with
_sockfd_
to be shut down.
If
_how_
is
**SHUT_RD**,
further receptions will be disallowed.
If
_how_
is
**SHUT_WR**,
further transmissions will be disallowed.
If
_how_
is
**SHUT_RDWR**,
further receptions and transmissions will be disallowed.

<a name="return-value"></a>

# Return Value

On success, zero is returned.
On error, -1 is returned, and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **EBADF**  
  _sockfd_
  is not a valid file descriptor.
* **EINVAL**  
  An invalid value was specified in
  _how_
  (but see BUGS).
* **ENOTCONN**  
  The specified socket is not connected.
* **ENOTSOCK**  
  The file descriptor
  _sockfd_
  does not refer to a socket.

<a name="conforming-to"></a>

# Conforming to

POSIX.1-2001, POSIX.1-2008, 4.4BSD
(**shutdown**()
first appeared in 4.2BSD).

<a name="notes"></a>

# Notes

The constants
**SHUT_RD**,
**SHUT_WR**,
**SHUT_RDWR**
have the value 0, 1, 2,
respectively, and are defined in
_&lt;sys/socket.h&gt;_
since glibc-2.1.91.

<a name="bugs"></a>

# Bugs

Checks for the validity of
_how_
are done in domain-specific code,
and before Linux 3.7 not all domains performed these checks.

Most notably, UNIX domain sockets simply ignored invalid values.
This problem was fixed for UNIX domain sockets


in Linux 3.7.

<a name="see-also"></a>

# See Also

**close**(2),
**connect**(2),
**socket**(2),
**socket**(7)

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
