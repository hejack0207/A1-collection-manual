# probe::signal\&.chec(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::signal.checkperm - Check being performed on a sent signal

<a name="synopsis"></a>

# Synopsis

```


```
    signal.checkperm 

<a name="values"></a>

# Values


_name_
Name of the probe point

_sig_
The number of the signal

_si\_code_
Indicates the signal type

_task_
A task handle to the signal recipient

_sig\_pid_
The PID of the process receiving the signal

_sig\_name_
A string representation of the signal

_sinfo_
The address of the siginfo structure

_pid\_name_
Name of the process receiving the signal

<a name="see-alson-"></a>

# See Also\N 

_tapset::signal_(3stap)
