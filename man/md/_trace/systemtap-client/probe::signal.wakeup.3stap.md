# probe::signal\&.wake(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::signal.wakeup - Sleeping process being wakened for signal

<a name="synopsis"></a>

# Synopsis

```


```
    signal.wakeup 

<a name="values"></a>

# Values


_state\_mask_
A string representation indicating the mask of task states to wake. Possible values are TASK_INTERRUPTIBLE, TASK_STOPPED, TASK_TRACED, TASK_WAKEKILL, and TASK_INTERRUPTIBLE.

_resume_
Indicates whether to wake up a task in a STOPPED or TRACED state

_pid\_name_
Name of the process to wake

_sig\_pid_
The PID of the process to wake

<a name="see-alson-"></a>

# See Also\N 

_tapset::signal_(3stap)
