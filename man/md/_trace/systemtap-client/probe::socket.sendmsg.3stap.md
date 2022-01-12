# probe::socket\&.send(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::socket.sendmsg - Message is currently being sent on a socket.

<a name="synopsis"></a>

# Synopsis

```


```
    socket.sendmsg 

<a name="values"></a>

# Values


_state_
Socket state value

_flags_
Socket flags value

_protocol_
Protocol value

_size_
Message size in bytes

_name_
Name of this probe

_type_
Socket type value

_family_
Protocol family value

<a name="context"></a>

# Context


The message sender

<a name="description"></a>

# Description


Fires at the beginning of sending a message on a socket via the
**sock\_sendmsg**
function

<a name="see-alson-"></a>

# See Also\N 

_tapset::socket_(3stap)
