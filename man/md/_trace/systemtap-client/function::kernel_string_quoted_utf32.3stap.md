# function::kernel_str(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::kernel_string_quoted_utf32 - Quote given UTF-32 kernel string.

<a name="synopsis"></a>

# Synopsis

```


```
        kernel_string_quoted_utf32:string(addr:long)

<a name="arguments"></a>

# Arguments


_addr_
The kernel address to retrieve the string from

<a name="description"></a>

# Description


This function combines quoting as per
_string\_quoted_
and UTF-32 decoding as per
_kernel\_string\_utf32_.

<a name="see-alson-"></a>

# See Also\N 

_tapset::conversions_(3stap)
