# probe::signal\&.sysk(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::signal.syskill - Sending kill signal to a process

<a name="synopsis"></a>

# Synopsis

```


```
    signal.syskill 

<a name="values"></a>

# Values


_pid\_name_
The name of the signal recipient

_sig\_name_
A string representation of the signal

_sig\_pid_
The PID of the process receiving the signal

_task_
A task handle to the signal recipient

_sig_
The specific signal sent to the process

_name_
Name of the probe point

<a name="see-alson-"></a>

# See Also\N 

_tapset::signal_(3stap)
