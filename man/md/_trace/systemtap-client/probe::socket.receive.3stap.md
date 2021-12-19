# probe::socket\&.rece(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::socket.receive - Message received on a socket.

<a name="synopsis"></a>

# Synopsis

```


```
    socket.receive 

<a name="values"></a>

# Values


_state_
Socket state value

_flags_
Socket flags value

_type_
Socket type value

_protocol_
Protocol value

_name_
Name of this probe

_size_
Size of message received (in bytes) or error code if success = 0

_success_
Was send successful? (1 = yes, 0 = no)

_family_
Protocol family value

<a name="context"></a>

# Context


The message receiver

<a name="see-alson-"></a>

# See Also\N 

_tapset::socket_(3stap)
