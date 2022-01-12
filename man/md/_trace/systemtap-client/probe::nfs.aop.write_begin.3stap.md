# probe::nfs\&.aop\&.w(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfs.aop.write_begin - NFS client begin to write data

<a name="synopsis"></a>

# Synopsis

```


```
    nfs.aop.write_begin 

<a name="values"></a>

# Values


_dev_
device identifier

_ino_
inode number

_\_\_page_
the address of page

_to_
end address of this write operation

_size_
write bytes

_page\_index_
offset within mapping, can used a page identifier and position identifier in the page frame

_offset_
start address of this write operation

<a name="description"></a>

# Description


Occurs when write operation occurs on nfs. It prepare a page for writing, look for a request corresponding to the page. If there is one, and it belongs to another file, it flush it out before it tries to copy anything into the page. Also do the same if it finds a request from an existing dropped page

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfs_(3stap)
