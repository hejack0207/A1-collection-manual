# function::inode_name(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::inode_name - get the inode name

<a name="synopsis"></a>

# Synopsis

```


```
        inode_name:string(inode:long)

<a name="arguments"></a>

# Arguments


_inode_
Pointer to inode.

<a name="description"></a>

# Description



Returns the first path basename associated with the given inode.
