# probe::nfsd\&.proc\&(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfsd.proc.commit - NFS server performing a commit operation for client

<a name="synopsis"></a>

# Synopsis

```


```
    nfsd.proc.commit 

<a name="values"></a>

# Values


_size_
read bytes

_gid_
requesters group id

_version_
nfs version

_client\_ip_
the ip address of client

_count_
read bytes

_proto_
transfer protocol

_offset_
the offset of file

_uid_
requesters user id

_fh_
file handle (the first part is the length of the file handle)

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfsd_(3stap)
