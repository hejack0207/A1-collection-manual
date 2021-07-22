# setxattr(2) - set an extended attribute value

Linux, 2017-03-13

```
.fam C
</synopsis>
    #include <sys/types.h>
    #include <sys/xattr.h>
    
    int setxattr(const char&nbsp;*path, const char&nbsp;*name,
                  const void&nbsp;*value, size_t size, int flags);
    int lsetxattr(const char&nbsp;*path, const char&nbsp;*name,
                  const void&nbsp;*value, size_t size, int flags);
    int fsetxattr(int fd, const char&nbsp;*name,
                  const void&nbsp;*value, size_t size, int flags);
<synopsis>
.fam T
```

<a name="description"></a>

# Description

Extended attributes are
_name_:\c
_value_
pairs associated with inodes (files, directories, symbolic links, etc.).
They are extensions to the normal attributes which are associated
with all inodes in the system (i.e., the
**stat**(2)
data).
A complete overview of extended attributes concepts can be found in
**xattr**(7).

**setxattr**()
sets the
_value_
of the extended attribute identified by
_name_
and associated with the given
_path_
in the filesystem.
The
_size_
argument specifies the size (in bytes) of
_value_;
a zero-length value is permitted.

**lsetxattr**()
is identical to
**setxattr**(),
except in the case of a symbolic link, where the extended attribute is
set on the link itself, not the file that it refers to.

**fsetxattr**()
is identical to
**setxattr**(),
only the extended attribute is set on the open file referred to by
_fd_
(as returned by
**open**(2))
in place of
_path_.

An extended attribute name is a null-terminated string.
The
_name_
includes a namespace prefix; there may be several, disjoint
namespaces associated with an individual inode.
The
_value_
of an extended attribute is a chunk of arbitrary textual or
binary data of specified length.

By default
(i.e.,
_flags_
is zero),
the extended attribute will be created if it does not exist,
or the value will be replaced if the attribute already exists.
To modify these semantics, one of the following values can be specified in
_flags_:

* **XATTR_CREATE**  
  Perform a pure create, which fails if the named attribute exists already.
* **XATTR_REPLACE**  
  Perform a pure replace operation,
  which fails if the named attribute does not already exist.

<a name="return-value"></a>

# Return Value

On success, zero is returned.
On failure, -1 is returned and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **EDQUOT**  
  Disk quota limits meant that
  there is insufficient space remaining to store the extended attribute.
* **EEXIST**  
  **XATTR_CREATE**
  was specified, and the attribute exists already.
* **ENOATTR**  
  **XATTR_REPLACE**
  was specified, and the attribute does not exist.
  (**ENOATTR**
  is defined to be a synonym for
  **ENODATA**
  in
  _&lt;attr/xattr.h&gt;_.)
* **ENOSPC**  
  There is insufficient space remaining to store the extended attribute.
* **ENOTSUP**  
  The namespace prefix of
  _name_
  is not valid.
* **ENOTSUP**  
  Extended attributes are not supported by the filesystem, or are disabled,
* **EPERM**  
  The file is marked immutable or append-only.
  (See
  **ioctl_iflags**(2).)

In addition, the errors documented in
**stat**(2)
can also occur.

<a name="versions"></a>

# Versions

These system calls have been available on Linux since kernel 2.4;
glibc support is provided since version 2.3.

<a name="conforming-to"></a>

# Conforming to

These system calls are Linux-specific.







<a name="see-also"></a>

# See Also

**getfattr**(1),
**setfattr**(1),
**getxattr**(2),
**listxattr**(2),
**open**(2),
**removexattr**(2),
**stat**(2),
**symlink**(7),
**xattr**(7)

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
