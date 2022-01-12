# probe::nfs\&.proc\&.(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfs.proc.lookup - NFS client opens/searches a file on server

<a name="synopsis"></a>

# Synopsis

```


```
    nfs.proc.lookup 

<a name="values"></a>

# Values


_prot_
transfer protocol

_filename_
the name of file which client opens/searches on server

_server\_ip_
IP address of server

_bitmask0_
V4 bitmask representing the set of attributes supported on this filesystem

_version_
NFS version

_name\_len_
the length of file name

_bitmask1_
V4 bitmask representing the set of attributes supported on this filesystem

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfs_proc_(3stap)
