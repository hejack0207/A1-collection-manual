# probe::tcp\&.recvmsg(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::tcp.recvmsg - Receiving TCP message

<a name="synopsis"></a>

# Synopsis

```


```
    tcp.recvmsg 

<a name="values"></a>

# Values


_name_
Name of this probe

_sport_
TCP source port

_size_
Number of bytes to be received

_sock_
Network socket

_daddr_
A string representing the destination IP address

_family_
IP address family

_dport_
TCP destination port

_saddr_
A string representing the source IP address

<a name="context"></a>

# Context


The process which receives a tcp message

<a name="see-alson-"></a>

# See Also\N 

_tapset::tcp_(3stap)
