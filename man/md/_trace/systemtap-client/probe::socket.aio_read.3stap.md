# probe::socket\&.aio_(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::socket.aio_read - Receiving message via **sock\_aio\_read**

<a name="synopsis"></a>

# Synopsis

```


```
    socket.aio_read 

<a name="values"></a>

# Values


_flags_
Socket flags value

_state_
Socket state value

_family_
Protocol family value

_name_
Name of this probe

_protocol_
Protocol value

_size_
Message size in bytes

_type_
Socket type value

<a name="context"></a>

# Context


The message sender

<a name="description"></a>

# Description


Fires at the beginning of receiving a message on a socket via the
**sock\_aio\_read**
function

<a name="see-alson-"></a>

# See Also\N 

_tapset::socket_(3stap)
