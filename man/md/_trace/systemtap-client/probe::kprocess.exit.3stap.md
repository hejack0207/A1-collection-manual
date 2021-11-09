# probe::kprocess\&.ex(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::kprocess.exit - Exit from process

<a name="synopsis"></a>

# Synopsis

```


```
    kprocess.exit 

<a name="values"></a>

# Values


_code_
The exit code of the process

<a name="context"></a>

# Context


The process which is terminating.

<a name="description"></a>

# Description


Fires when a process terminates. This will always be followed by a kprocess.release, though the latter may be delayed if the process waits in a zombie state.

<a name="see-alson-"></a>

# See Also\N 

_tapset::kprocess_(3stap)
