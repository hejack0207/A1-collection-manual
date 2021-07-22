# utime(2) - change file last access and modification times

Linux, 2017-09-15

    #include <sys/types.h>
    #include <utime.h>
    
    int utime(const char *filename, const struct utimbuf *times);
    
    #include <sys/time.h>
    
    int utimes(const char *filename, const struct timeval times[2]);

<a name="description"></a>

# Description

**Note:**
modern applications may prefer to use the interfaces described in
**utimensat**(2).

The
**utime**()
system call
changes the access and modification times of the inode specified by
_filename_
to the
_actime_ and _modtime_
fields of
_times_
respectively.

If
_times_
is NULL, then the access and modification times of the file are set
to the current time.

Changing timestamps is permitted when: either
the process has appropriate privileges,
or the effective user ID equals the user ID
of the file, or
_times_
is NULL and the process has write permission for the file.

The
_utimbuf_
structure is:

.in +4n
.EX
struct utimbuf {
    time_t actime;       /* access time */
    time_t modtime;      /* modification time */
};
.EE
.in

The
**utime**()
system call
allows specification of timestamps with a resolution of 1 second.

The
**utimes**()
system call
is similar, but the
_times_
argument refers to an array rather than a structure.
The elements of this array are
_timeval_
structures, which allow a precision of 1 microsecond for specifying timestamps.
The
_timeval_
structure is:

.in +4n
.EX
struct timeval {
    long tv_sec;        /* seconds */
    long tv_usec;       /* microseconds */
};
.EE
.in

_times_[0]
specifies the new access time, and
_times_[1]
specifies the new modification time.
If
_times_
is NULL, then analogously to
**utime**(),
the access and modification times of the file are
set to the current time.

<a name="return-value"></a>

# Return Value

On success, zero is returned.
On error, -1 is returned, and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **EACCES**  
  Search permission is denied for one of the directories in
  the path prefix of
  _path_
  (see also
  **path_resolution**(7)).
* **EACCES**  
  _times_
  is NULL,
  the caller's effective user ID does not match the owner of the file,
  the caller does not have write access to the file,
  and the caller is not privileged
  (Linux: does not have either the
  **CAP_DAC_OVERRIDE**
  or the
  **CAP_FOWNER**
  capability).
* **ENOENT**  
  _filename_
  does not exist.
* **EPERM**  
  _times_
  is not NULL,
  the caller's effective UID does not match the owner of the file,
  and the caller is not privileged
  (Linux: does not have the
  **CAP_FOWNER**
  capability).
* **EROFS**  
  _path_
  resides on a read-only filesystem.

<a name="conforming-to"></a>

# Conforming to

**utime**():
SVr4, POSIX.1-2001.
POSIX.1-2008 marks
**utime**()
as obsolete.

**utimes**():
4.3BSD, POSIX.1-2001.

<a name="notes"></a>

# Notes

Linux does not allow changing the timestamps on an immutable file,
or setting the timestamps to something other than the current time
on an append-only file.







<a name="see-also"></a>

# See Also

**chattr**(1),
**touch**(1),
**futimesat**(2),
**stat**(2),
**utimensat**(2),
**futimens**(3),
**futimes**(3),
**inode**(7)

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
