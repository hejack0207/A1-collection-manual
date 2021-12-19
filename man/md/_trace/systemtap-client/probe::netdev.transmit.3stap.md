# probe::netdev\&.tran(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::netdev.transmit - Network device transmitting buffer

<a name="synopsis"></a>

# Synopsis

```


```
    netdev.transmit 

<a name="values"></a>

# Values


_length_
The length of the transmit buffer.

_dev\_name_
The name of the device. e.g: eth0, ath1.

_truesize_
The size of the data to be transmitted.

_protocol_
The protocol of this packet(defined in include/linux/if_ether.h).

<a name="see-alson-"></a>

# See Also\N 

_tapset::networking_(3stap)
