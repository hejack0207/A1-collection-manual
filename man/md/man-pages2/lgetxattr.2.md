# getxattr(2) - retrieve an extended attribute value

Linux, 2017-03-13

```
.fam C
</synopsis>
    #include <sys/types.h>
    #include <sys/xattr.h>
    
    ssize_t getxattr(const char&nbsp;*path, const char&nbsp;*name,
                     void&nbsp;*value, size_t size);
    ssize_t lgetxattr(const char&nbsp;*path, const char&nbsp;*name,
                     void&nbsp;*value, size_t size);
    ssize_t fgetxattr(int fd, const char&nbsp;*name,
                     void&nbsp;*value, size_t size);
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

**getxattr**()
retrieves the value of the extended attribute identified by
_name_
and associated with the given
_path_
in the filesystem.
The attribute value is placed in the buffer pointed to by
_value_;
_size_
specifies the size of that buffer.
The return value of the call is the number of bytes placed in
_value_.

**lgetxattr**()
is identical to
**getxattr**(),
except in the case of a symbolic link, where the link itself is
interrogated, not the file that it refers to.

**fgetxattr**()
is identical to
**getxattr**(),
only the open file referred to by
_fd_
(as returned by
**open**(2))
is interrogated in place of
_path_.

An extended attribute
_name_
is a null-terminated string.
The name includes a namespace prefix; there may be several, disjoint
namespaces associated with an individual inode.
The value of an extended attribute is a chunk of arbitrary textual or
binary data that was assigned using
**setxattr**(2).

If
_size_
is specified as zero, these calls return the current size of the
named extended attribute (and leave
_value_
unchanged).
This can be used to determine the size of the buffer that
should be supplied in a subsequent call.
(But, bear in mind that there is a possibility that the
attribute value may change between the two calls,
so that it is still necessary to check the return status
from the second call.)

<a name="return-value"></a>

# Return Value

On success, these calls return a nonnegative value which is
the size (in bytes) of the extended attribute value.
On failure, -1 is returned and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **E2BIG**  
  The size of the attribute value is larger than the maximum size allowed; the
  attribute cannot be retrieved.
  This can happen on filesystems that support
  very large attribute values such as NFSv4, for example.
* **ENOATTR**  
  The named attribute does not exist, or the process has no access to
  this attribute.
  (**ENOATTR**
  is defined to be a synonym for
  **ENODATA**
  in
  _&lt;attr/xattr.h&gt;_.)
* **ENOTSUP**  
  Extended attributes are not supported by the filesystem, or are disabled.
* **ERANGE**  
  The
  _size_
  of the
  _value_
  buffer is too small to hold the result.

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







<a name="example"></a>

# Example

See
**listxattr**(2).

<a name="see-also"></a>

# See Also

**getfattr**(1),
**setfattr**(1),
**listxattr**(2),
**open**(2),
**removexattr**(2),
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
