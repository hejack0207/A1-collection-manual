# probe::tcp\&.disconn(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::tcp.disconnect - TCP socket disconnection

<a name="synopsis"></a>

# Synopsis

```


```
    tcp.disconnect 

<a name="values"></a>

# Values


_dport_
TCP destination port

_family_
IP address family

_saddr_
A string representing the source IP address

_flags_
TCP flags (e.g. FIN, etc)

_sport_
TCP source port

_sock_
Network socket

_name_
Name of this probe

_daddr_
A string representing the destination IP address

<a name="context"></a>

# Context


The process which disconnects tcp

<a name="see-alson-"></a>

# See Also\N 

_tapset::tcp_(3stap)
