# probe::vm\&.mmap(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::vm.mmap - Fires when an mmap is requested

<a name="synopsis"></a>

# Synopsis

```


```
    vm.mmap 

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


The process calling mmap.

<a name="see-alson-"></a>

# See Also\N 

_tapset::memory_(3stap)
