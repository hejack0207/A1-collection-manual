# probe::netfilter\&.i(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::netfilter.ip.local_in - Called on an incoming IP packet addressed to the local computer

<a name="synopsis"></a>

# Synopsis

```


```
    netfilter.ip.local_in 

<a name="values"></a>

# Values


_rst_
TCP RST flag (if protocol is TCP; ipv4 only)

_pf_
Protocol family -- either
“ipv4”
or
“ipv6”

_nf\_stop_
Constant used to signify a stop\*(Aq verdict

_saddr_
A string representing the source IP address

_family_
IP address family

_nf\_drop_
Constant used to signify a drop\*(Aq verdict

_data\_hex_
A hexadecimal string representing the packet buffer contents

_data\_str_
A string representing the packet buffer contents

_nf\_repeat_
Constant used to signify a repeat\*(Aq verdict

_nf\_stolen_
Constant used to signify a stolen\*(Aq verdict

_dport_
TCP or UDP destination port (ipv4 only)

_psh_
TCP PSH flag (if protocol is TCP; ipv4 only)

_ipproto\_udp_
Constant used to signify that the packet protocol is UDP

_fin_
TCP FIN flag (if protocol is TCP; ipv4 only)

_length_
The length of the packet buffer contents, in bytes

_ack_
TCP ACK flag (if protocol is TCP; ipv4 only)

_sport_
TCP or UDP source port (ipv4 only)

_nf\_queue_
Constant used to signify a queue\*(Aq verdict

_outdev\_name_
Name of network device packet will be routed to (if known)

_iphdr_
Address of IP header

_urg_
TCP URG flag (if protocol is TCP; ipv4 only)

_indev_
Address of net_device representing input device, 0 if unknown

_ipproto\_tcp_
Constant used to signify that the packet protocol is TCP

_nf\_accept_
Constant used to signify an accept\*(Aq verdict

_syn_
TCP SYN flag (if protocol is TCP; ipv4 only)

_outdev_
Address of net_device representing output device, 0 if unknown

_protocol_
Packet protocol from driver (ipv4 only)

_indev\_name_
Name of network device packet was received on (if known)

_daddr_
A string representing the destination IP address

<a name="see-alson-"></a>

# See Also\N 

_tapset::netfilter_(3stap)
