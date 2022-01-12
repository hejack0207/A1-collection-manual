# probe::vm\&.write_sh(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::vm.write_shared_copy - Page copy for shared page write

<a name="synopsis"></a>

# Synopsis

```


```
    vm.write_shared_copy 

<a name="values"></a>

# Values


_address_
The address of the shared write

_zero_
boolean indicating whether it is a zero page (can do a clear instead of a copy)

_name_
Name of the probe point

<a name="context"></a>

# Context


The process attempting the write.

<a name="description"></a>

# Description


Fires when a write to a shared page requires a page copy. This is always preceded by a vm.write_shared.

<a name="see-alson-"></a>

# See Also\N 

_tapset::memory_(3stap)
