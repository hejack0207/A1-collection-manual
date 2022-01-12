# probe::nfs\&.fop\&.r(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfs.fop.read_iter - NFS client read_iter file operation

<a name="synopsis"></a>

# Synopsis

```


```
    nfs.fop.read_iter 

<a name="values"></a>

# Values


_cache\_valid_
cache related bit mask flag

_dev_
device identifier

_cache\_time_
when we started read-caching this inode

_count_
read bytes

_attrtimeo_
how long the cached information is assumed to be valid. We need to revalidate the cached attrs for this inode if jiffies - read_cache_jiffies &gt; attrtimeo.

_file\_name_
file name

_parent\_name_
parent dir name

_ino_
inode number

_pos_
current position of file

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfs_(3stap)
