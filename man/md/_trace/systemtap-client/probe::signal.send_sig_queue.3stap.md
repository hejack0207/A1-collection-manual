# probe::signal\&.send(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::signal.send_sig_queue - Queuing a signal to a process

<a name="synopsis"></a>

# Synopsis

```


```
    signal.send_sig_queue 

<a name="values"></a>

# Values


_name_
Name of the probe point

_sig_
The queued signal

_sigqueue\_addr_
The address of the signal queue

_pid\_name_
Name of the process to which the signal is queued

_sig\_pid_
The PID of the process to which the signal is queued

_sig\_name_
A string representation of the signal

<a name="see-alson-"></a>

# See Also\N 

_tapset::signal_(3stap)
