# function::read_stopw(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::read_stopwatch_us - Reads the time in microseconds for a stopwatch

<a name="synopsis"></a>

# Synopsis

```


```
        read_stopwatch_us:long(name:string)

<a name="arguments"></a>

# Arguments


_name_
stopwatch name

<a name="description"></a>

# Description


Returns time in microseconds for stopwatch
_name_. Creates stopwatch
_name_
if it does not currently exist.

<a name="see-alson-"></a>

# See Also\N 

_tapset::stopwatch_(3stap)
