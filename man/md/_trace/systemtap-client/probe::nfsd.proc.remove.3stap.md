# probe::nfsd\&.proc\&(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfsd.proc.remove - NFS server removing a file for client

<a name="synopsis"></a>

# Synopsis

```


```
    nfsd.proc.remove 

<a name="values"></a>

# Values


_gid_
requesters group id

_version_
nfs version

_filename_
file name

_filelen_
length of file name

_proto_
transfer protocol

_client\_ip_
the ip address of client

_fh_
file handle (the first part is the length of the file handle)

_uid_
requesters user id

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfsd_(3stap)
