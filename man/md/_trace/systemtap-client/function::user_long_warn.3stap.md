# function::user_long_(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::user_long_warn - Retrieves a long value stored in user space

<a name="synopsis"></a>

# Synopsis

```


```
        user_long_warn:long(addr:long)

<a name="arguments"></a>

# Arguments


_addr_
the user space address to retrieve the long from

<a name="description"></a>

# Description


Returns the long value from a given user space address. Returns zero when user space data is not accessible and warns about the failure (but does not error). Note that the size of the long depends on the architecture of the current user space task (for those architectures that support both 64/32 bit compat tasks).

<a name="see-alson-"></a>

# See Also\N 

_tapset::uconversions_(3stap)
