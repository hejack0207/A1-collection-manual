# function::modname(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::modname - Return the kernel module name loaded at the address

<a name="synopsis"></a>

# Synopsis

```


```
        modname:string(addr:long)

<a name="arguments"></a>

# Arguments


_addr_
The address to map to a kernel module name

<a name="description"></a>

# Description


Returns the module name associated with the given address if known. If not known it will raise an error. If the address was not in a kernel module, but in the kernel itself, then the string
“kernel”
will be returned.

<a name="see-alson-"></a>

# See Also\N 

_tapset::context-symbols_(3stap)
