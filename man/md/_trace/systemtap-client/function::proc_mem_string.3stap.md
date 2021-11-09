# function::proc_mem_s(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::proc_mem_string - Human readable string of process memory usage

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    1) proc_mem_string:string()
<synopsis>


```
    2) proc_mem_string:string(pid:long)

<a name="arguments"></a>

# Arguments


_pid_
The pid of process to examine

<a name="description"></a>

# Description


1) Returns a human readable string showing the size, rss, shr, txt and data of the memory used by the current process. For example“size: 301m, rss: 11m, shr: 8m, txt: 52k, data: 2248k”.

2) Returns a human readable string showing the size, rss, shr, txt and data of the memory used by the given process. For example“size: 301m, rss: 11m, shr: 8m, txt: 52k, data: 2248k”.

<a name="see-alson-"></a>

# See Also\N 

_tapset::proc_mem_(3stap)
