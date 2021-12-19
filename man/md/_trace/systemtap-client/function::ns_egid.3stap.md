# function::ns_egid(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::ns_egid - Returns the effective gid of a target process as seen in a user namespace

<a name="synopsis"></a>

# Synopsis

```


```
        ns_egid:long()

<a name="arguments"></a>

# Arguments


None

<a name="description"></a>

# Description


This function returns the effective gid of a target process as seen in the target user namespace if provided, or the stap process namespace

<a name="see-alson-"></a>

# See Also\N 

_tapset::context_(3stap)
