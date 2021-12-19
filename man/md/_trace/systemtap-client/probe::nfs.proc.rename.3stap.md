# probe::nfs\&.proc\&.(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfs.proc.rename - NFS client renames a file on server

<a name="synopsis"></a>

# Synopsis

```


```
    nfs.proc.rename 

<a name="values"></a>

# Values


_server\_ip_
IP address of server

_new\_name_
new file name

_old\_name_
old file name

_version_
NFS version (the function is used for all NFS version)

_prot_
transfer protocol

_old\_filelen_
length of old file name

_old\_fh_
file handle of old parent dir

_new\_fh_
file handle of new parent dir

_new\_filelen_
length of new file name

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfs_proc_(3stap)
