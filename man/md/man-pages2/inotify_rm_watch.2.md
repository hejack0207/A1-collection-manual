# inotify_rm_watch(2) - remove an existing watch from an inotify instance

Linux, 2017-09-15

```
#include <sys/inotify.h> 
 int inotify_rm_watch(int fd, int wd);
```



<a name="description"></a>

# Description

**inotify_rm_watch**()
removes the watch associated with the watch descriptor
_wd_
from the inotify instance associated with the file descriptor
_fd_.

Removing a watch causes an
**IN_IGNORED**
event to be generated for this watch descriptor.
(See
**inotify**(7).)

<a name="return-value"></a>

# Return Value

On success,
**inotify_rm_watch**()
returns zero.
On error, -1 is returned and
_errno_
is set to indicate the cause of the error.

<a name="errors"></a>

# Errors


* **EBADF**  
  _fd_
  is not a valid file descriptor.
* **EINVAL**  
  The watch descriptor
  _wd_
  is not valid; or
  _fd_
  is not an inotify file descriptor.

<a name="versions"></a>

# Versions

Inotify was merged into the 2.6.13 Linux kernel.

<a name="conforming-to"></a>

# Conforming to

This system call is Linux-specific.

<a name="see-also"></a>

# See Also

**inotify_add_watch**(2),
**inotify_init**(2),
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
