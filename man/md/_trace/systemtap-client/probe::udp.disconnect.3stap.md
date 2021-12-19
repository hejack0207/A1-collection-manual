# probe::udp\&.disconn(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::udp.disconnect - Fires when a process requests for a UDP disconnection

<a name="synopsis"></a>

# Synopsis

```


```
    udp.disconnect 

<a name="values"></a>

# Values


_flags_
Flags (e.g. FIN, etc)

_name_
The name of this probe

_sport_
UDP source port

_dport_
UDP destination port

_sock_
Network socket used by the process

_family_
IP address family

_daddr_
A string representing the destination IP address

_saddr_
A string representing the source IP address

<a name="context"></a>

# Context


The process which requests a UDP disconnection

<a name="see-alson-"></a>

# See Also\N 

_tapset::udp_(3stap)
