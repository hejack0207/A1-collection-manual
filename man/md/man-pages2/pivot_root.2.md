# pivot_root(2) - change the root filesystem

Linux, 2017-09-15

```
int pivot_root(const char *new_root, const char *put_old); 
 Note: There is no glibc wrapper for this system call; see NOTES.
```

<a name="description"></a>

# Description

**pivot_root**()
moves the root filesystem of the calling process to the
directory _put\_old_ and makes _new\_root_ the new root filesystem
of the calling process.





The typical use of
**pivot_root**()
is during system startup, when the
system mounts a temporary root filesystem (e.g., an **initrd**), then
mounts the real root filesystem, and eventually turns the latter into
the current root of all relevant processes or threads.

**pivot_root**()
may or may not change the current root and the current
working directory of any processes or threads which use the old
root directory.
The caller of
**pivot_root**()
must ensure that processes with root or current working directory
at the old root operate correctly in either case.
An easy way to ensure this is to change their
root and current working directory to _new\_root_ before invoking
**pivot_root**().

The paragraph above is intentionally vague because the implementation of
**pivot_root**()
may change in the future.
At the time of writing,
**pivot_root**()
changes root and current working directory of each process or
thread to _new\_root_ if they point to the old root directory.
This is necessary in order to prevent kernel threads from keeping the old
root directory busy with their root and current working directory,
even if they never access
the filesystem in any way.
In the future, there may be a mechanism for
kernel threads to explicitly relinquish any access to the filesystem,
such that this fairly intrusive mechanism can be removed from
**pivot_root**().

Note that this also applies to the calling process:
**pivot_root**()
may or may not affect its current working directory.
It is therefore recommended to call
**chdir("/")** immediately after
**pivot_root**().

The following restrictions apply to _new\_root_ and _put\_old_:

* They must be directories.
* _new\_root_ and _put\_old_ must not be on the same filesystem as
  the current root.
* _put\_old_ must be underneath _new\_root_, that is, adding a nonzero
  number of _/.._ to the string pointed to by _put\_old_ must yield
  the same directory as _new\_root_.
* No other filesystem may be mounted on _put\_old_.

See also
**pivot_root**(8)
for additional usage examples.

If the current root is not a mount point (e.g., after
**chroot**(2)
or
**pivot_root**(),
see also below), not the old root directory, but the
mount point of that filesystem is mounted on _put\_old_.

_new\_root_ does not have to be a mount point.
In this case,
_/proc/mounts_ will show the mount point of the filesystem containing
_new\_root_ as root (_/_).

<a name="return-value"></a>

# Return Value

On success, zero is returned.
On error, -1 is returned, and
_errno_ is set appropriately.

<a name="errors"></a>

# Errors

**pivot_root**()
may return (in _errno_) any of the errors returned by
**stat**(2).
Additionally, it may return:

* **EBUSY**  
  _new\_root_ or _put\_old_ are on the current root filesystem,
  or a filesystem is already mounted on _put\_old_.
* **EINVAL**  
  _put\_old_ is not underneath _new\_root_.
* **ENOTDIR**  
  _new\_root_ or _put\_old_ is not a directory.
* **EPERM**  
  The calling process does not have the
  **CAP_SYS_ADMIN**
  capability.

<a name="versions"></a>

# Versions

**pivot_root**()
was introduced in Linux 2.3.41.

<a name="conforming-to"></a>

# Conforming to

**pivot_root**()
is Linux-specific and hence is not portable.

<a name="notes"></a>

# Notes

Glibc does not provide a wrapper for this system call; call it using
**syscall**(2).

<a name="bugs"></a>

# Bugs

**pivot_root**()
should not have to change root and current working directory of all other
processes in the system.

Some of the more obscure uses of
**pivot_root**()
may quickly lead to
insanity.

<a name="see-also"></a>

# See Also

**chdir**(2),
**chroot**(2),
**stat**(2),
**initrd**(4),
**pivot_root**(8),
**switch_root**(8)

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
