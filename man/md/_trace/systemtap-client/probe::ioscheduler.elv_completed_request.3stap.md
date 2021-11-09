# probe::ioscheduler\&(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::ioscheduler.elv_completed_request - Fires when a request is completed

<a name="synopsis"></a>

# Synopsis

```


```
    ioscheduler.elv_completed_request 

<a name="values"></a>

# Values


_disk\_minor_
Disk minor number of the request

_name_
Name of the probe point

_disk\_major_
Disk major number of the request

_rq\_flags_
Request flags

_elevator\_name_
The type of I/O elevator currently enabled

_rq_
Address of the request

<a name="see-alson-"></a>

# See Also\N 

_tapset::ioscheduler_(3stap)
