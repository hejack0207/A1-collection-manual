# function::qsq_utiliz(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::qsq_utilization - Fraction of time that any request was being serviced

<a name="synopsis"></a>

# Synopsis

```


```
        qsq_utilization:long(qname:string,scale:long)

<a name="arguments"></a>

# Arguments


_qname_
queue name

_scale_
scale variable to take account for interval fraction

<a name="description"></a>

# Description


This function returns the average time in microseconds that at least one request was being serviced.

<a name="see-alson-"></a>

# See Also\N 

_tapset::queue_stats_(3stap)
