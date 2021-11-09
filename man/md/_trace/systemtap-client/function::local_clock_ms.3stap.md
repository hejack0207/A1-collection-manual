# function::local_cloc(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::local_clock_ms - Number of milliseconds on the local cpus clock

<a name="synopsis"></a>

# Synopsis

```


```
        local_clock_ms:long()

<a name="arguments"></a>

# Arguments


None

<a name="description"></a>

# Description


This function returns the number of milliseconds on the local cpus clock. This is always monotonic comparing on the same cpu, but may have some drift between cpus (within about a jiffy).

<a name="see-alson-"></a>

# See Also\N 

_tapset::timestamp_monotonic_(3stap)
