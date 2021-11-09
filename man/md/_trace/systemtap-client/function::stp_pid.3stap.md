# function::stp_pid(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::stp_pid - The process id of the stapio process

<a name="synopsis"></a>

# Synopsis

```


```
        stp_pid:long()

<a name="arguments"></a>

# Arguments


None

<a name="description"></a>

# Description


This function returns the process id of the stapio process that launched this script. There could be other SystemTap scripts and stapio processes running on the system.

<a name="see-alson-"></a>

# See Also\N 

_tapset::context_(3stap)
