# probe::scheduler\&.c(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::scheduler.cpu_on - Process is beginning execution on a cpu

<a name="synopsis"></a>

# Synopsis

```


```
    scheduler.cpu_on 

<a name="values"></a>

# Values


_idle_
- boolean indicating whether current is the idle process

_task\_prev_
the process that was previously running on this cpu

_name_
name of the probe point

<a name="context"></a>

# Context


The resuming process.

<a name="see-alson-"></a>

# See Also\N 

_tapset::scheduler_(3stap)
