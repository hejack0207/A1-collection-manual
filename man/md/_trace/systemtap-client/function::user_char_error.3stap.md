# function::user_char_(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::user_char_error - Retrieves a char value stored in user space

<a name="synopsis"></a>

# Synopsis

```


```
        user_char_error:long(addr:long)

<a name="arguments"></a>

# Arguments


_addr_
the user space address to retrieve the char from

<a name="description"></a>

# Description


Returns the char value from a given user space address. If the user space data is not accessible, an error will occur.

<a name="see-alson-"></a>

# See Also\N 

_tapset::uconversions_(3stap)
