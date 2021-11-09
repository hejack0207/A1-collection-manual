# probe::socket\&.writ(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::socket.writev - Message sent via **socket\_writev**

<a name="synopsis"></a>

# Synopsis

```


```
    socket.writev 

<a name="values"></a>

# Values


_size_
Message size in bytes

_protocol_
Protocol value

_name_
Name of this probe

_type_
Socket type value

_family_
Protocol family value

_state_
Socket state value

_flags_
Socket flags value

<a name="context"></a>

# Context


The message sender

<a name="description"></a>

# Description


Fires at the beginning of sending a message on a socket via the
**sock\_writev**
function

<a name="see-alson-"></a>

# See Also\N 

_tapset::socket_(3stap)
