# probe::socket\&.read(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::socket.readv.return - Conclusion of receiving a message via **sock\_readv**

<a name="synopsis"></a>

# Synopsis

```


```
    socket.readv.return 

<a name="values"></a>

# Values


_state_
Socket state value

_flags_
Socket flags value

_success_
Was receive successful? (1 = yes, 0 = no)

_family_
Protocol family value

_type_
Socket type value

_name_
Name of this probe

_protocol_
Protocol value

_size_
Size of message received (in bytes) or error code if success = 0

<a name="context"></a>

# Context


The message receiver.

<a name="description"></a>

# Description


Fires at the conclusion of receiving a message on a socket via the
**sock\_readv**
function

<a name="see-alson-"></a>

# See Also\N 

_tapset::socket_(3stap)
