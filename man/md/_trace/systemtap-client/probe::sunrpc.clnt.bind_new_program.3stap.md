# probe::sunrpc\&.clnt(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::sunrpc.clnt.bind_new_program - Bind a new RPC program to an existing client

<a name="synopsis"></a>

# Synopsis

```


```
    sunrpc.clnt.bind_new_program 

<a name="values"></a>

# Values


_old\_progname_
the name of old RPC program

_servername_
the server machine name

_old\_vers_
the version of old RPC program

_prog_
the number of new RPC program

_old\_prog_
the number of old RPC program

_progname_
the name of new RPC program

_vers_
the version of new RPC program

<a name="see-alson-"></a>

# See Also\N 

_tapset::rpc_(3stap)
