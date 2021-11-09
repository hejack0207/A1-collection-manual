# probe::ioblock\&.end(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::ioblock.end - Fires whenever a block I/O transfer is complete.

<a name="synopsis"></a>

# Synopsis

```


```
    ioblock.end 

<a name="values"></a>

# Values


_devname_
block device name

_name_
name of the probe point

_opf_
operations and flags

_vcnt_
bio vector count which represents number of array element (page, offset, length) which makes up this I/O request

_bytes\_done_
number of bytes transferred

_ino_
i-node number of the mapped file

_size_
total size in bytes

_flags_
see below BIO_UPTODATE 0 ok after I/O completion BIO_RW_BLOCK 1 RW_AHEAD set, and read/write would block BIO_EOF 2 out-out-bounds error BIO_SEG_VALID 3 nr_hw_seg valid BIO_CLONED 4 doesnt own data BIO_BOUNCED 5 bio is a bounce bio BIO_USER_MAPPED 6 contains user pages BIO_EOPNOTSUPP 7 not supported

_phys\_segments_
number of segments in this bio after physical address coalescing is performed.

_rw_
binary trace for read/write request

_idx_
offset into the bio vector array

_sector_
beginning sector for the entire bio

_error_
0 on success

_hw\_segments_
number of segments after physical and DMA remapping hardware coalescing is performed

<a name="context"></a>

# Context


The process signals the transfer is done.

<a name="see-alson-"></a>

# See Also\N 

_tapset::ioblock_(3stap)
