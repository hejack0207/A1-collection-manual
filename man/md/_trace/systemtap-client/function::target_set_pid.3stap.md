# function::target_set(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::target_set_pid - Does pid descend from target process?

<a name="synopsis"></a>

# Synopsis

```


```
        target_set_pid(pid:)

<a name="arguments"></a>

# Arguments


_pid_
The pid of the process to query

<a name="description"></a>

# Description


This function returns whether the given process-id is within the
“target set”, that is whether it is a descendant of the top-level
**target**
process.

<a name="see-alson-"></a>

# See Also\N 

_tapset::target_set_(3stap)
