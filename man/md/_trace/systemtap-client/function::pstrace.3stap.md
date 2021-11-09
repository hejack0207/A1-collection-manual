# function::pstrace(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::pstrace - Chain of processes and pids back to init(1)

<a name="synopsis"></a>

# Synopsis

```


```
        pstrace:string(task:long)

<a name="arguments"></a>

# Arguments


_task_
Pointer to task struct of process

<a name="description"></a>

# Description


This function returns a string listing execname and pid for each process starting from
_task_
back to the process ancestor that init(1) spawned.

<a name="see-alson-"></a>

# See Also\N 

_tapset::pstrace_(3stap)
