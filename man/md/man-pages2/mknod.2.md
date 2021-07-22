# mknod(2) - create a special or ordinary file

Linux, 2017-09-15

    #include <sys/types.h>
    #include <sys/stat.h>
    #include <fcntl.h>
    #include <unistd.h>
    
    int mknod(const char *pathname, mode_t mode, dev_t dev);
    
    #include <fcntl.h>           /* Definition of AT_* constants */
    #include <sys/stat.h>
    
    int mknodat(int dirfd, const char *pathname, mode_t mode, dev_t dev);
```

 .in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in 
 mknod(): .RS 4 _XOPEN_SOURCE&nbsp;>=&nbsp;500
</synopsis>

<synopsis>
    || /* Since glibc 2.19: */ _DEFAULT_SOURCE     || /* Glibc versions <= 2.19: */ _BSD_SOURCE || _SVID_SOURCE .RE
```

<a name="description"></a>

# Description

The system call
**mknod**()
creates a filesystem node (file, device special file, or
named pipe) named
_pathname_,
with attributes specified by
_mode_
and
_dev_.

The
_mode_
argument specifies both the file mode to use and the type of node
to be created.
It should be a combination (using bitwise OR) of one of the file types
listed below and zero or more of the file mode bits listed in
**inode**(7).

The file mode is modified by the process's
_umask_
in the usual way: in the absence of a default ACL, the permissions of the
created node are
(_mode_ & ~_umask_).

The file type must be one of
**S_IFREG**,
**S_IFCHR**,
**S_IFBLK**,
**S_IFIFO**,
or
**S_IFSOCK**

to specify a regular file (which will be created empty), character
special file, block special file, FIFO (named pipe), or UNIX domain socket,
respectively.
(Zero file type is equivalent to type
**S_IFREG**.)

If the file type is
**S_IFCHR**
or
**S_IFBLK**,
then
_dev_
specifies the major and minor numbers of the newly created device
special file
(**makedev**(3)
may be useful to build the value for
_dev_);
otherwise it is ignored.

If
_pathname_
already exists, or is a symbolic link, this call fails with an
**EEXIST**
error.

The newly created node will be owned by the effective user ID of the
process.
If the directory containing the node has the set-group-ID
bit set, or if the filesystem is mounted with BSD group semantics, the
new node will inherit the group ownership from its parent directory;
otherwise it will be owned by the effective group ID of the process.



<a name="mknodat"></a>

### mknodat()

The
**mknodat**()
system call operates in exactly the same way as
**mknod**(),
except for the differences described here.

If the pathname given in
_pathname_
is relative, then it is interpreted relative to the directory
referred to by the file descriptor
_dirfd_
(rather than relative to the current working directory of
the calling process, as is done by
**mknod**()
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
**mknod**()).

If
_pathname_
is absolute, then
_dirfd_
is ignored.

See
**openat**(2)
for an explanation of the need for
**mknodat**().

<a name="return-value"></a>

# Return Value

**mknod**()
and
**mknodat**()
return zero on success, or -1 if an error occurred (in which case,
_errno_
is set appropriately).

<a name="errors"></a>

# Errors


* **EACCES**  
  The parent directory does not allow write permission to the process,
  or one of the directories in the path prefix of
  _pathname_
  did not allow search permission.
  (See also
  **path_resolution**(7).)
* **EDQUOT**  
  The user's quota of disk blocks or inodes on the filesystem has been
  exhausted.
* **EEXIST**  
  _pathname_
  already exists.
  This includes the case where
  _pathname_
  is a symbolic link, dangling or not.
* **EFAULT**  
  _pathname_ points outside your accessible address space.
* **EINVAL**  
  _mode_
  requested creation of something other than a regular file, device
  special file, FIFO or socket.
* **ELOOP**  
  Too many symbolic links were encountered in resolving
  _pathname_.
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
  has no room for the new node.
* **ENOTDIR**  
  A component used as a directory in
  _pathname_
  is not, in fact, a directory.
* **EPERM**  
  _mode_
  requested creation of something other than a regular file,
  FIFO (named pipe), or UNIX domain socket, and the caller
  is not privileged (Linux: does not have the
  **CAP_MKNOD**
  capability);
  
  
  
  also returned if the filesystem containing
  _pathname_
  does not support the type of node requested.
* **EROFS**  
  _pathname_
  refers to a file on a read-only filesystem.

The following additional errors can occur for
**mknodat**():

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

**mknodat**()
was added to Linux in kernel 2.6.16;
library support was added to glibc in version 2.4.

<a name="conforming-to"></a>

# Conforming to

**mknod**():
SVr4, 4.4BSD, POSIX.1-2001 (but see below), POSIX.1-2008.




**mknodat**():
POSIX.1-2008.

<a name="notes"></a>

# Notes

POSIX.1-2001 says: "The only portable use of
**mknod**()
is to create a FIFO-special file.
If
_mode_
is not
**S_IFIFO**
or
_dev_
is not 0, the behavior of
**mknod**()
is unspecified."
However, nowadays one should never use
**mknod**()
for this purpose; one should use
**mkfifo**(3),
a function especially defined for this purpose.

Under Linux,
**mknod**()
cannot be used to create directories.
One should make directories with
**mkdir**(2).


There are many infelicities in the protocol underlying NFS.
Some of these affect
**mknod**()
and
**mknodat**().

<a name="see-also"></a>

# See Also

**mknod**(1),
**chmod**(2),
**chown**(2),
**fcntl**(2),
**mkdir**(2),
**mount**(2),
**socket**(2),
**stat**(2),
**umask**(2),
**unlink**(2),
**makedev**(3),
**mkfifo**(3),
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
