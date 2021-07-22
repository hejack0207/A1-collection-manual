# killpg(3) - send signal to a process group

Linux, 2017-09-15

```
#include <signal.h> 
 int killpg(int pgrp, int sig); 
 .in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in .TP 4 killpg(): _XOPEN_SOURCE&nbsp;>=&nbsp;500
</synopsis>

<synopsis>
    || /* Since glibc 2.19: */ _DEFAULT_SOURCE     || /* Glibc versions <= 2.19: */ _BSD_SOURCE
```

<a name="description"></a>

# Description

**killpg**()
sends the signal
_sig_
to the process group
_pgrp_.
See
**signal**(7)
for a list of signals.

If
_pgrp_
is 0,
**killpg**()
sends the signal to the calling process's process group.
(POSIX says: if
_pgrp_
is less than or equal to 1, the behavior is undefined.)

For the permissions required to send a signal to another process, see
**kill**(2).

<a name="return-value"></a>

# Return Value

On success, zero is returned.
On error, -1 is returned, and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **EINVAL**  
  _sig_
  is not a valid signal number.
* **EPERM**  
  The process does not have permission to send the signal
  to any of the target processes.
  For the required permissions, see
  **kill**(2).
* **ESRCH**  
  No process can be found in the process group specified by
  _pgrp_.
* **ESRCH**  
  The process group was given as 0 but the sending process does not
  have a process group.

<a name="conforming-to"></a>

# Conforming to

POSIX.1-2001, POSIX.1-2008, SVr4, 4.4BSD
(**killpg**()
first appeared in 4BSD).

<a name="notes"></a>

# Notes

There are various differences between the permission checking
in BSD-type systems and System&nbsp;V-type systems.
See the POSIX rationale for
**kill**().
A difference not mentioned by POSIX concerns the return
value
**EPERM**:
BSD documents that no signal is sent and
**EPERM**
returned when the permission check failed for at least one target process,
while POSIX documents
**EPERM**
only when the permission check failed for all target processes.

<a name="c-librarykernel-differences"></a>

### C library/kernel differences

On Linux,
**killpg**()
is implemented as a library function that makes the call
_kill(-pgrp,&nbsp;sig)_.

<a name="see-also"></a>

# See Also

**getpgrp**(2),
**kill**(2),
**signal**(2),
**capabilities**(7),
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
