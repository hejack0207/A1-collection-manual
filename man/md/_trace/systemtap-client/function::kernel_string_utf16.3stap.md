# function::kernel_str(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::kernel_string_utf16 - Retrieves UTF-16 string from kernel memory

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    1) kernel_string_utf16:string(addr:long)
<synopsis>


```
    2) kernel_string_utf16:string(addr:long,err_msg:string)

<a name="arguments"></a>

# Arguments


_addr_
The kernel address to retrieve the string from

_err\_msg_
The error message to return when data isnt available

<a name="description"></a>

# Description


1) This function returns a null terminated UTF-8 string converted from the UTF-16 string at a given kernel memory address. Reports an error on string copy fault or conversion error.

2) This function returns a null terminated UTF-8 string converted from the UTF-16 string at a given kernel memory address. Reports the given error message on string copy fault or conversion error.

<a name="see-alson-"></a>

# See Also\N 

_tapset::conversions_(3stap)
