# futimesat(2) - change timestamps of a file relative to a directory file descriptor

Linux, 2017-09-15

    #include <fcntl.h>           /* Definition of AT_* constants */
    #include <sys/time.h>
    
    int futimesat(int dirfd, const char *pathname,
                  const struct timeval times[2]);
```

 .in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in 
 futimesat(): _GNU_SOURCE
```

<a name="description"></a>

# Description

This system call is obsolete.
Use
**utimensat**(2)
instead.

The
**futimesat**()
system call operates in exactly the same way as
**utimes**(2),
except for the differences described in this manual page.

If the pathname given in
_pathname_
is relative, then it is interpreted relative to the directory
referred to by the file descriptor
_dirfd_
(rather than relative to the current working directory of
the calling process, as is done by
**utimes**(2)
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
**utimes**(2)).

If
_pathname_
is absolute, then
_dirfd_
is ignored.

<a name="return-value"></a>

# Return Value

On success,
**futimesat**()
returns a 0.
On error, -1 is returned and
_errno_
is set to indicate the error.

<a name="errors"></a>

# Errors

The same errors that occur for
**utimes**(2)
can also occur for
**futimesat**().
The following additional errors can occur for
**futimesat**():

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

**futimesat**()
was added to Linux in kernel 2.6.16;
library support was added to glibc in version 2.4.

<a name="conforming-to"></a>

# Conforming to

This system call is nonstandard.
It was implemented from a specification that was proposed for POSIX.1,
but that specification was replaced by the one for
**utimensat**(2).

A similar system call exists on Solaris.

<a name="notes"></a>

# Notes


<a name="glibc-notes"></a>

### Glibc notes

If
_pathname_
is NULL, then the glibc
**futimesat**()
wrapper function updates the times for the file referred to by
_dirfd_.


<a name="see-also"></a>

# See Also

**stat**(2),
**utimensat**(2),
**utimes**(2),
**futimes**(3),
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
