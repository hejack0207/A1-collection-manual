# function::tcpmib_get(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::tcpmib_get_state - Get a sockets state

<a name="synopsis"></a>

# Synopsis

```


```
        tcpmib_get_state:long(sk:long)

<a name="arguments"></a>

# Arguments


_sk_
pointer to a struct sock

<a name="description"></a>

# Description


Returns the sk_state from a struct sock.

<a name="see-alson-"></a>

# See Also\N 

_tapset::tcpmib_(3stap)
