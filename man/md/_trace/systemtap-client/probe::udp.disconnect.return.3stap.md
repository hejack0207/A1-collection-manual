# probe::udp\&.disconn(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::udp.disconnect.return - UDP has been disconnected successfully

<a name="synopsis"></a>

# Synopsis

```


```
    udp.disconnect.return 

<a name="values"></a>

# Values


_saddr_
A string representing the source IP address

_daddr_
A string representing the destination IP address

_family_
IP address family

_name_
The name of this probe

_dport_
UDP destination port

_sport_
UDP source port

_ret_
Error code (0: no error)

<a name="context"></a>

# Context


The process which requested a UDP disconnection

<a name="see-alson-"></a>

# See Also\N 

_tapset::udp_(3stap)
