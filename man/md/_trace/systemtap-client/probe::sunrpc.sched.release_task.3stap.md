# probe::sunrpc\&.sche(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::sunrpc.sched.release_task - Release all resources associated with a task

<a name="synopsis"></a>

# Synopsis

```


```
    sunrpc.sched.release_task 

<a name="values"></a>

# Values


_prot_
the IP protocol in the RPC call

_xid_
the transmission id in the RPC call

_vers_
the program version in the RPC call

_tk\_flags_
the flags of the task

_prog_
the program number in the RPC call

<a name="description"></a>

# Description


**rpc\_release\_task**
function might not be found for a particular kernel. So, if we cant find it, just return \*(Aq-1\*(Aq for everything.

<a name="see-alson-"></a>

# See Also\N 

_tapset::rpc_(3stap)
