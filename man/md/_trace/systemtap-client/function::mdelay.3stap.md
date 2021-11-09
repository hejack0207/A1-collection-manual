# function::mdelay(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::mdelay - millisecond delay

<a name="synopsis"></a>

# Synopsis

```


```
        mdelay(ms:long)

<a name="arguments"></a>

# Arguments


_ms_
Number of milliseconds to delay.

<a name="description"></a>

# Description


This function inserts a multi-millisecond busy-delay into a probe handler. It requires guru mode.

<a name="see-alson-"></a>

# See Also\N 

_tapset::guru-delay_(3stap)
