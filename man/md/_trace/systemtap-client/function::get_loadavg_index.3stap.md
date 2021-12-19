# function::get_loadav(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::get_loadavg_index - Get the load average for a specified interval

<a name="synopsis"></a>

# Synopsis

```


```
        get_loadavg_index:long(indx:long)

<a name="arguments"></a>

# Arguments


_indx_
The load average interval to capture.

<a name="description"></a>

# Description


This function returns the load average at a specified interval. The three load average values 1, 5 and 15 minute average corresponds to indexes 0, 1 and 2 of the avenrun array - see linux/sched.h. Please note that the truncated-integer portion of the load average is returned. If the specified index is out-of-bounds, then an error message and exception is thrown.

<a name="see-alson-"></a>

# See Also\N 

_tapset::loadavg_(3stap)
