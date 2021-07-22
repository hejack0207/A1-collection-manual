# rename(2) - change the name or location of a file

Linux, 2017-09-15

    #include <stdio.h>
    
    int rename(const char *oldpath, const char *newpath);
    
    #include <fcntl.h>           /* Definition of AT_* constants */
    #include <stdio.h>
    
    int renameat(int olddirfd, const char *oldpath,
                 int newdirfd, const char *newpath);
    
    int renameat2(int olddirfd, const char *oldpath,
                  int newdirfd, const char *newpath, unsigned int flags);
```

 Note: There is no glibc wrapper for renameat2(); see NOTES. 
 .in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in 
 renameat(): .RS 4 .TP 4 Since glibc 2.10: _POSIX_C_SOURCE&nbsp;>=&nbsp;200809L .TP Before glibc 2.10: _ATFILE_SOURCE
</synopsis>

<synopsis>
.RE
```

<a name="description"></a>

# Description

**rename**()
renames a file, moving it between directories if required.
Any other hard links to the file (as created using
**link**(2))
are unaffected.
Open file descriptors for
_oldpath_
are also unaffected.

Various restrictions determine whether or not the rename operation succeeds:
see ERRORS below.

If
_newpath_
already exists, it will be atomically replaced, so that there is
no point at which another process attempting to access
_newpath_
will find it missing.
However, there will probably be a window in which both
_oldpath_
and
_newpath_
refer to the file being renamed.

If
_oldpath_
and
_newpath_
are existing hard links referring to the same file, then
**rename**()
does nothing, and returns a success status.

If
_newpath_
exists but the operation fails for some reason,
**rename**()
guarantees to leave an instance of
_newpath_
in place.

_oldpath_
can specify a directory.
In this case,
_newpath_
must either not exist, or it must specify an empty directory.

If
_oldpath_
refers to a symbolic link, the link is renamed; if
_newpath_
refers to a symbolic link, the link will be overwritten.

<a name="renameat"></a>

### renameat()

The
**renameat**()
system call operates in exactly the same way as
**rename**(),
except for the differences described here.

If the pathname given in
_oldpath_
is relative, then it is interpreted relative to the directory
referred to by the file descriptor
_olddirfd_
(rather than relative to the current working directory of
the calling process, as is done by
**rename**()
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
**rename**()).

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

See
**openat**(2)
for an explanation of the need for
**renameat**().

<a name="renameat2"></a>

### renameat2()

**renameat2**()
has an additional
_flags_
argument.
A
**renameat2**()
call with a zero
_flags_
argument is equivalent to
**renameat**().

The
_flags_
argument is a bit mask consisting of zero or more of the following flags:

* **RENAME_EXCHANGE**  
  Atomically exchange
  _oldpath_
  and
  _newpath_.
  Both pathnames must exist
  but may be of different types (e.g., one could be a non-empty directory
  and the other a symbolic link).
* **RENAME_NOREPLACE**  
  Don't overwrite
  _newpath_
  of the rename.
  Return an error if
  _newpath_
  already exists.
* **RENAME_NOREPLACE**
  can't be employed together with
  **RENAME_EXCHANGE**.
* **RENAME_WHITEOUT** (since Linux 3.18)  
  
  
  This operation makes sense only for overlay/union
  filesystem implementations.
* Specifying
  **RENAME_WHITEOUT**
  creates a "whiteout" object at the source of
  the rename at the same time as performing the rename.
  The whole operation is atomic,
  so that if the rename succeeds then the whiteout will also have been created.
* A "whiteout" is an object that has special meaning in union/overlay
  filesystem constructs.
  In these constructs,
  multiple layers exist and only the top one is ever modified.
  A whiteout on an upper layer will effectively hide a
  matching file in the lower layer,
  making it appear as if the file didn't exist.
* When a file that exists on the lower layer is renamed,
  the file is first copied up (if not already on the upper layer)
  and then renamed on the upper, read-write layer.
  At the same time, the source file needs to be "whiteouted"
  (so that the version of the source file in the lower layer
  is rendered invisible).
  The whole operation needs to be done atomically.
* When not part of a union/overlay,
  the whiteout appears as a character device with a {0,0} device number.
* **RENAME_WHITEOUT**
  requires the same privileges as creating a device node (i.e., the
  **CAP_MKNOD**
  capability).
* **RENAME_WHITEOUT**
  can't be employed together with
  **RENAME_EXCHANGE**.
* **RENAME_WHITEOUT**
  requires support from the underlying filesystem.
  Among the filesystems that provide that support are
  shmem (since Linux 3.18),
  
  ext4 (since Linux 3.18),
  
  and XFS (since Linux 4.1).
  

<a name="return-value"></a>

# Return Value

On success, zero is returned.
On error, -1 is returned, and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **EACCES**  
  Write permission is denied for the directory containing
  _oldpath_
  or
  _newpath_,
  or, search permission is denied for one of the directories
  in the path prefix of
  _oldpath_
  or
  _newpath_,
  or
  _oldpath_
  is a directory and does not allow write permission (needed to update
  the
  _.._
  entry).
  (See also
  **path_resolution**(7).)
* **EBUSY**  
  The rename fails because
  _oldpath_ or _newpath_
  is a directory that is in use by some process (perhaps as
  current working directory, or as root directory, or because
  it was open for reading) or is in use by the system
  (for example as mount point), while the system considers
  this an error.
  (Note that there is no requirement to return
  **EBUSY**
  in such
  cases—there is nothing wrong with doing the rename anyway—but
  it is allowed to return
  **EBUSY**
  if the system cannot otherwise
  handle such situations.)
* **EDQUOT**  
  The user's quota of disk blocks on the filesystem has been exhausted.
* **EFAULT**  
  _oldpath_ or _newpath_ points outside your accessible address space.
* **EINVAL**  
  The new pathname contained a path prefix of the old, or, more generally,
  an attempt was made to make a directory a subdirectory of itself.
* **EISDIR**  
  _newpath_
  is an existing directory, but
  _oldpath_
  is not a directory.
* **ELOOP**  
  Too many symbolic links were encountered in resolving
  _oldpath_ or _newpath_.
* **EMLINK**  
  _oldpath_
  already has the maximum number of links to it, or
  it was a directory and the directory containing
  _newpath_
  has the maximum number of links.
* **ENAMETOOLONG**  
  _oldpath_ or _newpath_ was too long.
* **ENOENT**  
  The link named by
  _oldpath_
  does not exist;
  or, a directory component in
  _newpath_
  does not exist;
  or,
  _oldpath_
  or
  _newpath_
  is an empty string.
* **ENOMEM**  
  Insufficient kernel memory was available.
* **ENOSPC**  
  The device containing the file has no room for the new directory
  entry.
* **ENOTDIR**  
  A component used as a directory in
  _oldpath_ or _newpath_
  is not, in fact, a directory.
  Or,
  _oldpath_
  is a directory, and
  _newpath_
  exists but is not a directory.
* **ENOTEMPTY** or **EEXIST**  
  _newpath_
  is a nonempty directory, that is, contains entries other than "." and "..".
* **EPERM** or **EACCES**  
  The directory containing
  _oldpath_
  has the sticky bit
  (**S_ISVTX**)
  set and the process's effective user ID is neither
  the user ID of the file to be deleted nor that of the directory
  containing it, and the process is not privileged
  (Linux: does not have the
  **CAP_FOWNER**
  capability);
  or
  _newpath_
  is an existing file and the directory containing it has the sticky bit set
  and the process's effective user ID is neither the user ID of the file
  to be replaced nor that of the directory containing it,
  and the process is not privileged
  (Linux: does not have the
  **CAP_FOWNER**
  capability);
  or the filesystem containing
  _pathname_
  does not support renaming of the type requested.
* **EROFS**  
  The file is on a read-only filesystem.
* **EXDEV**  
  _oldpath_ and _newpath_
  are not on the same mounted filesystem.
  (Linux permits a filesystem to be mounted at multiple points, but
  **rename**()
  does not work across different mount points,
  even if the same filesystem is mounted on both.)

The following additional errors can occur for
**renameat**()
and
**renameat2**():

* **EBADF**  
  _olddirfd_
  or
  _newdirfd_
  is not a valid file descriptor.
* **ENOTDIR**  
  _oldpath_
  is relative and
  _olddirfd_
  is a file descriptor referring to a file other than a directory;
  or similar for
  _newpath_
  and
  _newdirfd_

The following additional errors can occur for
**renameat2**():

* **EEXIST**  
  _flags_
  contains
  **RENAME_NOREPLACE**
  and
  _newpath_
  already exists.
* **EINVAL**  
  An invalid flag was specified in
  _flags_.
* **EINVAL**  
  Both
  **RENAME_NOREPLACE**
  and
  **RENAME_EXCHANGE**
  were specified in
  _flags_.
* **EINVAL**  
  Both
  **RENAME_WHITEOUT**
  and
  **RENAME_EXCHANGE**
  were specified in
  _flags_.
* **EINVAL**  
  The filesystem does not support one of the flags in
  _flags_.
* **ENOENT**  
  _flags_
  contains
  **RENAME_EXCHANGE**
  and
  _newpath_
  does not exist.
* **EPERM**  
  **RENAME_WHITEOUT**
  was specified in
  _flags_,
  but the caller does not have the
  **CAP_MKNOD**
  capability.

<a name="versions"></a>

# Versions

**renameat**()
was added to Linux in kernel 2.6.16;
library support was added to glibc in version 2.4.

**renameat2**()
was added to Linux in kernel 3.15.


<a name="conforming-to"></a>

# Conforming to

**rename**():
4.3BSD, C89, C99, POSIX.1-2001, POSIX.1-2008.

**renameat**():
POSIX.1-2008.

**renameat2**()
is Linux-specific.

<a name="notes"></a>

# Notes

Glibc does not provide a wrapper for the
**renameat2**()
system call; call it using
**syscall**(2).


<a name="glibc-notes"></a>

### Glibc notes

On older kernels where
**renameat**()
is unavailable, the glibc wrapper function falls back to the use of
**rename**().
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

On NFS filesystems, you can not assume that if the operation
failed, the file was not renamed.
If the server does the rename operation
and then crashes, the retransmitted RPC which will be processed when the
server is up again causes a failure.
The application is expected to
deal with this.
See
**link**(2)
for a similar problem.

<a name="see-also"></a>

# See Also

**mv**(1),
**chmod**(2),
**link**(2),
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
