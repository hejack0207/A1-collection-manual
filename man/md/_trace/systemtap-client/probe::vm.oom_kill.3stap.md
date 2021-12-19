# probe::vm\&.oom_kill(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::vm.oom_kill - Fires when a thread is selected for termination by the OOM killer

<a name="synopsis"></a>

# Synopsis

```


```
    vm.oom_kill 

<a name="values"></a>

# Values


_task_
the task being killed

_name_
name of the probe point

<a name="context"></a>

# Context


The process that tried to consume excessive memory, and thus triggered the OOM.

<a name="see-alson-"></a>

# See Also\N 

_tapset::memory_(3stap)
