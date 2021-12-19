# function::set_u64_ar(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::set_u64_arg - Set function argument as unsigned 64-bit value

<a name="synopsis"></a>

# Synopsis

```


```
        set_u64_arg(n:long,v:long)

<a name="arguments"></a>

# Arguments


_n_
index of argument to return

_v_
value to set

<a name="description"></a>

# Description


Set the unsigned 64-bit value of argument n, same as ulonglong_arg.

<a name="see-alson-"></a>

# See Also\N 

_tapset::registers_(3stap)
