# probe::netdev\&.rece(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::netdev.receive - Data received from network device.

<a name="synopsis"></a>

# Synopsis

```


```
    netdev.receive 

<a name="values"></a>

# Values


_length_
The length of the receiving buffer.

_dev\_name_
The name of the device. e.g: eth0, ath1.

_protocol_
Protocol of received packet.

<a name="see-alson-"></a>

# See Also\N 

_tapset::networking_(3stap)
