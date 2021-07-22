# getsid(2) - get session ID

Linux, 2017-09-15

```
#include <sys/types.h>
#include <unistd.h> 
 pid_t getsid(pid_t pid); 
 .in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in 
 getsid(): .RS 4 _XOPEN_SOURCE&nbsp;>=&nbsp;500
</synopsis>

<synopsis>

|| /* Since glibc 2.12: */ _POSIX_C_SOURCE&nbsp;>=&nbsp;200809L .RE
```

<a name="description"></a>

# Description

_getsid(0)_
returns the session ID of the calling process.
**getsid**()
returns the session ID of the process with process ID
_pid_.
If
_pid_
is 0,
**getsid**()
returns the session ID of the calling process.

<a name="return-value"></a>

# Return Value

On success, a session ID is returned.
On error, _(pid_t)&nbsp;-1_ will be returned, and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **EPERM**  
  A process with process ID
  _pid_
  exists, but it is not in the same session as the calling process,
  and the implementation considers this an error.
* **ESRCH**  
  No process with process ID
  _pid_
  was found.

<a name="versions"></a>

# Versions

This system call is available on Linux since version 2.0.



<a name="conforming-to"></a>

# Conforming to

POSIX.1-2001, POSIX.1-2008, SVr4.

<a name="notes"></a>

# Notes

Linux does not return
**EPERM**.

See
**credentials**(7)
for a description of sessions and session IDs.

<a name="see-also"></a>

# See Also

**getpgid**(2),
**setsid**(2),
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
