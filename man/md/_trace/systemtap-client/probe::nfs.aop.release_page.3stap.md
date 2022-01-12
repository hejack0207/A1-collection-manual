# probe::nfs\&.aop\&.r(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfs.aop.release_page - NFS client releasing page

<a name="synopsis"></a>

# Synopsis

```


```
    nfs.aop.release_page 

<a name="values"></a>

# Values


_dev_
device identifier

_page\_index_
offset within mapping, can used a page identifier and position identifier in the page frame

_size_
release pages

_\_\_page_
the address of page

_ino_
inode number

<a name="description"></a>

# Description


Fires when do a release operation on NFS.

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfs_(3stap)
