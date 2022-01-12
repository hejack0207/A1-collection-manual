# function::qsq_blocke(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::qsq_blocked - Returns the time reqest was on the wait queue

<a name="synopsis"></a>

# Synopsis

```


```
        qsq_blocked:long(qname:string,scale:long)

<a name="arguments"></a>

# Arguments


_qname_
queue name

_scale_
scale variable to take account for interval fraction

<a name="description"></a>

# Description


This function returns the fraction of elapsed time during which one or more requests were on the wait queue.

<a name="see-alson-"></a>

# See Also\N 

_tapset::queue_stats_(3stap)
