# probe::nfs\&.proc\&.(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfs.proc.rename_done - NFS client response to a rename RPC task

<a name="synopsis"></a>

# Synopsis

```


```
    nfs.proc.rename_done 

<a name="values"></a>

# Values


_version_
NFS version

_server\_ip_
IP address of server

_new\_fh_
file handle of new parent dir

_status_
result of last operation

_timestamp_
V4 timestamp, which is used for lease renewal

_prot_
transfer protocol

_old\_fh_
file handle of old parent dir

<a name="description"></a>

# Description


Fires when a reply to a rename RPC task is received or some rename error occurs (timeout or socket shutdown).

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfs_proc_(3stap)
