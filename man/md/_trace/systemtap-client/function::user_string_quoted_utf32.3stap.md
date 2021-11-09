# function::user_strin(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::user_string_quoted_utf32 - Quote given user UTF-32 string.

<a name="synopsis"></a>

# Synopsis

```


```
        user_string_quoted_utf32:string(addr:long)

<a name="arguments"></a>

# Arguments


_addr_
The user address to retrieve the string from

<a name="description"></a>

# Description


This function combines quoting as per
_string\_quoted_
and UTF-32 decoding as per
_user\_string\_utf32_.

<a name="see-alson-"></a>

# See Also\N 

_tapset::uconversions_(3stap)
