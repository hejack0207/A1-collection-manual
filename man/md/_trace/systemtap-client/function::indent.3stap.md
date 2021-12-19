# function::indent(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::indent - returns an amount of space to indent

<a name="synopsis"></a>

# Synopsis

```


```
        indent:string(delta:long)

<a name="arguments"></a>

# Arguments


_delta_
the amount of space added/removed for each call

<a name="description"></a>

# Description


This function returns a string with appropriate indentation. Call it with a small positive or matching negative delta. Unlike the thread_indent function, the indent does not track individual indent values on a per thread basis.

<a name="see-alson-"></a>

# See Also\N 

_tapset::indent_(3stap)
