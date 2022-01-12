# probe::tcp\&.receive(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::tcp.receive - Called when a TCP packet is received

<a name="synopsis"></a>

# Synopsis

```


```
    tcp.receive 

<a name="values"></a>

# Values


_urg_
TCP URG flag

_name_
Name of the probe point

_ack_
TCP ACK flag

_sport_
TCP source port

_protocol_
Packet protocol from driver

_psh_
TCP PSH flag

_dport_
TCP destination port

_rst_
TCP RST flag

_daddr_
A string representing the destination IP address

_syn_
TCP SYN flag

_fin_
TCP FIN flag

_iphdr_
IP header address

_saddr_
A string representing the source IP address

_family_
IP address family

<a name="see-alson-"></a>

# See Also\N 

_tapset::tcp_(3stap)
