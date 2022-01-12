# probe::tcpmib\&.curr(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::tcpmib.CurrEstab - Update the count of open sockets

<a name="synopsis"></a>

# Synopsis

```


```
    tcpmib.CurrEstab 

<a name="values"></a>

# Values


_sk_
pointer to the struct sock being acted on

_op_
value to be added to the counter (default value of 1)

<a name="description"></a>

# Description


The packet pointed to by
_skb_
is filtered by the function
**tcpmib\_filter\_key**. If the packet passes the filter is is counted in the global
_CurrEstab_
(equivalent to SNMPs MIB TCP_MIB_CURRESTAB)

<a name="see-alson-"></a>

# See Also\N 

_tapset::tcpmib_(3stap)
