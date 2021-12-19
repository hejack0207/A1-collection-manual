# probe::vm\&.kmalloc_(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::vm.kmalloc_node - Fires when kmalloc_node is requested

<a name="synopsis"></a>

# Synopsis

```


```
    vm.kmalloc_node 

<a name="values"></a>

# Values


_gfp\_flags_
type of kmemory to allocate

_name_
name of the probe point

_call\_site_
address of the function caling this kmemory function

_ptr_
pointer to the kmemory allocated

_bytes\_req_
requested Bytes

_gfp\_flag\_name_
type of kmemory to allocate(in string format)

_caller\_function_
name of the caller function

_bytes\_alloc_
allocated Bytes

<a name="see-alson-"></a>

# See Also\N 

_tapset::memory_(3stap)
