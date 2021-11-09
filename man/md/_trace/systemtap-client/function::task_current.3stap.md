# function::task_curre(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::task_current - The current task_struct of the current task

<a name="synopsis"></a>

# Synopsis

```


```
        task_current:long()

<a name="arguments"></a>

# Arguments


None

<a name="description"></a>

# Description


This function returns the task_struct representing the current process. This address can be passed to the various task_*() functions to extract more task-specific data.

<a name="see-alson-"></a>

# See Also\N 

_tapset::task_(3stap)
