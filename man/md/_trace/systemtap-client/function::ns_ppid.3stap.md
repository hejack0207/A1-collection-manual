# function::ns_ppid(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::ns_ppid - Returns the process ID of a target processs parent process as seen in a pid namespace

<a name="synopsis"></a>

# Synopsis

```


```
        ns_ppid:long()

<a name="arguments"></a>

# Arguments


None

<a name="description"></a>

# Description


This function return the process ID of the target proccesss parent process as seen in the target pid namespace if provided, or the stap process namespace.

<a name="see-alson-"></a>

# See Also\N 

_tapset::context_(3stap)
