# probe::nfs\&.proc\&.(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfs.proc.read_done - NFS client response to a read RPC task

<a name="synopsis"></a>

# Synopsis

```


```
    nfs.proc.read_done 

<a name="values"></a>

# Values


_version_
NFS version

_count_
number of bytes read

_server\_ip_
IP address of server

_timestamp_
V4 timestamp, which is used for lease renewal

_status_
result of last operation

_prot_
transfer protocol

<a name="description"></a>

# Description


Fires when a reply to a read RPC task is received or some read error occurs (timeout or socket shutdown).

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfs_proc_(3stap)
