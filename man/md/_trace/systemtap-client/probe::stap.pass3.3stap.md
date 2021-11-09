# probe::stap\&.pass3(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::stap.pass3 - Starting stap pass3 (translation to C)

<a name="synopsis"></a>

# Synopsis

```


```
    stap.pass3 

<a name="values"></a>

# Values


_session_
the systemtap_session variable s

<a name="description"></a>

# Description


pass3 fires just after the call to
**gettimeofday**, just before the call to translate_pass.

<a name="see-alson-"></a>

# See Also\N 

_tapset::stap_staticmarkers_(3stap)
