# function::fullpath_s(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::fullpath_struct_path - get the full path

<a name="synopsis"></a>

# Synopsis

```


```
        fullpath_struct_path:string(path:long)

<a name="arguments"></a>

# Arguments


_path_
Pointer to
“struct path”.

<a name="description"></a>

# Description



Returns the full dirent name (full path to the root), like the kernel d_path function.
