# function::raise(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::raise - raise a signal in the current thread

<a name="synopsis"></a>

# Synopsis

```


```
        raise(signo:long)

<a name="arguments"></a>

# Arguments


_signo_
signal number

<a name="description"></a>

# Description


This function calls the kernel send_sig routine on the current thread, with the given raw unchecked signal number. It may raise an error if
**send\_sig**
failed. It requires guru mode.

<a name="see-alson-"></a>

# See Also\N 

_tapset::guru-signal_(3stap)
