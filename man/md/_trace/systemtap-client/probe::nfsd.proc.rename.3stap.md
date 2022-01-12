# probe::nfsd\&.proc\&(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfsd.proc.rename - NFS Server renaming a file for client

<a name="synopsis"></a>

# Synopsis

```


```
    nfsd.proc.rename 

<a name="values"></a>

# Values


_tname_
new file name

_fh_
file handler of old path

_uid_
requesters user id

_flen_
length of old file name

_client\_ip_
the ip address of client

_tfh_
file handler of new path

_gid_
requesters group id

_filename_
old file name

_tlen_
length of new file name

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfsd_(3stap)
