# function::kernel_cha(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::kernel_char - Retrieves a char value stored in kernel memory

<a name="synopsis"></a>

# Synopsis

```


```
        kernel_char:long(addr:long)

<a name="arguments"></a>

# Arguments


_addr_
The kernel address to retrieve the char from

<a name="description"></a>

# Description


Returns the char value from a given kernel memory address. Reports an error when reading from the given address fails.

<a name="see-alson-"></a>

# See Also\N 

_tapset::conversions_(3stap)
