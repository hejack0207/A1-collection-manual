# function::atomic_lon(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::atomic_long_read - Retrieves an atomic long variable from kernel memory

<a name="synopsis"></a>

# Synopsis

```


```
        atomic_long_read:long(addr:long)

<a name="arguments"></a>

# Arguments


_addr_
pointer to atomic long variable

<a name="description"></a>

# Description


Safely perform the read of an atomic long variable. This will be a NOP on kernels that do not have ATOMIC_LONG_INIT set on the kernel config.

<a name="see-alson-"></a>

# See Also\N 

_tapset::atomic_(3stap)
