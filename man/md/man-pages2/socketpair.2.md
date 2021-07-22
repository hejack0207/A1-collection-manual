# socketpair(2) - create a pair of connected sockets

Linux, 2017-09-15

```
#include <sys/types.h>          /* See NOTES */
#include <sys/socket.h> 
 int socketpair(int domain, int type, int protocol, int sv[2]);
```

<a name="description"></a>

# Description

The
**socketpair**()
call creates an unnamed pair of connected sockets in the specified
_domain_,
of the specified
_type_,
and using the optionally specified
_protocol_.
For further details of these arguments, see
**socket**(2).

The file descriptors used in referencing the new sockets are returned in
_sv_[0]
and
_sv_[1].
The two sockets are indistinguishable.

<a name="return-value"></a>

# Return Value

On success, zero is returned.
On error, -1 is returned, and
_errno_
is set appropriately.

On Linux (and other systems),
**socketpair**()
does not modify
_sv_
on failure.
A requirement standardizing this behavior was added in POSIX.1-2016.


<a name="errors"></a>

# Errors


* **EAFNOSUPPORT**  
  The specified address family is not supported on this machine.
* **EFAULT**  
  The address
  _sv_
  does not specify a valid part of the process address space.
* **EMFILE**  
  The per-process limit on the number of open file descriptors has been reached.
* **ENFILE**  
  The system-wide limit on the total number of open files has been reached.
* **EOPNOTSUPP**  
  The specified protocol does not support creation of socket pairs.
* **EPROTONOSUPPORT**  
  The specified protocol is not supported on this machine.

<a name="conforming-to"></a>

# Conforming to

POSIX.1-2001, POSIX.1-2008, 4.4BSD.
**socketpair**()
first appeared in 4.2BSD.
It is generally portable to/from
non-BSD systems supporting clones of the BSD socket layer (including
System&nbsp;V variants).

<a name="notes"></a>

# Notes

On Linux, the only supported domain for this call is
**AF_UNIX**
(or synonymously,
**AF_LOCAL**).
(Most implementations have the same restriction.)

Since Linux 2.6.27,
**socketpair**()
supports the
**SOCK_NONBLOCK**
and
**SOCK_CLOEXEC**
flags in the
_type_
argument, as described in
**socket**(2).

POSIX.1 does not require the inclusion of
_&lt;sys/types.h&gt;_,
and this header file is not required on Linux.
However, some historical (BSD) implementations required this header
file, and portable applications are probably wise to include it.

<a name="see-also"></a>

# See Also

**pipe**(2),
**read**(2),
**socket**(2),
**write**(2),
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
