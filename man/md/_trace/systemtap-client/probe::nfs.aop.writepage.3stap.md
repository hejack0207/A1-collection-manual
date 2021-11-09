# probe::nfs\&.aop\&.w(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfs.aop.writepage - NFS client writing a mapped page to the NFS server

<a name="synopsis"></a>

# Synopsis

```


```
    nfs.aop.writepage 

<a name="values"></a>

# Values


_for\_kupdate_
a flag of writeback_control, indicates if its a kupdate writeback

_wsize_
write size

_i\_flag_
file flags

_dev_
device identifier

_sb\_flag_
super block flags

_i\_size_
file length in bytes

_for\_reclaim_
a flag of writeback_control, indicates if its invoked from the page allocator

_\_\_page_
the address of page

_ino_
inode number

_i\_state_
inode state flags

_page\_index_
offset within mapping, can used a page identifier and position identifier in the page frame

_size_
number of pages to be written in this execution

<a name="description"></a>

# Description


The priority of wb is decided by the flags
_for\_reclaim_
and
_for\_kupdate_.

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfs_(3stap)
