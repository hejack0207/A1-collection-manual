# function::get_cycles(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::get_cycles - Processor cycle count

<a name="synopsis"></a>

# Synopsis

```


```
        get_cycles:long()

<a name="arguments"></a>

# Arguments


None

<a name="description"></a>

# Description


This function returns the processor cycle counter value if available, else it returns zero. The cycle counter is free running and unsynchronized on each processor. Thus, the order of events cannot determined by comparing the results of the get_cycles function on different processors.

<a name="see-alson-"></a>

# See Also\N 

_tapset::timestamp_(3stap)
