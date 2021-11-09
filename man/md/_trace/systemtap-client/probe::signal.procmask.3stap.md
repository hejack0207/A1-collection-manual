# probe::signal\&.proc(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::signal.procmask - Examining or changing blocked signals

<a name="synopsis"></a>

# Synopsis

```


```
    signal.procmask 

<a name="values"></a>

# Values


_sigset_
The actual value to be set for sigset_t (correct?)

_oldsigset\_addr_
The old address of the signal set (sigset_t)

_how_
Indicates how to change the blocked signals; possible values are SIG_BLOCK=0 (for blocking signals), SIG_UNBLOCK=1 (for unblocking signals), and SIG_SETMASK=2 for setting the signal mask.

_name_
Name of the probe point

_sigset\_addr_
The address of the signal set (sigset_t) to be implemented

<a name="see-alson-"></a>

# See Also\N 

_tapset::signal_(3stap)
