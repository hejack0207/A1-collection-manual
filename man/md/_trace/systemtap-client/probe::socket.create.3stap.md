# probe::socket\&.crea(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::socket.create - Creation of a socket

<a name="synopsis"></a>

# Synopsis

```


```
    socket.create 

<a name="values"></a>

# Values


_family_
Protocol family value

_requester_
Requested by user process or the kernel (1 = kernel, 0 = user)

_type_
Socket type value

_protocol_
Protocol value

_name_
Name of this probe

<a name="context"></a>

# Context


The requester (see requester variable)

<a name="description"></a>

# Description


Fires at the beginning of creating a socket.

<a name="see-alson-"></a>

# See Also\N 

_tapset::socket_(3stap)
