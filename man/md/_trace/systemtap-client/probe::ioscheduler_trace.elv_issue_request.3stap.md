# probe::ioscheduler_t(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::ioscheduler_trace.elv_issue_request - Fires when a request is

<a name="synopsis"></a>

# Synopsis

```


```
    ioscheduler_trace.elv_issue_request 

<a name="values"></a>

# Values


_rq_
Address of request.

_disk\_minor_
Disk minor number of request.

_elevator\_name_
The type of I/O elevator currently enabled.

_disk\_major_
Disk major no of request.

_name_
Name of the probe point

_rq\_flags_
Request flags.

<a name="description"></a>

# Description


scheduled.

<a name="see-alson-"></a>

# See Also\N 

_tapset::ioscheduler_(3stap)
