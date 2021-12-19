# function::text_strn(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::text_strn - Escape any non-printable chars in a string

<a name="synopsis"></a>

# Synopsis

```


```
        text_strn:string(input:string,len:long,quoted:long)

<a name="arguments"></a>

# Arguments


_input_
the string to escape

_len_
maximum length of string to return (0 implies MAXSTRINGLEN)

_quoted_
put double quotes around the string. If input string is truncated it will have
“...”
after the second quote

<a name="description"></a>

# Description


This function accepts a string of designated length, and any ASCII characters that are not printable are replaced by the corresponding escape sequence in the returned string.

<a name="see-alson-"></a>

# See Also\N 

_tapset::string_(3stap)
