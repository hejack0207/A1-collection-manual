# function::task_ns_pi(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::task_ns_pid - The process identifier of the task

<a name="synopsis"></a>

# Synopsis

```


```
        task_ns_pid:long(task:long)

<a name="arguments"></a>

# Arguments


_task_
task_struct pointer

<a name="description"></a>

# Description


This fucntion returns the process id of the given task based on the specified pid namespace..

<a name="see-alson-"></a>

# See Also\N 

_tapset::task_(3stap)
