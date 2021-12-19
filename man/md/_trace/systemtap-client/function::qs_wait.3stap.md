# function::qs_wait(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::qs_wait - Function to record enqueue requests

<a name="synopsis"></a>

# Synopsis

```


```
        qs_wait(qname:string)

<a name="arguments"></a>

# Arguments


_qname_
the name of the queue requesting enqueue

<a name="description"></a>

# Description


This function records that a new request was enqueued for the given queue name.

<a name="see-alson-"></a>

# See Also\N 

_tapset::queue_stats_(3stap)
