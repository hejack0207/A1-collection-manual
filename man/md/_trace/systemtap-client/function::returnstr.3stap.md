# function::returnstr(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::returnstr - Formats the return value as a string

<a name="synopsis"></a>

# Synopsis

```


```
        returnstr:string(format:long)

<a name="arguments"></a>

# Arguments


_format_
Variable to determine return type base value

<a name="description"></a>

# Description


This function is used by the nd_syscall tapset, and returns a string. Set format equal to 1 for a decimal, 2 for hex, 3 for octal.

Note that this function should only be used in dwarfless probes (i.e. kprobe.function(“foo”)\*(Aq). Other probes should use
**return\_str**.

<a name="see-alson-"></a>

# See Also\N 

_tapset::errno_(3stap)
