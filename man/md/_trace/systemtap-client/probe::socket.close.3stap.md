# probe::socket\&.clos(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::socket.close - Close a socket

<a name="synopsis"></a>

# Synopsis

```


```
    socket.close 

<a name="values"></a>

# Values


_family_
Protocol family value

_protocol_
Protocol value

_name_
Name of this probe

_type_
Socket type value

_flags_
Socket flags value

_state_
Socket state value

<a name="context"></a>

# Context


The requester (user process or kernel)

<a name="description"></a>

# Description


Fires at the beginning of closing a socket.

<a name="see-alson-"></a>

# See Also\N 

_tapset::socket_(3stap)
