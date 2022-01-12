# probe::nfsd\&.unlink(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfsd.unlink - NFS server removing a file or a directory for client

<a name="synopsis"></a>

# Synopsis

```


```
    nfsd.unlink 

<a name="values"></a>

# Values


_type_
file type (file or dir)

_filelen_
the length of file name

_client\_ip_
the ip address of client

_fh_
file handle (the first part is the length of the file handle)

_filename_
file name

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfsd_(3stap)
