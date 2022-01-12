# function::text_str(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::text_str - Escape any non-printable chars in a string

<a name="synopsis"></a>

# Synopsis

```


```
        text_str:string(input:string)

<a name="arguments"></a>

# Arguments


_input_
the string to escape

<a name="description"></a>

# Description


This function accepts a string argument, and any ASCII characters that are not printable are replaced by the corresponding escape sequence in the returned string.

<a name="see-alson-"></a>

# See Also\N 

_tapset::string_(3stap)
