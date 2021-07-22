# link(2) - make a new name for a file

Linux, 2017-09-15

    #include <unistd.h>
    
    int link(const char *oldpath, const char *newpath);
    
    #include <fcntl.h>           /* Definition of AT_* constants */
    #include <unistd.h>
    
    int linkat(int olddirfd, const char *oldpath,
               int newdirfd, const char *newpath, int flags);
```

 .in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in 
 linkat(): .RS 4 .TP 4 Since glibc 2.10: _POSIX_C_SOURCE&nbsp;>=&nbsp;200809L .TP Before glibc 2.10: _ATFILE_SOURCE .RE
```

<a name="description"></a>

# Description

**link**()
creates a new link (also known as a hard link) to an existing file.

If
_newpath_
exists, it will
_not_
be overwritten.

This new name may be used exactly as the old one for any operation;
both names refer to the same file (and so have the same permissions
and ownership) and it is impossible to tell which name was the
"original".

<a name="linkat"></a>

### linkat()

The
**linkat**()
system call operates in exactly the same way as
**link**(),
except for the differences described here.

If the pathname given in
_oldpath_
is relative, then it is interpreted relative to the directory
referred to by the file descriptor
_olddirfd_
(rather than relative to the current working directory of
the calling process, as is done by
**link**()
for a relative pathname).

If
_oldpath_
is relative and
_olddirfd_
is the special value
**AT_FDCWD**,
then
_oldpath_
is interpreted relative to the current working
directory of the calling process (like
**link**()).

If
_oldpath_
is absolute, then
_olddirfd_
is ignored.

The interpretation of
_newpath_
is as for
_oldpath_,
except that a relative pathname is interpreted relative
to the directory referred to by the file descriptor
_newdirfd_.

The following values can be bitwise ORed in
_flags_:

* **AT_EMPTY_PATH** (since Linux 2.6.39)  
  
  If
  _oldpath_
  is an empty string, create a link to the file referenced by
  _olddirfd_
  (which may have been obtained using the
  **open**(2)
  **O_PATH**
  flag).
  In this case,
  _olddirfd_
  can refer to any type of file except a directory.
  This will generally not work if the file has a link count of zero (files
  created with
  **O_TMPFILE**
  and without
  **O_EXCL**
  are an exception).
  The caller must have the
  **CAP_DAC_READ_SEARCH**
  capability in order to use this flag.
  This flag is Linux-specific; define
  **_GNU_SOURCE**
  
  to obtain its definition.
* **AT_SYMLINK_FOLLOW** (since Linux 2.6.18)  
  By default,
  **linkat**(),
  does not dereference
  _oldpath_
  if it is a symbolic link (like
  **link**()).
  The flag
  **AT_SYMLINK_FOLLOW**
  can be specified in
  _flags_
  to cause
  _oldpath_
  to be dereferenced if it is a symbolic link.
  If procfs is mounted,
  this can be used as an alternative to
  **AT_EMPTY_PATH**,
  like this:
* .in +4n
  .EX
  linkat(AT_FDCWD, "/proc/self/fd/&lt;fd&gt;", newdirfd,
         newname, AT_SYMLINK_FOLLOW);
  .EE
  .in

Before kernel 2.6.18, the
_flags_
argument was unused, and had to be specified as 0.

See
**openat**(2)
for an explanation of the need for
**linkat**().

<a name="return-value"></a>

# Return Value

On success, zero is returned.
On error, -1 is returned, and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **EACCES**  
  Write access to the directory containing
  _newpath_
  is denied, or search permission is denied for one of the directories
  in the path prefix of
  _oldpath_
  or
  _newpath_.
  (See also
  **path_resolution**(7).)
* **EDQUOT**  
  The user's quota of disk blocks on the filesystem has been exhausted.
* **EEXIST**  
  _newpath_
  already exists.
* **EFAULT**  
  _oldpath_ or _newpath_ points outside your accessible address space.
* **EIO**  
  An I/O error occurred.
* **ELOOP**  
  Too many symbolic links were encountered in resolving
  _oldpath_ or _newpath_.
* **EMLINK**  
  The file referred to by
  _oldpath_
  already has the maximum number of links to it.
  For example, on an
  **ext4**(5)
  filesystem that does not employ the
  _dir_index_
  feature, the limit on the number of hard links to a file is 65,000; on
  **btrfs**(5),
  the limit is 65,535 links.
* **ENAMETOOLONG**  
  _oldpath_ or _newpath_ was too long.
* **ENOENT**  
  A directory component in
  _oldpath_ or _newpath_
  does not exist or is a dangling symbolic link.
* **ENOMEM**  
  Insufficient kernel memory was available.
* **ENOSPC**  
  The device containing the file has no room for the new directory
  entry.
* **ENOTDIR**  
  A component used as a directory in
  _oldpath_ or _newpath_
  is not, in fact, a directory.
* **EPERM**  
  _oldpath_
  is a directory.
* **EPERM**  
  The filesystem containing
  _oldpath_ and _newpath_
  does not support the creation of hard links.
* **EPERM** (since Linux 3.6)  
  The caller does not have permission to create a hard link to this file
  (see the description of
  _/proc/sys/fs/protected_hardlinks_
  in
  **proc**(5)).
* **EPERM**  
  _oldpath_
  is marked immutable or append-only.
  (See
  **ioctl_iflags**(2).)
* **EROFS**  
  The file is on a read-only filesystem.
* **EXDEV**  
  _oldpath_ and _newpath_
  are not on the same mounted filesystem.
  (Linux permits a filesystem to be mounted at multiple points, but
  **link**()
  does not work across different mount points,
  even if the same filesystem is mounted on both.)

The following additional errors can occur for
**linkat**():

* **EBADF**  
  _olddirfd_
  or
  _newdirfd_
  is not a valid file descriptor.
* **EINVAL**  
  An invalid flag value was specified in
  _flags_.
* **ENOENT**  
  **AT_EMPTY_PATH**
  was specified in
  _flags_,
  but the caller did not have the
  **CAP_DAC_READ_SEARCH**
  capability.
* **ENOENT**  
  An attempt was made to link to the
  _/proc/self/fd/NN_
  file corresponding to a file descriptor created with
*     open(path, O_TMPFILE | O_EXCL, mode);
* See
  **open**(2).
* **ENOENT**  
  _oldpath_
  is a relative pathname and
  _olddirfd_
  refers to a directory that has been deleted,
  or
  _newpath_
  is a relative pathname and
  _newdirfd_
  refers to a directory that has been deleted.
* **ENOTDIR**  
  _oldpath_
  is relative and
  _olddirfd_
  is a file descriptor referring to a file other than a directory;
  or similar for
  _newpath_
  and
  _newdirfd_
* **EPERM**  
  **AT_EMPTY_PATH**
  was specified in
  _flags_,
  _oldpath_
  is an empty string, and
  _olddirfd_
  refers to a directory.

<a name="versions"></a>

# Versions

**linkat**()
was added to Linux in kernel 2.6.16;
library support was added to glibc in version 2.4.

<a name="conforming-to"></a>

# Conforming to

**link**():
SVr4, 4.3BSD, POSIX.1-2001 (but see NOTES), POSIX.1-2008.




**linkat**():
POSIX.1-2008.

<a name="notes"></a>

# Notes

Hard links, as created by
**link**(),
cannot span filesystems.
Use
**symlink**(2)
if this is required.

POSIX.1-2001 says that
**link**()
should dereference
_oldpath_
if it is a symbolic link.
However, since kernel 2.0,

Linux does not do so: if
_oldpath_
is a symbolic link, then
_newpath_
is created as a (hard) link to the same symbolic link file
(i.e.,
_newpath_
becomes a symbolic link to the same file that
_oldpath_
refers to).
Some other implementations behave in the same manner as Linux.




POSIX.1-2008 changes the specification of
**link**(),
making it implementation-dependent whether or not
_oldpath_
is dereferenced if it is a symbolic link.
For precise control over the treatment of symbolic links when
creating a link, use
**linkat**().

<a name="glibc-notes"></a>

### Glibc notes

On older kernels where
**linkat**()
is unavailable, the glibc wrapper function falls back to the use of
**link**(),
unless the
**AT_SYMLINK_FOLLOW**
is specified.
When
_oldpath_
and
_newpath_
are relative pathnames,
glibc constructs pathnames based on the symbolic links in
_/proc/self/fd_
that correspond to the
_olddirfd_
and
_newdirfd_
arguments.

<a name="bugs"></a>

# Bugs

On NFS filesystems, the return code may be wrong in case the NFS server
performs the link creation and dies before it can say so.
Use
**stat**(2)
to find out if the link got created.

<a name="see-also"></a>

# See Also

**ln**(1),
**open**(2),
**rename**(2),
**stat**(2),
**symlink**(2),
**unlink**(2),
**path_resolution**(7),
**symlink**(7)

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
