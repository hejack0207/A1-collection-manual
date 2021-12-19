# function::ns_pgrp(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::ns_pgrp - Returns the process group ID of the current process as seen in a pid namespace

<a name="synopsis"></a>

# Synopsis

```


```
        ns_pgrp:long()

<a name="arguments"></a>

# Arguments


None

<a name="description"></a>

# Description


This function returns the process group ID of the current process as seen in the target pid namespace if provided, or the stap process namespace.

<a name="see-alson-"></a>

# See Also\N 

_tapset::context_(3stap)
