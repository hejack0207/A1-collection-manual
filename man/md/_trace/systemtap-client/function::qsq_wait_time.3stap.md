# function::qsq_wait_t(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::qsq_wait_time - Amount of time in queue + service per request

<a name="synopsis"></a>

# Synopsis

```


```
        qsq_wait_time:long(qname:string,scale:long)

<a name="arguments"></a>

# Arguments


_qname_
queue name

_scale_
scale variable to take account for interval fraction

<a name="description"></a>

# Description


This function returns the average time in microseconds that it took for a request to be serviced (**qs\_wait**
to
**qa\_done**).

<a name="see-alson-"></a>

# See Also\N 

_tapset::queue_stats_(3stap)
