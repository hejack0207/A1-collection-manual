# probe::scheduler\&.c(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::scheduler.cpu_off - Process is about to stop running on a cpu

<a name="synopsis"></a>

# Synopsis

```


```
    scheduler.cpu_off 

<a name="values"></a>

# Values


_task\_next_
the process replacing current

_task\_prev_
the process leaving the cpu (same as current)

_name_
name of the probe point

_idle_
boolean indicating whether current is the idle process

<a name="context"></a>

# Context


The process leaving the cpu.

<a name="see-alson-"></a>

# See Also\N 

_tapset::scheduler_(3stap)
