# function::qsq_servic(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::qsq_service_time - Amount of time per request service

<a name="synopsis"></a>

# Synopsis

```


```
        qsq_service_time:long(qname:string,scale:long)

<a name="arguments"></a>

# Arguments


_qname_
queue name

_scale_
scale variable to take account for interval fraction

<a name="description"></a>

# Description


This function returns the average time in microseconds required to service a request once it is removed from the wait queue.

<a name="see-alson-"></a>

# See Also\N 

_tapset::queue_stats_(3stap)
