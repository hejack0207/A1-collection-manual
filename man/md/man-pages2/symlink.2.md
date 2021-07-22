# symlink(2) - make a new name for a file

Linux, 2017-09-15

    #include <unistd.h>
    
    int symlink(const char *target, const char *linkpath);
    
    #include <fcntl.h>           /* Definition of AT_* constants */
    #include <unistd.h>
    
    int symlinkat(const char *target, int newdirfd, const char *linkpath);
    
```
.in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in 
 symlink(): .RS 4 _XOPEN_SOURCE&nbsp;>=&nbsp;500 || _POSIX_C_SOURCE&nbsp;>=&nbsp;200112L
</synopsis>

<synopsis>
    || /* Glibc versions <= 2.19: */ _BSD_SOURCE .RE 
 symlinkat(): .RS 4 .TP 4 Since glibc 2.10: _POSIX_C_SOURCE&nbsp;>=&nbsp;200809L .TP Before glibc 2.10: _ATFILE_SOURCE .RE
```

<a name="description"></a>

# Description

**symlink**()
creates a symbolic link named
_linkpath_
which contains the string
_target_.

Symbolic links are interpreted at run time as if the contents of the
link had been substituted into the path being followed to find a file or
directory.

Symbolic links may contain
_.._
path components, which (if used at the start of the link) refer to the
parent directories of that in which the link resides.

A symbolic link (also known as a soft link) may point to an existing
file or to a nonexistent one; the latter case is known as a dangling
link.

The permissions of a symbolic link are irrelevant; the ownership is
ignored when following the link, but is checked when removal or
renaming of the link is requested and the link is in a directory with
the sticky bit
(**S_ISVTX**)
set.

If
_linkpath_
exists, it will
_not_
be overwritten.

<a name="symlinkat"></a>

### symlinkat()

The
**symlinkat**()
system call operates in exactly the same way as
**symlink**(),
except for the differences described here.

If the pathname given in
_linkpath_
is relative, then it is interpreted relative to the directory
referred to by the file descriptor
_newdirfd_
(rather than relative to the current working directory of
the calling process, as is done by
**symlink**()
for a relative pathname).

If
_linkpath_
is relative and
_newdirfd_
is the special value
**AT_FDCWD**,
then
_linkpath_
is interpreted relative to the current working
directory of the calling process (like
**symlink**()).

If
_linkpath_
is absolute, then
_newdirfd_
is ignored.

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
  _linkpath_
  is denied, or one of the directories in the path prefix of
  _linkpath_
  did not allow search permission.
  (See also
  **path_resolution**(7).)
* **EDQUOT**  
  The user's quota of resources on the filesystem has been exhausted.
  The resources could be inodes or disk blocks, depending on the filesystem
  implementation.
* **EEXIST**  
  _linkpath_
  already exists.
* **EFAULT**  
  _target_ or _linkpath_ points outside your accessible address space.
* **EIO**  
  An I/O error occurred.
* **ELOOP**  
  Too many symbolic links were encountered in resolving
  _linkpath_.
* **ENAMETOOLONG**  
  _target_ or _linkpath_ was too long.
* **ENOENT**  
  A directory component in
  _linkpath_
  does not exist or is a dangling symbolic link, or
  _target_
  or
  _linkpath_
  is an empty string.
* **ENOMEM**  
  Insufficient kernel memory was available.
* **ENOSPC**  
  The device containing the file has no room for the new directory
  entry.
* **ENOTDIR**  
  A component used as a directory in
  _linkpath_
  is not, in fact, a directory.
* **EPERM**  
  The filesystem containing
  _linkpath_
  does not support the creation of symbolic links.
* **EROFS**  
  _linkpath_
  is on a read-only filesystem.

The following additional errors can occur for
**symlinkat**():

* **EBADF**  
  _newdirfd_
  is not a valid file descriptor.
* **ENOENT**  
  _linkpath_
  is a relative pathname and
  _newdirfd_
  refers to a directory that has been deleted.
* **ENOTDIR**  
  _linkpath_
  is relative and
  _newdirfd_
  is a file descriptor referring to a file other than a directory.

<a name="versions"></a>

# Versions

**symlinkat**()
was added to Linux in kernel 2.6.16;
library support was added to glibc in version 2.4.

<a name="conforming-to"></a>

# Conforming to

**symlink**():
SVr4, 4.3BSD, POSIX.1-2001, POSIX.1-2008.





**symlinkat**():
POSIX.1-2008.

<a name="notes"></a>

# Notes

No checking of
_target_
is done.

Deleting the name referred to by a symbolic link will actually delete the
file (unless it also has other hard links).
If this behavior is not desired, use
**link**(2).

<a name="glibc-notes"></a>

### Glibc notes

On older kernels where
**symlinkat**()
is unavailable, the glibc wrapper function falls back to the use of
**symlink**().
When
_linkpath_
is a relative pathname,
glibc constructs a pathname based on the symbolic link in
_/proc/self/fd_
that corresponds to the
_newdirfd_
argument.

<a name="see-also"></a>

# See Also

**ln**(1),
**namei**(1),
**lchown**(2),
**link**(2),
**lstat**(2),
**open**(2),
**readlink**(2),
**rename**(2),
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
