# function::panic(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::panic - trigger a panic

<a name="synopsis"></a>

# Synopsis

```


```
        panic(msg:string)

<a name="arguments"></a>

# Arguments


_msg_
message to pass to kernels
**panic**
function

<a name="description"></a>

# Description


This function triggers an immediate panic of the running kernel with a user-specified panic message. It requires guru mode.

<a name="see-alson-"></a>

# See Also\N 

_tapset::panic_(3stap)
