# probe::socket\&.read(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::socket.read_iter - Receiving message via **sock\_read\_iter**

<a name="synopsis"></a>

# Synopsis

```


```
    socket.read_iter 

<a name="values"></a>

# Values


_family_
Protocol family value

_type_
Socket type value

_protocol_
Protocol value

_name_
Name of this probe

_size_
Message size in bytes

_state_
Socket state value

_flags_
Socket flags value

<a name="context"></a>

# Context


The message sender

<a name="description"></a>

# Description


Fires at the beginning of receiving a message on a socket via the
**sock\_read\_iter**
function

<a name="see-alson-"></a>

# See Also\N 

_tapset::socket_(3stap)
