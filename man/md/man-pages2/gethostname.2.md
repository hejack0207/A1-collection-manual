# gethostname(2) - get/set hostname

Linux, 2017-09-15

```
#include <unistd.h> 
 int gethostname(char *name, size_t len);
int sethostname(const char *name, size_t len); 
 .in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in 
 gethostname(): .RS 4 Since glibc 2.12: _BSD_SOURCE || _XOPEN_SOURCE&nbsp;>=&nbsp;500
|| /* Since glibc 2.12: */ _POSIX_C_SOURCE&nbsp;>=&nbsp;200112L .RE
sethostname():
```
        Since glibc 2.21:
    
            _DEFAULT_SOURCE
        In glibc 2.19 and 2.20:
            _DEFAULT_SOURCE || (_XOPEN_SOURCE && _XOPEN_SOURCE&nbsp;<&nbsp;500)
        Up to and including glibc 2.19:
            _BSD_SOURCE || (_XOPEN_SOURCE && _XOPEN_SOURCE&nbsp;<&nbsp;500)

<a name="description"></a>

# Description

These system calls are used to access or to change the hostname of the
current processor.

**sethostname**()
sets the hostname to the value given in the character array
_name_.
The
_len_
argument specifies the number of bytes in
_name_.
(Thus,
_name_
does not require a terminating null byte.)

**gethostname**()
returns the null-terminated hostname in the character array
_name_,
which has a length of
_len_
bytes.
If the null-terminated hostname is too large to fit,
then the name is truncated, and no error is returned (but see NOTES below).
POSIX.1 says that if such truncation occurs,
then it is unspecified whether the returned buffer
includes a terminating null byte.

<a name="return-value"></a>

# Return Value

On success, zero is returned.
On error, -1 is returned, and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **EFAULT**  
  _name_
  is an invalid address.
* **EINVAL**  
  _len_
  is negative
  
  
  or, for
  **sethostname**(),
  _len_
  is larger than the maximum allowed size.
* **ENAMETOOLONG**  
  (glibc **gethostname**())
  _len_
  is smaller than the actual size.
  (Before version 2.1, glibc uses
  **EINVAL**
  for this case.)
* **EPERM**  
  For
  **sethostname**(),
  the caller did not have the
  **CAP_SYS_ADMIN**
  capability in the user namespace associated with its UTS namespace (see
  **namespaces**(7)).

<a name="conforming-to"></a>

# Conforming to

SVr4, 4.4BSD  (these interfaces first appeared in 4.2BSD).
POSIX.1-2001 and POSIX.1-2008 specify
**gethostname**()
but not
**sethostname**().

<a name="notes"></a>

# Notes

SUSv2 guarantees that "Host names are limited to 255 bytes".
POSIX.1 guarantees that "Host names (not including
the terminating null byte) are limited to
**HOST_NAME_MAX**
bytes".
On Linux,
**HOST_NAME_MAX**
is defined with the value 64, which has been the limit since Linux 1.0
(earlier kernels imposed a limit of 8 bytes).

<a name="c-librarykernel-differences"></a>

### C library/kernel differences

The GNU C library does not employ the
**gethostname**()
system call; instead, it implements
**gethostname**()
as a library function that calls
**uname**(2)
and copies up to
_len_
bytes from the returned
_nodename_
field into
_name_.
Having performed the copy, the function then checks if the length of the
_nodename_
was greater than or equal to
_len_,
and if it is, then the function returns -1 with
_errno_
set to
**ENAMETOOLONG**;
in this case, a terminating null byte is not included in the returned
_name_.

Versions of glibc before 2.2

handle the case where the length of the
_nodename_
was greater than or equal to
_len_
differently: nothing is copied into
_name_
and the function returns -1 with
_errno_
set to
**ENAMETOOLONG**.

<a name="see-also"></a>

# See Also

**hostname**(1),
**getdomainname**(2),
**setdomainname**(2),
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
