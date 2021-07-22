# idle(2) - make process 0 idle

Linux, 2012-12-31

```
#include <unistd.h> 
 int idle(void);
```

<a name="description"></a>

# Description

**idle**()
is an internal system call used during bootstrap.
It marks the process's pages as swappable, lowers its priority,
and enters the main scheduling loop.
**idle**()
never returns.

Only process 0 may call
**idle**().
Any user process, even a process with superuser permission,
will receive
**EPERM**.

<a name="return-value"></a>

# Return Value

**idle**()
never returns for process 0, and always returns -1 for a user process.

<a name="errors"></a>

# Errors


* **EPERM**  
  Always, for a user process.

<a name="versions"></a>

# Versions

Since Linux 2.3.13, this system call does not exist anymore.

<a name="conforming-to"></a>

# Conforming to

This function is Linux-specific, and should not be used in programs
intended to be portable.

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
