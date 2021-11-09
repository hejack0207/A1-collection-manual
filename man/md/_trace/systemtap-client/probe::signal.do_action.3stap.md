# probe::signal\&.do_a(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::signal.do_action - Examining or changing a signal action

<a name="synopsis"></a>

# Synopsis

```


```
    signal.do_action 

<a name="values"></a>

# Values


_oldsigact\_addr_
The address of the old sigaction struct associated with the signal

_sig_
The signal to be examined/changed

_sa\_mask_
The new mask of the signal

_name_
Name of the probe point

_sig\_name_
A string representation of the signal

_sigact\_addr_
The address of the new sigaction struct associated with the signal

_sa\_handler_
The new handler of the signal

<a name="see-alson-"></a>

# See Also\N 

_tapset::signal_(3stap)
