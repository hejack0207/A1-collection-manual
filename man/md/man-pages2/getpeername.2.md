# getpeername(2) - get name of connected peer socket

Linux, 2017-09-15

```
#include <sys/socket.h> 
 int getpeername(int sockfd, struct sockaddr *addr, socklen_t *addrlen);
```

<a name="description"></a>

# Description

**getpeername**()
returns the address of the peer connected to the socket
_sockfd_,
in the buffer pointed to by
_addr_.
The
_addrlen_
argument should be initialized to indicate the amount of space pointed to
by
_addr_.
On return it contains the actual size of the name returned (in bytes).
The name is truncated if the buffer provided is too small.

The returned address is truncated if the buffer provided is too small;
in this case,
_addrlen_
will return a value greater than was supplied to the call.

<a name="return-value"></a>

# Return Value

On success, zero is returned.
On error, -1 is returned, and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **EBADF**  
  The argument
  _sockfd_
  is not a valid file descriptor.
* **EFAULT**  
  The
  _addr_
  argument points to memory not in a valid part of the
  process address space.
* **EINVAL**  
  _addrlen_
  is invalid (e.g., is negative).
* **ENOBUFS**  
  Insufficient resources were available in the system
  to perform the operation.
* **ENOTCONN**  
  The socket is not connected.
* **ENOTSOCK**  
  The file descriptor
  _sockfd_
  does not refer to a socket.

<a name="conforming-to"></a>

# Conforming to

POSIX.1-2001, POSIX.1-2008, SVr4, 4.4BSD
(**getpeername**()
first appeared in 4.2BSD).

<a name="notes"></a>

# Notes

For background on the
_socklen_t_
type, see
**accept**(2).

For stream sockets, once a
**connect**(2)
has been performed, either socket can call
**getpeername**()
to obtain the address of the peer socket.
On the other hand, datagram sockets are connectionless.
Calling
**connect**(2)
on a datagram socket merely sets the peer address for outgoing
datagrams sent with
**write**(2)
or
**recv**(2).
The caller of
**connect**(2)
can use
**getpeername**()
to obtain the peer address that it earlier set for the socket.
However, the peer socket is unaware of this information, and calling
**getpeername**()
on the peer socket will return no useful information (unless a
**connect**(2)
call was also executed on the peer).
Note also that the receiver of a datagram can obtain
the address of the sender when using
**recvfrom**(2).

<a name="see-also"></a>

# See Also

**accept**(2),
**bind**(2),
**getsockname**(2),
**ip**(7),
**socket**(7),
**unix**(7)

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
