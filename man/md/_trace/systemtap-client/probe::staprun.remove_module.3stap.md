# probe::staprun\&.rem(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::staprun.remove_module - Removing SystemTap instrumentation module

<a name="synopsis"></a>

# Synopsis

```


```
    staprun.remove_module 

<a name="values"></a>

# Values


_name_
the stap module name to be removed (without the .ko extension)

<a name="description"></a>

# Description


Fires just before the call to remove the module.

<a name="see-alson-"></a>

# See Also\N 

_tapset::stap_staticmarkers_(3stap)
