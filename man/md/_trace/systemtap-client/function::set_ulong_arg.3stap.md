# function::set_ulong_(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::set_ulong_arg - Set function argument as unsigned long

<a name="synopsis"></a>

# Synopsis

```


```
        set_ulong_arg(n:long,v:long)

<a name="arguments"></a>

# Arguments


_n_
index of argument to return

_v_
value to set

<a name="description"></a>

# Description


Set the value of argument n as an unsigned long. On architectures where a long is 32 bits, the value is zero-extended to 64 bits.

<a name="see-alson-"></a>

# See Also\N 

_tapset::registers_(3stap)
