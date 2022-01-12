# probe::nfs\&.aop\&.r(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfs.aop.readpages - NFS client reading multiple pages

<a name="synopsis"></a>

# Synopsis

```


```
    nfs.aop.readpages 

<a name="values"></a>

# Values


_ino_
inode number

_nr\_pages_
number of pages attempted to read in this execution

_rpages_
read size (in pages)

_rsize_
read size (in bytes)

_file_
filp argument

_size_
number of pages attempted to read in this execution

_dev_
device identifier

<a name="description"></a>

# Description


Fires when in readahead way, read several pages once

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfs_(3stap)
