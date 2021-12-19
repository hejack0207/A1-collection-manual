# function::kernel_str(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::kernel_string_n - Retrieves string of given length from kernel memory

<a name="synopsis"></a>

# Synopsis

```


```
        kernel_string_n:string(addr:long,n:long)

<a name="arguments"></a>

# Arguments


_addr_
The kernel address to retrieve the string from

_n_
The maximum length of the string (if not null terminated)

<a name="description"></a>

# Description


Returns the C string of a maximum given length from a given kernel memory address. Reports an error on string copy fault.

<a name="see-alson-"></a>

# See Also\N 

_tapset::conversions_(3stap)
