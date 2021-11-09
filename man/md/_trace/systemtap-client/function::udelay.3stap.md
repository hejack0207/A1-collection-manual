# function::udelay(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::udelay - microsecond delay

<a name="synopsis"></a>

# Synopsis

```


```
        udelay(us:long)

<a name="arguments"></a>

# Arguments


_us_
Number of microseconds to delay.

<a name="description"></a>

# Description


This function inserts a multi-microsecond busy-delay into a probe handler. It requires guru mode.

<a name="see-alson-"></a>

# See Also\N 

_tapset::guru-delay_(3stap)
