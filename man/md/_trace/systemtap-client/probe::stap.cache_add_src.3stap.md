# probe::stap\&.cache_(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::stap.cache_add_src - Adding C code translation to cache

<a name="synopsis"></a>

# Synopsis

```


```
    stap.cache_add_src 

<a name="values"></a>

# Values


_dest\_path_
the path the .c file is going to (incl filename)

_source\_path_
the path the .c file is coming from (incl filename)

<a name="description"></a>

# Description


Fires just before the file is actually moved. Note: if moving the kernel module fails, this probe will not fire.

<a name="see-alson-"></a>

# See Also\N 

_tapset::stap_staticmarkers_(3stap)
