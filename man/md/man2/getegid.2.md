# getgid(2) - get group identity

Linux, 2017-09-15

```
#include <unistd.h>
#include <sys/types.h> 
 gid_t getgid(void);
gid_t getegid(void);
```

<a name="description"></a>

# Description

**getgid**()
returns the real group ID of the calling process.

**getegid**()
returns the effective group ID of the calling process.

<a name="errors"></a>

# Errors

These functions are always successful.

<a name="conforming-to"></a>

# Conforming to

POSIX.1-2001, POSIX.1-2008, 4.3BSD.

<a name="notes"></a>

# Notes

The original Linux
**getgid**()
and
**getegid**()
system calls supported only 16-bit group IDs.
Subsequently, Linux 2.4 added
**getgid32**()
and
**getegid32**(),
supporting 32-bit IDs.
The glibc
**getgid**()
and
**getegid**()
wrapper functions transparently deal with the variations across kernel versions.

<a name="see-also"></a>

# See Also

**getresgid**(2),
**setgid**(2),
**setregid**(2),
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
