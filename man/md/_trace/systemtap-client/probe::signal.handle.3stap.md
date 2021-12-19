# probe::signal\&.hand(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::signal.handle - Signal handler being invoked

<a name="synopsis"></a>

# Synopsis

```


```
    signal.handle 

<a name="values"></a>

# Values


_ka\_addr_
The address of the k_sigaction table associated with the signal

_sig\_code_
The si_code value of the siginfo signal

_sig_
The signal number that invoked the signal handler

_name_
Name of the probe point

_oldset\_addr_
The address of the bitmask array of blocked signals (deprecated in SystemTap 2.1)

_sig\_mode_
Indicates whether the signal was a user-mode or kernel-mode signal

_sig\_name_
A string representation of the signal

_sinfo_
The address of the siginfo table

_regs_
The address of the kernel-mode stack area (deprecated in SystemTap 2.1)

<a name="see-alson-"></a>

# See Also\N 

_tapset::signal_(3stap)
