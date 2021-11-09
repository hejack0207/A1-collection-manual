# probe::stap\&.system(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::stap.system.return - Finished a command from stap

<a name="synopsis"></a>

# Synopsis

```


```
    stap.system.return 

<a name="values"></a>

# Values


_ret_
a return code associated with running waitpid on the spawned process; a non-zero value indicates error

<a name="description"></a>

# Description


Fires just before the return of the stap_system function, after waitpid.

<a name="see-alson-"></a>

# See Also\N 

_tapset::stap_staticmarkers_(3stap)
