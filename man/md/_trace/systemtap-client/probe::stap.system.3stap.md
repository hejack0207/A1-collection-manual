# probe::stap\&.system(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::stap.system - Starting a command from stap

<a name="synopsis"></a>

# Synopsis

```


```
    stap.system 

<a name="values"></a>

# Values


_command_
the command string to be run by posix_spawn (as sh -c &lt;str&gt;)

<a name="description"></a>

# Description


Fires at the entry of the stap_system command.

<a name="see-alson-"></a>

# See Also\N 

_tapset::stap_staticmarkers_(3stap)
