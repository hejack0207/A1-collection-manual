# inotify_add_watch(2) - add a watch to an initialized inotify instance

Linux, 2017-09-15

```
#include <sys/inotify.h> 
 int inotify_add_watch(int fd, const char *pathname, uint32_t mask);
```

<a name="description"></a>

# Description

**inotify_add_watch**()
adds a new watch, or modifies an existing watch,
for the file whose location is specified in
_pathname_;
the caller must have read permission for this file.
The
_fd_
argument is a file descriptor referring to the
inotify instance whose watch list is to be modified.
The events to be monitored for
_pathname_
are specified in the
_mask_
bit-mask argument.
See
**inotify**(7)
for a description of the bits that can be set in
_mask_.

A successful call to
**inotify_add_watch**()
returns a unique watch descriptor for this inotify instance,
for the filesystem object (inode) that corresponds to
_pathname_.
If the filesystem object
was not previously being watched by this inotify instance,
then the watch descriptor is newly allocated.
If the filesystem object was already being watched
(perhaps via a different link to the same object), then the descriptor
for the existing watch is returned.

The watch descriptor is returned by later
**read**(2)s
from the inotify file descriptor.
These reads fetch
_inotify_event_
structures (see
**inotify**(7))
indicating filesystem events;
the watch descriptor inside this structure identifies
the object for which the event occurred.

<a name="return-value"></a>

# Return Value

On success,
**inotify_add_watch**()
returns a nonnegative watch descriptor.
On error, -1 is returned and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **EACCES**  
  Read access to the given file is not permitted.
* **EBADF**  
  The given file descriptor is not valid.
* **EFAULT**  
  _pathname_
  points outside of the process's accessible address space.
* **EINVAL**  
  The given event mask contains no valid events; or
  _fd_
  is not an inotify file descriptor.
* **ENAMETOOLONG**  
  _pathname_
  is too long.
* **ENOENT**  
  A directory component in
  _pathname_
  does not exist or is a dangling symbolic link.
* **ENOMEM**  
  Insufficient kernel memory was available.
* **ENOSPC**  
  The user limit on the total number of inotify watches was reached or the
  kernel failed to allocate a needed resource.

<a name="versions"></a>

# Versions

Inotify was merged into the 2.6.13 Linux kernel.

<a name="conforming-to"></a>

# Conforming to

This system call is Linux-specific.

<a name="see-also"></a>

# See Also

**inotify_init**(2),
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
