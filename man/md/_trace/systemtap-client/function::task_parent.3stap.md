# function::task_paren(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::task_parent - The task_struct of the parent task

<a name="synopsis"></a>

# Synopsis

```


```
        task_parent:long(task:long)

<a name="arguments"></a>

# Arguments


_task_
task_struct pointer

<a name="description"></a>

# Description


This function returns the parent task_struct of the given task. This address can be passed to the various task_*() functions to extract more task-specific data.

<a name="see-alson-"></a>

# See Also\N 

_tapset::task_(3stap)
