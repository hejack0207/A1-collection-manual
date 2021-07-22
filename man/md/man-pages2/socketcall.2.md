# socketcall(2) - socket system calls

Linux, 2017-09-15

```
#include <linux/net.h> 
 int socketcall(int call, unsigned long *args);
```

<a name="description"></a>

# Description

**socketcall**()
is a common kernel entry point for the socket system calls.
_call_
determines which socket function to invoke.
_args_
points to a block containing the actual arguments,
which are passed through to the appropriate call.

User programs should call the appropriate functions by their usual names.
Only standard library implementors and kernel hackers need to know about
**socketcall**().

.TS
tab(:);
l l.
_call_:Man page
T{
**SYS_SOCKET**
T}:T{
**socket**(2)
T}
T{
**SYS_BIND**
T}:T{
**bind**(2)
T}
T{
**SYS_CONNECT**
T}:T{
**connect**(2)
T}
T{
**SYS_LISTEN**
T}:T{
**listen**(2)
T}
T{
**SYS_ACCEPT**
T}:T{
**accept**(2)
T}
T{
**SYS_GETSOCKNAME**
T}:T{
**getsockname**(2)
T}
T{
**SYS_GETPEERNAME**
T}:T{
**getpeername**(2)
T}
T{
**SYS_SOCKETPAIR**
T}:T{
**socketpair**(2)
T}
T{
**SYS_SEND**
T}:T{
**send**(2)
T}
T{
**SYS_RECV**
T}:T{
**recv**(2)
T}
T{
**SYS_SENDTO**
T}:T{
**sendto**(2)
T}
T{
**SYS_RECVFROM**
T}:T{
**recvfrom**(2)
T}
T{
**SYS_SHUTDOWN**
T}:T{
**shutdown**(2)
T}
T{
**SYS_SETSOCKOPT**
T}:T{
**setsockopt**(2)
T}
T{
**SYS_GETSOCKOPT**
T}:T{
**getsockopt**(2)
T}
T{
**SYS_SENDMSG**
T}:T{
**sendmsg**(2)
T}
T{
**SYS_RECVMSG**
T}:T{
**recvmsg**(2)
T}
T{
**SYS_ACCEPT4**
T}:T{
**accept4**(2)
T}
T{
**SYS_RECVMMSG**
T}:T{
**recvmmsg**(2)
T}
T{
**SYS_SENDMMSG**
T}:T{
**sendmmsg**(2)
T}
.TE

<a name="conforming-to"></a>

# Conforming to

This call is specific to Linux, and should not be used in programs
intended to be portable.

<a name="notes"></a>

# Notes

On a some architectures—for example, x86-64 and ARM—there is no
**socketcall**()
system call; instead
**socket**(2),
**accept**(2),
**bind**(2),
and so on really are implemented as separate system calls.

On x86-32,
**socketcall**()
was historically the only entry point for the sockets API.
However, starting in Linux 4.3,

direct system calls are provided on x86-32 for the sockets API.
This facilitates the creation of
**seccomp**(2)
filters that filter sockets system calls
(for new user-space binaries that are compiled
to use the new entry points)
and also provides a (very) small performance improvement.

<a name="see-also"></a>

# See Also

**accept**(2),
**bind**(2),
**connect**(2),
**getpeername**(2),
**getsockname**(2),
**getsockopt**(2),
**listen**(2),
**recv**(2),
**recvfrom**(2),
**recvmsg**(2),
**send**(2),
**sendmsg**(2),
**sendto**(2),
**setsockopt**(2),
**shutdown**(2),
**socket**(2),
**socketpair**(2)

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
