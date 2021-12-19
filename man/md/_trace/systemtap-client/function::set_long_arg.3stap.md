# function::set_long_a(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::set_long_arg - Set argument as signed long

<a name="synopsis"></a>

# Synopsis

```


```
        set_long_arg(n:long,v:long)

<a name="arguments"></a>

# Arguments


_n_
index of argument to set

_v_
value to set

<a name="description"></a>

# Description


Set the value of argument n as a signed long. On architectures where a long is 32 bits, the value is sign-extended to 64 bits.

<a name="see-alson-"></a>

# See Also\N 

_tapset::registers_(3stap)
