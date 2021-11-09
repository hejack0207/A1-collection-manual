# function::ulong_arg(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::ulong_arg - Return function argument as unsigned long

<a name="synopsis"></a>

# Synopsis

```


```
        ulong_arg:long(n:long)

<a name="arguments"></a>

# Arguments


_n_
index of argument to return

<a name="description"></a>

# Description


Return the value of argument n as an unsigned long. On architectures where a long is 32 bits, the value is zero-extended to 64 bits.

<a name="see-alson-"></a>

# See Also\N 

_tapset::registers_(3stap)
