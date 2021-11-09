# function::cpu_clock_(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::cpu_clock_ms - Number of milliseconds on the given cpus clock

<a name="synopsis"></a>

# Synopsis

```


```
        cpu_clock_ms:long(cpu:long)

<a name="arguments"></a>

# Arguments


_cpu_
Which processors clock to read

<a name="description"></a>

# Description


This function returns the number of milliseconds on the given cpus clock. This is always monotonic comparing on the same cpu, but may have some drift between cpus (within about a jiffy).

<a name="see-alson-"></a>

# See Also\N 

_tapset::timestamp_monotonic_(3stap)
