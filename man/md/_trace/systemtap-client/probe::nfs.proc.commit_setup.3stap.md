# probe::nfs\&.proc\&.(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfs.proc.commit_setup - NFS client setting up a commit RPC task

<a name="synopsis"></a>

# Synopsis

```


```
    nfs.proc.commit_setup 

<a name="values"></a>

# Values


_prot_
transfer protocol

_bitmask1_
V4 bitmask representing the set of attributes supported on this filesystem

_offset_
the file offset

_version_
NFS version

_size_
bytes in this commit

_server\_ip_
IP address of server

_bitmask0_
V4 bitmask representing the set of attributes supported on this filesystem

_count_
bytes in this commit

<a name="description"></a>

# Description


The commit_setup function is used to setup a commit RPC task. Is is not doing the actual commit operation. It does not exist in NFSv2.

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfs_proc_(3stap)
