# function::task_state(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::task_state - The state of the task

<a name="synopsis"></a>

# Synopsis

```


```
        task_state:long(task:long)

<a name="arguments"></a>

# Arguments


_task_
task_struct pointer

<a name="description"></a>

# Description


Return the state of the given task, one of: TASK_RUNNING (0), TASK_INTERRUPTIBLE (1), TASK_UNINTERRUPTIBLE (2), TASK_STOPPED (4), TASK_TRACED (8), EXIT_ZOMBIE (16), or EXIT_DEAD (32).

<a name="see-alson-"></a>

# See Also\N 

_tapset::task_(3stap)
