# probe::nfsd\&.create(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfsd.createv3 - NFS server creating a regular file or set file attributes for client

<a name="synopsis"></a>

# Synopsis

```


```
    nfsd.createv3 

<a name="values"></a>

# Values


_filename_
file name

_iap\_mode_
file access mode

_truncp_
trunp arguments, indicates if the file shouldbe truncate

_iap\_valid_
Attribute flags

_verifier_
file attributes (atime,mtime,mode). Its used to reset file attributes for CREATE_EXCLUSIVE

_createmode_
create mode .The possible values could be: NFS3_CREATE_EXCLUSIVE, NFS3_CREATE_UNCHECKED, or NFS3_CREATE_GUARDED

_client\_ip_
the ip address of client

_filelen_
the length of file name

_fh_
file handle (the first part is the length of the file handle)

<a name="description"></a>

# Description


This probepoints is only called by nfsd3_proc_create and nfsd4_open when op_claim_type is NFS4_OPEN_CLAIM_NULL.

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfsd_(3stap)
