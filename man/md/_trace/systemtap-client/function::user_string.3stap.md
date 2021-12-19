# function::user_strin(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::user_string - Retrieves string from user space

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    1) user_string:string(addr:long)
<synopsis>


```
    2) user_string:string(addr:long,err_msg:string)

<a name="arguments"></a>

# Arguments


_addr_
the user space address to retrieve the string from

_err\_msg_
the error message to return when data isnt available

<a name="description"></a>

# Description


1) Returns the null terminated C string from a given user space memory address. Reports an error on the rare cases when userspace data is not accessible.

2) Returns the null terminated C string from a given user space memory address. Reports the given error message on the rare cases when userspace data is not accessible.

<a name="see-alson-"></a>

# See Also\N 

_tapset::uconversions_(3stap)

<a name="see-alson-"></a>

# See Also\N 

_tapset::uconversions_(3stap)
