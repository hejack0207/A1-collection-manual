# probe::vm\&.brk(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::vm.brk - Fires when a brk is requested (i.e. the heap will be resized)

<a name="synopsis"></a>

# Synopsis

```


```
    vm.brk 

<a name="values"></a>

# Values


_address_
the requested address

_name_
name of the probe point

_length_
the length of the memory segment

<a name="context"></a>

# Context


The process calling brk.

<a name="see-alson-"></a>

# See Also\N 

_tapset::memory_(3stap)
