# probe::signal\&.sys_(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::signal.sys_tkill - Sending a kill signal to a thread

<a name="synopsis"></a>

# Synopsis

```


```
    signal.sys_tkill 

<a name="values"></a>

# Values


_pid\_name_
The name of the signal recipient

_sig\_name_
A string representation of the signal

_sig\_pid_
The PID of the process receiving the kill signal

_task_
A task handle to the signal recipient

_sig_
The specific signal sent to the process

_name_
Name of the probe point

<a name="description"></a>

# Description


The tkill call is analogous to kill(2), except that it also allows a process within a specific thread group to be targeted. Such processes are targeted through their unique thread IDs (TID).

<a name="see-alson-"></a>

# See Also\N 

_tapset::signal_(3stap)
