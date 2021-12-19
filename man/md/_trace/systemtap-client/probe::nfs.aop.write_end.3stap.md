# probe::nfs\&.aop\&.w(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfs.aop.write_end - NFS client complete writing data

<a name="synopsis"></a>

# Synopsis

```


```
    nfs.aop.write_end 

<a name="values"></a>

# Values


_i\_flag_
file flags

_dev_
device identifier

_sb\_flag_
super block flags

_\_\_page_
the address of page

_to_
end address of this write operation

_ino_
inode number

_i\_size_
file length in bytes

_page\_index_
offset within mapping, can used a page identifier and position identifier in the page frame

_size_
write bytes

_offset_
start address of this write operation

<a name="description"></a>

# Description


Fires when do a write operation on nfs, often after prepare_write

Update and possibly write a cached page of an NFS file.

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfs_(3stap)
