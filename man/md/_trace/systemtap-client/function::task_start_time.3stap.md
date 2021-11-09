# function::task_start(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::task_start_time - Start time of the given task

<a name="synopsis"></a>

# Synopsis

```


```
        task_start_time:long(tid:long)

<a name="arguments"></a>

# Arguments


_tid_
Thread id of the given task

<a name="description"></a>

# Description


Returns the start time of the given task in nanoseconds since boot time or 0 if the task does not exist.

<a name="see-alson-"></a>

# See Also\N 

_tapset::task_time_(3stap)
