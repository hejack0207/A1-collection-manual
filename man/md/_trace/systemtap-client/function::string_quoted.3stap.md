# function::string_quo(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::string_quoted - Quotes a given string

<a name="synopsis"></a>

# Synopsis

```


```
        string_quoted:string(str:string)

<a name="arguments"></a>

# Arguments


_str_
The kernel address to retrieve the string from

<a name="description"></a>

# Description


Returns the quoted string version of the given string, with characters where any ASCII characters that are not printable are replaced by the corresponding escape sequence in the returned string. Note that the string will be surrounded by double quotes.

<a name="see-alson-"></a>

# See Also\N 

_tapset::string_(3stap)
