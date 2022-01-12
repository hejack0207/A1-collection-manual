# probe::nfs\&.proc\&.(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfs.proc.read - NFS client synchronously reads file from server

<a name="synopsis"></a>

# Synopsis

```


```
    nfs.proc.read 

<a name="values"></a>

# Values


_prot_
transfer protocol

_count_
read bytes in this execution

_server\_ip_
IP address of server

_flags_
used to set task-&gt;tk_flags in rpc_init_task function

_offset_
the file offset

_version_
NFS version

<a name="description"></a>

# Description


All the nfs.proc.read kernel functions were removed in kernel commit 8e0969 in December 2006, so these probes do not exist on Linux 2.6.21 and newer kernels.

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfs_proc_(3stap)
