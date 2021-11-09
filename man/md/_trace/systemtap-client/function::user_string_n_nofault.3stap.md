# function::user_strin(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::user_string_n_nofault - Retrieves string of given length from user space

<a name="synopsis"></a>

# Synopsis

```


```
        user_string_n_nofault(addr:long,n:long)

<a name="arguments"></a>

# Arguments


_addr_
the user space address to retrieve the string from

_n_
the maximum length of the string (if not null terminated)

<a name="description"></a>

# Description


Returns the C string of a maximum given length from a given user space address. Returns the empty string when userspace data is not accessible at the given address.

<a name="see-alson-"></a>

# See Also\N 

_tapset::uconversions_(3stap)
