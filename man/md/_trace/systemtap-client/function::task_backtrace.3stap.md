# function::task_backt(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::task_backtrace - Hex backtrace of an arbitrary task

<a name="synopsis"></a>

# Synopsis

```


```
        task_backtrace:string(task:long)

<a name="arguments"></a>

# Arguments


_task_
pointer to task_struct

<a name="description"></a>

# Description


This function returns a string of hex addresses that are a backtrace of the stack of a particular task Output may be truncated as per maximum string length. Deprecated in SystemTap 1.6.

<a name="see-alson-"></a>

# See Also\N 

_tapset::context-unwind_(3stap)
