# function::linuxmib_f(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::linuxmib_filter_key - Default filter function for linuxmib.* probes

<a name="synopsis"></a>

# Synopsis

```


```
        linuxmib_filter_key:long(sk:long,op:long)

<a name="arguments"></a>

# Arguments


_sk_
pointer to the struct sock

_op_
value to be counted if
_sk_
passes the filter

<a name="description"></a>

# Description


This function is a default filter function. The user can replace this function with their own. The user-supplied filter function returns an index key based on the values in
_sk_. A return value of 0 means this particular
_sk_
should be not be counted.

<a name="see-alson-"></a>

# See Also\N 

_tapset::linuxmib-filter-default_(3stap)
