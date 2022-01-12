# probe::vm\&.munmap(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::vm.munmap - Fires when an munmap is requested

<a name="synopsis"></a>

# Synopsis

```


```
    vm.munmap 

<a name="values"></a>

# Values


_address_
the requested address

_length_
the length of the memory segment

_name_
name of the probe point

<a name="context"></a>

# Context


The process calling munmap.

<a name="see-alson-"></a>

# See Also\N 

_tapset::memory_(3stap)
