# probe::kprocess\&.ex(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::kprocess.exec_complete - Return from exec to a new program

<a name="synopsis"></a>

# Synopsis

```


```
    kprocess.exec_complete 

<a name="values"></a>

# Values


_errno_
The error number resulting from the exec

_retstr_
A string representation of errno (SystemTap v2.5+)

_success_
A boolean indicating whether the exec was successful

_name_
Name of the system call (“execve”) (SystemTap v2.5+)

<a name="context"></a>

# Context


On success, the context of the new executable. On failure, remains in the context of the caller.

<a name="description"></a>

# Description


Fires at the completion of an exec call. Aliased to the syscall.execve.return probe in SystemTap v2.5+.

<a name="see-alson-"></a>

# See Also\N 

_tapset::kprocess_(3stap)
