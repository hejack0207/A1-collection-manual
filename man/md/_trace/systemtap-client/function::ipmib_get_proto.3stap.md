# function::ipmib_get_(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::ipmib_get_proto - Get the protocol value

<a name="synopsis"></a>

# Synopsis

```


```
        ipmib_get_proto:long(skb:long)

<a name="arguments"></a>

# Arguments


_skb_
pointer to a struct sk_buff

<a name="description"></a>

# Description


Returns the protocol value from
_skb_.

<a name="see-alson-"></a>

# See Also\N 

_tapset::ipmib_(3stap)
