# function::umodname(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::umodname - Returns the (short) name of the user module.

<a name="synopsis"></a>

# Synopsis

```


```
        umodname:string(addr:long)

<a name="arguments"></a>

# Arguments


_addr_
User-space address

<a name="description"></a>

# Description


Returns the short name of the user space module for the current task that that the given address is part of. Reports an error when the address isnt in a (mapped in) module, or the module cannot be found for some reason.

<a name="see-alson-"></a>

# See Also\N 

_tapset::ucontext_(3stap)
