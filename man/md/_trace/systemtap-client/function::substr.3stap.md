# function::substr(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::substr - Returns a substring

<a name="synopsis"></a>

# Synopsis

```


```
        substr:string(str:string,start:long,length:long)

<a name="arguments"></a>

# Arguments


_str_
the string to take a substring from

_start_
starting position of the extracted string (first character is 0)

_length_
length of string to return

<a name="description"></a>

# Description


Returns the substring of the given string at the given start position with the given length (or smaller if the length of the original string is less than start + length, or length is bigger than MAXSTRINGLEN).

<a name="see-alson-"></a>

# See Also\N 

_tapset::string_(3stap)
