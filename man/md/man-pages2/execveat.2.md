# execveat(2) - execute program relative to a directory file descriptor

Linux, 2017-09-15

```
#include <unistd.h> 
 int execveat(int dirfd, const char *pathname,
char *const argv[], char *const envp[],
int flags);
```

<a name="description"></a>

# Description


The
**execveat**()
system call executes the program referred to by the combination of
_dirfd_
and
_pathname_.
It operates in exactly the same way as
**execve**(2),
except for the differences described in this manual page.

If the pathname given in
_pathname_
is relative, then it is interpreted relative to the directory
referred to by the file descriptor
_dirfd_
(rather than relative to the current working directory of
the calling process, as is done by
**execve**(2)
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
**execve**(2)).

If
_pathname_
is absolute, then
_dirfd_
is ignored.

If
_pathname_
is an empty string and the
**AT_EMPTY_PATH**
flag is specified, then the file descriptor
_dirfd_
specifies the file to be executed (i.e.,
_dirfd_
refers to an executable file, rather than a directory).

The
_flags_
argument is a bit mask that can include zero or more of the following flags:

* **AT_EMPTY_PATH**  
  If
  _pathname_
  is an empty string, operate on the file referred to by
  _dirfd_
  (which may have been obtained using the
  **open**(2)
  **O_PATH**
  flag).
* **AT_SYMLINK_NOFOLLOW**  
  If the file identified by
  _dirfd_
  and a non-NULL
  _pathname_
  is a symbolic link, then the call fails with the error
  **ELOOP**.

<a name="return-value"></a>

# Return Value

On success,
**execveat**()
does not return.
On error, -1 is returned, and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors

The same errors that occur for
**execve**(2)
can also occur for
**execveat**().
The following additional errors can occur for
**execveat**():

* **EBADF**  
  _dirfd_
  is not a valid file descriptor.
* **EINVAL**  
  Invalid flag specified in
  _flags_.
* **ELOOP**  
  _flags_
  includes
  **AT_SYMLINK_NOFOLLOW**
  and the file identified by
  _dirfd_
  and a non-NULL
  _pathname_
  is a symbolic link.
* **ENOENT**  
  The program identified by
  _dirfd_
  and
  _pathname_
  requires the use of an interpreter program
  (such as a script starting with "#!"), but the file descriptor
  _dirfd_
  was opened with the
  **O_CLOEXEC**
  flag, with the result that
  the program file is inaccessible to the launched interpreter.
  See BUGS.
* **ENOTDIR**  
  _pathname_
  is relative and
  _dirfd_
  is a file descriptor referring to a file other than a directory.

<a name="versions"></a>

# Versions

**execveat**()
was added to Linux in kernel 3.19.
GNU C library support is pending.


<a name="conforming-to"></a>

# Conforming to

The
**execveat**()
system call is Linux-specific.

<a name="notes"></a>

# Notes

In addition to the reasons explained in
**openat**(2),
the
**execveat**()
system call is also needed to allow
**fexecve**(3)
to be implemented on systems that do not have the
_/proc_
filesystem mounted.

When asked to execute a script file, the
_argv[0]_
that is passed to the script interpreter is a string of the form
_/dev/fd/N_
or
_/dev/fd/N/P_,
where
_N_
is the number of the file descriptor passed via the
_dirfd_
argument.
A string of the first form occurs when
**AT_EMPTY_PATH**
is employed.
A string of the second form occurs when the script is specified via both
_dirfd_
and
_pathname_;
in this case,
_P_
is the value given in
_pathname_.

For the same reasons described in
**fexecve**(3),
the natural idiom when using
**execveat**()
is to set the close-on-exec flag on
_dirfd_.
(But see BUGS.)

<a name="bugs"></a>

# Bugs

The
**ENOENT**
error described above means that it is not possible to set the
close-on-exec flag on the file descriptor given to a call of the form:

    execveat(fd, "", argv, envp, AT_EMPTY_PATH);

However, the inability to set the close-on-exec flag means that a file
descriptor referring to the script leaks through to the script itself.
As well as wasting a file descriptor,
this leakage can lead to file-descriptor exhaustion in scenarios
where scripts recursively employ
**execveat**().






<a name="see-also"></a>

# See Also

**execve**(2),
**openat**(2),
**fexecve**(3)

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
