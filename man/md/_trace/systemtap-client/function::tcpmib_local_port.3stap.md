# function::tcpmib_loc(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::tcpmib_local_port - Get the local port

<a name="synopsis"></a>

# Synopsis

```


```
        tcpmib_local_port:long(sk:long)

<a name="arguments"></a>

# Arguments


_sk_
pointer to a struct inet_sock

<a name="description"></a>

# Description


Returns the sport from a struct inet_sock in host order.

<a name="see-alson-"></a>

# See Also\N 

_tapset::tcpmib_(3stap)
