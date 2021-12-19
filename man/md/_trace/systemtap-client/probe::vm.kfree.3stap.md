# probe::vm\&.kfree(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::vm.kfree - Fires when kfree is requested

<a name="synopsis"></a>

# Synopsis

```


```
    vm.kfree 

<a name="values"></a>

# Values


_name_
name of the probe point

_caller\_function_
name of the caller function.

_ptr_
pointer to the kmemory allocated which is returned by kmalloc

_call\_site_
address of the function calling this kmemory function

<a name="see-alson-"></a>

# See Also\N 

_tapset::memory_(3stap)
