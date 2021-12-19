# probe::vm\&.kmem_cac(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::vm.kmem_cache_alloc_node - Fires when kmem_cache_alloc_node is requested

<a name="synopsis"></a>

# Synopsis

```


```
    vm.kmem_cache_alloc_node 

<a name="values"></a>

# Values


_bytes\_alloc_
allocated Bytes

_call\_site_
address of the function calling this kmemory function

_ptr_
pointer to the kmemory allocated

_caller\_function_
name of the caller function

_gfp\_flag\_name_
type of kmemory to allocate(in string format)

_bytes\_req_
requested Bytes

_name_
name of the probe point

_gfp\_flags_
type of kmemory to allocate

<a name="see-alson-"></a>

# See Also\N 

_tapset::memory_(3stap)
