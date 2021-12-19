# probe::socket\&.crea(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::socket.create.return - Return from Creation of a socket

<a name="synopsis"></a>

# Synopsis

```


```
    socket.create.return 

<a name="values"></a>

# Values


_type_
Socket type value

_protocol_
Protocol value

_name_
Name of this probe

_requester_
Requested by user process or the kernel (1 = kernel, 0 = user)

_success_
Was socket creation successful? (1 = yes, 0 = no)

_family_
Protocol family value

_err_
Error code if success == 0

<a name="context"></a>

# Context


The requester (user process or kernel)

<a name="description"></a>

# Description


Fires at the conclusion of creating a socket.

<a name="see-alson-"></a>

# See Also\N 

_tapset::socket_(3stap)
