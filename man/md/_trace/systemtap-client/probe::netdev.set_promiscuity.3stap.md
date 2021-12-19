# probe::netdev\&.set_(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::netdev.set_promiscuity - Called when the device enters/leaves promiscuity

<a name="synopsis"></a>

# Synopsis

```


```
    netdev.set_promiscuity 

<a name="values"></a>

# Values


_enable_
If the device is entering promiscuity mode

_inc_
Count the number of promiscuity openers

_disable_
If the device is leaving promiscuity mode

_dev\_name_
The device that is entering/leaving promiscuity mode

<a name="see-alson-"></a>

# See Also\N 

_tapset::networking_(3stap)
