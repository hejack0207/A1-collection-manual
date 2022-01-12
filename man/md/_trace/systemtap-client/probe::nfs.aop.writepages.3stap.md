# probe::nfs\&.aop\&.w(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfs.aop.writepages - NFS client writing several dirty pages to the NFS server

<a name="synopsis"></a>

# Synopsis

```


```
    nfs.aop.writepages 

<a name="values"></a>

# Values


_nr\_to\_write_
number of pages attempted to be written in this execution

_dev_
device identifier

_wsize_
write size

_for\_kupdate_
a flag of writeback_control, indicates if its a kupdate writeback

_size_
number of pages attempted to be written in this execution

_wpages_
write size (in pages)

_ino_
inode number

_for\_reclaim_
a flag of writeback_control, indicates if its invoked from the page allocator

<a name="description"></a>

# Description


The priority of wb is decided by the flags
_for\_reclaim_
and
_for\_kupdate_.

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfs_(3stap)
