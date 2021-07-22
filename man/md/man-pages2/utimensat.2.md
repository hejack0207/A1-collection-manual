# utimensat(2) - change file timestamps with nanosecond precision

Linux, 2017-09-15

    #include <fcntl.h>           /* Definition of AT_* constants */
    #include <sys/stat.h>
    
    int utimensat(int dirfd, const char *pathname,
                  const struct timespec times[2], int flags);
    
    int futimens(int fd, const struct timespec times[2]);
```

 .in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in 
 utimensat(): .RS 4 .TP 4 Since glibc 2.10: _POSIX_C_SOURCE&nbsp;>=&nbsp;200809L .TP Before glibc 2.10: _ATFILE_SOURCE .RE 
 futimens(): .RS 4 .TP Since glibc 2.10: _POSIX_C_SOURCE&nbsp;>=&nbsp;200809L .TP Before glibc 2.10: _GNU_SOURCE .RE
```

<a name="description"></a>

# Description

**utimensat**()
and
**futimens**()
update the timestamps of a file with nanosecond precision.
This contrasts with the historical
**utime**(2)
and
**utimes**(2),
which permit only second and microsecond precision, respectively,
when setting file timestamps.

With
**utimensat**()
the file is specified via the pathname given in
_pathname_.
With
**futimens**()
the file whose timestamps are to be updated is specified via
an open file descriptor,
_fd_.

For both calls, the new file timestamps are specified in the array
_times_:
_times_[0]
specifies the new "last access time" (_atime_);
_times_[1]
specifies the new "last modification time" (_mtime_).
Each of the elements of
_times_
specifies a time as the number of seconds and nanoseconds
since the Epoch, 1970-01-01 00:00:00 +0000 (UTC).
This information is conveyed in a structure of the following form:

.in +4n
.EX
struct timespec {
    time_t tv_sec;        /* seconds */
    long   tv_nsec;       /* nanoseconds */
};
.EE
.in

Updated file timestamps are set to the greatest value
supported by the filesystem that is not greater than the specified time.

If the
_tv_nsec_
field of one of the
_timespec_
structures has the special value
**UTIME_NOW**,
then the corresponding file timestamp is set to the current time.
If the
_tv_nsec_
field of one of the
_timespec_
structures has the special value
**UTIME_OMIT**,
then the corresponding file timestamp is left unchanged.
In both of these cases, the value of the corresponding
_tv_sec_

field is ignored.

If
_times_
is NULL, then both timestamps are set to the current time.


<a name="permissions-requirements"></a>

### Permissions requirements

To set both file timestamps to the current time (i.e.,
_times_
is NULL, or both
_tv_nsec_
fields specify
**UTIME_NOW**),
either:

* 1.  
  the caller must have write access to the file;
  
  
  
  
* 2.  
  the caller's effective user ID must match the owner of the file; or
* 3.  
  the caller must have appropriate privileges.

To make any change other than setting both timestamps to the
current time (i.e.,
_times_
is not NULL, and neither
_tv_nsec_
field is
**UTIME_NOW**


and neither
_tv_nsec_
field is
**UTIME_OMIT**),
either condition 2 or 3 above must apply.

If both
_tv_nsec_
fields are specified as
**UTIME_OMIT**,
then no file ownership or permission checks are performed,
and the file timestamps are not modified,
but other error conditions may still be detected.



<a name="utimensat-specifics"></a>

### utimensat() specifics

If
_pathname_
is relative, then by default it is interpreted relative to the
directory referred to by the open file descriptor,
_dirfd_
(rather than relative to the current working directory of
the calling process, as is done by
**utimes**(2)
for a relative pathname).
See
**openat**(2)
for an explanation of why this can be useful.

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
**utimes**(2)).

If
_pathname_
is absolute, then
_dirfd_
is ignored.

The
_flags_
field is a bit mask that may be 0, or include the following constant,
defined in
_&lt;fcntl.h&gt;_:

* **AT_SYMLINK_NOFOLLOW**  
  If
  _pathname_
  specifies a symbolic link, then update the timestamps of the link,
  rather than the file to which it refers.

<a name="return-value"></a>

# Return Value

On success,
**utimensat**()
and
**futimens**()
return 0.
On error, -1 is returned and
_errno_
is set to indicate the error.

<a name="errors"></a>

# Errors


* **EACCES**  
  _times_
  is NULL,
  or both
  _tv_nsec_
  values are
  **UTIME_NOW**,
  and either:
    * *  
      the effective user ID of the caller does not match
      the owner of the file,
      the caller does not have write access to the file,
      and the caller is not privileged
      (Linux: does not have either the
      **CAP_FOWNER**
      or the
      **CAP_DAC_OVERRIDE**
      capability); or,
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
    * *  
      the file is marked immutable (see
      **chattr**(1)).
      
* **EBADF**  
  (**futimens**())
  _fd_
  is not a valid file descriptor.
* **EBADF**  
  (**utimensat**())
  _pathname_
  is a relative pathname, but
  _dirfd_
  is neither
  **AT_FDCWD**
  nor a valid file descriptor.
* **EFAULT**  
  _times_
  pointed to an invalid address; or,
  _dirfd_
  was
  **AT_FDCWD**,
  and
  _pathname_
  is NULL or an invalid address.
* **EINVAL**  
  Invalid value in
  _flags_.
* **EINVAL**  
  Invalid value in one of the
  _tv_nsec_
  fields (value outside range 0 to 999,999,999, and not
  **UTIME_NOW**
  or
  **UTIME_OMIT**);
  or an invalid value in one of the
  _tv_sec_
  fields.
* **EINVAL**  
  
  _pathname_
  is NULL,
  _dirfd_
  is not
  **AT_FDCWD**,
  and
  _flags_
  contains
  **AT_SYMLINK_NOFOLLOW**.
* **ELOOP**  
  (**utimensat**())
  Too many symbolic links were encountered in resolving
  _pathname_.
* **ENAMETOOLONG**  
  (**utimensat**())
  _pathname_
  is too long.
* **ENOENT**  
  (**utimensat**())
  A component of
  _pathname_
  does not refer to an existing directory or file,
  or
  _pathname_
  is an empty string.
* **ENOTDIR**  
  (**utimensat**())
  _pathname_
  is a relative pathname, but
  _dirfd_
  is neither
  **AT_FDCWD**
  nor a file descriptor referring to a directory;
  or, one of the prefix components of
  _pathname_
  is not a directory.
* **EPERM**  
  The caller attempted to change one or both timestamps to a value
  other than the current time,
  or to change one of the timestamps to the current time while
  leaving the other timestamp unchanged,
  (i.e.,
  _times_
  is not NULL, neither
  _tv_nsec_
  field is
  **UTIME_NOW**,
  and neither
  _tv_nsec_
  field is
  **UTIME_OMIT**)
  and either:
    * *  
      the caller's effective user ID does not match the owner of file,
      and the caller is not privileged
      (Linux: does not have the
      **CAP_FOWNER**
      capability); or,
    * *  
      
      
      
      
      the file is marked append-only or immutable (see
      **chattr**(1)).
      
      
      
      
      
      
* **EROFS**  
  The file is on a read-only filesystem.
* **ESRCH**  
  (**utimensat**())
  Search permission is denied for one of the prefix components of
  _pathname_.

<a name="versions"></a>

# Versions

**utimensat**()
was added to Linux in kernel 2.6.22;
glibc support was added with version 2.6.

Support for
**futimens**()
first appeared in glibc 2.6.

<a name="attributes"></a>

# Attributes

For an explanation of the terms used in this section, see
**attributes**(7).
.TS
allbox;
lbw23 lb lb
l l l.
Interface	Attribute	Value
T{
**utimensat**(),
**futimens**()
T}	Thread safety	MT-Safe
.TE


<a name="conforming-to"></a>

# Conforming to

**futimens**()
and
**utimensat**()
are specified in POSIX.1-2008.

<a name="notes"></a>

# Notes

**utimensat**()
obsoletes
**futimesat**(2).

On Linux, timestamps cannot be changed for a file marked immutable,
and the only change permitted for files marked append-only is to
set the timestamps to the current time.
(This is consistent with the historical behavior of
**utime**(2)
and
**utimes**(2)
on Linux.)

If both
_tv_nsec_
fields are specified as
**UTIME_OMIT**,
then the Linux implementation of
**utimensat**()
succeeds even if the file referred to by
_dirfd_
and
_pathname_
does not exist.

<a name="c-librarykernel-abi-differences"></a>

### C library/kernel ABI differences

On Linux,
**futimens**()
is a library function implemented on top of the
**utimensat**()
system call.
To support this, the Linux
**utimensat**()
system call implements a nonstandard feature: if
_pathname_
is NULL, then the call modifies the timestamps of
the file referred to by the file descriptor
_dirfd_
(which may refer to any type of file).
Using this feature, the call
_futimens(fd,&nbsp;times)_
is implemented as:

.in +4n
.EX
utimensat(fd, NULL, times, 0);
.EE
.in

Note, however, that the glibc wrapper for
**utimensat**()
disallows passing NULL as the value for
_pathname_:
the wrapper function returns the error
_EINVAL_
in this case.

<a name="bugs"></a>

# Bugs

Several bugs afflict
**utimensat**()
and
**futimens**()
on kernels before 2.6.26.
These bugs are either nonconformances with the POSIX.1 draft specification
or inconsistencies with historical Linux behavior.

* *  
  POSIX.1 specifies that if one of the
  _tv_nsec_
  fields has the value
  **UTIME_NOW**
  or
  **UTIME_OMIT**,
  then the value of the corresponding
  _tv_sec_
  field should be ignored.
  Instead, the value of the
  _tv_sec_
  field is required to be 0 (or the error
  **EINVAL**
  results).
* *  
  Various bugs mean that for the purposes of permission checking,
  the case where both
  _tv_nsec_
  fields are set to
  **UTIME_NOW**
  isn't always treated the same as specifying
  _times_
  as NULL,
  and the case where one
  _tv_nsec_
  value is
  **UTIME_NOW**
  and the other is
  **UTIME_OMIT**
  isn't treated the same as specifying
  _times_
  as a pointer to an array of structures containing arbitrary time values.
  As a result, in some cases:
  a) file timestamps can be updated by a process that shouldn't have
  permission to perform updates;
  b) file timestamps can't be updated by a process that should have
  permission to perform updates; and
  c) the wrong
  _errno_
  value is returned in case of an error.
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
* *  
  POSIX.1 says that a process that has _write access to the file_
  can make a call with
  _times_
  as NULL, or with
  _times_
  pointing to an array of structures in which both
  _tv_nsec_
  fields are
  **UTIME_NOW**,
  in order to update both timestamps to the current time.
  However,
  **futimens**()
  instead checks whether the
  _access mode of the file descriptor allows writing_.
  
  
  
  
  
  

<a name="see-also"></a>

# See Also

**chattr**(1),
**touch**(1),
**futimesat**(2),
**openat**(2),
**stat**(2),
**utimes**(2),
**futimes**(3),
**inode**(7),
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
