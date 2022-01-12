# probe::sunrpc\&.clnt(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::sunrpc.clnt.call_sync - Make a synchronous RPC call

<a name="synopsis"></a>

# Synopsis

```


```
    sunrpc.clnt.call_sync 

<a name="values"></a>

# Values


_prot_
the IP protocol number

_servername_
the server machine name

_port_
the port number

_xid_
current transmission id

_progname_
the RPC program name

_proc_
the procedure number in this RPC call

_flags_
flags

_vers_
the RPC program version number

_prog_
the RPC program number

_procname_
the procedure name in this RPC call

_dead_
whether this client is abandoned

<a name="see-alson-"></a>

# See Also\N 

_tapset::rpc_(3stap)
