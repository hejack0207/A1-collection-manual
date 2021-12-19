# function::user_strin(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::user_string_warn - Retrieves string from user space

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    1) user_string_warn:string(addr:long)
<synopsis>


```
    2) user_string_warn:string(addr:long,warn_msg:string)

<a name="arguments"></a>

# Arguments


_addr_
the user space address to retrieve the string from

_warn\_msg_
the warning message to return when data isnt available

<a name="description"></a>

# Description


1) Returns the null terminated C string from a given user space memory address. Reports "" on the rare cases when userspace data is not accessible and warns (but does not abort) about the failure.

2) Returns the null terminated C string from a given user space memory address. Reports the given warning message on the rare cases when userspace data is not accessible and warns (but does not abort) about the failure.

<a name="see-alson-"></a>

# See Also\N 

_tapset::uconversions_(3stap)
