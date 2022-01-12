# function::user_strin(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::user_string_n - Retrieves string of given length from user space

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    1) user_string_n:string(addr:long,n:long)
<synopsis>


```
    2) user_string_n:string(addr:long,n:long,err_msg:string)

<a name="arguments"></a>

# Arguments


_addr_
the user space address to retrieve the string from

_n_
the maximum length of the string (if not null terminated)

_err\_msg_
the error message to return when data isnt available

<a name="description"></a>

# Description


1) Returns the C string of a maximum given length from a given user space address. Reports an error on the rare cases when userspace data is not accessible at the given address.

2) Returns the C string of a maximum given length from a given user space address. Returns the given error message string on the rare cases when userspace data is not accessible at the given address.

<a name="see-alson-"></a>

# See Also\N 

_tapset::uconversions_(3stap)

<a name="see-alson-"></a>

# See Also\N 

_tapset::uconversions_(3stap)
