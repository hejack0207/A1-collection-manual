# probe::linuxmib\&.li(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::linuxmib.ListenOverflows - Count of times a listen queue overflowed

<a name="synopsis"></a>

# Synopsis

```


```
    linuxmib.ListenOverflows 

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
_ListenOverflows_
(equivalent to SNMPs MIB LINUX_MIB_LISTENOVERFLOWS)

<a name="see-alson-"></a>

# See Also\N 

_tapset::linuxmib_(3stap)
