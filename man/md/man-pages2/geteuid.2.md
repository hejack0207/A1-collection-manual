# getuid(2) - get user identity

Linux, 2017-09-15

```
#include <unistd.h>
#include <sys/types.h> 
 uid_t getuid(void);
uid_t geteuid(void);
```

<a name="description"></a>

# Description

**getuid**()
returns the real user ID of the calling process.

**geteuid**()
returns the effective user ID of the calling process.

<a name="errors"></a>

# Errors

These functions are always successful.

<a name="conforming-to"></a>

# Conforming to

POSIX.1-2001, POSIX.1-2008, 4.3BSD.

<a name="notes"></a>

# Notes


<a name="history"></a>

### History

In UNIX&nbsp;V6 the
**getuid**()
call returned
_(euid &lt;&lt; 8) + uid_.
UNIX&nbsp;V7 introduced separate calls
**getuid**()
and
**geteuid**().

The original Linux
**getuid**()
and
**geteuid**()
system calls supported only 16-bit user IDs.
Subsequently, Linux 2.4 added
**getuid32**()
and
**geteuid32**(),
supporting 32-bit IDs.
The glibc
**getuid**()
and
**geteuid**()
wrapper functions transparently deal with the variations across kernel versions.

<a name="see-also"></a>

# See Also

**getresuid**(2),
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
