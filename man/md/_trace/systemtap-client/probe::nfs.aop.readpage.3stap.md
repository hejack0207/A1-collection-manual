# probe::nfs\&.aop\&.r(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfs.aop.readpage - NFS client synchronously reading a page

<a name="synopsis"></a>

# Synopsis

```


```
    nfs.aop.readpage 

<a name="values"></a>

# Values


_ino_
inode number

_\_\_page_
the address of page

_i\_flag_
file flags

_i\_size_
file length in bytes

_size_
number of pages to be read in this execution

_page\_index_
offset within mapping, can used a page identifier and position identifier in the page frame

_file_
file argument

_rsize_
read size (in bytes)

_sb\_flag_
super block flags

_dev_
device identifier

<a name="description"></a>

# Description


Read the page over, only fires when a previous async read operation failed

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfs_(3stap)
