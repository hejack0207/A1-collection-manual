# access(2) - check user's permissions for a file

Linux, 2016-03-15

    #include <unistd.h>
    
    int access(const char *pathname, int mode);
    
    #include <fcntl.h>           /* Definition of AT_* constants */
    #include <unistd.h>
    
    int faccessat(int dirfd, const char *pathname, int mode, int flags);
```

 .in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in 
 faccessat(): .RS 4 .TP 4 Since glibc 2.10: _POSIX_C_SOURCE&nbsp;>=&nbsp;200809L .TP Before glibc 2.10: _ATFILE_SOURCE .RE
```

<a name="description"></a>

# Description

**access**()
checks whether the calling process can access the file
_pathname_.
If
_pathname_
is a symbolic link, it is dereferenced.

The
_mode_
specifies the accessibility check(s) to be performed,
and is either the value
**F_OK**,

or a mask consisting of the bitwise OR of one or more of
**R_OK**, **W_OK**, and **X_OK**.
**F_OK**
tests for the existence of the file.
**R_OK**, **W_OK**, and **X_OK**
test whether the file exists and grants read, write, and
execute permissions, respectively.

The check is done using the calling process's
_real_
UID and GID, rather than the effective IDs as is done when
actually attempting an operation (e.g.,
**open**(2))
on the file.
Similarly, for the root user, the check uses the set of
permitted capabilities rather than the set of effective
capabilities; and for non-root users, the check uses an empty set
of capabilities.

This allows set-user-ID programs and capability-endowed programs
to easily determine the invoking user's authority.
In other words,
**access**()
does not answer the "can I read/write/execute this file?" question.
It answers a slightly different question:
"(assuming I'm a setuid binary) can
_the user who invoked me_
read/write/execute this file?",
which gives set-user-ID programs the possibility to
prevent malicious users from causing them to read files
which users shouldn't be able to read.

If the calling process is privileged (i.e., its real UID is zero),
then an
**X_OK**
check is successful for a regular file if execute permission
is enabled for any of the file owner, group, or other.

<a name="faccessat"></a>

### faccessat()

The
**faccessat**()
system call operates in exactly the same way as
**access**(),
except for the differences described here.

If the pathname given in
_pathname_
is relative, then it is interpreted relative to the directory
referred to by the file descriptor
_dirfd_
(rather than relative to the current working directory of
the calling process, as is done by
**access**()
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
**access**()).

If
_pathname_
is absolute, then
_dirfd_
is ignored.

_flags_
is constructed by ORing together zero or more of the following values:

* **AT_EACCESS**  
  Perform access checks using the effective user and group IDs.
  By default,
  **faccessat**()
  uses the real IDs (like
  **access**()).
* **AT_SYMLINK_NOFOLLOW**  
  If
  _pathname_
  is a symbolic link, do not dereference it:
  instead return information about the link itself.

See
**openat**(2)
for an explanation of the need for
**faccessat**().

<a name="return-value"></a>

# Return Value

On success (all requested permissions granted, or
_mode_
is
**F_OK**
and the file exists), zero is returned.
On error (at least one bit in
_mode_
asked for a permission that is denied, or
_mode_
is
**F_OK**
and the file does not exist, or some other error occurred),
-1 is returned, and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors

**access**()
and
**faccessat**()
shall fail if:

* **EACCES**  
  The requested access would be denied to the file, or search permission
  is denied for one of the directories in the path prefix of
  _pathname_.
  (See also
  **path_resolution**(7).)
* **ELOOP**  
  Too many symbolic links were encountered in resolving
  _pathname_.
* **ENAMETOOLONG**  
  _pathname_
  is too long.
* **ENOENT**  
  A component of
  _pathname_
  does not exist or is a dangling symbolic link.
* **ENOTDIR**  
  A component used as a directory in
  _pathname_
  is not, in fact, a directory.
* **EROFS**  
  Write permission was requested for a file on a read-only filesystem.

**access**()
and
**faccessat**()
may fail if:

* **EFAULT**  
  _pathname_
  points outside your accessible address space.
* **EINVAL**  
  _mode_
  was incorrectly specified.
* **EIO**  
  An I/O error occurred.
* **ENOMEM**  
  Insufficient kernel memory was available.
* **ETXTBSY**  
  Write access was requested to an executable which is being
  executed.

The following additional errors can occur for
**faccessat**():

* **EBADF**  
  _dirfd_
  is not a valid file descriptor.
* **EINVAL**  
  Invalid flag specified in
  _flags_.
* **ENOTDIR**  
  _pathname_
  is relative and
  _dirfd_
  is a file descriptor referring to a file other than a directory.

<a name="versions"></a>

# Versions

**faccessat**()
was added to Linux in kernel 2.6.16;
library support was added to glibc in version 2.4.

<a name="conforming-to"></a>

# Conforming to

**access**():
SVr4, 4.3BSD, POSIX.1-2001, POSIX.1-2008.

**faccessat**():
POSIX.1-2008.

<a name="notes"></a>

# Notes


**Warning**:
Using these calls to check if a user is authorized to, for example,
open a file before actually doing so using
**open**(2)
creates a security hole, because the user might exploit the short time
interval between checking and opening the file to manipulate it.
**For this reason, the use of this system call should be avoided**.
(In the example just described,
a safer alternative would be to temporarily switch the process's
effective user ID to the real ID and then call
**open**(2).)

**access**()
always dereferences symbolic links.
If you need to check the permissions on a symbolic link, use
**faccessat**()
with the flag
**AT_SYMLINK_NOFOLLOW**.

These calls return an error if any of the access types in
_mode_
is denied, even if some of the other access types in
_mode_
are permitted.

If the calling process has appropriate privileges (i.e., is superuser),
POSIX.1-2001 permits an implementation to indicate success for an
**X_OK**
check even if none of the execute file permission bits are set.

Linux does not do this.

A file is accessible only if the permissions on each of the
directories in the path prefix of
_pathname_
grant search (i.e., execute) access.
If any directory is inaccessible, then the
**access**()
call fails, regardless of the permissions on the file itself.

Only access bits are checked, not the file type or contents.
Therefore, if a directory is found to be writable,
it probably means that files can be created in the directory,
and not that the directory can be written as a file.
Similarly, a DOS file may be found to be "executable," but the
**execve**(2)
call will still fail.

These calls
may not work correctly on NFSv2 filesystems with UID mapping enabled,
because UID mapping is done on the server and hidden from the client,
which checks permissions.  (NFS versions 3 and higher perform the check on
the server.)
Similar problems can occur to FUSE mounts.



<a name="c-librarykernel-differences"></a>

### C library/kernel differences

The raw
**faccessat**()
system call takes only the first three arguments.
The
**AT_EACCESS**
and
**AT_SYMLINK_NOFOLLOW**
flags are actually implemented within the glibc wrapper function for
**faccessat**().
If either of these flags is specified, then the wrapper function employs
**fstatat**(2)
to determine access permissions.

<a name="glibc-notes"></a>

### Glibc notes

On older kernels where
**faccessat**()
is unavailable (and when the
**AT_EACCESS**
and
**AT_SYMLINK_NOFOLLOW**
flags are not specified),
the glibc wrapper function falls back to the use of
**access**().
When
_pathname_
is a relative pathname,
glibc constructs a pathname based on the symbolic link in
_/proc/self/fd_
that corresponds to the
_dirfd_
argument.

<a name="bugs"></a>

# Bugs

In kernel 2.4 (and earlier) there is some strangeness in the handling of
**X_OK**
tests for superuser.
If all categories of execute permission are disabled
for a nondirectory file, then the only
**access**()
test that returns -1 is when
_mode_
is specified as just
**X_OK**;
if
**R_OK**
or
**W_OK**
is also specified in
_mode_,
then
**access**()
returns 0 for such files.

Early 2.6 kernels (up to and including 2.6.3)
also behaved in the same way as kernel 2.4.

In kernels before 2.6.20,
these calls ignored the effect of the
**MS_NOEXEC**
flag if it was used to
**mount**(2)
the underlying filesystem.
Since kernel 2.6.20, the
**MS_NOEXEC**
flag is honored.

<a name="see-also"></a>

# See Also

**chmod**(2),
**chown**(2),
**open**(2),
**setgid**(2),
**setuid**(2),
**stat**(2),
**euidaccess**(3),
**credentials**(7),
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
