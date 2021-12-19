# probe::tcp\&.setsock(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::tcp.setsockopt - Call to **setsockopt**

<a name="synopsis"></a>

# Synopsis

```


```
    tcp.setsockopt 

<a name="values"></a>

# Values


_family_
IP address family

_sock_
Network socket

_optname_
TCP socket options (e.g. TCP_NODELAY, TCP_MAXSEG, etc)

_name_
Name of this probe

_level_
The level at which the socket options will be manipulated

_optstr_
Resolves optname to a human-readable format

_optlen_
Used to access values for
**setsockopt**

<a name="context"></a>

# Context


The process which calls setsockopt

<a name="see-alson-"></a>

# See Also\N 

_tapset::tcp_(3stap)
