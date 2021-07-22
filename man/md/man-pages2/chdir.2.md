# chdir(2) - change working directory

Linux, 2017-09-15

```
#include <unistd.h> 
 int chdir(const char *path);
int fchdir(int fd); 
 .in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in 
 fchdir(): .RS 4 _XOPEN_SOURCE&nbsp;>=&nbsp;500
</synopsis>

<synopsis>
    || /* Since glibc 2.12: */ _POSIX_C_SOURCE&nbsp;>=&nbsp;200809L     || /* Glibc up to and including 2.19: */ _BSD_SOURCE .RE
```

<a name="description"></a>

# Description

**chdir**()
changes the current working directory of the calling process to the
directory specified in
_path_.

**fchdir**()
is identical to
**chdir**();
the only difference is that the directory is given as an
open file descriptor.

<a name="return-value"></a>

# Return Value

On success, zero is returned.
On error, -1 is returned, and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors

Depending on the filesystem, other errors can be returned.
The more
general errors for
**chdir**()
are listed below:

* **EACCES**  
  Search permission is denied for one of the components of
  _path_.
  (See also
  **path_resolution**(7).)
* **EFAULT**  
  _path_
  points outside your accessible address space.
* **EIO**  
  An I/O error occurred.
* **ELOOP**  
  Too many symbolic links were encountered in resolving
  _path_.
* **ENAMETOOLONG**  
  _path_
  is too long.
* **ENOENT**  
  The directory specified in
  _path_
  does not exist.
* **ENOMEM**  
  Insufficient kernel memory was available.
* **ENOTDIR**  
  A component of
  _path_
  is not a directory.

The general errors for
**fchdir**()
are listed below:

* **EACCES**  
  Search permission was denied on the directory open on
  _fd_.
* **EBADF**  
  _fd_
  is not a valid file descriptor.

<a name="conforming-to"></a>

# Conforming to

POSIX.1-2001, POSIX.1-2008, SVr4, 4.4BSD.

<a name="notes"></a>

# Notes

The current working directory is the starting point for interpreting
relative pathnames (those not starting with '/').

A child process created via
**fork**(2)
inherits its parent's current working directory.
The current working directory is left unchanged by
**execve**(2).

<a name="see-also"></a>

# See Also

**chroot**(2),
**getcwd**(3),
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
