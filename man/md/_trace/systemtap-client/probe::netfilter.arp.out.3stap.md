# probe::netfilter\&.a(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::netfilter.arp.out - - Called for each outgoing ARP packet

<a name="synopsis"></a>

# Synopsis

```


```
    netfilter.arp.out 

<a name="values"></a>

# Values


_indev\_name_
Name of network device packet was received on (if known)

_ar\_tip_
Ethernet+IP only (ar_pro==0x800): target IP address

_outdev_
Address of net_device representing output device, 0 if unknown

_ar\_data_
Address of ARP packet data region (after the header)

_nf\_accept_
Constant used to signify an accept\*(Aq verdict

_ar\_hrd_
Format of hardware address

_indev_
Address of net_device representing input device, 0 if unknown

_outdev\_name_
Name of network device packet will be routed to (if known)

_nf\_queue_
Constant used to signify a queue\*(Aq verdict

_ar\_sip_
Ethernet+IP only (ar_pro==0x800): source IP address

_length_
The length of the packet buffer contents, in bytes

_nf\_stolen_
Constant used to signify a stolen\*(Aq verdict

_ar\_pro_
Format of protocol address

_nf\_repeat_
Constant used to signify a repeat\*(Aq verdict

_data\_str_
A string representing the packet buffer contents

_ar\_tha_
Ethernet+IP only (ar_pro==0x800): target hardware (MAC) address

_data\_hex_
A hexadecimal string representing the packet buffer contents

_nf\_drop_
Constant used to signify a drop\*(Aq verdict

_ar\_sha_
Ethernet+IP only (ar_pro==0x800): source hardware (MAC) address

_nf\_stop_
Constant used to signify a stop\*(Aq verdict

_ar\_hln_
Length of hardware address

_arphdr_
Address of ARP header

_ar\_pln_
Length of protocol address

_pf_
Protocol family -- always
“arp”

_ar\_op_
ARP opcode (command)

<a name="see-alson-"></a>

# See Also\N 

_tapset::netfilter_(3stap)
