# sigpending(2) - examine pending signals

Linux, 2017-09-15

```
#include <signal.h> 
 int sigpending(sigset_t *set); 
 .in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in 
 sigpending(): _POSIX_C_SOURCE
```

<a name="description"></a>

# Description


**sigpending**()
returns the set of signals that are pending for delivery to the calling
thread (i.e., the signals which have been raised while blocked).
The mask of pending signals is returned in
_set_.

<a name="return-value"></a>

# Return Value

**sigpending**()
returns 0 on success and -1 on error.
In the event of an error,
_errno_
is set to indicate the cause.

<a name="errors"></a>

# Errors


* **EFAULT**  
  _set_
  points to memory which is not a valid part of the process address space.

<a name="conforming-to"></a>

# Conforming to

POSIX.1-2001, POSIX.1-2008.

<a name="notes"></a>

# Notes

See
**sigsetops**(3)
for details on manipulating signal sets.

If a signal is both blocked and has a disposition of "ignored", it is
_not_
added to the mask of pending signals when generated.

The set of signals that is pending for a thread
is the union of the set of signals that is pending for that thread
and the set of signals that is pending for the process as a whole; see
**signal**(7).

A child created via
**fork**(2)
initially has an empty pending signal set;
the pending signal set is preserved across an
**execve**(2).


<a name="c-librarykernel-differences"></a>

### C library/kernel differences

The original Linux system call was named
**sigpending**().
However, with the addition of real-time signals in Linux 2.2,
the fixed-size, 32-bit
_sigset_t_
argument supported by that system call was no longer fit for purpose.
Consequently, a new system call,
**rt_sigpending**(),
was added to support an enlarged
_sigset_t_
type.
The new system call takes a second argument,
_size_t sigsetsize_,
which specifies the size in bytes of the signal set in
_set_.





The glibc
**sigpending**()
wrapper function hides these details from us, transparently calling
**rt_sigpending**()
when the kernel provides it.


<a name="bugs"></a>

# Bugs

In versions of glibc up to and including 2.2.1,
there is a bug in the wrapper function for
**sigpending**()
which means that information about pending real-time signals
is not correctly returned.

<a name="see-also"></a>

# See Also

**kill**(2),
**sigaction**(2),
**signal**(2),
**sigprocmask**(2),
**sigsuspend**(2),
**sigsetops**(3),
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
