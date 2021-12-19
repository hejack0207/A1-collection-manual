# probe::linuxmib\&.tc(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::linuxmib.TCPMemoryPressures - Count of times memory pressure was used

<a name="synopsis"></a>

# Synopsis

```


```
    linuxmib.TCPMemoryPressures 

<a name="values"></a>

# Values


_op_
Value to be added to the counter (default value of 1)

_sk_
Pointer to the struct sock being acted on

<a name="description"></a>

# Description


The packet pointed to by
_skb_
is filtered by the function
**linuxmib\_filter\_key**. If the packet passes the filter is is counted in the global
_TCPMemoryPressures_
(equivalent to SNMPs MIB LINUX_MIB_TCPMEMORYPRESSURES)

<a name="see-alson-"></a>

# See Also\N 

_tapset::linuxmib_(3stap)
