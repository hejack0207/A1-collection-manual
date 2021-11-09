# function::u_register(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::u_register - Return the unsigned value of the named CPU register

<a name="synopsis"></a>

# Synopsis

```


```
        u_register:long(name:string)

<a name="arguments"></a>

# Arguments


_name_
Name of the register to return

<a name="description"></a>

# Description


Same as register(name), except that if the register is 32 bits wide, it is zero-extended to 64 bits.

<a name="see-alson-"></a>

# See Also\N 

_tapset::registers_(3stap)
