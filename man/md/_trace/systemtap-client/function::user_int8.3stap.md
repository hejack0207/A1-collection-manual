# function::user_int8(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::user_int8 - Retrieves a 8-bit integer value stored in user space

<a name="synopsis"></a>

# Synopsis

```


```
        user_int8:long(addr:long)

<a name="arguments"></a>

# Arguments


_addr_
the user space address to retrieve the 8-bit integer from

<a name="description"></a>

# Description


Returns the 8-bit integer value from a given user space address. Returns zero when user space data is not accessible.

<a name="see-alson-"></a>

# See Also\N 

_tapset::uconversions_(3stap)
