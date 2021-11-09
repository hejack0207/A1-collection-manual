# probe::nfsd\&.proc\&(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfsd.proc.lookup - NFS server opening or searching for a file for client

<a name="synopsis"></a>

# Synopsis

```


```
    nfsd.proc.lookup 

<a name="values"></a>

# Values


_filename_
file name

_client\_ip_
the ip address of client

_gid_
requesters group id

_filelen_
the length of file name

_version_
nfs version

_proto_
transfer protocol

_fh_
file handle of parent dir (the first part is the length of the file handle)

_uid_
requesters user id

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfsd_(3stap)
