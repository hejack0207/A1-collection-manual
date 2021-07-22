# ipv6(7) - Linux IPv6 protocol implementation

Linux, 2017-09-15

```
#include <sys/socket.h>
#include <netinet/in.h> 
 tcp6_socket = socket(AF_INET6, SOCK_STREAM, 0);
raw6_socket = socket(AF_INET6, SOCK_RAW, protocol);
udp6_socket = socket(AF_INET6, SOCK_DGRAM, protocol);
```

<a name="description"></a>

# Description

Linux 2.2 optionally implements the Internet Protocol, version 6.
This man page contains a description of the IPv6 basic API as
implemented by the Linux kernel and glibc 2.1.
The interface
is based on the BSD sockets interface; see
**socket**(7).

The IPv6 API aims to be mostly compatible with the
IPv4 API (see
**ip**(7)).
Only differences are described in this man page.

To bind an
**AF_INET6**
socket to any process, the local address should be copied from the
_in6addr_any_
variable which has
_in6_addr_
type.
In static initializations,
**IN6ADDR_ANY_INIT**
may also be used, which expands to a constant expression.
Both of them are in network byte order.

The IPv6 loopback address (::1) is available in the global
_in6addr_loopback_
variable.
For initializations,
**IN6ADDR_LOOPBACK_INIT**
should be used.

IPv4 connections can be handled with the v6 API by using the
v4-mapped-on-v6 address type;
thus a program needs to support only this API type to
support both protocols.
This is handled transparently by the address
handling functions in the C library.

IPv4 and IPv6 share the local port space.
When you get an IPv4 connection
or packet to an IPv6 socket, its source address will be mapped
to v6 and it will be mapped to v6.

<a name="address-format"></a>

### Address format

.in +4n
.EX
struct sockaddr_in6 {
    sa_family_t     sin6_family;   /* AF_INET6 */
    in_port_t       sin6_port;     /* port number */
    uint32_t        sin6_flowinfo; /* IPv6 flow information */
    struct in6_addr sin6_addr;     /* IPv6 address */
    uint32_t        sin6_scope_id; /* Scope ID (new in 2.4) */
};

struct in6_addr {
    unsigned char   s6_addr[16];   /* IPv6 address */
};
.EE
.in

_sin6_family_
is always set to
**AF_INET6**;
_sin6_port_
is the protocol port (see
_sin_port_
in
**ip**(7));
_sin6_flowinfo_
is the IPv6 flow identifier;
_sin6_addr_
is the 128-bit IPv6 address.
_sin6_scope_id_
is an ID depending on the scope of the address.
It is new in Linux 2.4.
Linux supports it only for link-local addresses, in that case
_sin6_scope_id_
contains the interface index (see
**netdevice**(7))

IPv6 supports several address types: unicast to address a single
host, multicast to address a group of hosts,
anycast to address the nearest member of a group of hosts
(not implemented in Linux), IPv4-on-IPv6 to
address an IPv4 host, and other reserved address types.

The address notation for IPv6 is a group of 8 4-digit hexadecimal
numbers, separated with a ':'.
"::" stands for a string of 0 bits.
Special addresses are ::1 for loopback and ::FFFF:&lt;IPv4 address&gt;
for IPv4-mapped-on-IPv6.

The port space of IPv6 is shared with IPv4.

<a name="socket-options"></a>

### Socket options

IPv6 supports some protocol-specific socket options that can be set with
**setsockopt**(2)
and read with
**getsockopt**(2).
The socket option level for IPv6 is
**IPPROTO_IPV6**.
A boolean integer flag is zero when it is false, otherwise true.

* **IPV6_ADDRFORM**  
  Turn an
  **AF_INET6**
  socket into a socket of a different address family.
  Only
  **AF_INET**
  is currently supported for that.
  It is allowed only for IPv6 sockets
  that are connected and bound to a v4-mapped-on-v6 address.
  The argument is a pointer to an integer containing
  **AF_INET**.
  This is useful to pass v4-mapped sockets as file descriptors to
  programs that don't know how to deal with the IPv6 API.
* **IPV6_ADD_MEMBERSHIP, IPV6_DROP_MEMBERSHIP**  
  Control membership in multicast groups.
  Argument is a pointer to a
  _struct ipv6_mreq_.
* **IPV6_MTU**  
  **getsockopt**():
  Retrieve the current known path MTU of the current socket.
  Valid only when the socket has been connected.
  Returns an integer.
* **setsockopt**():
  Set the MTU to be used for the socket.
  The MTU is limited by the device
  MTU or the path MTU when path MTU discovery is enabled.
  Argument is a pointer to integer.
* **IPV6_MTU_DISCOVER**  
  Control path-MTU discovery on the socket.
  See
  **IP_MTU_DISCOVER**
  in
  **ip**(7)
  for details.
* **IPV6_MULTICAST_HOPS**  
  Set the multicast hop limit for the socket.
  Argument is a pointer to an
  integer.
  -1 in the value means use the route default, otherwise it should be
  between 0 and 255.
* **IPV6_MULTICAST_IF**  
  Set the device for outgoing multicast packets on the socket.
  This is allowed only for
  **SOCK_DGRAM**
  and
  **SOCK_RAW**
  socket.
  The argument is a pointer to an interface index (see
  **netdevice**(7))
  in an integer.
* **IPV6_MULTICAST_LOOP**  
  Control whether the socket sees multicast packets that it has send itself.
  Argument is a pointer to boolean.
* **IPV6_RECVPKTINFO** (since Linux 2.6.14)  
  Set delivery of the
  **IPV6_PKTINFO**
  control message on incoming datagrams.
  Such control messages contain a
  _struct in6_pktinfo_,
  as per RFC 3542.
  Allowed only for
  **SOCK_DGRAM**
  or
  **SOCK_RAW**
  sockets.
  Argument is a pointer to a boolean value in an integer.
* .nh  
  **IPV6_RTHDR, IPV6_AUTHHDR, IPV6_DSTOPTS, IPV6_HOPOPTS, IPV6_FLOWINFO, IPV6_HOPLIMIT**
  Set delivery of control messages for incoming datagrams containing
  extension headers from the received packet.
  **IPV6_RTHDR**
  delivers the routing header,
  **IPV6_AUTHHDR**
  delivers the authentication header,
  **IPV6_DSTOPTS**
  delivers the destination options,
  **IPV6_HOPOPTS**
  delivers the hop options,
  **IPV6_FLOWINFO**
  delivers an integer containing the flow ID,
  **IPV6_HOPLIMIT**
  delivers an integer containing the hop count of the packet.
  The control messages have the same type as the socket option.
  All these header options can also be set for outgoing packets
  by putting the appropriate control message into the control buffer of
  **sendmsg**(2).
  Allowed only for
  **SOCK_DGRAM**
  or
  **SOCK_RAW**
  sockets.
  Argument is a pointer to a boolean value.
* **IPV6_RECVERR**  
  Control receiving of asynchronous error options.
  See
  **IP_RECVERR**
  in
  **ip**(7)
  for details.
  Argument is a pointer to boolean.
* **IPV6_ROUTER_ALERT**  
  Pass forwarded packets containing a router alert hop-by-hop option to
  this socket.
  Allowed only for
  **SOCK_RAW**
  sockets.
  The tapped packets are not forwarded by the kernel, it is the
  user's responsibility to send them out again.
  Argument is a pointer to an integer.
  A positive integer indicates a router alert option value to intercept.
  Packets carrying a router alert option with a value field containing
  this integer will be delivered to the socket.
  A negative integer disables delivery of packets with router alert options
  to this socket.
* **IPV6_UNICAST_HOPS**  
  Set the unicast hop limit for the socket.
  Argument is a pointer to an integer.
  -1 in the value means use the route default,
  otherwise it should be between 0 and 255.
* **IPV6_V6ONLY** (since Linux 2.4.21 and 2.6)  
  
  If this flag is set to true (nonzero), then the socket is restricted
  to sending and receiving IPv6 packets only.
  In this case, an IPv4 and an IPv6 application can bind
  to a single port at the same time.
* If this flag is set to false (zero),
  then the socket can be used to send and receive packets
  to and from an IPv6 address or an IPv4-mapped IPv6 address.
* The argument is a pointer to a boolean value in an integer.
* The default value for this flag is defined by the contents of the file
  _/proc/sys/net/ipv6/bindv6only_.
  The default value for that file is 0 (false).
  

<a name="errors"></a>

# Errors


* **ENODEV**  
  The user tried to
  **bind**(2)
  to a link-local IPv6 address, but the
  _sin6_scope_id_
  in the supplied
  _sockaddr_in6_
  structure is not a valid
  interface index.

<a name="versions"></a>

# Versions

Linux 2.4 will break binary compatibility for the
_sockaddr_in6_
for 64-bit
hosts by changing the alignment of
_in6_addr_
and adding an additional
_sin6_scope_id_
field.
The kernel interfaces stay compatible, but a program including
_sockaddr_in6_
or
_in6_addr_
into other structures may not be.
This is not
a problem for 32-bit hosts like i386.

The
_sin6_flowinfo_
field is new in Linux 2.4.
It is transparently passed/read by the kernel
when the passed address length contains it.
Some programs that pass a longer address buffer and then
check the outgoing address length may break.

<a name="notes"></a>

# Notes

The
_sockaddr_in6_
structure is bigger than the generic
_sockaddr_.
Programs that assume that all address types can be stored safely in a
_struct sockaddr_
need to be changed to use
_struct sockaddr_storage_
for that instead.

**SOL_IP**,
**SOL_IPV6**,
**SOL_ICMPV6**
and other
**SOL_***
socket options are nonportable variants of
**IPPROTO_***.
See also
**ip**(7).

<a name="bugs"></a>

# Bugs

The IPv6 extended API as in RFC&nbsp;2292 is currently only partly
implemented;
although the 2.2 kernel has near complete support for receiving options,
the macros for generating IPv6 options are missing in glibc 2.1.

IPSec support for EH and AH headers is missing.

Flow label management is not complete and not documented here.

This man page is not complete.

<a name="see-also"></a>

# See Also

**cmsg**(3),
**ip**(7)

RFC&nbsp;2553: IPv6 BASIC API;
Linux tries to be compliant to this.
RFC&nbsp;2460: IPv6 specification.

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
