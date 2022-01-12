# probe::signal\&.send(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::signal.send - Signal being sent to a process

<a name="synopsis"></a>

# Synopsis

```


```
    signal.send 

<a name="values"></a>

# Values


_task_
A task handle to the signal recipient

_send2queue_
Indicates whether the signal is sent to an existing sigqueue (deprecated in SystemTap 2.1)

_si\_code_
Indicates the signal type

_sig_
The number of the signal

_name_
The name of the function used to send out the signal

_pid\_name_
The name of the signal recipient

_sinfo_
The address of siginfo struct

_shared_
Indicates whether the signal is shared by the thread group

_sig\_name_
A string representation of the signal

_sig\_pid_
The PID of the process receiving the signal

<a name="context"></a>

# Context


The signals sender.

<a name="see-alson-"></a>

# See Also\N 

_tapset::signal_(3stap)
