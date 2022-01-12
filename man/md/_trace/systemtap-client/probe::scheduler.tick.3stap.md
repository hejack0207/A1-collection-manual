# probe::scheduler\&.t(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::scheduler.tick - Schedulers internal tick, a processes timeslice accounting is updated

<a name="synopsis"></a>

# Synopsis

```


```
    scheduler.tick 

<a name="values"></a>

# Values


_idle_
boolean indicating whether current is the idle process

_name_
name of the probe point

<a name="context"></a>

# Context


The process whose accounting will be updated.

<a name="see-alson-"></a>

# See Also\N 

_tapset::scheduler_(3stap)
