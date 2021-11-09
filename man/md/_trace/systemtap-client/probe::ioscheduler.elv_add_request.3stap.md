# probe::ioscheduler\&(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::ioscheduler.elv_add_request - probe to indicate request is added to the request queue.

<a name="synopsis"></a>

# Synopsis

```


```
    ioscheduler.elv_add_request 

<a name="values"></a>

# Values


_elevator\_name_
The type of I/O elevator currently enabled.

_disk\_major_
Disk major no of request.

_rq\_flags_
Request flags.

_rq_
Address of request.

_q_
Pointer to request queue.

_disk\_minor_
Disk minor number of request.

<a name="see-alson-"></a>

# See Also\N 

_tapset::ioscheduler_(3stap)
