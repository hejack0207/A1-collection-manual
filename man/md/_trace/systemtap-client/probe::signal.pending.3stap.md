# probe::signal\&.pend(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::signal.pending - Examining pending signal

<a name="synopsis"></a>

# Synopsis

```


```
    signal.pending 

<a name="values"></a>

# Values


_sigset\_size_
The size of the user-space signal set

_name_
Name of the probe point

_sigset\_add_
The address of the user-space signal set (sigset_t)

<a name="description"></a>

# Description


This probe is used to examine a set of signals pending for delivery to a specific thread. This normally occurs when the do_sigpending kernel function is executed.

<a name="see-alson-"></a>

# See Also\N 

_tapset::signal_(3stap)
