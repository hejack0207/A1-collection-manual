# function::kernel_str(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::kernel_string_quoted - Retrieves and quotes string from kernel memory

<a name="synopsis"></a>

# Synopsis

```


```
        kernel_string_quoted:string(addr:long)

<a name="arguments"></a>

# Arguments


_addr_
the kernel memory address to retrieve the string from

<a name="description"></a>

# Description


Returns the null terminated C string from a given kernel memory address where any ASCII characters that are not printable are replaced by the corresponding escape sequence in the returned string. Note that the string will be surrounded by double quotes. If the kernel memory data is not accessible at the given address, the address itself is returned as a string, without double quotes.

<a name="see-alson-"></a>

# See Also\N 

_tapset::conversions_(3stap)
