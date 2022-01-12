# function::set_pointe(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::set_pointer_arg - Set function argument as pointer value

<a name="synopsis"></a>

# Synopsis

```


```
        set_pointer_arg(n:long,v:long)

<a name="arguments"></a>

# Arguments


_n_
index of argument to return

_v_
value to set

<a name="description"></a>

# Description


Set the unsigned value of argument n, same as ulong_arg. Can be used with any type of pointer.

<a name="see-alson-"></a>

# See Also\N 

_tapset::registers_(3stap)
