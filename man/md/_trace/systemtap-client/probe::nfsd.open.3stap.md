# probe::nfsd\&.open(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfsd.open - NFS server opening a file for client

<a name="synopsis"></a>

# Synopsis

```


```
    nfsd.open 

<a name="values"></a>

# Values


_access_
indicates the type of open (read/write/commit/readdir...)

_fh_
file handle (the first part is the length of the file handle)

_client\_ip_
the ip address of client

_type_
type of file (regular file or dir)

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfsd_(3stap)
