# probe::nfs\&.proc\&.(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfs.proc.release - NFS client releases file read/write context information

<a name="synopsis"></a>

# Synopsis

```


```
    nfs.proc.release 

<a name="values"></a>

# Values


_server\_ip_
IP address of server

_version_
NFS version (the function is used for all NFS version)

_flag_
file flag

_mode_
file mode

_prot_
transfer protocol

_filename_
file name

<a name="description"></a>

# Description


Release file read/write context information

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfs_proc_(3stap)
