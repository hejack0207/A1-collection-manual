# function::proc_mem_s(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::proc_mem_shr - Program shared pages (from shared mappings)

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    1) proc_mem_shr:long()
<synopsis>


```
    2) proc_mem_shr:long(pid:long)

<a name="arguments"></a>

# Arguments


_pid_
The pid of process to examine

<a name="description"></a>

# Description


1) Returns the shared pages (from shared mappings) of the current process, or zero when there is no current process or the number of pages couldnt be retrieved.

2) Returns the shared pages (from shared mappings) of the given process, or zero when the process doesnt exist or the number of pages couldn\*(Aqt be retrieved.

<a name="see-alson-"></a>

# See Also\N 

_tapset::proc_mem_(3stap)
