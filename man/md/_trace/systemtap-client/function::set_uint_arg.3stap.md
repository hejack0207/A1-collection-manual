# function::set_uint_a(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::set_uint_arg - Set argument as unsigned int

<a name="synopsis"></a>

# Synopsis

```


```
        set_uint_arg:long(n:long,v:long)

<a name="arguments"></a>

# Arguments


_n_
index of argument to set

_v_
value to set

<a name="description"></a>

# Description


Set the value of argument n as an unsigned int (i.e., a 32-bit integer zero-extended to 64 bits).

<a name="see-alson-"></a>

# See Also\N 

_tapset::registers_(3stap)
