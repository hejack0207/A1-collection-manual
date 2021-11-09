# function::indent_dep(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::indent_depth - returns the global nested-depth

<a name="synopsis"></a>

# Synopsis

```


```
        indent_depth:long(delta:long)

<a name="arguments"></a>

# Arguments


_delta_
the amount of depth added/removed for each call

<a name="description"></a>

# Description


This function returns a number for appropriate indentation, similar to
**indent**. Call it with a small positive or matching negative delta. Unlike the thread_indent_depth function, the indent does not track individual indent values on a per thread basis.

<a name="see-alson-"></a>

# See Also\N 

_tapset::indent_(3stap)
