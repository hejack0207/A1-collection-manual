# probe::stap\&.cache_(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::stap.cache_clean - Removing file from stap cache

<a name="synopsis"></a>

# Synopsis

```


```
    stap.cache_clean 

<a name="values"></a>

# Values


_path_
the path to the .ko/.c file being removed

<a name="description"></a>

# Description


Fires just before the call to unlink the module/source file.

<a name="see-alson-"></a>

# See Also\N 

_tapset::stap_staticmarkers_(3stap)
