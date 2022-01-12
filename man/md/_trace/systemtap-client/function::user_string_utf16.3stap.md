# function::user_strin(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::user_string_utf16 - Retrieves UTF-16 string from user memory

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    1) user_string_utf16:string(addr:long)
<synopsis>


```
    2) user_string_utf16:string(addr:long,err_msg:string)

<a name="arguments"></a>

# Arguments


_addr_
The user address to retrieve the string from

_err\_msg_
The error message to return when data isnt available

<a name="description"></a>

# Description


1) This function returns a null terminated UTF-8 string converted from the UTF-16 string at a given user memory address. Reports an error on string copy fault or conversion error.

2) This function returns a null terminated UTF-8 string converted from the UTF-16 string at a given user memory address. Reports the given error message on string copy fault or conversion error.

<a name="see-alson-"></a>

# See Also\N 

_tapset::uconversions_(3stap)
