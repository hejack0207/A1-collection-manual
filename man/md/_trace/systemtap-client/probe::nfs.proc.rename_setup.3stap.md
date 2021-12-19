# probe::nfs\&.proc\&.(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfs.proc.rename_setup - NFS client setting up a rename RPC task

<a name="synopsis"></a>

# Synopsis

```


```
    nfs.proc.rename_setup 

<a name="values"></a>

# Values


_version_
NFS version

_server\_ip_
IP address of server

_fh_
file handle of parent dir

_prot_
transfer protocol

<a name="description"></a>

# Description


The rename_setup function is used to setup a rename RPC task. Is is not doing the actual rename operation.

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfs_proc_(3stap)
