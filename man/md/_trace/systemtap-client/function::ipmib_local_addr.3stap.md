# function::ipmib_loca(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::ipmib_local_addr - Get the local ip address

<a name="synopsis"></a>

# Synopsis

```


```
        ipmib_local_addr:long(skb:long,SourceIsLocal:long)

<a name="arguments"></a>

# Arguments


_skb_
pointer to a struct sk_buff

_SourceIsLocal_
flag to indicate whether local operation

<a name="description"></a>

# Description


Returns the local ip address
_skb_.

<a name="see-alson-"></a>

# See Also\N 

_tapset::ipmib_(3stap)
