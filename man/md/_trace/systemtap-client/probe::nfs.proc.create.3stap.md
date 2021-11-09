# probe::nfs\&.proc\&.(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfs.proc.create - NFS client creating file on server

<a name="synopsis"></a>

# Synopsis

```


```
    nfs.proc.create 

<a name="values"></a>

# Values


_filelen_
length of file name

_server\_ip_
IP address of server

_fh_
file handle of parent dir

_flag_
indicates create mode (only for NFSv3 and NFSv4)

_version_
NFS version (the function is used for all NFS version)

_prot_
transfer protocol

_filename_
file name

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfs_proc_(3stap)
