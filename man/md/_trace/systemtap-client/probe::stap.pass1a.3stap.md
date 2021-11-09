# probe::stap\&.pass1a(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::stap.pass1a - Starting stap pass1 (parsing user script)

<a name="synopsis"></a>

# Synopsis

```


```
    stap.pass1a 

<a name="values"></a>

# Values


_session_
the systemtap_session variable s

<a name="description"></a>

# Description


pass1a fires just after the call to
**gettimeofday**, before the user script is parsed.

<a name="see-alson-"></a>

# See Also\N 

_tapset::stap_staticmarkers_(3stap)
