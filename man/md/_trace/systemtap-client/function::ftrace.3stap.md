# function::ftrace(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::ftrace - Send a message to the ftrace ring-buffer

<a name="synopsis"></a>

# Synopsis

```


```
        ftrace(msg:string)

<a name="arguments"></a>

# Arguments


_msg_
The formatted message string

<a name="description"></a>

# Description


If the ftrace ring-buffer is configured & available, see /debugfs/tracing/trace for the message. Otherwise, the message may be quietly dropped. An implicit end-of-line is added.

<a name="see-alson-"></a>

# See Also\N 

_tapset::logging_(3stap)
