# probe::nfs\&.fop\&.a(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfs.fop.aio_read - NFS client aio_read file operation

<a name="synopsis"></a>

# Synopsis

```


```
    nfs.fop.aio_read 

<a name="values"></a>

# Values


_count_
read bytes

_cache\_time_
when we started read-caching this inode

_dev_
device identifier

_cache\_valid_
cache related bit mask flag

_attrtimeo_
how long the cached information is assumed to be valid. We need to revalidate the cached attrs for this inode if jiffies - read_cache_jiffies &gt; attrtimeo.

_file\_name_
file name

_pos_
current position of file

_ino_
inode number

_parent\_name_
parent dir name

_buf_
the address of buf in user space

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfs_(3stap)
