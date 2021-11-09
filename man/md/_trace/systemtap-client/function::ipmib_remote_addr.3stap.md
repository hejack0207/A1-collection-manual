# function::ipmib_remo(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::ipmib_remote_addr - Get the remote ip address

<a name="synopsis"></a>

# Synopsis

```


```
        ipmib_remote_addr:long(skb:long,SourceIsLocal:long)

<a name="arguments"></a>

# Arguments


_skb_
pointer to a struct sk_buff

_SourceIsLocal_
flag to indicate whether local operation

<a name="description"></a>

# Description


Returns the remote ip address from
_skb_.

<a name="see-alson-"></a>

# See Also\N 

_tapset::ipmib_(3stap)
