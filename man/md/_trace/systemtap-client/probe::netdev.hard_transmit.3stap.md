# probe::netdev\&.hard(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::netdev.hard_transmit - Called when the devices is going to TX (hard)

<a name="synopsis"></a>

# Synopsis

```


```
    netdev.hard_transmit 

<a name="values"></a>

# Values


_length_
The length of the transmit buffer.

_truesize_
The size of the data to be transmitted.

_protocol_
The protocol used in the transmission

_dev\_name_
The device scheduled to transmit

<a name="see-alson-"></a>

# See Also\N 

_tapset::networking_(3stap)
