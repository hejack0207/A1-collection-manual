# rmdir(2) - delete a directory

Linux, 2015-08-08

```
#include <unistd.h> 
 int rmdir(const char *pathname);
```

<a name="description"></a>

# Description

**rmdir**()
deletes a directory, which must be empty.

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
  was not allowed, or one of the directories in the path prefix of
  _pathname_
  did not allow search permission.
  (See also
  **path_resolution**(7).
* **EBUSY**  
  _pathname_
  is currently in use by the system or some process that prevents its
  removal.
  On Linux, this means
  _pathname_
  is currently used as a mount point
  or is the root directory of the calling process.
* **EFAULT**  
  _pathname_ points outside your accessible address space.
* **EINVAL**  
  _pathname_
  has
  _._
  as last component.
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
* **ENOTDIR**  
  _pathname_,
  or a component used as a directory in
  _pathname_,
  is not, in fact, a directory.
* **ENOTEMPTY**  
  _pathname_
  contains entries other than
  _._ and _.._ ;
  or,
  _pathname_
  has
  _.._
  as its final component.
  POSIX.1 also allows
  
  **EEXIST**
  for this condition.
* **EPERM**  
  The directory containing
  _pathname_
  has the sticky bit
  (**S_ISVTX**)
  set and the process's effective user ID is neither the user ID
  of the file to be deleted nor that of the directory containing it,
  and the process is not privileged (Linux: does not have the
  **CAP_FOWNER**
  capability).
* **EPERM**  
  The filesystem containing
  _pathname_
  does not support the removal of directories.
* **EROFS**  
  _pathname_
  refers to a directory on a read-only filesystem.

<a name="conforming-to"></a>

# Conforming to

POSIX.1-2001, POSIX.1-2008, SVr4, 4.3BSD.

<a name="bugs"></a>

# Bugs

Infelicities in the protocol underlying NFS can cause the unexpected
disappearance of directories which are still being used.

<a name="see-also"></a>

# See Also

**rm**(1),
**rmdir**(1),
**chdir**(2),
**chmod**(2),
**mkdir**(2),
**rename**(2),
**unlink**(2),
**unlinkat**(2)

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
