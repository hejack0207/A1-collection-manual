# function::log(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::log - Send a line to the common trace buffer

<a name="synopsis"></a>

# Synopsis

```


```
        log(msg:string)

<a name="arguments"></a>

# Arguments


_msg_
The formatted message string

<a name="description"></a>

# Description


This function logs data. log sends the message immediately to staprun and to the bulk transport (relayfs) if it is being used. If the last character given is not a newline, then one is added. This function is not as efficient as printf and should be used only for urgent messages.

<a name="see-alson-"></a>

# See Also\N 

_tapset::logging_(3stap)
