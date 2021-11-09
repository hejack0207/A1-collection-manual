# function::task_euid(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::task_euid - The effective user identifier of the task

<a name="synopsis"></a>

# Synopsis

```


```
        task_euid:long(task:long)

<a name="arguments"></a>

# Arguments


_task_
task_struct pointer

<a name="description"></a>

# Description


This function returns the effective user id of the given task.

<a name="see-alson-"></a>

# See Also\N 

_tapset::task_(3stap)
