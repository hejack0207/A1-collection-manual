# readlink(2) - read value of a symbolic link

Linux, 2017-09-15

    #include <unistd.h>
    
    ssize_t readlink(const char *pathname, char *buf, size_t bufsiz);
    
    #include <fcntl.h>           /* Definition of AT_* constants */
    #include <unistd.h>
    
    ssize_t readlinkat(int dirfd, const char *pathname,
                       char *buf, size_t bufsiz);
    
```
.in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in 
 readlink(): .RS 4 _XOPEN_SOURCE&nbsp;>=&nbsp;500 || _POSIX_C_SOURCE&nbsp;>=&nbsp;200112L
</synopsis>

<synopsis>
    || /* Glibc versions <= 2.19: */ _BSD_SOURCE .RE 
 readlinkat(): .RS 4 .TP 4 Since glibc 2.10: _POSIX_C_SOURCE&nbsp;>=&nbsp;200809L .TP Before glibc 2.10: _ATFILE_SOURCE .RE
```

<a name="description"></a>

# Description

**readlink**()
places the contents of the symbolic link
_pathname_
in the buffer
_buf_,
which has size
_bufsiz_.
**readlink**()
does not append a null byte to
_buf_.
It will (silently) truncate the contents (to a length of
_bufsiz_
characters), in case the buffer is too small to hold all of the contents.

<a name="readlinkat"></a>

### readlinkat()

The
**readlinkat**()
system call operates in exactly the same way as
**readlink**(),
except for the differences described here.

If the pathname given in
_pathname_
is relative, then it is interpreted relative to the directory
referred to by the file descriptor
_dirfd_
(rather than relative to the current working directory of
the calling process, as is done by
**readlink**()
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
**readlink**()).

If
_pathname_
is absolute, then
_dirfd_
is ignored.

Since Linux 2.6.39,

_pathname_
can be an empty string,
in which case the call operates on the symbolic link referred to by
_dirfd_
(which should have been obtained using
**open**(2)
with the
**O_PATH**
and
**O_NOFOLLOW**
flags).

See
**openat**(2)
for an explanation of the need for
**readlinkat**().

<a name="return-value"></a>

# Return Value

On success, these calls return the number of bytes placed in
_buf_.
(If the returned value equals
_bufsiz_,
then truncation may have occurred.)
On error, -1 is returned and
_errno_
is set to indicate the error.

<a name="errors"></a>

# Errors


* **EACCES**  
  Search permission is denied for a component of the path prefix.
  (See also
  **path_resolution**(7).)
* **EFAULT**  
  _buf_
  extends outside the process's allocated address space.
* **EINVAL**  
  _bufsiz_
  is not positive.
  
  
  
  
  
* **EINVAL**  
  The named file (i.e., the final filename component of
  _pathname_)
  is not a symbolic link.
* **EIO**  
  An I/O error occurred while reading from the filesystem.
* **ELOOP**  
  Too many symbolic links were encountered in translating the pathname.
* **ENAMETOOLONG**  
  A pathname, or a component of a pathname, was too long.
* **ENOENT**  
  The named file does not exist.
* **ENOMEM**  
  Insufficient kernel memory was available.
* **ENOTDIR**  
  A component of the path prefix is not a directory.

The following additional errors can occur for
**readlinkat**():

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

**readlinkat**()
was added to Linux in kernel 2.6.16;
library support was added to glibc in version 2.4.

<a name="conforming-to"></a>

# Conforming to

**readlink**():
4.4BSD
(**readlink**()
first appeared in 4.2BSD),
POSIX.1-2001, POSIX.1-2008.

**readlinkat**():
POSIX.1-2008.

<a name="notes"></a>

# Notes

In versions of glibc up to and including glibc 2.4, the return type of
**readlink**()
was declared as
_int_.
Nowadays, the return type is declared as
_ssize_t_,
as (newly) required in POSIX.1-2001.

Using a statically sized buffer might not provide enough room for the
symbolic link contents.
The required size for the buffer can be obtained from the
_stat.st_size_
value returned by a call to
**lstat**(2)
on the link.
However, the number of bytes written by
**readlink**()
and
**readlinkat**()
should be checked to make sure that the size of the
symbolic link did not increase between the calls.
Dynamically allocating the buffer for
**readlink**()
and
**readlinkat**()
also addresses a common portability problem when using
_PATH_MAX_
for the buffer size,
as this constant is not guaranteed to be defined per POSIX
if the system does not have such limit.

<a name="glibc-notes"></a>

### Glibc notes

On older kernels where
**readlinkat**()
is unavailable, the glibc wrapper function falls back to the use of
**readlink**().
When
_pathname_
is a relative pathname,
glibc constructs a pathname based on the symbolic link in
_/proc/self/fd_
that corresponds to the
_dirfd_
argument.

<a name="example"></a>

# Example

The following program allocates the buffer needed by
**readlink**()
dynamically from the information provided by
**lstat**(2),
falling back to a buffer of size
**PATH_MAX**
in cases where
**lstat**(2)
reports a size of zero.

.EX
#include &lt;sys/types.h&gt;
#include &lt;sys/stat.h&gt;
#include &lt;limits.h&gt;
#include &lt;stdio.h&gt;
#include &lt;stdlib.h&gt;
#include &lt;unistd.h&gt;

int
main(int argc, char *argv[])
{
    struct stat sb;
    char *buf;
    ssize_t nbytes, bufsiz;

    if (argc != 2) {
        fprintf(stderr, "Usage: %s &lt;pathname&gt;\\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    if (lstat(argv[1], &sb) == -1) {
        perror("lstat");
        exit(EXIT_FAILURE);
    }

    /* Add one to the link size, so that we can determine whether
       the buffer returned by readlink() was truncated. */

    bufsiz = sb.st_size + 1;

    /* Some magic symlinks under (for example) /proc and /sys
       report 'st_size' as zero. In that case, take PATH_MAX as
       a "good enough" estimate. */

    if (sb.st_size == 0)
        bufsiz = PATH_MAX;

    buf = malloc(bufsiz);
    if (buf == NULL) {
        perror("malloc");
        exit(EXIT_FAILURE);
    }

    nbytes = readlink(argv[1], buf, bufsiz);
    if (nbytes == -1) {
        perror("readlink");
        exit(EXIT_FAILURE);
    }

    printf("'%s' points to '%.*s'\\n", argv[1], (int) nbytes, buf);

    /* If the return value was equal to the buffer size, then the
       the link target was larger than expected (perhaps because the
       target was changed between the call to lstat() and the call to
       readlink()). Warn the user that the returned target may have
       been truncated. */

    if (nbytes == bufsiz)
        printf("(Returned buffer may have been truncated)\\n");

    free(buf);
    exit(EXIT_SUCCESS);
}
.EE

<a name="see-also"></a>

# See Also

**readlink**(1),
**lstat**(2),
**stat**(2),
**symlink**(2),
**realpath**(3),
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
