# probe::syscall_any(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::syscall_any - Record entry into a syscall

<a name="synopsis"></a>

# Synopsis

```


```
    syscall_any 

<a name="values"></a>

# Values


_name_
name of the syscall

_syscall\_nr_
number of the syscall

<a name="context"></a>

# Context


The process performing the syscall

<a name="description"></a>

# Description


The syscall_any probe point is designed to be a low overhead that monitors all the syscalls entered via a kernel tracepoint. Because of the breadth of syscalls it monitors it provides no information about the syscall arguments or argstr string representation of those arguments.

This requires kernel 3.5+ and newer which have the kernel.trace(“sys_enter”) probe point.

<a name="see-alson-"></a>

# See Also\N 

_tapset::syscall_any_(3stap)
