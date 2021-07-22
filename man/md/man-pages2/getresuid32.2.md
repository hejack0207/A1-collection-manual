# getresuid(2) - get real, effective and saved user/group IDs

Linux, 2017-09-15

```
#define _GNU_SOURCE         /* See feature_test_macros(7) */
#include <unistd.h> 
 int getresuid(uid_t *ruid, uid_t *euid, uid_t *suid);
int getresgid(gid_t *rgid, gid_t *egid, gid_t *sgid);
```

<a name="description"></a>

# Description

**getresuid**()
returns the real UID, the effective UID, and the saved set-user-ID
of the calling process, in the arguments
_ruid_,
_euid_,
and
_suid_,
respectively.
**getresgid**()
performs the analogous task for the process's group IDs.

<a name="return-value"></a>

# Return Value

On success, zero is returned.
On error, -1 is returned, and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **EFAULT**  
  One of the arguments specified an address outside the calling program's
  address space.

<a name="versions"></a>

# Versions

These system calls appeared on Linux starting with kernel 2.1.44.

The prototypes are given by glibc since version 2.3.2,
provided
**_GNU_SOURCE**
is defined.

<a name="conforming-to"></a>

# Conforming to

These calls are nonstandard;
they also appear on HP-UX and some of the BSDs.

<a name="notes"></a>

# Notes

The original Linux
**getresuid**()
and
**getresgid**()
system calls supported only 16-bit user and group IDs.
Subsequently, Linux 2.4 added
**getresuid32**()
and
**getresgid32**(),
supporting 32-bit IDs.
The glibc
**getresuid**()
and
**getresgid**()
wrapper functions transparently deal with the variations across kernel versions.

<a name="see-also"></a>

# See Also

**getuid**(2),
**setresuid**(2),
**setreuid**(2),
**setuid**(2),
**credentials**(7)

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
