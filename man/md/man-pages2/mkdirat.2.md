# mkdir(2) - create a directory

Linux, 2017-09-15

    #include <sys/stat.h>
    #include <sys/types.h>
    
    
    int mkdir(const char *pathname, mode_t mode);
    
    #include <fcntl.h>           /* Definition of AT_* constants */
    #include <sys/stat.h>
    
    int mkdirat(int dirfd, const char *pathname, mode_t mode);
```

 .in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in 
 mkdirat(): .RS 4 .TP 4 Since glibc 2.10: _POSIX_C_SOURCE&nbsp;>=&nbsp;200809L .TP Before glibc 2.10: _ATFILE_SOURCE .RE
```

<a name="description"></a>

# Description

**mkdir**()
attempts to create a directory named
_pathname_.

The argument
_mode_
specifies the mode for the new directory (see
**inode**(7)).
It is modified by the process's
_umask_
in the usual way: in the absence of a default ACL, the mode of the
created directory is
(_mode_ & ~_umask_ & 0777).
Whether other
_mode_
bits are honored for the created directory depends on the operating system.
For Linux, see NOTES below.

The newly created directory will be owned by the effective user ID of the
process.
If the directory containing the file has the set-group-ID
bit set, or if the filesystem is mounted with BSD group semantics
(_mount -o bsdgroups_
or, synonymously
_mount -o grpid_),
the new directory will inherit the group ownership from its parent;
otherwise it will be owned by the effective group ID of the process.

If the parent directory has the set-group-ID bit set, then so will the
newly created directory.



<a name="mkdirat"></a>

### mkdirat()

The
**mkdirat**()
system call operates in exactly the same way as
**mkdir**(),
except for the differences described here.

If the pathname given in
_pathname_
is relative, then it is interpreted relative to the directory
referred to by the file descriptor
_dirfd_
(rather than relative to the current working directory of
the calling process, as is done by
**mkdir**()
for a relative pathname).

If
_pathname_
is relative and
_dirfd_
is the special value
**AT_FDCWD**,
then
_pathname_
is interpreted relative to the current working
directory of the calling process (like
**mkdir**()).

If
_pathname_
is absolute, then
_dirfd_
is ignored.

See
**openat**(2)
for an explanation of the need for
**mkdirat**().

<a name="return-value"></a>

# Return Value

**mkdir**()
and
**mkdirat**()
return zero on success, or -1 if an error occurred (in which case,
_errno_
is set appropriately).

<a name="errors"></a>

# Errors


* **EACCES**  
  The parent directory does not allow write permission to the process,
  or one of the directories in
  _pathname_
  did not allow search permission.
  (See also
  **path_resolution**(7).)
* **EDQUOT**  
  The user's quota of disk blocks or inodes on the filesystem has been
  exhausted.
* **EEXIST**  
  _pathname_
  already exists (not necessarily as a directory).
  This includes the case where
  _pathname_
  is a symbolic link, dangling or not.
* **EFAULT**  
  _pathname_ points outside your accessible address space.
* **EINVAL**  
  The final component ("basename") of the new directory's
  _pathname_
  is invalid
  (e.g., it contains characters not permitted by the underlying filesystem).
* **ELOOP**  
  Too many symbolic links were encountered in resolving
  _pathname_.
* **EMLINK**  
  The number of links to the parent directory would exceed
  **LINK_MAX**.
* **ENAMETOOLONG**  
  _pathname_ was too long.
* **ENOENT**  
  A directory component in
  _pathname_
  does not exist or is a dangling symbolic link.
* **ENOMEM**  
  Insufficient kernel memory was available.
* **ENOSPC**  
  The device containing
  _pathname_
  has no room for the new directory.
* **ENOSPC**  
  The new directory cannot be created because the user's disk quota is
  exhausted.
* **ENOTDIR**  
  A component used as a directory in
  _pathname_
  is not, in fact, a directory.
* **EPERM**  
  The filesystem containing
  _pathname_
  does not support the creation of directories.
* **EROFS**  
  _pathname_
  refers to a file on a read-only filesystem.

The following additional errors can occur for
**mkdirat**():

* **EBADF**  
  _dirfd_
  is not a valid file descriptor.
* **ENOTDIR**  
  _pathname_
  is relative and
  _dirfd_
  is a file descriptor referring to a file other than a directory.

<a name="versions"></a>

# Versions

**mkdirat**()
was added to Linux in kernel 2.6.16;
library support was added to glibc in version 2.4.

<a name="conforming-to"></a>

# Conforming to

**mkdir**():
SVr4, BSD, POSIX.1-2001, POSIX.1-2008.


**mkdirat**():
POSIX.1-2008.

<a name="notes"></a>

# Notes

Under Linux, apart from the permission bits, the
**S_ISVTX**
_mode_
bit is also honored.

There are many infelicities in the protocol underlying NFS.
Some of these affect
**mkdir**().

<a name="glibc-notes"></a>

### Glibc notes

On older kernels where
**mkdirat**()
is unavailable, the glibc wrapper function falls back to the use of
**mkdir**().
When
_pathname_
is a relative pathname,
glibc constructs a pathname based on the symbolic link in
_/proc/self/fd_
that corresponds to the
_dirfd_
argument.

<a name="see-also"></a>

# See Also

**mkdir**(1),
**chmod**(2),
**chown**(2),
**mknod**(2),
**mount**(2),
**rmdir**(2),
**stat**(2),
**umask**(2),
**unlink**(2),
**acl**(5)
**path_resolution**(7)

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
