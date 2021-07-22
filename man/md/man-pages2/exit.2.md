# _exit(2) - terminate the calling process

Linux, 2017-05-03

```
#include <unistd.h> 
 void _exit(int status);
</synopsis>

<synopsis>
#include <stdlib.h> 
 void _Exit(int status); 
 .in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in 
 _Exit(): .RS 4 _ISOC99_SOURCE || _POSIX_C_SOURCE&nbsp;>=&nbsp;200112L .RE
```

<a name="description"></a>

# Description

The function
**_exit**()
terminates the calling process "immediately".
Any open file descriptors belonging to the process are closed.
Any children of the process are inherited by
**init**(1)
(or by the nearest "subreaper" process as defined through the use of the
**prctl**(2)
**PR_SET_CHILD_SUBREAPER**
operation).
The process's parent is sent a
**SIGCHLD**
signal.

The value
_status & 0377_
is returned to the parent process as the process's exit status, and
can be collected using one of the
**wait**(2)
family of calls.

The function
**_Exit**()
is equivalent to
**_exit**().

<a name="return-value"></a>

# Return Value

These functions do not return.

<a name="conforming-to"></a>

# Conforming to

POSIX.1-2001, POSIX.1-2008, SVr4, 4.3BSD.
The function
**_Exit**()
was introduced by C99.

<a name="notes"></a>

# Notes

For a discussion on the effects of an exit, the transmission of
exit status, zombie processes, signals sent, and so on, see
**exit**(3).

The function
**_exit**()
is like
**exit**(3),
but does not call any
functions registered with
**atexit**(3)
or
**on_exit**(3).
Open
**stdio**(3)
streams are not flushed.
On the other hand,
**_exit**()
does close open file descriptors, and this may cause an unknown delay,
waiting for pending output to finish.
If the delay is undesired,
it may be useful to call functions like
**tcflush**(3)
before calling
**_exit**().
Whether any pending I/O is canceled, and which pending I/O may be
canceled upon
**_exit**(),
is implementation-dependent.

<a name="c-librarykernel-differences"></a>

### C library/kernel differences

In glibc up to version 2.3, the
**_exit**()
wrapper function invoked the kernel system call of the same name.
Since glibc 2.3, the wrapper function invokes
**exit_group**(2),
in order to terminate all of the threads in a process.

<a name="see-also"></a>

# See Also

**execve**(2),
**exit_group**(2),
**fork**(2),
**kill**(2),
**wait**(2),
**wait4**(2),
**waitpid**(2),
**atexit**(3),
**exit**(3),
**on_exit**(3),
**termios**(3)

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
