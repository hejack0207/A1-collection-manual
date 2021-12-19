# function::qs_run(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::qs_run - Function to record being moved from wait queue to being serviced

<a name="synopsis"></a>

# Synopsis

```


```
        qs_run(qname:string)

<a name="arguments"></a>

# Arguments


_qname_
the name of the service being moved and started

<a name="description"></a>

# Description


This function records that the previous enqueued request was removed from the given wait queue and is now being serviced.

<a name="see-alson-"></a>

# See Also\N 

_tapset::queue_stats_(3stap)
