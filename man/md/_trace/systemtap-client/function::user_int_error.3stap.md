# function::user_int_e(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::user_int_error - Retrieves an int value stored in user space

<a name="synopsis"></a>

# Synopsis

```


```
        user_int_error:long(addr:long)

<a name="arguments"></a>

# Arguments


_addr_
the user space address to retrieve the int from

<a name="description"></a>

# Description


Returns the int value from a given user space address. If the user space data is not accessible, an error will occur.

<a name="see-alson-"></a>

# See Also\N 

_tapset::uconversions_(3stap)
