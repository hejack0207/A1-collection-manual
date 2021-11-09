# function::task_dentr(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::task_dentry_path - get the full dentry path

<a name="synopsis"></a>

# Synopsis

```


```
        task_dentry_path:string(task:long,dentry:long,vfsmnt:long)

<a name="arguments"></a>

# Arguments


_task_
task_struct pointer.

_dentry_
direntry pointer.

_vfsmnt_
vfsmnt pointer.

<a name="description"></a>

# Description



Returns the full dirent name (full path to the root), like the kernel d_path function.
