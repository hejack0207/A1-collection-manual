# probe::stapio\&.rece(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::stapio.receive_control_message - Received a control message

<a name="synopsis"></a>

# Synopsis

```


```
    stapio.receive_control_message 

<a name="values"></a>

# Values


_data_
a ptr to a binary blob of data sent as the control message

_len_
the length (in bytes) of the data blob

_type_
type of message being send; defined in runtime/transport/transport_msgs.h

<a name="description"></a>

# Description


Fires just after a message was receieved and before its processed.

<a name="see-alson-"></a>

# See Also\N 

_tapset::stap_staticmarkers_(3stap)
