# sigsuspend(2) - wait for a signal

Linux, 2017-09-15

```
#include <signal.h> 
 int sigsuspend(const sigset_t *mask); 
 .in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in 
 sigsuspend(): _POSIX_C_SOURCE
```

<a name="description"></a>

# Description

**sigsuspend**()
temporarily replaces the signal mask of the calling process with the
mask given by
_mask_
and then suspends the process until delivery of a signal whose
action is to invoke a signal handler or to terminate a process.

If the signal terminates the process, then
**sigsuspend**()
does not return.
If the signal is caught, then
**sigsuspend**()
returns after the signal handler returns,
and the signal mask is restored to the state before the call to
**sigsuspend**().

It is not possible to block
**SIGKILL**
or
**SIGSTOP**;
specifying these signals in
_mask_,
has no effect on the process's signal mask.

<a name="return-value"></a>

# Return Value

**sigsuspend**()
always returns -1, with
_errno_
set to indicate the error (normally,
**EINTR**).

<a name="errors"></a>

# Errors


* **EFAULT**  
  _mask_
  points to memory which is not a valid part of the process address space.
* **EINTR**  
  The call was interrupted by a signal;
  **signal**(7).

<a name="conforming-to"></a>

# Conforming to

POSIX.1-2001, POSIX.1-2008.

<a name="notes"></a>

# Notes


Normally,
**sigsuspend**()
is used in conjunction with
**sigprocmask**(2)
in order to prevent delivery of a signal during the execution of a
critical code section.
The caller first blocks the signals with
**sigprocmask**(2).
When the critical code has completed, the caller then waits for the
signals by calling
**sigsuspend**()
with the signal mask that was returned by
**sigprocmask**(2)
(in the
_oldset_
argument).

See
**sigsetops**(3)
for details on manipulating signal sets.


<a name="c-librarykernel-differences"></a>

### C library/kernel differences

The original Linux system call was named
**sigsuspend**().
However, with the addition of real-time signals in Linux 2.2,
the fixed-size, 32-bit
_sigset_t_
type supported by that system call was no longer fit for purpose.
Consequently, a new system call,
**rt_sigsuspend**(),
was added to support an enlarged
_sigset_t_
type.
The new system call takes a second argument,
_size_t sigsetsize_,
which specifies the size in bytes of the signal set in
_mask_.
This argument is currently required to have the value
_sizeof(sigset_t)_
(or the error
**EINVAL**
results).
The glibc
**sigsuspend**()
wrapper function hides these details from us, transparently calling
**rt_sigsuspend**()
when the kernel provides it.


<a name="see-also"></a>

# See Also

**kill**(2),
**pause**(2),
**sigaction**(2),
**signal**(2),
**sigprocmask**(2),
**sigwaitinfo**(2),
**sigsetops**(3),
**sigwait**(3),
**signal**(7)

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
