# netstat(8) - Print network connections, routing tables, interface statistics, masquerade connections, and multicast memberships

net\-tools, 2014\-10\-07

```
netstat  [address_family_options] [--tcp|-t] [--udp|-u] [--udplite|-U] [--sctp|-S] [--raw|-w] [--l2cap|-2] [--rfcomm|-f] [--listening|-l] [--all|-a] [--numeric|-n] [--numeric-hosts] [--numeric-ports] [--numeric-users] [--symbolic|-N] [--extend|-e[--extend|-e]] [--timers|-o] [--program|-p] [--verbose|-v] [--continuous|-c] [--wide|-W] [delay] 
 netstat  {--route|-r} [address_family_options] [--extend|-e[--extend|-e]] [--verbose|-v] [--numeric|-n] [--numeric-hosts] [--numeric-ports] [--numeric-users] [--continuous|-c] [delay] 
 netstat {--interfaces|-I|-i} [--all|-a] [--extend|-e] [--verbose|-v] [--program|-p] [--numeric|-n] [--numeric-hosts] [--numeric-ports] [--numeric-users] [--continuous|-c] [delay] 
 netstat {--groups|-g} [--numeric|-n] [--numeric-hosts] [--numeric-ports] [--numeric-users] [--continuous|-c] [delay] 
 netstat {--masquerade|-M} [--extend|-e] [--numeric|-n] [--numeric-hosts] [--numeric-ports] [--numeric-users] [--continuous|-c] [delay] 
 netstat {--statistics|-s} [--tcp|-t] [--udp|-u] [--udplite|-U] [--sctp|-S] [--raw|-w] [delay] 
 netstat  {--version|-V} 
 netstat  {--help|-h} 
 address_family_options: 
 [-4|--inet] [-6|--inet6] [--protocol={inet,inet6,unix,ipx,ax25,netrom,ddp,bluetooth, ... } ] [--unix|-x] [--inet|--ip|--tcpip] [--ax25] [--x25] [--rose] [--ash] [--bluetooth] [--ipx] [--netrom] [--ddp|--appletalk] [--econet|--ec]
```


<a name="notes"></a>

# Notes

This program is mostly obsolete.
Replacement for **netstat** is **ss**.
Replacement for **netstat -r** is **ip route**.
Replacement for **netstat -i** is **ip -s link**.
Replacement for **netstat -g** is **ip maddr**.


<a name="description"></a>

# Description

**Netstat**
prints information about the Linux networking subsystem.  The type of
information printed is controlled by the first argument, as follows:

<a name="none"></a>

### (none)

By default,
.B
netstat 
displays a list of open sockets.  If you don't specify any
address families, then the active sockets of all configured address
families will be printed.

<a name="-route-r"></a>

### \-\-route, \-r

Display the kernel routing tables. See the description in 
**route**(8)
for details. 
**netstat -r**
and 
**route -e**
produce the same output.

<a name="-groups-g"></a>

### \-\-groups, \-g

Display multicast group membership information for IPv4 and IPv6.

<a name="-interfacesfiiface-fr-fb-ifiiface-fr-fb-i"></a>

### \-\-interfaces=\fIiface \fR, \fB\-I=\fIiface \fR, \fB\-i

Display a table of all network interfaces, or the specified _iface_.

<a name="-masquerade-m"></a>

### \-\-masquerade, \-M

Display a list of masqueraded connections.

<a name="-statistics-s"></a>

### \-\-statistics, \-s

Display summary statistics for each protocol.

<a name="options"></a>

# Options


<a name="-verbose-v"></a>

### \-\-verbose, \-v

Tell the user what is going on by being verbose. Especially print some
useful information about unconfigured address families.

<a name="-wide-w"></a>

### \-\-wide, \-W

Do not truncate IP addresses by using output as wide as needed. This is
optional for now to not break existing scripts.

<a name="-numeric-n"></a>

### \-\-numeric, \-n

Show numerical addresses instead of trying to determine symbolic host, port
or user names.

<a name="-numeric-hosts"></a>

### \-\-numeric\-hosts

shows numerical host addresses but does not affect the resolution of
port or user names.

<a name="-numeric-ports"></a>

### \-\-numeric\-ports

shows numerical port numbers but does not affect the resolution of
host or user names.

<a name="-numeric-users"></a>

### \-\-numeric\-users

shows numerical user IDs but does not affect the resolution of host or
port names.


<a name="-protocolfifamilyfr-fb-a"></a>

### \-\-protocol=\fIfamily\fR, \fB\-A

Specifies the address families (perhaps better described as low level
protocols) for which connections are to be shown.
_family_
is a comma (',') separated list of address family keywords like
**inet**,
**inet6**,
**unix**,
**ipx**,
**ax25**,
**netrom**,
**econet**,
**ddp**,
and
**bluetooth**.
This has the same effect as using the 
**--inet**|**-4**,
**--inet6**|**-6**,
**--unix**|**-x**,
**--ipx**,
**--ax25**,
**--netrom**,
**--ddp**,
and
**--bluetooth**
options.

The address family
**inet**
(Iv4) includes raw, udp, udplite and tcp protocol sockets.

The address family
**bluetooth**
(Iv4) includes l2cap and rfcomm protocol sockets.

<a name="-c-continuous"></a>

### \-c, \-\-continuous

This will cause
**netstat**
to print the selected information every second continuously.

<a name="-e-extend"></a>

### \-e, \-\-extend

Display additional information.  Use this option twice for maximum detail.

<a name="-o-timers"></a>

### \-o, \-\-timers

Include information related to networking timers.

<a name="-p-program"></a>

### \-p, \-\-program

Show the PID and name of the program to which each socket belongs.

<a name="-l-listening"></a>

### \-l, \-\-listening

Show only listening sockets.  (These are omitted by default.)

<a name="-a-all"></a>

### \-a, \-\-all

Show both listening and non-listening (for TCP this means established
connections) sockets.  With the
**--interfaces**
option, show interfaces that are not up

<a name="-f"></a>

### \-F

Print routing information from the FIB.  (This is the default.)

<a name="-c"></a>

### \-C

Print routing information from the route cache.

<a name="delay"></a>

### delay

Netstat will cycle printing through statistics every 
**delay**
seconds.


<a name="output"></a>

# Output



<a name="active-internet-connections-frtcp-udp-udplite-rawfr"></a>

### Active Internet connections \fR(TCP, UDP, UDPLite, raw)\fR


<a name="proto-"></a>

### "Proto" 

The protocol (tcp, udp, udpl, raw) used by the socket. 

<a name="recv-q"></a>

### Recv\-Q

Established: The count of bytes not copied by the user program connected to this socket.
Listening: Since Kernel 2.6.18 this column contains the current syn backlog.

<a name="send-q"></a>

### Send\-Q

Established: The count of bytes not acknowledged by the remote host.
Listening: Since Kernel 2.6.18 this column contains the maximum size of the syn backlog.

<a name="local-address-"></a>

### "Local Address" 

Address and port number of the local end of the socket.  Unless the
**--numeric** (**-n**)
option is specified, the socket address is resolved to its canonical
host name (FQDN), and the port number is translated into the
corresponding service name.

<a name="foreign-address"></a>

### Foreign Address

Address and port number of the remote end of the socket.
Analogous to "Local Address".

<a name="state"></a>

### State

The state of the socket. Since there are no states in raw mode and usually no
states used in UDP and UDPLite, this column may be left blank. Normally this can be one
of several values:

* .I  
  ESTABLISHED
  The socket has an established connection.
* .I  
  SYN_SENT
  The socket is actively attempting to establish a connection.
* .I  
  SYN_RECV
  A connection request has been received from the network.
* .I  
  FIN_WAIT1
  The socket is closed, and the connection is shutting down.
* .I  
  FIN_WAIT2
  Connection is closed, and the socket is waiting for a shutdown from the
  remote end.
* .I  
  TIME_WAIT
  The socket is waiting after close to handle packets still in the network.
* .I  
  CLOSE
  The socket is not being used.
* .I  
  CLOSE_WAIT
  The remote end has shut down, waiting for the socket to close.
* .I  
  LAST_ACK
  The remote end has shut down, and the socket is closed. Waiting for
  acknowledgement.
* .I  
  LISTEN
  The socket is listening for incoming connections.  Such sockets are 
  not included in the output unless you specify the 
  **--listening** (**-l**)
  or 
  **--all** (**-a**)
  option.
* .I  
  CLOSING
  Both sockets are shut down but we still don't have all our data
  sent.
* .I  
  UNKNOWN
  The state of the socket is unknown.

<a name="user"></a>

### User

The username or the user id (UID) of the owner of the socket.

<a name="pidprogram-name"></a>

### PID/Program name

Slash-separated pair of the process id (PID) and process name of the 
process that owns the socket.
**--program**
causes this column to be included.  You will also need
_superuser_
privileges to see this information on sockets you don't own.  This
identification information is not yet available for IPX sockets.

<a name="timer"></a>

### Timer

TCP timer associated with this socket. The format is timer(a/b/c). The timer is one of the following values:

* .I  
  off
  There is no timer set for this socket.
* .I  
  on
  The retransmission timer is active for the socket.
* .I  
  keepalive
  The keepalive timer is active for the socket.
* .I  
  timewait
  The connection is closing and the timewait timer is active for the socket.

The values in the brackets:

* .I  
  a
  Timer value.
* .I  
  b
  Number of retransmissions sent.
* .I  
  c
  Number of keepalives sent.


<a name="active-unix-domain-sockets"></a>

### Active UNIX domain Sockets


<a name="proto-"></a>

### "Proto" 

The protocol (usually unix) used by the socket.

<a name="refcnt"></a>

### RefCnt

The reference count (i.e. attached processes via this socket).

<a name="flags"></a>

### Flags

The flags displayed is SO_ACCEPTON (displayed as 
**ACC**),
SO_WAITDATA 
(**W**)
or SO_NOSPACE 
(**N**).
SO_ACCECPTON 
is used on unconnected sockets if their corresponding
processes are waiting for a connect request. The other flags are not
of normal interest.

<a name="type"></a>

### Type

There are several types of socket access:

* .I  
  SOCK_DGRAM
  The socket is used in Datagram (connectionless) mode.
* .I  
  SOCK_STREAM
  This is a stream (connection) socket.
* .I  
  SOCK_RAW
  The socket is used as a raw socket.
* .I  
  SOCK_RDM
  This one serves reliably-delivered messages.
* .I  
  SOCK_SEQPACKET
  This is a sequential packet socket.
* .I  
  SOCK_PACKET
  Raw interface access socket.
* .I  
  UNKNOWN
  Who ever knows what the future will bring us - just fill in here :-)


<a name="state"></a>

### State

This field will contain one of the following Keywords:

* _FREE_  
  The socket is not allocated
* _LISTENING_  
  The socket is listening for a connection request.  Such
  sockets are only included in the output if you specify the
  **--listening** (**-l**)
  or
  **--all** (**-a**)
  option.
* _CONNECTING_  
  The socket is about to establish a connection.
* _CONNECTED_  
  The socket is connected.
* _DISCONNECTING_  
  The socket is disconnecting.
* _(empty)_  
  The socket is not connected to another one.
* _UNKNOWN_  
  This state should never happen.

<a name="pidprogram-name"></a>

### PID/Program name

Process ID (PID) and process name of the process that has the socket open. 
More info available in
**Active Internet connections**
section written above.

<a name="path"></a>

### Path

This is the path name as which the corresponding processes attached
to the socket.


<a name="active-ipx-sockets"></a>

### Active IPX sockets

(this needs to be done by somebody who knows it)


<a name="active-netrom-sockets"></a>

### Active NET/ROM sockets

(this needs to be done by somebody who knows it)


<a name="active-ax25-sockets"></a>

### Active AX.25 sockets

(this needs to be done by somebody who knows it)



<a name="files"></a>

# Files

.ta
_/etc/services_
-- The services translation file

_/proc_
-- Mount point for the proc filesystem, which gives access to kernel 
status information via the following files.

_/proc/net/dev_
-- device information

_/proc/net/raw_
-- raw socket information

_/proc/net/tcp_
-- TCP socket information

_/proc/net/udp_
-- UDP socket information

_/proc/net/udplite_
-- UDPLite socket information

_/proc/net/igmp_
-- IGMP multicast information

_/proc/net/unix_
-- Unix domain socket information

_/proc/net/ipx_
-- IPX socket information

_/proc/net/ax25_
-- AX25 socket information

_/proc/net/appletalk_
-- DDP (appletalk) socket information

_/proc/net/nr_
-- NET/ROM socket information

_/proc/net/route_
-- IP routing information

_/proc/net/ax25_route_
-- AX25 routing information

_/proc/net/ipx_route_
-- IPX routing information

_/proc/net/nr_nodes_
-- NET/ROM nodelist

_/proc/net/nr_neigh_
-- NET/ROM neighbours

_/proc/net/ip_masquerade_
-- masqueraded connections

_/sys/kernel/debug/bluetooth/l2cap_
-- Bluetooth L2CAP information

_/sys/kernel/debug/bluetooth/rfcomm_
-- Bluetooth serial connections

_/proc/net/snmp_
-- statistics


<a name="see-also"></a>

# See Also

**route**(8),
**ifconfig**(8),
**iptables**(8),
**proc**(5)
**ss**(8)
**ip**(8)


<a name="bugs"></a>

# Bugs

Occasionally strange information may appear if a socket changes
as it is viewed. This is unlikely to occur.


<a name="authors"></a>

# Authors

The netstat user interface was written by Fred Baumgarten
&lt;[dc6iq@insu1.etec](mailto:dc6iq@insu1.etec).uni-karlsruhe.de&gt;, the man page basically
by Matt Welsh &lt;[mdw@tc.cornell](mailto:mdw@tc.cornell).edu&gt;. It was updated by
Alan Cox &lt;[Alan.Cox@linux.org](mailto:Alan.Cox@linux.org)&gt;, updated again by Tuan Hoang
&lt;[tqhoang@bigfoot.com](mailto:tqhoang@bigfoot.com)&gt;. The man page and the command included 
in the net-tools package is totally rewritten by Bernd Eckenfels 
&lt;[ecki@linux.de](mailto:ecki@linux.de)&gt;.  UDPLite options were added by Brian Micek
&lt;[bmicek@gmail.com](mailto:bmicek@gmail.com)&gt;
