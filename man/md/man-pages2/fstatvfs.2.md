# statvfs(3) - get filesystem statistics

Linux, 2017-09-15

```
#include <sys/statvfs.h> 
 int statvfs(const char *path, struct statvfs *buf);
int fstatvfs(int fd, struct statvfs *buf);
```

<a name="description"></a>

# Description

The function
**statvfs**()
returns information about a mounted filesystem.
_path_
is the pathname of any file within the mounted filesystem.
_buf_
is a pointer to a
_statvfs_
structure defined approximately as follows:

.in +4n
.EX
struct statvfs {
    unsigned long  f_bsize;    /* Filesystem block size */
    unsigned long  f_frsize;   /* Fragment size */
    fsblkcnt_t     f_blocks;   /* Size of fs in f_frsize units */
    fsblkcnt_t     f_bfree;    /* Number of free blocks */
    fsblkcnt_t     f_bavail;   /* Number of free blocks for
                                  unprivileged users */
    fsfilcnt_t     f_files;    /* Number of inodes */
    fsfilcnt_t     f_ffree;    /* Number of free inodes */
    fsfilcnt_t     f_favail;   /* Number of free inodes for
                                  unprivileged users */
    unsigned long  f_fsid;     /* Filesystem ID */
    unsigned long  f_flag;     /* Mount flags */
    unsigned long  f_namemax;  /* Maximum filename length */
};
.EE
.in

Here the types
_fsblkcnt_t_
and
_fsfilcnt_t_
are defined in
_&lt;sys/types.h&gt;_.
Both used to be
_unsigned long_.

The field
_f_flag_
is a bit mask indicating various options that were employed
when mounting this filesystem.
It contains zero or more of the following flags:


* **ST_MANDLOCK**  
  Mandatory locking is permitted on the filesystem (see
  **fcntl**(2)).
* **ST_NOATIME**  
  Do not update access times; see
  **mount**(2).
* **ST_NODEV**  
  Disallow access to device special files on this filesystem.
* **ST_NODIRATIME**  
  Do not update directory access times; see
  **mount**(2).
* **ST_NOEXEC**  
  Execution of programs is disallowed on this filesystem.
* **ST_NOSUID**  
  The set-user-ID and set-group-ID bits are ignored by
  **exec**(3)
  for executable files on this filesystem
* **ST_RDONLY**  
  This filesystem is mounted read-only.
* **ST_RELATIME**  
  Update atime relative to mtime/ctime; see
  **mount**(2).
* **ST_SYNCHRONOUS**  
  Writes are synched to the filesystem immediately (see the description of
  **O_SYNC**
  in
  **open**(2)).

It is unspecified whether all members of the returned struct
have meaningful values on all filesystems.

**fstatvfs**()
returns the same information about an open file referenced by descriptor
_fd_.

<a name="return-value"></a>

# Return Value

On success, zero is returned.
On error, -1 is returned, and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **EACCES**  
  (**statvfs**())
  Search permission is denied for a component of the path prefix of
  _path_.
  (See also
  **path_resolution**(7).)
* **EBADF**  
  (**fstatvfs**())
  _fd_
  is not a valid open file descriptor.
* **EFAULT**  
  _Buf_
  or
  _path_
  points to an invalid address.
* **EINTR**  
  This call was interrupted by a signal; see
  **signal**(7).
* **EIO**  
  An I/O error occurred while reading from the filesystem.
* **ELOOP**  
  (**statvfs**())
  Too many symbolic links were encountered in translating
  _path_.
* **ENAMETOOLONG**  
  (**statvfs**())
  _path_
  is too long.
* **ENOENT**  
  (**statvfs**())
  The file referred to by
  _path_
  does not exist.
* **ENOMEM**  
  Insufficient kernel memory was available.
* **ENOSYS**  
  The filesystem does not support this call.
* **ENOTDIR**  
  (**statvfs**())
  A component of the path prefix of
  _path_
  is not a directory.
* **EOVERFLOW**  
  Some values were too large to be represented in the returned struct.

<a name="attributes"></a>

# Attributes

For an explanation of the terms used in this section, see
**attributes**(7).
.TS
allbox;
lbw21 lb lb
l l l.
Interface	Attribute	Value
T{
**statvfs**(),
**fstatvfs**()
T}	Thread safety	MT-Safe
.TE

<a name="conforming-to"></a>

# Conforming to

POSIX.1-2001, POSIX.1-2008.

Only the
**ST_NOSUID**
and
**ST_RDONLY**
flags of the
_f_flag_
field are specified in POSIX.1.
To obtain definitions of the remaining flags, one must define
**_GNU_SOURCE**.

<a name="notes"></a>

# Notes

The Linux kernel has system calls
**statfs**(2)
and
**fstatfs**(2)
to support this library call.

In glibc versions before 2.13,

**statvfs**()
populated the bits of the
_f_flag_
field by scanning the mount options shown in
_/proc/mounts_.
However, starting with Linux 2.6.36, the underlying
**statfs**(2)
system call provides the necessary information via the
_f_flags_
field, and since glibc version 2.13, the
**statvfs**()
function will use information from that field rather than scanning
_/proc/mounts_.

The glibc implementations of

.in +4n
.EX
pathconf(path, _PC_REC_XFER_ALIGN);
pathconf(path, _PC_ALLOC_SIZE_MIN);
pathconf(path, _PC_REC_MIN_XFER_SIZE);
.EE
.in

respectively use the
_f_frsize_,
_f_frsize_,
and
_f_bsize_
fields returned by a call to
**statvfs**()
with the argument
_path_.

<a name="see-also"></a>

# See Also

**statfs**(2)

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
