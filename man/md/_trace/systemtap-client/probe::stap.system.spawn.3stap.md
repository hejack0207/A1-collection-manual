# probe::stap\&.system(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::stap.system.spawn - stap spawned new process

<a name="synopsis"></a>

# Synopsis

```


```
    stap.system.spawn 

<a name="values"></a>

# Values


_pid_
the pid of the spawned process

_ret_
the return value from posix_spawn

<a name="description"></a>

# Description


Fires just after the call to posix_spawn.

<a name="see-alson-"></a>

# See Also\N 

_tapset::stap_staticmarkers_(3stap)
