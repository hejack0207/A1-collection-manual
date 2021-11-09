# probe::nfsd\&.lookup(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfsd.lookup - NFS server opening or searching file for a file for client

<a name="synopsis"></a>

# Synopsis

```


```
    nfsd.lookup 

<a name="values"></a>

# Values


_fh_
file handle of parent dir(the first part is the length of the file handle)

_filelen_
the length of file name

_client\_ip_
the ip address of client

_filename_
file name

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfsd_(3stap)
