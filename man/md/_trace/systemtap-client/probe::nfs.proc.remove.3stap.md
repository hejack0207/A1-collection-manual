# probe::nfs\&.proc\&.(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfs.proc.remove - NFS client removes a file on server

<a name="synopsis"></a>

# Synopsis

```


```
    nfs.proc.remove 

<a name="values"></a>

# Values


_filename_
file name

_prot_
transfer protocol

_fh_
file handle of parent dir

_server\_ip_
IP address of server

_filelen_
length of file name

_version_
NFS version (the function is used for all NFS version)

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfs_proc_(3stap)
