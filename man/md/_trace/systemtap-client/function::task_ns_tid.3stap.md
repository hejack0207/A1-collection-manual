# function::task_ns_ti(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::task_ns_tid - The thread identifier of the task as seen in a namespace

<a name="synopsis"></a>

# Synopsis

```


```
        task_ns_tid:long(task:long)

<a name="arguments"></a>

# Arguments


_task_
task_struct pointer

<a name="description"></a>

# Description


This function returns the thread id of the given task as seen in the pid namespace.

<a name="see-alson-"></a>

# See Also\N 

_tapset::task_(3stap)
