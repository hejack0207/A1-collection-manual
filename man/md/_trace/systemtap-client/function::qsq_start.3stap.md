# function::qsq_start(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::qsq_start - Function to reset the stats for a queue

<a name="synopsis"></a>

# Synopsis

```


```
        qsq_start(qname:string)

<a name="arguments"></a>

# Arguments


_qname_
the name of the service that finished

<a name="description"></a>

# Description


This function resets the statistics counters for the given queue, and restarts tracking from the moment the function was called. This function is also used to create intialize a queue.

<a name="see-alson-"></a>

# See Also\N 

_tapset::queue_stats_(3stap)
