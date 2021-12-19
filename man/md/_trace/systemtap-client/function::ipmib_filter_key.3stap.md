# function::ipmib_filt(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::ipmib_filter_key - Default filter function for ipmib.* probes

<a name="synopsis"></a>

# Synopsis

```


```
        ipmib_filter_key:long(skb:long,op:long,SourceIsLocal:long)

<a name="arguments"></a>

# Arguments


_skb_
pointer to the struct sk_buff

_op_
value to be counted if
_skb_
passes the filter

_SourceIsLocal_
1 is local operation and 0 is non-local operation

<a name="description"></a>

# Description


This function is a default filter function. The user can replace this function with their own. The user-supplied filter function returns an index key based on the values in
_skb_. A return value of 0 means this particular
_skb_
should be not be counted.

<a name="see-alson-"></a>

# See Also\N 

_tapset::ipmib-filter-default_(3stap)
