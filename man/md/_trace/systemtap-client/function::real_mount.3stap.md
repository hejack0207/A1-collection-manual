# function::real_mount(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::real_mount - get the struct mount\*(Aq pointer

<a name="synopsis"></a>

# Synopsis

```


```
        real_mount:long(vfsmnt:long)

<a name="arguments"></a>

# Arguments


_vfsmnt_
Pointer to struct vfsmount\*(Aq

<a name="description"></a>

# Description



Returns the struct mount\*(Aq pointer value for a \*(Aqstruct vfsmount\*(Aq pointer.
