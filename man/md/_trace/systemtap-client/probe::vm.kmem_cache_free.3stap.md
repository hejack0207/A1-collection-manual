# probe::vm\&.kmem_cac(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::vm.kmem_cache_free - Fires when kmem_cache_free is requested

<a name="synopsis"></a>

# Synopsis

```


```
    vm.kmem_cache_free 

<a name="values"></a>

# Values


_call\_site_
Address of the function calling this kmemory function

_ptr_
Pointer to the kmemory allocated which is returned by kmem_cache

_caller\_function_
Name of the caller function.

_name_
Name of the probe point

<a name="see-alson-"></a>

# See Also\N 

_tapset::memory_(3stap)
