# function::uaddr(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::uaddr - User space address of current running task

<a name="synopsis"></a>

# Synopsis

```


```
        uaddr:long()

<a name="arguments"></a>

# Arguments


None

<a name="description"></a>

# Description


Returns the address in userspace that the current task was at when the probe occurred. When the current running task isnt a user space thread, or the address cannot be found, zero is returned. Can be used to see where the current task is combined with
**usymname**
or
**usymdata**. Often the task will be in the VDSO where it entered the kernel.

<a name="see-alson-"></a>

# See Also\N 

_tapset::context_(3stap)
