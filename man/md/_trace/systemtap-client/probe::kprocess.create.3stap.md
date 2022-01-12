# probe::kprocess\&.cr(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::kprocess.create - Fires whenever a new process or thread is successfully created

<a name="synopsis"></a>

# Synopsis

```


```
    kprocess.create 

<a name="values"></a>

# Values


_new\_pid_
The PID of the newly created process

_new\_tid_
The TID of the newly created task

<a name="context"></a>

# Context


Parent of the created process.

<a name="description"></a>

# Description


Fires whenever a new process is successfully created, either as a result of fork (or one of its syscall variants), or a new kernel thread.

<a name="see-alson-"></a>

# See Also\N 

_tapset::kprocess_(3stap)
