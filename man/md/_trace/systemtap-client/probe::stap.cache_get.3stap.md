# probe::stap\&.cache_(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::stap.cache_get - Found item in stap cache

<a name="synopsis"></a>

# Synopsis

```


```
    stap.cache_get 

<a name="values"></a>

# Values


_source\_path_
the path of the .c source file

_module\_path_
the path of the .ko kernel module file

<a name="description"></a>

# Description


Fires just before the return of get_from_cache, when the cache grab is successful.

<a name="see-alson-"></a>

# See Also\N 

_tapset::stap_staticmarkers_(3stap)
