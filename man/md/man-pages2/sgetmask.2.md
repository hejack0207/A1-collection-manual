# sgetmask(2) - manipulation of signal mask (obsolete)

```
"long sgetmask(void);" 
 long ssetmask(long newmask); 
 Note: There are no glibc wrappers for these system calls; see NOTES.
```

<a name="description"></a>

# Description

These system calls are obsolete.
_Do not use them_;
use
**sigprocmask**(2)
instead.

**sgetmask**()
returns the signal mask of the calling process.

**ssetmask**()
sets the signal mask of the calling process to the value given in
_newmask_.
The previous signal mask is returned.

The signal masks dealt with by these two system calls
are plain bit masks (unlike the
_sigset_t_
used by
**sigprocmask**(2));
use
**sigmask**(3)
to create and inspect these masks.

<a name="return-value"></a>

# Return Value

**sgetmask**()
always successfully returns the signal mask.
**ssetmask**()
always succeeds, and returns the previous signal mask.

<a name="errors"></a>

# Errors

These system calls always succeed.

<a name="versions"></a>

# Versions

Since Linux 3.16,

support for these system calls is optional,
depending on whether the kernel was built with the
**CONFIG_SGETMASK_SYSCALL**
option.

<a name="conforming-to"></a>

# Conforming to

These system calls are Linux-specific.

<a name="notes"></a>

# Notes

Glibc does not provide wrappers for these obsolete system calls;
in the unlikely event that you want to call them, use
**syscall**(2).

These system calls are unaware of signal numbers greater than 31
(i.e., real-time signals).

These system calls do not exist on x86-64.

It is not possible to block
**SIGSTOP**
or
**SIGKILL**.

<a name="see-also"></a>

# See Also

**sigprocmask**(2),
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
