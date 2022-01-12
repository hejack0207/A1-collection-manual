# probe::kprocess\&.re(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::kprocess.release - Process released

<a name="synopsis"></a>

# Synopsis

```


```
    kprocess.release 

<a name="values"></a>

# Values


_released\_tid_
TID of the task being released

_task_
A task handle to the process being released

_pid_
Same as
_released\_pid_
for compatibility (deprecated)

_released\_pid_
PID of the process being released

<a name="context"></a>

# Context


The context of the parent, if it wanted notification of this process termination, else the context of the process itself.

<a name="description"></a>

# Description


Fires when a process is released from the kernel. This always follows a kprocess.exit, though it may be delayed somewhat if the process waits in a zombie state.

<a name="see-alson-"></a>

# See Also\N 

_tapset::kprocess_(3stap)
