# probe::vm\&.pagefaul(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::vm.pagefault - Records that a page fault occurred

<a name="synopsis"></a>

# Synopsis

```


```
    vm.pagefault 

<a name="values"></a>

# Values


_name_
name of the probe point

_address_
the address of the faulting memory access; i.e. the address that caused the page fault

_write\_access_
indicates whether this was a write or read access; 1 indicates a write, while 0 indicates a read

<a name="context"></a>

# Context


The process which triggered the fault

<a name="see-alson-"></a>

# See Also\N 

_tapset::memory_(3stap)
