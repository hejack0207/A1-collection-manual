# function::warn(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::warn - Send a line to the warning stream

<a name="synopsis"></a>

# Synopsis

```


```
        warn(msg:string)

<a name="arguments"></a>

# Arguments


_msg_
The formatted message string

<a name="description"></a>

# Description


This function sends a warning message immediately to staprun. It is also sent over the bulk transport (relayfs) if it is being used. If the last characater is not a newline, the one is added.

<a name="see-alson-"></a>

# See Also\N 

_tapset::logging_(3stap)
