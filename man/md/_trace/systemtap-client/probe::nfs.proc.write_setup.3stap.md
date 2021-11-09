# probe::nfs\&.proc\&.(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfs.proc.write_setup - NFS client setting up a write RPC task

<a name="synopsis"></a>

# Synopsis

```


```
    nfs.proc.write_setup 

<a name="values"></a>

# Values


_prot_
transfer protocol

_how_
used to set args.stable. The stable value could be: NFS_UNSTABLE,NFS_DATA_SYNC,NFS_FILE_SYNC (in nfs.proc3.write_setup and nfs.proc4.write_setup)

_offset_
the file offset

_bitmask1_
V4 bitmask representing the set of attributes supported on this filesystem

_version_
NFS version

_bitmask0_
V4 bitmask representing the set of attributes supported on this filesystem

_server\_ip_
IP address of server

_count_
bytes written in this execution

_size_
bytes written in this execution

<a name="description"></a>

# Description


The write_setup function is used to setup a write RPC task. It is not doing the actual write operation.

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfs_proc_(3stap)
