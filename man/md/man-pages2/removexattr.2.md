# removexattr(2) - remove an extended attribute

Linux, 2015-05-07

```
.fam C
</synopsis>
    #include <sys/types.h>
    #include <sys/xattr.h>
    
    int removexattr(const char&nbsp;*path, const char&nbsp;*name);
    int lremovexattr(const char&nbsp;*path, const char&nbsp;*name);
    int fremovexattr(int fd, const char&nbsp;*name);
<synopsis>
.fam T
```

<a name="description"></a>

# Description

Extended attributes are
_name_:_value_
pairs associated with inodes (files, directories, symbolic links, etc.).
They are extensions to the normal attributes which are associated
with all inodes in the system (i.e., the
**stat**(2)
data).
A complete overview of extended attributes concepts can be found in
**xattr**(7).

**removexattr**()
removes the extended attribute identified by
_name_
and associated with the given
_path_
in the filesystem.

**lremovexattr**()
is identical to
**removexattr**(),
except in the case of a symbolic link, where the extended attribute is
removed from the link itself, not the file that it refers to.

**fremovexattr**()
is identical to
**removexattr**(),
only the extended attribute is removed from the open file referred to by
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

<a name="return-value"></a>

# Return Value

On success, zero is returned.
On failure, -1 is returned and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **ENOATTR**  
  The named attribute does not exist.
  (**ENOATTR**
  is defined to be a synonym for
  **ENODATA**
  in
  _&lt;attr/xattr.h&gt;_.)
* **ENOTSUP**  
  Extended attributes are not supported by the filesystem, or are disabled.

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
**setxattr**(2),
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
