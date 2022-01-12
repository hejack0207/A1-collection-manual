# probe::signal\&.sys_(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::signal.sys_tgkill - Sending kill signal to a thread group

<a name="synopsis"></a>

# Synopsis

```


```
    signal.sys_tgkill 

<a name="values"></a>

# Values


_task_
A task handle to the signal recipient

_name_
Name of the probe point

_sig_
The specific kill signal sent to the process

_pid\_name_
The name of the signal recipient

_tgid_
The thread group ID of the thread receiving the kill signal

_sig\_pid_
The PID of the thread receiving the kill signal

_sig\_name_
A string representation of the signal

<a name="description"></a>

# Description


The tgkill call is similar to tkill, except that it also allows the caller to specify the thread group ID of the thread to be signalled. This protects against TID reuse.

<a name="see-alson-"></a>

# See Also\N 

_tapset::signal_(3stap)
