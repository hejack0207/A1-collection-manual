# function::errno_str(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::errno_str - Symbolic string associated with error code

<a name="synopsis"></a>

# Synopsis

```


```
        errno_str:string(err:long)

<a name="arguments"></a>

# Arguments


_err_
The error number received

<a name="description"></a>

# Description


This function returns the symbolic string associated with the giver error code, such as ENOENT for the number 2, or E#3333 for an out-of-range value such as 3333.

<a name="see-alson-"></a>

# See Also\N 

_tapset::errno_(3stap)
