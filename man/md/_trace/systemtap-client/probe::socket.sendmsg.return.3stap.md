# probe::socket\&.send(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::socket.sendmsg.return - Return from socket.sendmsg.

<a name="synopsis"></a>

# Synopsis

```


```
    socket.sendmsg.return 

<a name="values"></a>

# Values


_type_
Socket type value

_size_
Size of message sent (in bytes) or error code if success = 0

_protocol_
Protocol value

_name_
Name of this probe

_success_
Was send successful? (1 = yes, 0 = no)

_family_
Protocol family value

_state_
Socket state value

_flags_
Socket flags value

<a name="context"></a>

# Context


The message sender.

<a name="description"></a>

# Description


Fires at the conclusion of sending a message on a socket via the
**sock\_sendmsg**
function

<a name="see-alson-"></a>

# See Also\N 

_tapset::socket_(3stap)
