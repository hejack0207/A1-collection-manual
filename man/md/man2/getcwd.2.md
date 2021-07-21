# getcwd(3) - get current working directory

GNU, 2018-04-30

    #include <unistd.h>
    
    char *getcwd(char *buf, size_t size);
    
    char *getwd(char *buf);
    
    "char *get_current_dir_name(void);"
```

 .in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in 
 get_current_dir_name(): .RS _GNU_SOURCE .RE 
 getwd(): .RS 4 .TP 4 Since glibc 2.12:
</synopsis>
    (_XOPEN_SOURCE&nbsp;>=&nbsp;500) && ! (_POSIX_C_SOURCE&nbsp;>=&nbsp;200809L)
        || /* Glibc since 2.19: */ _DEFAULT_SOURCE
        || /* Glibc versions <= 2.19: */ _BSD_SOURCE
    .TP 4
<synopsis>
Before glibc 2.12: _BSD_SOURCE || _XOPEN_SOURCE&nbsp;>=&nbsp;500
</synopsis>

<synopsis>
.RE
```

<a name="description"></a>

# Description

These functions return a null-terminated string containing an
absolute pathname that is the current working directory of
the calling process.
The pathname is returned as the function result and via the argument
_buf_,
if present.

If the current directory is not below the root directory of the current
process (e.g., because the process set a new filesystem root using
**chroot**(2)
without changing its current directory into the new root),
then, since Linux 2.6.36,

the returned path will be prefixed with the string "(unreachable)".
Such behavior can also be caused by an unprivileged user by changing
the current directory into another mount namespace.
When dealing with paths from untrusted sources, callers of these
functions should consider checking whether the returned path starts
with '/' or '(' to avoid misinterpreting an unreachable path
as a relative path.
This is no longer true under some C libraries; see
**NOTES**.

The
**getcwd**()
function copies an absolute pathname of the current working directory
to the array pointed to by
_buf_,
which is of length
_size_.

If the length of the absolute pathname of the current working directory,
including the terminating null byte, exceeds
_size_
bytes, NULL is returned, and
_errno_
is set to
**ERANGE**;
an application should check for this error, and allocate a larger
buffer if necessary.

As an extension to the POSIX.1-2001 standard, glibc's
**getcwd**()
allocates the buffer dynamically using
**malloc**(3)
if
_buf_
is NULL.
In this case, the allocated buffer has the length
_size_
unless
_size_
is zero, when
_buf_
is allocated as big as necessary.
The caller should
**free**(3)
the returned buffer.

**get_current_dir_name**()
will
**malloc**(3)
an array big enough to hold the absolute pathname of
the current working directory.
If the environment
variable
**PWD**
is set, and its value is correct, then that value will be returned.
The caller should
**free**(3)
the returned buffer.

**getwd**()
does not
**malloc**(3)
any memory.
The
_buf_
argument should be a pointer to an array at least
**PATH_MAX**
bytes long.
If the length of the absolute pathname of the current working directory,
including the terminating null byte, exceeds
**PATH_MAX**
bytes, NULL is returned, and
_errno_
is set to
**ENAMETOOLONG**.
(Note that on some systems,
**PATH_MAX**
may not be a compile-time constant;
furthermore, its value may depend on the filesystem, see
**pathconf**(3).)
For portability and security reasons, use of
**getwd**()
is deprecated.

<a name="return-value"></a>

# Return Value

On success, these functions return a pointer to a string containing
the pathname of the current working directory.
In the case
**getcwd**()
and
**getwd**()
this is the same value as
_buf_.

On failure, these functions return NULL, and
_errno_
is set to indicate the error.
The contents of the array pointed to by
_buf_
are undefined on error.

<a name="errors"></a>

# Errors


* **EACCES**  
  Permission to read or search a component of the filename was denied.
* **EFAULT**  
  _buf_
  points to a bad address.
* **EINVAL**  
  The
  _size_
  argument is zero and
  _buf_
  is not a null pointer.
* **EINVAL**  
  **getwd**():
  _buf_
  is NULL.
* **ENAMETOOLONG**  
  **getwd**():
  The size of the null-terminated absolute pathname string exceeds
  **PATH_MAX**
  bytes.
* **ENOENT**  
  The current working directory has been unlinked.
* **ENOMEM**  
  Out of memory.
* **ERANGE**  
  The
  _size_
  argument is less than the length of the absolute pathname of the
  working directory, including the terminating null byte.
  You need to allocate a bigger array and try again.

<a name="attributes"></a>

# Attributes

For an explanation of the terms used in this section, see
**attributes**(7).
.TS
allbox;
lbw22 lb lb
l l l.
Interface	Attribute	Value
T{
**getcwd**(),
**getwd**()
T}	Thread safety	MT-Safe
T{
**get_current_dir_name**()
T}	Thread safety	MT-Safe env
.TE

<a name="conforming-to"></a>

# Conforming to

**getcwd**()
conforms to POSIX.1-2001.
Note however that POSIX.1-2001 leaves the behavior of
**getcwd**()
unspecified if
_buf_
is NULL.

**getwd**()
is present in POSIX.1-2001, but marked LEGACY.
POSIX.1-2008 removes the specification of
**getwd**().
Use
**getcwd**()
instead.
POSIX.1-2001
does not define any errors for
**getwd**().

**get_current_dir_name**()
is a GNU extension.

<a name="notes"></a>

# Notes

Under Linux, the function
**getcwd**()
is a system call (since 2.1.92).
On older systems it would query
_/proc/self/cwd_.
If both system call and proc filesystem are missing, a
generic implementation is called.
Only in that case can
these calls fail under Linux with
**EACCES**.

Since a Linux 2.6.36 change that added "(unreachable)", the glibc
**getcwd**()
has failed to conform to POSIX and returned a relative path when the API
contract requires an absolute path.
With glibc 2.27 onwards this is corrected;
calling
**getcwd**()
from such a path will now result in failure with
**ENOENT**.

These functions are often used to save the location of the current working
directory for the purpose of returning to it later.
Opening the current
directory (".") and calling
**fchdir**(2)
to return is usually a faster and more reliable alternative when sufficiently
many file descriptors are available, especially on platforms other than Linux.

<a name="see-also"></a>

# See Also

**pwd**(1),
**chdir**(2),
**fchdir**(2),
**open**(2),
**unlink**(2),
**free**(3),
**malloc**(3)

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
