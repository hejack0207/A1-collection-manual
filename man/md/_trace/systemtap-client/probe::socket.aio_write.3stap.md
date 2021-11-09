# probe::socket\&.aio_(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::socket.aio_write - Message send via **sock\_aio\_write**

<a name="synopsis"></a>

# Synopsis

```


```
    socket.aio_write 

<a name="values"></a>

# Values


_family_
Protocol family value

_protocol_
Protocol value

_size_
Message size in bytes

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

<a name="description"></a>

# Description


Fires at the beginning of sending a message on a socket via the
**sock\_aio\_write**
function

<a name="see-alson-"></a>

# See Also\N 

_tapset::socket_(3stap)
