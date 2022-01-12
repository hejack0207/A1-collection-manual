# probe::nfs\&.proc\&.(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfs.proc.write - NFS client synchronously writes file to server

<a name="synopsis"></a>

# Synopsis

```


```
    nfs.proc.write 

<a name="values"></a>

# Values


_bitmask1_
V4 bitmask representing the set of attributes supported on this filesystem

_flags_
used to set task-&gt;tk_flags in rpc_init_task function

_offset_
the file offset

_version_
NFS version

_size_
read bytes in this execution

_bitmask0_
V4 bitmask representing the set of attributes supported on this filesystem

_server\_ip_
IP address of server

_prot_
transfer protocol

<a name="description"></a>

# Description


All the nfs.proc.write kernel functions were removed in kernel commit 200baa in December 2006, so these probes do not exist on Linux 2.6.21 and newer kernels.

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfs_proc_(3stap)
