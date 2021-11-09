# function::task_ances(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::task_ancestry - The ancestry of the given task

<a name="synopsis"></a>

# Synopsis

```


```
        task_ancestry:string(task:long,with_time:long)

<a name="arguments"></a>

# Arguments


_task_
task_struct pointer

_with\_time_
set to 1 to also print the start time of processes (given as a delta from boot time)

<a name="description"></a>

# Description


Return the ancestry of the given task in the form of
“grandparent_process=&gt;parent_process=&gt;process”.

<a name="see-alson-"></a>

# See Also\N 

_tapset::task_ancestry_(3stap)
