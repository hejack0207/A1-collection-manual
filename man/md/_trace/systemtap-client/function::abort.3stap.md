# function::abort(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::abort - Immediately shutting down probing script.

<a name="synopsis"></a>

# Synopsis

```


```
        abort()

<a name="arguments"></a>

# Arguments


None

<a name="description"></a>

# Description


This is similar to
**exit**
but immediately aborts the current probe handler instead of waiting for its completion. Probe handlers already running on *other* CPU cores, however, will still continue to their completion. Unlike
**error**, this function call cannot be caught by try ... catch\*(Aq.

<a name="see-alson-"></a>

# See Also\N 

_tapset::logging_(3stap)
