# function::sid(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::sid - Returns the session ID of the current process

<a name="synopsis"></a>

# Synopsis

```


```
        sid:long()

<a name="arguments"></a>

# Arguments


None

<a name="description"></a>

# Description


The session ID of a process is the process group ID of the session leader. Session ID is stored in the signal_struct since Kernel 2.6.0.

<a name="see-alson-"></a>

# See Also\N 

_tapset::context_(3stap)
