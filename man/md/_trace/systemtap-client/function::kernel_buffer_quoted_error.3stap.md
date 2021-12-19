# function::kernel_buf(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::kernel_buffer_quoted_error - Retrieves and quotes buffer from kernel space

<a name="synopsis"></a>

# Synopsis

```


```
        kernel_buffer_quoted_error:string(addr:long,inlen:long,outlen:long)

<a name="arguments"></a>

# Arguments


_addr_
the kernel space address to retrieve the buffer from

_inlen_
the exact length of the buffer to read

_outlen_
the maximum length of the output string

<a name="description"></a>

# Description


Reads inlen characters of a buffer from the given kernel space memory address, and returns up to outlen characters, where any ASCII characters that are not printable are replaced by the corresponding escape sequence in the returned string. Note that the string will be surrounded by double quotes. On the rare cases when kernel space data is not accessible at the given address, an error is thrown.

<a name="see-alson-"></a>

# See Also\N 

_tapset::conversions_(3stap)
