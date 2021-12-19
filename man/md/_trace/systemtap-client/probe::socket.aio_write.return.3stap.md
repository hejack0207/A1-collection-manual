# probe::socket\&.aio_(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::socket.aio_write.return - Conclusion of message send via **sock\_aio\_write**

<a name="synopsis"></a>

# Synopsis

```


```
    socket.aio_write.return 

<a name="values"></a>

# Values


_type_
Socket type value

_protocol_
Protocol value

_size_
Size of message received (in bytes) or error code if success = 0

_name_
Name of this probe

_success_
Was receive successful? (1 = yes, 0 = no)

_family_
Protocol family value

_state_
Socket state value

_flags_
Socket flags value

<a name="context"></a>

# Context


The message receiver.

<a name="description"></a>

# Description


Fires at the conclusion of sending a message on a socket via the
**sock\_aio\_write**
function

<a name="see-alson-"></a>

# See Also\N 

_tapset::socket_(3stap)
