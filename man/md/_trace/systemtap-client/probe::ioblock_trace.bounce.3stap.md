# probe::ioblock_trace(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::ioblock_trace.bounce - Fires whenever a buffer bounce is needed for at least one page of a block IO request.

<a name="synopsis"></a>

# Synopsis

```


```
    ioblock_trace.bounce 

<a name="values"></a>

# Values


_bdev_
target block device

_name_
name of the probe point

_devname_
device for which a buffer bounce was needed.

_vcnt_
bio vector count which represents number of array element (page, offset, length) which makes up this I/O request

_opf_
operations and flags

_ino_
i-node number of the mapped file

_bytes\_done_
number of bytes transferred

_bdev\_contains_
points to the device object which contains the partition (when bio structure represents a partition)

_q_
request queue on which this bio was queued.

_flags_
see below BIO_UPTODATE 0 ok after I/O completion BIO_RW_BLOCK 1 RW_AHEAD set, and read/write would block BIO_EOF 2 out-out-bounds error BIO_SEG_VALID 3 nr_hw_seg valid BIO_CLONED 4 doesnt own data BIO_BOUNCED 5 bio is a bounce bio BIO_USER_MAPPED 6 contains user pages BIO_EOPNOTSUPP 7 not supported

_size_
total size in bytes

_rw_
binary trace for read/write request

_p\_start\_sect_
points to the start sector of the partition structure of the device

_idx_
offset into the bio vector array
_phys\_segments_
- number of segments in this bio after physical address coalescing is performed.

_sector_
beginning sector for the entire bio

<a name="context"></a>

# Context


The process creating a block IO request.

<a name="see-alson-"></a>

# See Also\N 

_tapset::ioblock_(3stap)
