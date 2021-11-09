# function::user_strin(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::user_string_nofault - Retrieves string from user space

<a name="synopsis"></a>

# Synopsis

```


```
        user_string_nofault:string(addr:long)

<a name="arguments"></a>

# Arguments


_addr_
the user space address to retrieve the string from

<a name="description"></a>

# Description


Returns the null terminated C string from a given user space memory address. Returns the empty string if userspace data is not accessible.

<a name="see-alson-"></a>

# See Also\N 

_tapset::uconversions_(3stap)
