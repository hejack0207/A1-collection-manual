# sysfs(2) - get filesystem type information

Linux, 2017-09-15

```
int sysfs(int option, const char *fsname); 
 int sysfs(int option, unsigned int fs_index, char *buf); 
 int sysfs(int option);
```

<a name="description"></a>

# Description

**Note**:
if you are looking for information about the
**sysfs**
filesystem that is normally mounted at
_/sys_,
see
**sysfs**(5).

The (obsolete)
**sysfs**()
system call returns information about the filesystem types
currently present in the kernel.
The specific form of the
**sysfs**()
call and the information returned depends on the
_option_
in effect:

* **1**  
  Translate the filesystem identifier string
  _fsname_
  into a filesystem type index.
* **2**  
  Translate the filesystem type index
  _fs_index_
  into a null-terminated filesystem identifier string.
  This string will
  be written to the buffer pointed to by
  _buf_.
  Make sure that
  _buf_
  has enough space to accept the string.
* **3**  
  Return the total number of filesystem types currently present in the
  kernel.

The numbering of the filesystem type indexes begins with zero.

<a name="return-value"></a>

# Return Value

On success,
**sysfs**()
returns the filesystem index for option
**1**,
zero for option
**2**,
and the number of currently configured filesystems for option
**3**.
On error, -1 is returned, and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **EFAULT**  
  Either _fsname_ or _buf_
  is outside your accessible address space.
* **EINVAL**  
  _fsname_
  is not a valid filesystem type identifier;
  _fs_index_
  is out-of-bounds;
  _option_
  is invalid.

<a name="conforming-to"></a>

# Conforming to

SVr4.

<a name="notes"></a>

# Notes

This System-V derived system call is obsolete; don't use it.
On systems with
_/proc_,
the same information can be obtained via
_/proc/filesystems_;
use that interface instead.

<a name="bugs"></a>

# Bugs

There is no libc or glibc support.
There is no way to guess how large _buf_ should be.

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
