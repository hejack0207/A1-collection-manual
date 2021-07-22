# unlink(2) - delete a name and possibly the file it refers to

Linux, 2017-09-15

    #include <unistd.h>
    
    int unlink(const char *pathname);
    
    #include <fcntl.h>           /* Definition of AT_* constants */
    #include <unistd.h>
    
    int unlinkat(int dirfd, const char *pathname, int flags);
```

 .in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in 
 unlinkat(): .RS 4 .TP 4 Since glibc 2.10: _POSIX_C_SOURCE&nbsp;>=&nbsp;200809L .TP Before glibc 2.10: _ATFILE_SOURCE .RE
```

<a name="description"></a>

# Description

**unlink**()
deletes a name from the filesystem.
If that name was the
last link to a file and no processes have the file open, the file is
deleted and the space it was using is made available for reuse.

If the name was the last link to a file but any processes still have
the file open, the file will remain in existence until the last file
descriptor referring to it is closed.

If the name referred to a symbolic link, the link is removed.

If the name referred to a socket, FIFO, or device, the name for it is
removed but processes which have the object open may continue to use
it.

<a name="unlinkat"></a>

### unlinkat()

The
**unlinkat**()
system call operates in exactly the same way as either
**unlink**()
or
**rmdir**(2)
(depending on whether or not
_flags_
includes the
**AT_REMOVEDIR**
flag)
except for the differences described here.

If the pathname given in
_pathname_
is relative, then it is interpreted relative to the directory
referred to by the file descriptor
_dirfd_
(rather than relative to the current working directory of
the calling process, as is done by
**unlink**()
and
**rmdir**(2)
for a relative pathname).

If the pathname given in
_pathname_
is relative and
_dirfd_
is the special value
**AT_FDCWD**,
then
_pathname_
is interpreted relative to the current working
directory of the calling process (like
**unlink**()
and
**rmdir**(2)).

If the pathname given in
_pathname_
is absolute, then
_dirfd_
is ignored.

_flags_
is a bit mask that can either be specified as 0, or by ORing
together flag values that control the operation of
**unlinkat**().
Currently, only one such flag is defined:

* **AT_REMOVEDIR**  
  By default,
  **unlinkat**()
  performs the equivalent of
  **unlink**()
  on
  _pathname_.
  If the
  **AT_REMOVEDIR**
  flag is specified, then
  performs the equivalent of
  **rmdir**(2)
  on
  _pathname_.

See
**openat**(2)
for an explanation of the need for
**unlinkat**().

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
  _pathname_
  is not allowed for the process's effective UID, or one of the
  directories in
  _pathname_
  did not allow search permission.
  (See also
  **path_resolution**(7).)
* **EBUSY**  
  The file
  _pathname_
  cannot be unlinked because it is being used by the system
  or another process;
  for example, it is a mount point
  or the NFS client software created it to represent an
  active but otherwise nameless inode ("NFS silly renamed").
* **EFAULT**  
  _pathname_
  points outside your accessible address space.
* **EIO**  
  An I/O error occurred.
* **EISDIR**  
  _pathname_
  refers to a directory.
  (This is the non-POSIX value returned by Linux since 2.1.132.)
* **ELOOP**  
  Too many symbolic links were encountered in translating
  _pathname_.
* **ENAMETOOLONG**  
  _pathname_ was too long.
* **ENOENT**  
  A component in
  _pathname_
  does not exist or is a dangling symbolic link, or
  _pathname_
  is empty.
* **ENOMEM**  
  Insufficient kernel memory was available.
* **ENOTDIR**  
  A component used as a directory in
  _pathname_
  is not, in fact, a directory.
* **EPERM**  
  The system does not allow unlinking of directories,
  or unlinking of directories requires privileges that the
  calling process doesn't have.
  (This is the POSIX prescribed error return;
  as noted above, Linux returns
  **EISDIR**
  for this case.)
* **EPERM** (Linux only)  
  The filesystem does not allow unlinking of files.
* **EPERM** or **EACCES**  
  The directory containing
  _pathname_
  has the sticky bit
  (**S_ISVTX**)
  set and the process's effective UID is neither the UID of the file to
  be deleted nor that of the directory containing it, and
  the process is not privileged (Linux: does not have the
  **CAP_FOWNER**
  capability).
* **EPERM**  
  The file to be unlinked is marked immutable or append-only.
  (See
  **ioctl_iflags**(2).)
* **EROFS**  
  _pathname_
  refers to a file on a read-only filesystem.

The same errors that occur for
**unlink**()
and
**rmdir**(2)
can also occur for
**unlinkat**().
The following additional errors can occur for
**unlinkat**():

* **EBADF**  
  _dirfd_
  is not a valid file descriptor.
* **EINVAL**  
  An invalid flag value was specified in
  _flags_.
* **EISDIR**  
  _pathname_
  refers to a directory, and
  **AT_REMOVEDIR**
  was not specified in
  _flags_.
* **ENOTDIR**  
  _pathname_
  is relative and
  _dirfd_
  is a file descriptor referring to a file other than a directory.

<a name="versions"></a>

# Versions

**unlinkat**()
was added to Linux in kernel 2.6.16;
library support was added to glibc in version 2.4.

<a name="conforming-to"></a>

# Conforming to

**unlink**():
SVr4, 4.3BSD, POSIX.1-2001, POSIX.1-2008.



**unlinkat**():
POSIX.1-2008.

<a name="notes"></a>

# Notes


<a name="glibc-notes"></a>

### Glibc notes

On older kernels where
**unlinkat**()
is unavailable, the glibc wrapper function falls back to the use of
**unlink**()
or
**rmdir**(2).
When
_pathname_
is a relative pathname,
glibc constructs a pathname based on the symbolic link in
_/proc/self/fd_
that corresponds to the
_dirfd_
argument.

<a name="bugs"></a>

# Bugs

Infelicities in the protocol underlying NFS can cause the unexpected
disappearance of files which are still being used.

<a name="see-also"></a>

# See Also

**rm**(1),
**unlink**(1),
**chmod**(2),
**link**(2),
**mknod**(2),
**open**(2),
**rename**(2),
**rmdir**(2),
**mkfifo**(3),
**remove**(3),
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
