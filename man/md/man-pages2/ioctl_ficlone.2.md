# ioctl-ficlonerange(2) - share some the data of one file with another file

Linux, 2017-09-15

```

#include <sys/ioctl.h>
#include <linux/fs.h> 
 int ioctl(int dest_fd, FICLONERANGE, struct file_clone_range *arg);
int ioctl(int dest_fd, FICLONE, int src_fd);
```

<a name="description"></a>

# Description

If a filesystem supports files sharing physical storage between multiple
files ("reflink"), this
**ioctl**(2)
operation can be used to make some of the data in the
_src_fd_
file appear in the
_dest_fd_
file by sharing the underlying storage, which is faster than making a separate
physical copy of the data.
Both files must reside within the same filesystem.
If a file write should occur to a shared region,
the filesystem must ensure that the changes remain private to the file being
written.
This behavior is commonly referred to as "copy on write".

This ioctl reflinks up to
_src_length_
bytes from file descriptor
_src_fd_
at offset
_src_offset_
into the file
_dest_fd_
at offset
_dest_offset_,
provided that both are files.
If
_src_length_
is zero, the ioctl reflinks to the end of the source file.
This information is conveyed in a structure of
the following form:

.in +4n
.EX
struct file_clone_range {
    __s64 src_fd;
    __u64 src_offset;
    __u64 src_length;
    __u64 dest_offset;
};
.EE
.in

Clones are atomic with regards to concurrent writes, so no locks need to be
taken to obtain a consistent cloned copy.

The
**FICLONE**
ioctl clones entire files.

<a name="return-value"></a>

# Return Value

On error, -1 is returned, and
_errno_
is set to indicate the error.


<a name="errors"></a>

# Errors

Error codes can be one of, but are not limited to, the following:

* **EBADF**  
  _src_fd_
  is not open for reading;
  _dest_fd_
  is not open for writing or is open for append-only writes;
  or the filesystem which
  _src_fd_
  resides on does not support reflink.
* **EINVAL**  
  The filesystem does not support reflinking the ranges of the given files.
  This error can also appear if either file descriptor represents
  a device, FIFO, or socket.
  Disk filesystems generally require the offset and length arguments
  to be aligned to the fundamental block size.
  XFS and Btrfs do not support
  overlapping reflink ranges in the same file.
* **EISDIR**  
  One of the files is a directory and the filesystem does not support shared
  regions in directories.
* **EOPNOTSUPP**  
  This can appear if the filesystem does not support reflinking either file
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

These ioctl operations first appeared in Linux 4.5.
They were previously known as
**BTRFS_IOC_CLONE**
and
**BTRFS_IOC_CLONE_RANGE**,
and were private to Btrfs.

<a name="conforming-to"></a>

# Conforming to

This API is Linux-specific.

<a name="notes"></a>

# Notes

Because a copy-on-write operation requires the allocation of new storage, the
**fallocate**(2)
operation may unshare shared blocks to guarantee that subsequent writes will
not fail because of lack of disk space.

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
