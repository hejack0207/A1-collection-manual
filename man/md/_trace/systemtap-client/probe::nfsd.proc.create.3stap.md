# probe::nfsd\&.proc\&(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfsd.proc.create - NFS server creating a file for client

<a name="synopsis"></a>

# Synopsis

```


```
    nfsd.proc.create 

<a name="values"></a>

# Values


_filename_
file name

_version_
nfs version

_gid_
requesters group id

_fh_
file handle (the first part is the length of the file handle)

_uid_
requesters user id

_client\_ip_
the ip address of client

_proto_
transfer protocol

_filelen_
length of file name

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfsd_(3stap)
