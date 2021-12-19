# function::return_str(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::return_str - Formats the return value as a string

<a name="synopsis"></a>

# Synopsis

```


```
        return_str:string(format:long,ret:long)

<a name="arguments"></a>

# Arguments


_format_
Variable to determine return type base value

_ret_
Return value (typically
**$return**)

<a name="description"></a>

# Description


This function is used by the syscall tapset, and returns a string. Set format equal to 1 for a decimal, 2 for hex, 3 for octal.

Note that this function is preferred over
**returnstr**.

<a name="see-alson-"></a>

# See Also\N 

_tapset::errno_(3stap)
