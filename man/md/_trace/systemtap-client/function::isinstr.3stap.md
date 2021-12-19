# function::isinstr(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::isinstr - Returns whether a string is a substring of another string

<a name="synopsis"></a>

# Synopsis

```


```
        isinstr:long(s1:string,s2:string)

<a name="arguments"></a>

# Arguments


_s1_
string to search in

_s2_
substring to find

<a name="description"></a>

# Description


This function returns 1 if string
_s1_
contains
_s2_, otherwise zero.

<a name="see-alson-"></a>

# See Also\N 

_tapset::string_(3stap)
