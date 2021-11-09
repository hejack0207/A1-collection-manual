# probe::nfs\&.fop\&.l(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfs.fop.lock - NFS client file lock operation

<a name="synopsis"></a>

# Synopsis

```


```
    nfs.fop.lock 

<a name="values"></a>

# Values


_fl\_type_
lock type

_dev_
device identifier

_fl\_flag_
lock flags

_i\_mode_
file type and access rights

_cmd_
cmd arguments

_fl\_end_
ending offset of locked region

_ino_
inode number

_fl\_start_
starting offset of locked region

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfs_(3stap)
