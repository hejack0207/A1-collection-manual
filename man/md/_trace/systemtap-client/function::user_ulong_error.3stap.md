# function::user_ulong(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::user_ulong_error - Retrieves a unsigned long value stored in user space

<a name="synopsis"></a>

# Synopsis

```


```
        user_ulong_error:long(addr:long)

<a name="arguments"></a>

# Arguments


_addr_
the user space address to retrieve the unsigned long from

<a name="description"></a>

# Description


Returns the unsigned long value from a given user space address. If the user space data is not accessible, an error will occur. Note that the size of the unsigned long depends on the architecture of the current user space task (for those architectures that support both 64/32 bit compat tasks).

<a name="see-alson-"></a>

# See Also\N 

_tapset::uconversions_(3stap)
