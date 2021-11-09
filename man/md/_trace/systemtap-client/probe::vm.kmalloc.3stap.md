# probe::vm\&.kmalloc(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::vm.kmalloc - Fires when kmalloc is requested

<a name="synopsis"></a>

# Synopsis

```


```
    vm.kmalloc 

<a name="values"></a>

# Values


_name_
name of the probe point

_gfp\_flags_
type of kmemory to allocate

_bytes\_alloc_
allocated Bytes

_call\_site_
address of the kmemory function

_ptr_
pointer to the kmemory allocated

_bytes\_req_
requested Bytes

_caller\_function_
name of the caller function

_gfp\_flag\_name_
type of kmemory to allocate (in String format)

<a name="see-alson-"></a>

# See Also\N 

_tapset::memory_(3stap)
