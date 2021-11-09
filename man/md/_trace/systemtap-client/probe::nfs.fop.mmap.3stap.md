# probe::nfs\&.fop\&.m(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfs.fop.mmap - NFS client mmap operation

<a name="synopsis"></a>

# Synopsis

```


```
    nfs.fop.mmap 

<a name="values"></a>

# Values


_vm\_start_
start address within vm_mm

_parent\_name_
parent dir name

_buf_
the address of buf in user space

_ino_
inode number

_vm\_end_
the first byte after end address within vm_mm

_file\_name_
file name

_attrtimeo_
how long the cached information is assumed to be valid. We need to revalidate the cached attrs for this inode if jiffies - read_cache_jiffies &gt; attrtimeo.

_dev_
device identifier

_cache\_valid_
cache related bit mask flag

_vm\_flag_
vm flags

_cache\_time_
when we started read-caching this inode

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfs_(3stap)
