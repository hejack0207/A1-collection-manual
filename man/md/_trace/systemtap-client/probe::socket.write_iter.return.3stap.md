# probe::socket\&.writ(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::socket.write_iter.return - Conclusion of message send via **sock\_write\_iter**

<a name="synopsis"></a>

# Synopsis

```


```
    socket.write_iter.return 

<a name="values"></a>

# Values


_flags_
Socket flags value

_state_
Socket state value

_protocol_
Protocol value

_size_
Size of message received (in bytes) or error code if success = 0

_name_
Name of this probe

_type_
Socket type value

_family_
Protocol family value

_success_
Was receive successful? (1 = yes, 0 = no)

<a name="context"></a>

# Context


The message receiver.

<a name="description"></a>

# Description


Fires at the conclusion of sending a message on a socket via the
**sock\_write\_iter**
function

<a name="see-alson-"></a>

# See Also\N 

_tapset::socket_(3stap)
