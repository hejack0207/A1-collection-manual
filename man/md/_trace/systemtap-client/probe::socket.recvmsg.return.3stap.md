# probe::socket\&.recv(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::socket.recvmsg.return - Return from Message being received on socket

<a name="synopsis"></a>

# Synopsis

```


```
    socket.recvmsg.return 

<a name="values"></a>

# Values


_family_
Protocol family value

_success_
Was receive successful? (1 = yes, 0 = no)

_protocol_
Protocol value

_name_
Name of this probe

_size_
Size of message received (in bytes) or error code if success = 0

_type_
Socket type value

_state_
Socket state value

_flags_
Socket flags value

<a name="context"></a>

# Context


The message receiver.

<a name="description"></a>

# Description


Fires at the conclusion of receiving a message on a socket via the
**sock\_recvmsg**
function.

<a name="see-alson-"></a>

# See Also\N 

_tapset::socket_(3stap)
