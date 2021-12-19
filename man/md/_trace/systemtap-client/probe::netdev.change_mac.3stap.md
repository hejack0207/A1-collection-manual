# probe::netdev\&.chan(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::netdev.change_mac - Called when the netdev_name has the MAC changed

<a name="synopsis"></a>

# Synopsis

```


```
    netdev.change_mac 

<a name="values"></a>

# Values


_new\_mac_
The new MAC address

_mac\_len_
The MAC length

_dev\_name_
The device that will have the MAC changed

_old\_mac_
The current MAC address

<a name="see-alson-"></a>

# See Also\N 

_tapset::networking_(3stap)
