# probe::nfsd\&.commit(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfsd.commit - NFS server committing all pending writes to stable storage

<a name="synopsis"></a>

# Synopsis

```


```
    nfsd.commit 

<a name="values"></a>

# Values


_size_
read bytes

_flag_
indicates whether this execution is a sync operation

_fh_
file handle (the first part is the length of the file handle)

_offset_
the offset of file

_count_
read bytes

_client\_ip_
the ip address of client

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfsd_(3stap)
