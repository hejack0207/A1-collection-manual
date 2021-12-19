# probe::socket\&.send(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::socket.send - Message sent on a socket.

<a name="synopsis"></a>

# Synopsis

```


```
    socket.send 

<a name="values"></a>

# Values


_family_
Protocol family value

_success_
Was send successful? (1 = yes, 0 = no)

_protocol_
Protocol value

_size_
Size of message sent (in bytes) or error code if success = 0

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


The message sender

<a name="see-alson-"></a>

# See Also\N 

_tapset::socket_(3stap)
