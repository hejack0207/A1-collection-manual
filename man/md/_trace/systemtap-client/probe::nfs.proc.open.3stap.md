# probe::nfs\&.proc\&.(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfs.proc.open - NFS client allocates file read/write context information

<a name="synopsis"></a>

# Synopsis

```


```
    nfs.proc.open 

<a name="values"></a>

# Values


_filename_
file name

_prot_
transfer protocol

_mode_
file mode

_server\_ip_
IP address of server

_flag_
file flag

_version_
NFS version (the function is used for all NFS version)

<a name="description"></a>

# Description


Allocate file read/write context information

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfs_proc_(3stap)
