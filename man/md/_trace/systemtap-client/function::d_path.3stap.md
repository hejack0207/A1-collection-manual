# function::d_path(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::d_path - get the full nameidata path

<a name="synopsis"></a>

# Synopsis

```


```
        d_path:string(nd:long)

<a name="arguments"></a>

# Arguments


_nd_
Pointer to nameidata.

<a name="description"></a>

# Description



Returns the full dirent name (full path to the root), like the kernel d_path function.
