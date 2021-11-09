# probe::nfsd\&.read(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfsd.read - NFS server reading data from a file for client

<a name="synopsis"></a>

# Synopsis

```


```
    nfsd.read 

<a name="values"></a>

# Values


_size_
read bytes

_file_
argument file, indicates if the file has been opened.

_fh_
file handle (the first part is the length of the file handle)

_vec_
struct kvec, includes buf address in kernel address and length of each buffer

_vlen_
read blocks

_offset_
the offset of file

_client\_ip_
the ip address of client

_count_
read bytes

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfsd_(3stap)
