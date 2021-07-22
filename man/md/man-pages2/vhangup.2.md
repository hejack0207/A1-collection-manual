# vhangup(2) - virtually hangup the current terminal

Linux, 2016-03-15

```
#include <unistd.h> 
 int vhangup(void); 
 .in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in 
 vhangup():
```
        Since glibc 2.21:
    
            _DEFAULT_SOURCE
        In glibc 2.19 and 2.20:
            _DEFAULT_SOURCE || (_XOPEN_SOURCE && _XOPEN_SOURCE&nbsp;<&nbsp;500)
        Up to and including glibc 2.19:
            _BSD_SOURCE || (_XOPEN_SOURCE && _XOPEN_SOURCE&nbsp;<&nbsp;500)

<a name="description"></a>

# Description

**vhangup**()
simulates a hangup on the current terminal.
This call arranges for other
users to have a clean\*(rq terminal at login time.

<a name="return-value"></a>

# Return Value

On success, zero is returned.
On error, -1 is returned, and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **EPERM**  
  The calling process has insufficient privilege to call
  **vhangup**();
  the
  **CAP_SYS_TTY_CONFIG**
  capability is required.

<a name="conforming-to"></a>

# Conforming to

This call is Linux-specific, and should not be used in programs
intended to be portable.

<a name="see-also"></a>

# See Also

**init**(1),
**capabilities**(7)

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
