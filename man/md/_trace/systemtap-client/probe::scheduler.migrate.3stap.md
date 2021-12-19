# probe::scheduler\&.m(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::scheduler.migrate - Task migrating across cpus

<a name="synopsis"></a>

# Synopsis

```


```
    scheduler.migrate 

<a name="values"></a>

# Values


_name_
name of the probe point

_cpu\_from_
the original cpu

_task_
the process that is being migrated

_cpu\_to_
the destination cpu

_priority_
priority of the task being migrated

_pid_
PID of the task being migrated

<a name="see-alson-"></a>

# See Also\N 

_tapset::scheduler_(3stap)
