# probe::nfs\&.fop\&.w(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfs.fop.write - NFS client write operation

<a name="synopsis"></a>

# Synopsis

```


```
    nfs.fop.write 

<a name="values"></a>

# Values


_devname_
block device name

<a name="description"></a>

# Description


SystemTap uses the vfs.do_sync_write probe to implement this probe and as a result will get operations other than the NFS client write operations.

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfs_(3stap)
