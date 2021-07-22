# pause(2) - wait for signal

Linux, 2015-08-08

```
#include <unistd.h> 
 int pause(void);
```

<a name="description"></a>

# Description

**pause**()
causes the calling process (or thread) to sleep
until a signal is delivered that either terminates the process or causes
the invocation of a signal-catching function.

<a name="return-value"></a>

# Return Value

**pause**()
returns only when a signal was caught and the
signal-catching function returned.
In this case,
**pause**()
returns -1, and
_errno_
is set to

**EINTR**.

<a name="errors"></a>

# Errors


* **EINTR**  
  a signal was caught and the signal-catching function returned.

<a name="conforming-to"></a>

# Conforming to

POSIX.1-2001, POSIX.1-2008, SVr4, 4.3BSD.

<a name="see-also"></a>

# See Also

**kill**(2),
**select**(2),
**signal**(2),
**sigsuspend**(2)

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
