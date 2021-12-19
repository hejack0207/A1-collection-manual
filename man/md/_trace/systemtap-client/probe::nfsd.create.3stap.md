# probe::nfsd\&.create(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfsd.create - NFS server creating a file(regular,dir,device,fifo) for client

<a name="synopsis"></a>

# Synopsis

```


```
    nfsd.create 

<a name="values"></a>

# Values


_client\_ip_
the ip address of client

_filelen_
the length of file name

_type_
file type(regular,dir,device,fifo ...)

_fh_
file handle (the first part is the length of the file handle)

_iap\_mode_
file access mode

_filename_
file name

_iap\_valid_
Attribute flags

<a name="description"></a>

# Description


Sometimes nfsd will call nfsd_create_v3 instead of this this probe point.

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfsd_(3stap)
