# function::error(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::error - Send an error message

<a name="synopsis"></a>

# Synopsis

```


```
        error(msg:string)

<a name="arguments"></a>

# Arguments


_msg_
The formatted message string

<a name="description"></a>

# Description


An implicit end-of-line is added. staprun prepends the string
“ERROR:”. Sending an error message aborts the currently running probe. Depending on the MAXERRORS parameter, it may trigger an
**exit**.

<a name="see-alson-"></a>

# See Also\N 

_tapset::logging_(3stap)
