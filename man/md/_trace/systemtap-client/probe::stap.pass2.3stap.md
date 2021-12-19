# probe::stap\&.pass2(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::stap.pass2 - Starting stap pass2 (elaboration)

<a name="synopsis"></a>

# Synopsis

```


```
    stap.pass2 

<a name="values"></a>

# Values


_session_
the systemtap_session variable s

<a name="description"></a>

# Description


pass2 fires just after the call to
**gettimeofday**, just before the call to semantic_pass.

<a name="see-alson-"></a>

# See Also\N 

_tapset::stap_staticmarkers_(3stap)
