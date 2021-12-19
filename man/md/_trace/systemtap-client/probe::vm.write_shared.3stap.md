# probe::vm\&.write_sh(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::vm.write_shared - Attempts at writing to a shared page

<a name="synopsis"></a>

# Synopsis

```


```
    vm.write_shared 

<a name="values"></a>

# Values


_name_
name of the probe point

_address_
the address of the shared write

<a name="context"></a>

# Context


The context is the process attempting the write.

<a name="description"></a>

# Description


Fires when a process attempts to write to a shared page. If a copy is necessary, this will be followed by a vm.write_shared_copy.

<a name="see-alson-"></a>

# See Also\N 

_tapset::memory_(3stap)
