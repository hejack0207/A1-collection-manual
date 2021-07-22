# ioctl-fideduperange(2) - share some the data of one file with another file

Linux, 2017-09-15

```

#include <sys/ioctl.h>
#include <linux/fs.h> 
 int ioctl(int src_fd, FIDEDUPERANGE, struct file_dedupe_range *arg);
```

<a name="description"></a>

# Description

If a filesystem supports files sharing physical storage between multiple
files, this
**ioctl**(2)
operation can be used to make some of the data in the
**src_fd**
file appear in the
**dest_fd**
file by sharing the underlying storage if the file data is identical
("deduplication").
Both files must reside within the same filesystem.
This reduces storage consumption by allowing the filesystem
to store one shared copy of the data.
If a file write should occur to a shared
region, the filesystem must ensure that the changes remain private to the file
being written.
This behavior is commonly referred to as "copy on write".

This ioctl performs the "compare and share if identical" operation on up to
_src_length_
bytes from file descriptor
_src_fd_
at offset
_src_offset_.
This information is conveyed in a structure of the following form:

.in +4n
.EX
struct file_dedupe_range {
    __u64 src_offset;
    __u64 src_length;
    __u16 dest_count;
    __u16 reserved1;
    __u32 reserved2;
    struct file_dedupe_range_info info[0];
};
.EE
.in

Deduplication is atomic with regards to concurrent writes, so no locks need to
be taken to obtain a consistent deduplicated copy.

The fields
_reserved1_ and _reserved2_
must be zero.

Destinations for the deduplication operation are conveyed in the array at the
end of the structure.
The number of destinations is given in
_dest_count_,
and the destination information is conveyed in the following form:

.in +4n
.EX
struct file_dedupe_range_info {
    __s64 dest_fd;
    __u64 dest_offset;
    __u64 bytes_deduped;
    __s32 status;
    __u32 reserved;
};
.EE
.in

Each deduplication operation targets
_src_length_
bytes in file descriptor
_dest_fd_
at offset
_dest_offset_.
The field
_reserved_
must be zero.
During the call,
_src_fd_
must be open for reading and
_dest_fd_
must be open for writing.
The combined size of the struct
_file_dedupe_range_
and the struct
_file_dedupe_range_info_
array must not exceed the system page size.
The maximum size of
_src_length_
is filesystem dependent and is typically 16&nbsp;MiB.
This limit will be enforced silently by the filesystem.
By convention, the storage used by
_src_fd_
is mapped into
_dest_fd_
and the previous contents in
_dest_fd_
are freed.

Upon successful completion of this ioctl, the number of bytes successfully
deduplicated is returned in
_bytes_deduped_
and a status code for the deduplication operation is returned in
_status_.
If even a single byte in the range does not match, the deduplication
request will be ignored and
_status_
set to
**FILE_DEDUPE_RANGE_DIFFERS**.
The
_status_
code is set to
**FILE_DEDUPE_RANGE_SAME**
for success, a negative error code in case of error, or
**FILE_DEDUPE_RANGE_DIFFERS**
if the data did not match.


<a name="return-value"></a>

# Return Value

On error, -1 is returned, and
_errno_
is set to indicate the error.


<a name="errors"></a>

# Errors

Error codes can be one of, but are not limited to, the following:

* **ENOMEM**  
  The kernel was unable to allocate sufficient memory to perform the
  operation or
  _dest_count_
  is so large that the input argument description spans more than a single
  page of memory.
* **EBADF**  
  _src_fd_
  is not open for reading;
  _dest_fd_
  is not open for writing or is open for append-only writes; or the filesystem
  which
  _src_fd_
  resides on does not support deduplication.
* **EINVAL**  
  The filesystem does not support deduplicating the ranges of the given files.
  This error can also appear if either file descriptor represents
  a device, FIFO, or socket.
  Disk filesystems generally require the offset and length arguments
  to be aligned to the fundamental block size.
  Neither Btrfs nor XFS support
  overlapping deduplication ranges in the same file.
* **EISDIR**  
  One of the files is a directory and the filesystem does not support shared
  regions in directories.
* **EOPNOTSUPP**  
  This can appear if the filesystem does not support deduplicating either file
  descriptor, or if either file descriptor refers to special inodes.
* **EPERM**  
  _dest_fd_
  is immutable.
* **ETXTBSY**  
  One of the files is a swap file.
  Swap files cannot share storage.
* **EXDEV**  
  _dest_fd_ and _src_fd_
  are not on the same mounted filesystem.

<a name="versions"></a>

# Versions

This ioctl operation first appeared in Linux 4.5.
It was previously known as
**BTRFS_IOC_FILE_EXTENT_SAME**
and was private to Btrfs.

<a name="conforming-to"></a>

# Conforming to

This API is Linux-specific.

<a name="notes"></a>

# Notes

Because a copy-on-write operation requires the allocation of new storage, the
**fallocate**(2)
operation may unshare shared blocks to guarantee that subsequent writes will
not fail because of lack of disk space.

Some filesystems may limit the amount of data that can be deduplicated in a
single call.

<a name="see-also"></a>

# See Also

**ioctl**(2)

<a name="colophon"></a>

# Colophon

This page is part of release 4.16 of the Linux
_man-pages_
project.
A description of the project,
information about reporting bugs,
and the latest version of this page,
can be found at
https://www.kernel.org/doc/man-pages/.
