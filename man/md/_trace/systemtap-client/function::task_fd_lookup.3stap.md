# function::task_fd_lo(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::task_fd_lookup - get the file struct for a tasks fd

<a name="synopsis"></a>

# Synopsis

```


```
        task_fd_lookup:long(task:long,fd:long)

<a name="arguments"></a>

# Arguments


_task_
task_struct pointer.

_fd_
file descriptor number.

<a name="description"></a>

# Description


Returns the file struct pointer for a tasks file descriptor.
