# probe::ioscheduler\&(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::ioscheduler.elv_add_request.kp - kprobe based probe to indicate that a request was added to the request queue

<a name="synopsis"></a>

# Synopsis

```


```
    ioscheduler.elv_add_request.kp 

<a name="values"></a>

# Values


_name_
Name of the probe point

_disk\_major_
Disk major number of the request

_rq\_flags_
Request flags

_elevator\_name_
The type of I/O elevator currently enabled

_disk\_minor_
Disk minor number of the request

_q_
pointer to request queue

_rq_
Address of the request

<a name="see-alson-"></a>

# See Also\N 

_tapset::ioscheduler_(3stap)
