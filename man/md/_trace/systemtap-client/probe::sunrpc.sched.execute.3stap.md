# probe::sunrpc\&.sche(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::sunrpc.sched.execute - Execute the RPC \`scheduler

<a name="synopsis"></a>

# Synopsis

```


```
    sunrpc.sched.execute 

<a name="values"></a>

# Values


_tk\_flags_
the flags of the task

_vers_
the program version in the RPC call

_prog_
the program number in the RPC call

_prot_
the IP protocol in the RPC call

_xid_
the transmission id in the RPC call

_tk\_pid_
the debugging id of the task

<a name="see-alson-"></a>

# See Also\N 

_tapset::rpc_(3stap)
