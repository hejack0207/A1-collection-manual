# function::atomic_rea(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::atomic_read - Retrieves an atomic variable from kernel memory

<a name="synopsis"></a>

# Synopsis

```


```
        atomic_read:long(addr:long)

<a name="arguments"></a>

# Arguments


_addr_
pointer to atomic variable

<a name="description"></a>

# Description


Safely perform the read of an atomic variable.

<a name="see-alson-"></a>

# See Also\N 

_tapset::atomic_(3stap)
