# probe::nfs\&.fop\&.s(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfs.fop.sendfile - NFS client send file operation

<a name="synopsis"></a>

# Synopsis

```


```
    nfs.fop.sendfile 

<a name="values"></a>

# Values


_attrtimeo_
how long the cached information is assumed to be valid. We need to revalidate the cached attrs for this inode if jiffies - read_cache_jiffies &gt; attrtimeo.

_dev_
device identifier

_cache\_valid_
cache related bit mask flag

_count_
read bytes

_cache\_time_
when we started read-caching this inode

_ino_
inode number

_ppos_
current position of file

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfs_(3stap)
