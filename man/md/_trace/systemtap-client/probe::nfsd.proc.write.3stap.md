# probe::nfsd\&.proc\&(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfsd.proc.write - NFS server writing data to file for client

<a name="synopsis"></a>

# Synopsis

```


```
    nfsd.proc.write 

<a name="values"></a>

# Values


_count_
read bytes

_client\_ip_
the ip address of client

_proto_
transfer protocol

_vlen_
read blocks

_offset_
the offset of file

_vec_
struct kvec, includes buf address in kernel address and length of each buffer

_fh_
file handle (the first part is the length of the file handle)

_uid_
requesters user id

_size_
read bytes

_version_
nfs version

_gid_
requesters group id

_stable_
argp-&gt;stable

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfsd_(3stap)
