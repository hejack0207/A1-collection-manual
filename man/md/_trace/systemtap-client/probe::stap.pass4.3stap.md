# probe::stap\&.pass4(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::stap.pass4 - Starting stap pass4 (compile C code into kernel module)

<a name="synopsis"></a>

# Synopsis

```


```
    stap.pass4 

<a name="values"></a>

# Values


_session_
the systemtap_session variable s

<a name="description"></a>

# Description


pass4 fires just after the call to
**gettimeofday**, just before the call to compile_pass.

<a name="see-alson-"></a>

# See Also\N 

_tapset::stap_staticmarkers_(3stap)
