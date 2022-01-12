# function::task_time_(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::task_time_string_tid - Human readable string of task time usage

<a name="synopsis"></a>

# Synopsis

```


```
        task_time_string_tid:string(tid:long)

<a name="arguments"></a>

# Arguments


_tid_
Thread id of the given task

<a name="description"></a>

# Description


Returns a human readable string showing the user and system time the given task has used up to now. For example
“usr: 0m12.908s, sys: 1m6.851s”.

<a name="see-alson-"></a>

# See Also\N 

_tapset::task_time_(3stap)
