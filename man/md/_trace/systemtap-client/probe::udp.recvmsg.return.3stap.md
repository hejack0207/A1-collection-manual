# probe::udp\&.recvmsg(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::udp.recvmsg.return - Fires whenever an attempt to receive a UDP message received is completed

<a name="synopsis"></a>

# Synopsis

```


```
    udp.recvmsg.return 

<a name="values"></a>

# Values


_size_
Number of bytes received by the process

_name_
The name of this probe

_sport_
UDP source port

_dport_
UDP destination port

_family_
IP address family

_daddr_
A string representing the destination IP address

_saddr_
A string representing the source IP address

<a name="context"></a>

# Context


The process which received a UDP message

<a name="see-alson-"></a>

# See Also\N 

_tapset::udp_(3stap)
