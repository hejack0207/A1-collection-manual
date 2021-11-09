# probe::udp\&.sendmsg(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::udp.sendmsg.return - Fires whenever an attempt to send a UDP message is completed

<a name="synopsis"></a>

# Synopsis

```


```
    udp.sendmsg.return 

<a name="values"></a>

# Values


_name_
The name of this probe

_size_
Number of bytes sent by the process

<a name="context"></a>

# Context


The process which sent a UDP message

<a name="see-alson-"></a>

# See Also\N 

_tapset::udp_(3stap)
