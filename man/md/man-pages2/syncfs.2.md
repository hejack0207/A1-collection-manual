# sync(2) - commit filesystem caches to disk

Linux, 2017-09-15

```
#include <unistd.h> 
 void sync(void); 
 int syncfs(int fd); 
 .in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in 
 sync(): .RS 4 _XOPEN_SOURCE&nbsp;>=&nbsp;500
</synopsis>

<synopsis>
    || /* Since glibc 2.19: */ _DEFAULT_SOURCE     || /* Glibc versions <= 2.19: */ _BSD_SOURCE .RE 
 syncfs(): .RS 4 _GNU_SOURCE .RE
```

<a name="description"></a>

# Description

**sync**()
causes all pending modifications to filesystem metadata and cached file
data to be written to the underlying filesystems.

**syncfs**()
is like
**sync**(),
but synchronizes just the filesystem containing file
referred to by the open file descriptor
_fd_.

<a name="return-value"></a>

# Return Value

**syncfs**()
returns 0 on success;
on error, it returns -1 and sets
_errno_
to indicate the error.

<a name="errors"></a>

# Errors

**sync**()
is always successful.

**syncfs**()
can fail for at least the following reason:

* **EBADF**  
  _fd_
  is not a valid file descriptor.

<a name="versions"></a>

# Versions

**syncfs**()
first appeared in Linux 2.6.39;
library support was added to glibc in version 2.14.

<a name="conforming-to"></a>

# Conforming to

**sync**():
POSIX.1-2001, POSIX.1-2008, SVr4, 4.3BSD.

**syncfs**()
is Linux-specific.

<a name="notes"></a>

# Notes

Since glibc 2.2.2, the Linux prototype for
**sync**()
is as listed above,
following the various standards.
In glibc 2.2.1 and earlier,
it was "int sync(void)", and
**sync**()
always returned 0.

According to the standard specification (e.g., POSIX.1-2001),
**sync**()
schedules the writes, but may return before the actual
writing is done.  However Linux waits for I/O completions,
and thus
**sync**()
or
**syncfs**()
provide the same guarantees as fsync called on every file in
the system or filesystem respectively.

<a name="bugs"></a>

# Bugs

Before version 1.3.20 Linux did not wait for I/O to complete
before returning.

<a name="see-also"></a>

# See Also

**sync**(1),
**fdatasync**(2),
**fsync**(2)

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
