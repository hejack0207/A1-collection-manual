# fanotify_mark(2) - add, remove, or modify an fanotify mark on a filesystem

Linux, 2016-10-08

object

<a name="synopsis"></a>

# Synopsis

    #include <sys/fanotify.h>
    
    int fanotify_mark(int fanotify_fd, unsigned int flags,
                      uint64_t mask, int dirfd, const char *pathname);

<a name="description"></a>

# Description

For an overview of the fanotify API, see
**fanotify**(7).

**fanotify_mark**()
adds, removes, or modifies an fanotify mark on a filesystem object.
The caller must have read permission on the filesystem object that
is to be marked.

The
_fanotify_fd_
argument is a file descriptor returned by
**fanotify_init**(2).

_flags_
is a bit mask describing the modification to perform.
It must include exactly one of the following values:

* **FAN_MARK_ADD**  
  The events in
  _mask_
  will be added to the mark mask (or to the ignore mask).
  _mask_
  must be nonempty or the error
  **EINVAL**
  will occur.
* **FAN_MARK_REMOVE**  
  The events in argument
  _mask_
  will be removed from the mark mask (or from the ignore mask).
  _mask_
  must be nonempty or the error
  **EINVAL**
  will occur.
* **FAN_MARK_FLUSH**  
  Remove either all mount or all non-mount marks from the fanotify group.
  If
  _flags_
  contains
  **FAN_MARK_MOUNT**,
  all marks for mounts are removed from the group.
  Otherwise, all marks for directories and files are removed.
  No flag other than
  **FAN_MARK_MOUNT**
  can be used in conjunction with
  **FAN_MARK_FLUSH**.
  _mask_
  is ignored.

If none of the values above is specified, or more than one is specified,
the call fails with the error
**EINVAL**.

In addition,
zero or more of the following values may be ORed into
_flags_:

* **FAN_MARK_DONT_FOLLOW**  
  If
  _pathname_
  is a symbolic link, mark the link itself, rather than the file to which it
  refers.
  (By default,
  **fanotify_mark**()
  dereferences
  _pathname_
  if it is a symbolic link.)
* **FAN_MARK_ONLYDIR**  
  If the filesystem object to be marked is not a directory, the error
  **ENOTDIR**
  shall be raised.
* **FAN_MARK_MOUNT**  
  Mark the mount point specified by
  _pathname_.
  If
  _pathname_
  is not itself a mount point, the mount point containing
  _pathname_
  will be marked.
  All directories, subdirectories, and the contained files of the mount point
  will be monitored.
* **FAN_MARK_IGNORED_MASK**  
  The events in
  _mask_
  shall be added to or removed from the ignore mask.
* **FAN_MARK_IGNORED_SURV_MODIFY**  
  The ignore mask shall survive modify events.
  If this flag is not set,
  the ignore mask is cleared when a modify event occurs
  for the ignored file or directory.

_mask_
defines which events shall be listened for (or which shall be ignored).
It is a bit mask composed of the following values:

* **FAN_ACCESS**  
  Create an event when a file or directory (but see BUGS) is accessed (read).
* **FAN_MODIFY**  
  Create an event when a file is modified (write).
* **FAN_CLOSE_WRITE**  
  Create an event when a writable file is closed.
* **FAN_CLOSE_NOWRITE**  
  Create an event when a read-only file or directory is closed.
* **FAN_OPEN**  
  Create an event when a file or directory is opened.
* **FAN_Q_OVERFLOW**  
  Create an event when an overflow of the event queue occurs.
  The size of the event queue is limited to 16384 entries if
  **FAN_UNLIMITED_QUEUE**
  is not set in
  **fanotify_init**(2).
* **FAN_OPEN_PERM**  
  Create an event when a permission to open a file or directory is requested.
  An fanotify file descriptor created with
  **FAN_CLASS_PRE_CONTENT**
  or
  **FAN_CLASS_CONTENT**
  is required.
* **FAN_ACCESS_PERM**  
  Create an event when a permission to read a file or directory is requested.
  An fanotify file descriptor created with
  **FAN_CLASS_PRE_CONTENT**
  or
  **FAN_CLASS_CONTENT**
  is required.
* **FAN_ONDIR**  
  Create events for directories—for example, when
  **opendir**(3),
  **readdir**(3)
  (but see BUGS), and
  **closedir**(3)
  are called.
  Without this flag, only events for files are created.
* **FAN_EVENT_ON_CHILD**  
  Events for the immediate children of marked directories shall be created.
  The flag has no effect when marking mounts.
  Note that events are not generated for children of the subdirectories
  of marked directories.
  To monitor complete directory trees it is necessary to mark the relevant
  mount.

The following composed value is defined:

* **FAN_CLOSE**  
  A file is closed
  (**FAN_CLOSE_WRITE**|**FAN_CLOSE_NOWRITE**).

The filesystem object to be marked is determined by the file descriptor
_dirfd_
and the pathname specified in
_pathname_:

* *  
  If
  _pathname_
  is NULL,
  _dirfd_
  defines the filesystem object to be marked.
* *  
  If
  _pathname_
  is NULL, and
  _dirfd_
  takes the special value
  **AT_FDCWD**,
  the current working directory is to be marked.
* *  
  If
  _pathname_
  is absolute, it defines the filesystem object to be marked, and
  _dirfd_
  is ignored.
* *  
  If
  _pathname_
  is relative, and
  _dirfd_
  does not have the value
  **AT_FDCWD**,
  then the filesystem object to be marked is determined by interpreting
  _pathname_
  relative the directory referred to by
  _dirfd_.
* *  
  If
  _pathname_
  is relative, and
  _dirfd_
  has the value
  **AT_FDCWD**,
  then the filesystem object to be marked is determined by interpreting
  _pathname_
  relative the current working directory.

<a name="return-value"></a>

# Return Value

On success,
**fanotify_mark**()
returns 0.
On error, -1 is returned, and
_errno_
is set to indicate the error.

<a name="errors"></a>

# Errors


* **EBADF**  
  An invalid file descriptor was passed in
  _fanotify_fd_.
* **EINVAL**  
  An invalid value was passed in
  _flags_
  or
  _mask_,
  or
  _fanotify_fd_
  was not an fanotify file descriptor.
* **EINVAL**  
  The fanotify file descriptor was opened with
  **FAN_CLASS_NOTIF**
  and mask contains a flag for permission events
  (**FAN_OPEN_PERM**
  or
  **FAN_ACCESS_PERM**).
* **ENOENT**  
  The filesystem object indicated by
  _dirfd_
  and
  _pathname_
  does not exist.
  This error also occurs when trying to remove a mark from an object
  which is not marked.
* **ENOMEM**  
  The necessary memory could not be allocated.
* **ENOSPC**  
  The number of marks exceeds the limit of 8192 and the
  **FAN_UNLIMITED_MARKS**
  flag was not specified when the fanotify file descriptor was created with
  **fanotify_init**(2).
* **ENOSYS**  
  This kernel does not implement
  **fanotify_mark**().
  The fanotify API is available only if the kernel was configured with
  **CONFIG_FANOTIFY**.
* **ENOTDIR**  
  _flags_
  contains
  **FAN_MARK_ONLYDIR**,
  and
  _dirfd_
  and
  _pathname_
  do not specify a directory.

<a name="versions"></a>

# Versions

**fanotify_mark**()
was introduced in version 2.6.36 of the Linux kernel and enabled in version
2.6.37.

<a name="conforming-to"></a>

# Conforming to

This system call is Linux-specific.

<a name="bugs"></a>

# Bugs

The following bugs were present in Linux kernels before version 3.16:

* *  
  
  If
  _flags_
  contains
  **FAN_MARK_FLUSH**,
  _dirfd_
  and
  _pathname_
  must specify a valid filesystem object, even though this object is not used.
* *  
  
  **readdir**(2)
  does not generate a
  **FAN_ACCESS**
  event.
* *  
  
  If
  **fanotify_mark**()
  is called with
  **FAN_MARK_FLUSH**,
  _flags_
  is not checked for invalid values.

<a name="see-also"></a>

# See Also

**fanotify_init**(2),
**fanotify**(7)

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
