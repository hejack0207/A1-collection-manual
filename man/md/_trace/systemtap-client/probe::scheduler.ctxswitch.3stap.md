# probe::scheduler\&.c(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::scheduler.ctxswitch - A context switch is occuring.

<a name="synopsis"></a>

# Synopsis

```


```
    scheduler.ctxswitch 

<a name="values"></a>

# Values


_next\_tid_
The TID of the process to be switched in

_prevtsk\_state_
the state of the process to be switched out

_prev\_task\_name_
The name of the process to be switched out

_next\_priority_
The priority of the process to be switched in

_next\_pid_
The PID of the process to be switched in

_prev\_tid_
The TID of the process to be switched out

_nexttsk\_state_
the state of the process to be switched in

_next\_task\_name_
The name of the process to be switched in

_prev\_pid_
The PID of the process to be switched out

_name_
name of the probe point

_prev\_priority_
The priority of the process to be switched out

<a name="see-alson-"></a>

# See Also\N 

_tapset::scheduler_(3stap)
