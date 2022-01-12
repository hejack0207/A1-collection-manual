# probe::linuxmib\&.li(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::linuxmib.ListenDrops - Count of times conn request that were dropped

<a name="synopsis"></a>

# Synopsis

```


```
    linuxmib.ListenDrops 

<a name="values"></a>

# Values


_sk_
Pointer to the struct sock being acted on

_op_
Value to be added to the counter (default value of 1)

<a name="description"></a>

# Description


The packet pointed to by
_skb_
is filtered by the function
**linuxmib\_filter\_key**. If the packet passes the filter is is counted in the global
_ListenDrops_
(equivalent to SNMPs MIB LINUX_MIB_LISTENDROPS)

<a name="see-alson-"></a>

# See Also\N 

_tapset::linuxmib_(3stap)
