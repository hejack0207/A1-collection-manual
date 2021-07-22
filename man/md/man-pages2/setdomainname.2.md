# getdomainname(2) - get/set NIS domain name

Linux, 2017-09-15

```
#include <unistd.h> 
 int getdomainname(char *name, size_t len);
int setdomainname(const char *name, size_t len); 
 .in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in 
 getdomainname(), setdomainname():
```
        Since glibc 2.21:
    
            _DEFAULT_SOURCE
        In glibc 2.19 and 2.20:
            _DEFAULT_SOURCE || (_XOPEN_SOURCE && _XOPEN_SOURCE&nbsp;<&nbsp;500)
        Up to and including glibc 2.19:
            _BSD_SOURCE || (_XOPEN_SOURCE && _XOPEN_SOURCE&nbsp;<&nbsp;500)

<a name="description"></a>

# Description

These functions are used to access or to change the NIS domain name of the
host system.

**setdomainname**()
sets the domain name to the value given in the character array
_name_.
The
_len_
argument specifies the number of bytes in
_name_.
(Thus,
_name_
does not require a terminating null byte.)

**getdomainname**()
returns the null-terminated domain name in the character array
_name_,
which has a length of
_len_
bytes.
If the null-terminated domain name requires more than _len_ bytes,
**getdomainname**()
returns the first _len_ bytes (glibc) or gives an error (libc).

<a name="return-value"></a>

# Return Value

On success, zero is returned.
On error, -1 is returned, and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors

**setdomainname**()
can fail with the following errors:

* **EFAULT**  
  _name_
  pointed outside of user address space.
* **EINVAL**  
  _len_
  was negative or too large.
* **EPERM**  
  The caller did not have the
  **CAP_SYS_ADMIN**
  capability in the user namespace associated with its UTS namespace (see
  **namespaces**(7)).

**getdomainname**()
can fail with the following errors:

* **EINVAL**  
  For
  **getdomainname**()
  under libc:
  _name_
  is NULL or
  _name_
  is longer than
  _len_
  bytes.

<a name="conforming-to"></a>

# Conforming to

POSIX does not specify these calls.


<a name="notes"></a>

# Notes

Since Linux 1.0, the limit on the length of a domain name,
including the terminating null byte, is 64 bytes.
In older kernels, it was 8 bytes.

On most Linux architectures (including x86),
there is no
**getdomainname**()
system call; instead, glibc implements
**getdomainname**()
as a library function that returns a copy of the
_domainname_
field returned from a call to
**uname**(2).

<a name="see-also"></a>

# See Also

**gethostname**(2),
**sethostname**(2),
**uname**(2)

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
