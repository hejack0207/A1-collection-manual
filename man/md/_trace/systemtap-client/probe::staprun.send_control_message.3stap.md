# probe::staprun\&.sen(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::staprun.send_control_message - Sending a control message

<a name="synopsis"></a>

# Synopsis

```


```
    staprun.send_control_message 

<a name="values"></a>

# Values


_type_
type of message being send; defined in runtime/transport/transport_msgs.h

_data_
a ptr to a binary blob of data sent as the control message

_len_
the length (in bytes) of the data blob

<a name="description"></a>

# Description


Fires at the beginning of the send_request function.

<a name="see-alson-"></a>

# See Also\N 

_tapset::stap_staticmarkers_(3stap)
