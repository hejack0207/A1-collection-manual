# probe::netfilter\&.b(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::netfilter.bridge.local_in - Called on a bridging packet destined for the local computer

<a name="synopsis"></a>

# Synopsis

```


```
    netfilter.bridge.local_in 

<a name="values"></a>

# Values


_br\_rid_
Identity of root bridge

_pf_
Protocol family -- always
“bridge”

_br\_cost_
Total cost from transmitting bridge to root

_br\_mac_
Bridge MAC address

_br\_prid_
Protocol identifier

_nf\_stop_
Constant used to signify a stop\*(Aq verdict

_br\_poid_
Port identifier

_br\_type_
BPDU type

_nf\_drop_
Constant used to signify a drop\*(Aq verdict

_data\_hex_
A hexadecimal string representing the packet buffer contents

_data\_str_
A string representing the packet buffer contents

_br\_bid_
Identity of bridge

_nf\_repeat_
Constant used to signify a repeat\*(Aq verdict

_brhdr_
Address of bridge header

_br\_rmac_
Root bridge MAC address

_nf\_stolen_
Constant used to signify a stolen\*(Aq verdict

_length_
The length of the packet buffer contents, in bytes

_br\_vid_
Protocol version identifier

_br\_fd_
Forward delay in 1/256 secs

_br\_msg_
Message age in 1/256 secs

_nf\_queue_
Constant used to signify a queue\*(Aq verdict

_br\_max_
Max age in 1/256 secs

_outdev\_name_
Name of network device packet will be routed to (if known)

_indev_
Address of net_device representing input device, 0 if unknown

_llcpdu_
Address of LLC Protocol Data Unit

_nf\_accept_
Constant used to signify an accept\*(Aq verdict

_br\_flags_
BPDU flags

_outdev_
Address of net_device representing output device, 0 if unknown

_protocol_
Packet protocol

_indev\_name_
Name of network device packet was received on (if known)

_br\_htime_
Hello time in 1/256 secs

_llcproto\_stp_
Constant used to signify Bridge Spanning Tree Protocol packet

<a name="see-alson-"></a>

# See Also\N 

_tapset::netfilter_(3stap)
