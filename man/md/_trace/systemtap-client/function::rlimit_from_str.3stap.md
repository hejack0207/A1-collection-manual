# function::rlimit_fro(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::rlimit_from_str - Symbolic string associated with resource limit code

<a name="synopsis"></a>

# Synopsis

```


```
        rlimit_from_str:long(lim_str:string)

<a name="arguments"></a>

# Arguments


_lim\_str_
The string representation of limit

<a name="description"></a>

# Description


This function returns the number associated with the given string, such as 0 for the string RLIMIT_CPU, or -1 for an out-of-range value.

<a name="see-alson-"></a>

# See Also\N 

_tapset::rlimit_(3stap)
