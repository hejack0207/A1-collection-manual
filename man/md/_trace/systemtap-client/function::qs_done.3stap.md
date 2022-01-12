# function::qs_done(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::qs_done - Function to record finishing request

<a name="synopsis"></a>

# Synopsis

```


```
        qs_done(qname:string)

<a name="arguments"></a>

# Arguments


_qname_
the name of the service that finished

<a name="description"></a>

# Description


This function records that a request originally from the given queue has completed being serviced.

<a name="see-alson-"></a>

# See Also\N 

_tapset::queue_stats_(3stap)
