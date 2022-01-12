# probe::ioscheduler_t(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::ioscheduler_trace.unplug_io - Fires when a request queue is unplugged;

<a name="synopsis"></a>

# Synopsis

```


```
    ioscheduler_trace.unplug_io 

<a name="values"></a>

# Values


_name_
Name of the probe point

_rq\_queue_
request queue

<a name="description"></a>

# Description


Either, when number of pending requests in the queue exceeds threshold or, upon expiration of timer that was activated when queue was plugged.

<a name="see-alson-"></a>

# See Also\N 

_tapset::ioscheduler_(3stap)
