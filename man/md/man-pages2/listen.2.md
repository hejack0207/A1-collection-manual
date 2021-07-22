# listen(2) - listen for connections on a socket

Linux, 2017-09-15

    #include <sys/types.h>          /* See NOTES */
    #include <sys/socket.h>
    
    int listen(int sockfd, int backlog);

<a name="description"></a>

# Description

**listen**()
marks the socket referred to by
_sockfd_
as a passive socket, that is, as a socket that will
be used to accept incoming connection requests using
**accept**(2).

The
_sockfd_
argument is a file descriptor that refers to a socket of type
**SOCK_STREAM**
or
**SOCK_SEQPACKET**.

The
_backlog_
argument defines the maximum length
to which the queue of pending connections for
_sockfd_
may grow.
If a connection request arrives when the queue is full, the client
may receive an error with an indication of
**ECONNREFUSED**
or, if the underlying protocol supports retransmission, the request may be
ignored so that a later reattempt at connection succeeds.

<a name="return-value"></a>

# Return Value

On success, zero is returned.
On error, -1 is returned, and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **EADDRINUSE**  
  Another socket is already listening on the same port.
* **EADDRINUSE**  
  (Internet domain sockets)
  The socket referred to by
  _sockfd_
  had not previously been bound to an address and,
  upon attempting to bind it to an ephemeral port,
  it was determined that all port numbers in the ephemeral port range
  are currently in use.
  See the discussion of
  _/proc/sys/net/ipv4/ip_local_port_range_
  in
  **ip**(7).
* **EBADF**  
  The argument
  _sockfd_
  is not a valid file descriptor.
* **ENOTSOCK**  
  The file descriptor
  _sockfd_
  does not refer to a socket.
* **EOPNOTSUPP**  
  The socket is not of a type that supports the
  **listen**()
  operation.

<a name="conforming-to"></a>

# Conforming to

POSIX.1-2001, POSIX.1-2008, 4.4BSD
(**listen**()
first appeared in 4.2BSD).

<a name="notes"></a>

# Notes

To accept connections, the following steps are performed:

* 1.  
  A socket is created with
  **socket**(2).
* 2.  
  The socket is bound to a local address using
  **bind**(2),
  so that other sockets may be
  **connect**(2)ed
  to it.
* 3.  
  A willingness to accept incoming connections and a queue limit for incoming
  connections are specified with
  **listen**().
* 4.  
  Connections are accepted with
  **accept**(2).

POSIX.1 does not require the inclusion of
_&lt;sys/types.h&gt;_,
and this header file is not required on Linux.
However, some historical (BSD) implementations required this header
file, and portable applications are probably wise to include it.

The behavior of the
_backlog_
argument on TCP sockets changed with Linux 2.2.
Now it specifies the queue length for
_completely_
established sockets waiting to be accepted,
instead of the number of incomplete connection requests.
The maximum length of the queue for incomplete sockets
can be set using
_/proc/sys/net/ipv4/tcp_max_syn_backlog_.
When syncookies are enabled there is no logical maximum
length and this setting is ignored.
See
**tcp**(7)
for more information.

If the
_backlog_
argument is greater than the value in
_/proc/sys/net/core/somaxconn_,
then it is silently truncated to that value;
the default value in this file is 128.
In kernels before 2.4.25, this limit was a hard coded value,
**SOMAXCONN**,
with the value 128.




<a name="example"></a>

# Example

See
**bind**(2).

<a name="see-also"></a>

# See Also

**accept**(2),
**bind**(2),
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
