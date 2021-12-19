# function::task_stime(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::task_stime - System time of the task

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    1) task_stime:long()
<synopsis>


```
    2) task_stime:long(tid:long)

<a name="arguments"></a>

# Arguments


_tid_
Thread id of the given task

<a name="description"></a>

# Description


1) Returns the system time of the current task in cputime. Does not include any time used by other tasks in this process, nor does it include any time of the children of this task.

2) Returns the system time of the given task in cputime, or zero if the task doesnt exist. Does not include any time used by other tasks in this process, nor does it include any time of the children of this task.

<a name="see-alson-"></a>

# See Also\N 

_tapset::task_time_(3stap)
