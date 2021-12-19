# function::fullpath_s(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::fullpath_struct_nameidata - get the full nameidata path

<a name="synopsis"></a>

# Synopsis

```


```
        fullpath_struct_nameidata(nd:)

<a name="arguments"></a>

# Arguments


_nd_
Pointer to
“struct nameidata”.

<a name="description"></a>

# Description



Returns the full dirent name (full path to the root), like the kernel (and systemtap-tapset) d_path function, with a
“/”.
