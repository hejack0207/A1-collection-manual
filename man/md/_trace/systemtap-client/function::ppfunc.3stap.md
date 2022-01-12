# function::ppfunc(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::ppfunc - Returns the function name parsed from **pp**

<a name="synopsis"></a>

# Synopsis

```


```
        ppfunc:string()

<a name="arguments"></a>

# Arguments


None

<a name="description"></a>

# Description


This returns the function name from the current
**pp**. Not all
**pp**
have functions in them, in which case "" is returned.

<a name="see-alson-"></a>

# See Also\N 

_tapset::context_(3stap)
