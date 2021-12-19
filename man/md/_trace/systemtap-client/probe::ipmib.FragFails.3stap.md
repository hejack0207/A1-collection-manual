# probe::ipmib\&.fragf(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::ipmib.FragFails - Count datagram fragmented unsuccessfully

<a name="synopsis"></a>

# Synopsis

```


```
    ipmib.FragFails 

<a name="values"></a>

# Values


_op_
Value to be added to the counter (default value of 1)

_skb_
pointer to the struct sk_buff being acted on

<a name="description"></a>

# Description


The packet pointed to by
_skb_
is filtered by the function
**ipmib\_filter\_key**. If the packet passes the filter is is counted in the global
_FragFails_
(equivalent to SNMPs MIB IPSTATS_MIB_FRAGFAILS)

<a name="see-alson-"></a>

# See Also\N 

_tapset::ipmib_(3stap)
