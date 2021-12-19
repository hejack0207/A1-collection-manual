# function::strpos(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::strpos - Returns location of a substring within another string

<a name="synopsis"></a>

# Synopsis

```


```
        strpos:long(s1:string,s2:string)

<a name="arguments"></a>

# Arguments


_s1_
string to search in

_s2_
substring to find

<a name="description"></a>

# Description


This function returns location of the first occurence of string
_s2_
within
_s1_, namely the return value is 0 in case
_s2_
is a prefix of
_s1_. If
_s2_
is not a substring of
_s1_, then the return value is -1.

<a name="see-alson-"></a>

# See Also\N 

_tapset::string_(3stap)
