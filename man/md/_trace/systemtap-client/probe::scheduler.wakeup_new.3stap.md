# probe::scheduler\&.w(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::scheduler.wakeup_new - Newly created task is woken up for the first time

<a name="synopsis"></a>

# Synopsis

```


```
    scheduler.wakeup_new 

<a name="values"></a>

# Values


_name_
name of the probe point

_task\_state_
state of the task woken up

_task\_cpu_
cpu of the task woken up

_task\_tid_
TID of the new task woken up

_task\_priority_
priority of the new task

_task\_pid_
PID of the new task woken up

<a name="see-alson-"></a>

# See Also\N 

_tapset::scheduler_(3stap)
