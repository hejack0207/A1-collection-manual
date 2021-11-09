# probe::sunrpc\&.clnt(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::sunrpc.clnt.shutdown_client - Shutdown an RPC client

<a name="synopsis"></a>

# Synopsis

```


```
    sunrpc.clnt.shutdown_client 

<a name="values"></a>

# Values


_prot_
the IP protocol number

_servername_
the server machine name

_clones_
the number of clones

_om\_execute_
the RPC execution jiffies

_port_
the port number

_tasks_
the number of references

_authflavor_
the authentication flavor

_netreconn_
the count of reconnections

_om\_ntrans_
the count of RPC transmissions

_progname_
the RPC program name

_om\_queue_
the jiffies queued for xmit

_om\_ops_
the count of operations

_vers_
the RPC program version number

_rpccnt_
the count of RPC calls

_prog_
the RPC program number

_om\_bytes\_sent_
the count of bytes out

_om\_rtt_
the RPC RTT jiffies

_om\_bytes\_recv_
the count of bytes in

<a name="see-alson-"></a>

# See Also\N 

_tapset::rpc_(3stap)
