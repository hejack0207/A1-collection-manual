# probe::stap\&.pass5(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::stap.pass5 - Starting stap pass5 (running the instrumentation)

<a name="synopsis"></a>

# Synopsis

```


```
    stap.pass5 

<a name="values"></a>

# Values


_session_
the systemtap_session variable s

<a name="description"></a>

# Description


pass5 fires just after the call to
**gettimeofday**, just before the call to run_pass.

<a name="see-alson-"></a>

# See Also\N 

_tapset::stap_staticmarkers_(3stap)
