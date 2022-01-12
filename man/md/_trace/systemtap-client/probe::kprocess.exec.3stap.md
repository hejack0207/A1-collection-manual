# probe::kprocess\&.ex(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::kprocess.exec - Attempt to exec to a new program

<a name="synopsis"></a>

# Synopsis

```


```
    kprocess.exec 

<a name="values"></a>

# Values


_args_
The arguments to pass to the new executable, including the 0th arg (SystemTap v2.5+)

_argstr_
A string containing the filename followed by the arguments to pass, excluding 0th arg (SystemTap v2.5+)

_filename_
The path to the new executable

_name_
Name of the system call (“execve”) (SystemTap v2.5+)

<a name="context"></a>

# Context


The caller of exec.

<a name="description"></a>

# Description


Fires whenever a process attempts to exec to a new program. Aliased to the syscall.execve probe in SystemTap v2.5+.

<a name="see-alson-"></a>

# See Also\N 

_tapset::kprocess_(3stap)
