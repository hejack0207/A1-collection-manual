# probe::staprun\&.ins(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::staprun.insert_module - Inserting SystemTap instrumentation module

<a name="synopsis"></a>

# Synopsis

```


```
    staprun.insert_module 

<a name="values"></a>

# Values


_path_
the full path to the .ko kernel module about to be inserted

<a name="description"></a>

# Description


Fires just before the call to insert the module.

<a name="see-alson-"></a>

# See Also\N 

_tapset::stap_staticmarkers_(3stap)
