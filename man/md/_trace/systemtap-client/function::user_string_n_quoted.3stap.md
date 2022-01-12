# function::user_strin(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::user_string_n_quoted - Retrieves and quotes string from user space

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    1) user_string_n_quoted:string(addr:long,n:long)
<synopsis>


```
    2) user_string_n_quoted:string(addr:long,inlen:long,outlen:long)

<a name="arguments"></a>

# Arguments


_addr_
the user space address to retrieve the string from

_n_
the maximum length of the string (if not null terminated)

_inlen_
the maximum length of the string to read (if not null terminated)

_outlen_
the maximum length of the output string

<a name="description"></a>

# Description


1) Returns up to n characters of a C string from the given user space memory address where any ASCII characters that are not printable are replaced by the corresponding escape sequence in the returned string. Note that the string will be surrounded by double quotes. On the rare cases when userspace data is not accessible at the given address, the address itself is returned as a string, without double quotes.

2) Reads up to inlen characters of a C string from the given user space memory address, and returns up to outlen characters, where any ASCII characters that are not printable are replaced by the corresponding escape sequence in the returned string. Note that the string will be surrounded by double quotes. On the rare cases when userspace data is not accessible at the given address, the address itself is returned as a string, without double quotes.

<a name="see-alson-"></a>

# See Also\N 

_tapset::uconversions_(3stap)
