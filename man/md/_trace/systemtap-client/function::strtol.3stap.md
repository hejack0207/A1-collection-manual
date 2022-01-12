# function::strtol(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::strtol - strtol - Convert a string to a long

<a name="synopsis"></a>

# Synopsis

```


```
        strtol:long(str:string,base:long)

<a name="arguments"></a>

# Arguments


_str_
string to convert

_base_
the base to use

<a name="description"></a>

# Description


This function converts the string representation of a number to an integer. The
_base_
parameter indicates the number base to assume for the string (eg. 16 for hex, 8 for octal, 2 for binary).

<a name="see-alson-"></a>

# See Also\N 

_tapset::string_(3stap)
