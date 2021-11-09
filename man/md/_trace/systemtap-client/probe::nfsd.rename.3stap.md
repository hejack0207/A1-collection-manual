# probe::nfsd\&.rename(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfsd.rename - NFS server renaming a file for client

<a name="synopsis"></a>

# Synopsis

```


```
    nfsd.rename 

<a name="values"></a>

# Values


_flen_
length of old file name

_client\_ip_
the ip address of client

_tfh_
file handler of new path

_tname_
new file name

_fh_
file handler of old path

_filename_
old file name

_tlen_
length of new file name

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfsd_(3stap)
