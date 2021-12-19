# function::stringat(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::stringat - Returns the char at a given position in the string

<a name="synopsis"></a>

# Synopsis

```


```
        stringat:long(str:string,pos:long)

<a name="arguments"></a>

# Arguments


_str_
the string to fetch the character from

_pos_
the position to get the character from (first character is 0)

<a name="description"></a>

# Description


This function returns the character at a given position in the string or zero if the string doesnt have as many characters. Reports an error if pos is out of bounds.

<a name="see-alson-"></a>

# See Also\N 

_tapset::string_(3stap)
