# inotify_init(2) - initialize an inotify instance

Linux, 2017-09-15

    #include <sys/inotify.h>
    
    "int inotify_init(void);"
    int inotify_init1(int flags);

<a name="description"></a>

# Description

For an overview of the inotify API, see
**inotify**(7).

**inotify_init**()
initializes a new inotify instance and returns a file descriptor associated
with a new inotify event queue.

If
_flags_
is 0, then
**inotify_init1**()
is the same as
**inotify_init**().
The following values can be bitwise ORed in
_flags_
to obtain different behavior:

* **IN_NONBLOCK**  
  Set the
  **O_NONBLOCK**
  file status flag on the new open file description.
  Using this flag saves extra calls to
  **fcntl**(2)
  to achieve the same result.
* **IN_CLOEXEC**  
  Set the close-on-exec
  (**FD_CLOEXEC**)
  flag on the new file descriptor.
  See the description of the
  **O_CLOEXEC**
  flag in
  **open**(2)
  for reasons why this may be useful.

<a name="return-value"></a>

# Return Value

On success, these system calls return a new file descriptor.
On error, -1 is returned, and
_errno_
is set to indicate the error.

<a name="errors"></a>

# Errors


* **EINVAL**  
  (**inotify_init1**())
  An invalid value was specified in
  _flags_.
* **EMFILE**  
  The user limit on the total number of inotify instances has been reached.
* **EMFILE**  
  The per-process limit on the number of open file descriptors has been reached.
* **ENFILE**  
  The system-wide limit on the total number of open files has been reached.
* **ENOMEM**  
  Insufficient kernel memory is available.

<a name="versions"></a>

# Versions

**inotify_init**()
first appeared in Linux 2.6.13;
library support was added to glibc in version 2.4.
**inotify_init1**()
was added in Linux 2.6.27;
library support was added to glibc in version 2.9.

<a name="conforming-to"></a>

# Conforming to

These system calls are Linux-specific.

<a name="see-also"></a>

# See Also

**inotify_add_watch**(2),
**inotify_rm_watch**(2),
**inotify**(7)

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
