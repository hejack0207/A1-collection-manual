# seteuid(2) - set effective user or group ID

Linux, 2017-09-15

```
#include <sys/types.h>
#include <unistd.h> 
 int seteuid(uid_t euid);
int setegid(gid_t egid); 
 .in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in 
 seteuid(), setegid(): .RS 4 _POSIX_C_SOURCE&nbsp;>=&nbsp;200112L     || /* Glibc versions <= 2.19: */ _BSD_SOURCE .RE
```

<a name="description"></a>

# Description

**seteuid**()
sets the effective user ID of the calling process.
Unprivileged processes may only set the effective user ID to the
real user ID, the effective user ID or the saved set-user-ID.

Precisely the same holds for
**setegid**()
with "group" instead of "user".






<a name="return-value"></a>

# Return Value

On success, zero is returned.
On error, -1 is returned, and
_errno_
is set appropriately.

_Note_:
there are cases where
**seteuid**()
can fail even when the caller is UID 0;
it is a grave security error to omit checking for a failure return from
**seteuid**().

<a name="errors"></a>

# Errors


* **EINVAL**  
  The target user or group ID is not valid in this user namespace.
* **EPERM**  
  In the case of
  **seteuid**():
  the calling process is not privileged (does not have the
  **CAP_SETUID**
  capability in its user namespace) and
  _euid_
  does not match the current real user ID, current effective user ID,
  or current saved set-user-ID.
* In the case of
  **setegid**():
  the calling process is not privileged (does not have the
  **CAP_SETGID**
  capability in its user namespace) and
  _egid_
  does not match the current real group ID, current effective group ID,
  or current saved set-group-ID.

<a name="conforming-to"></a>

# Conforming to

POSIX.1-2001, POSIX.1-2008, 4.3BSD.

<a name="notes"></a>

# Notes

Setting the effective user (group) ID to the
saved set-user-ID (saved set-group-ID) is
possible since Linux 1.1.37 (1.1.38).
On an arbitrary system one should check
**_POSIX_SAVED_IDS**.

Under glibc 2.0,
**seteuid(**_euid_**)**
is equivalent to
**setreuid(-1,**_ euid_**)**
and hence may change the saved set-user-ID.
Under glibc 2.1 and later, it is equivalent to
**setresuid(-1,**_ euid_**, -1)**
and hence does not change the saved set-user-ID.
Analogous remarks hold for
**setegid**(),
with the difference that the change in implementation from
**setregid(-1,**_ egid_**)**
to
**setresgid(-1,**_ egid_**, -1)**
occurred in glibc 2.2 or 2.3 (depending on the hardware architecture).

According to POSIX.1,
**seteuid**()
(**setegid**())
need not permit
_euid_
(_egid_)
to be the same value as the current effective user (group) ID,
and some implementations do not permit this.

<a name="c-librarykernel-differences"></a>

### C library/kernel differences

On Linux,
**seteuid**()
and
**setegid**()
are implemented as library functions that call, respectively,
**setreuid**(2)
and
**setregid**(2).

<a name="see-also"></a>

# See Also

**geteuid**(2),
**setresuid**(2),
**setreuid**(2),
**setuid**(2),
**capabilities**(7),
**credentials**(7),
**user_namespaces**(7)

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
