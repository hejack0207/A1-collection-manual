# probe::socket\&.recv(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::socket.recvmsg - Message being received on socket

<a name="synopsis"></a>

# Synopsis

```


```
    socket.recvmsg 

<a name="values"></a>

# Values


_state_
Socket state value

_flags_
Socket flags value

_family_
Protocol family value

_type_
Socket type value

_size_
Message size in bytes

_protocol_
Protocol value

_name_
Name of this probe

<a name="context"></a>

# Context


The message receiver.

<a name="description"></a>

# Description


Fires at the beginning of receiving a message on a socket via the
**sock\_recvmsg**
function

<a name="see-alson-"></a>

# See Also\N 

_tapset::socket_(3stap)
