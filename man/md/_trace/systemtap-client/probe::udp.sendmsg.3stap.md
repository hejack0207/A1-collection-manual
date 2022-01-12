# probe::udp\&.sendmsg(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::udp.sendmsg - Fires whenever a process sends a UDP message

<a name="synopsis"></a>

# Synopsis

```


```
    udp.sendmsg 

<a name="values"></a>

# Values


_daddr_
A string representing the destination IP address

_family_
IP address family

_saddr_
A string representing the source IP address

_sock_
Network socket used by the process

_sport_
UDP source port

_dport_
UDP destination port

_size_
Number of bytes sent by the process

_name_
The name of this probe

<a name="context"></a>

# Context


The process which sent a UDP message

<a name="see-alson-"></a>

# See Also\N 

_tapset::udp_(3stap)
