# function::is_sig_blo(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::is_sig_blocked - Returns 1 if the signal is currently blocked, or 0 if it is not

<a name="synopsis"></a>

# Synopsis

```


```
        is_sig_blocked:long(task:long,sig:long)

<a name="arguments"></a>

# Arguments


_task_
address of the task_struct to query.

_sig_
the signal number to test.

<a name="see-alson-"></a>

# See Also\N 

_tapset::signal_(3stap)
