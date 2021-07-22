# stime(2) - set time

Linux, 2016-03-15

```
#include <time.h> 
 int stime(const time_t *t); 
 .in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in 
 stime():     Since glibc 2.19:         _DEFAULT_SOURCE     Glibc 2.19 and earlier:         _SVID_SOURCE
```

<a name="description"></a>

# Description

**stime**()
sets the system's idea of the time and date.
The time, pointed
to by _t_, is measured in seconds since the
Epoch, 1970-01-01 00:00:00 +0000 (UTC).
**stime**()
may be executed only by the superuser.

<a name="return-value"></a>

# Return Value

On success, zero is returned.
On error, -1 is returned, and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **EFAULT**  
  Error in getting information from user space.
* **EPERM**  
  The calling process has insufficient privilege.
  Under Linux, the
  **CAP_SYS_TIME**
  privilege is required.

<a name="conforming-to"></a>

# Conforming to

SVr4.

<a name="see-also"></a>

# See Also

**date**(1),
**settimeofday**(2),
**capabilities**(7)

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
