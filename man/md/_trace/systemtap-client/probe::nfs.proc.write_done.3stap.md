# probe::nfs\&.proc\&.(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfs.proc.write_done - NFS client response to a write RPC task

<a name="synopsis"></a>

# Synopsis

```


```
    nfs.proc.write_done 

<a name="values"></a>

# Values


_timestamp_
V4 timestamp, which is used for lease renewal

_status_
result of last operation

_prot_
transfer protocol

_version_
NFS version

_count_
number of bytes written

_server\_ip_
IP address of server

_valid_
fattr-&gt;valid, indicates which fields are valid

<a name="description"></a>

# Description


Fires when a reply to a write RPC task is received or some write error occurs (timeout or socket shutdown).

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfs_proc_(3stap)
