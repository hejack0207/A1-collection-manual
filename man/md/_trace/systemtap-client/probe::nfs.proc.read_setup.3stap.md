# probe::nfs\&.proc\&.(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfs.proc.read_setup - NFS client setting up a read RPC task

<a name="synopsis"></a>

# Synopsis

```


```
    nfs.proc.read_setup 

<a name="values"></a>

# Values


_prot_
transfer protocol

_version_
NFS version

_offset_
the file offset

_count_
read bytes in this execution

_server\_ip_
IP address of server

_size_
read bytes in this execution

<a name="description"></a>

# Description


The read_setup function is used to setup a read RPC task. It is not doing the actual read operation.

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfs_proc_(3stap)
