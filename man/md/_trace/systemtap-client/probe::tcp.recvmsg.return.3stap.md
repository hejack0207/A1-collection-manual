# probe::tcp\&.recvmsg(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::tcp.recvmsg.return - Receiving TCP message complete

<a name="synopsis"></a>

# Synopsis

```


```
    tcp.recvmsg.return 

<a name="values"></a>

# Values


_daddr_
A string representing the destination IP address

_sport_
TCP source port

_size_
Number of bytes received or error code if an error occurred.

_name_
Name of this probe

_saddr_
A string representing the source IP address

_dport_
TCP destination port

_family_
IP address family

<a name="context"></a>

# Context


The process which receives a tcp message

<a name="see-alson-"></a>

# See Also\N 

_tapset::tcp_(3stap)
