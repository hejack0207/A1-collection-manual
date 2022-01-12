# probe::ioblock\&.req(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::ioblock.request - Fires whenever making a generic block I/O request.

<a name="synopsis"></a>

# Synopsis

```


```
    ioblock.request 

<a name="values"></a>

# Values


_bdev\_contains_
points to the device object which contains the partition (when bio structure represents a partition)

_ino_
i-node number of the mapped file

_opf_
operations and flags

_vcnt_
bio vector count which represents number of array element (page, offset, length) which make up this I/O request

_devname_
block device name

_name_
name of the probe point

_bdev_
target block device

_hw\_segments_
number of segments after physical and DMA remapping hardware coalescing is performed

_sector_
beginning sector for the entire bio

_idx_
offset into the bio vector array

_phys\_segments_
number of segments in this bio after physical address coalescing is performed

_p\_start\_sect_
points to the start sector of the partition structure of the device

_rw_
binary trace for read/write request

_size_
total size in bytes

_flags_
see below BIO_UPTODATE 0 ok after I/O completion BIO_RW_BLOCK 1 RW_AHEAD set, and read/write would block BIO_EOF 2 out-out-bounds error BIO_SEG_VALID 3 nr_hw_seg valid BIO_CLONED 4 doesnt own data BIO_BOUNCED 5 bio is a bounce bio BIO_USER_MAPPED 6 contains user pages BIO_EOPNOTSUPP 7 not supported

<a name="context"></a>

# Context


The process makes block I/O request

<a name="see-alson-"></a>

# See Also\N 

_tapset::ioblock_(3stap)
