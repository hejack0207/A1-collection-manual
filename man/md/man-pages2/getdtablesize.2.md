# getdtablesize(3) - get file descriptor table size

Linux, 2016-03-15

```
#include <unistd.h> 
 int getdtablesize(void); 
 .in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in 
 getdtablesize(): .RS 4 .TP 4 Since glibc 2.12:
</synopsis>
    /* Glibc since 2.19: */ _DEFAULT_SOURCE
        || /* Glibc versions <= 2.19: */ _BSD_SOURCE
        || ! (_POSIX_C_SOURCE&nbsp;>=&nbsp;200112L)
    .TP 4
<synopsis>
Before glibc 2.12: _BSD_SOURCE || _XOPEN_SOURCE&nbsp;>=&nbsp;500
</synopsis>

<synopsis>
.RE
```

<a name="description"></a>

# Description

**getdtablesize**()
returns the maximum number of files a process can have open,
one more than the largest possible value for a file descriptor.

<a name="return-value"></a>

# Return Value

The current limit on the number of open files per process.

<a name="errors"></a>

# Errors

On Linux,
**getdtablesize**()
can return any of the errors described for
**getrlimit**(2);
see NOTES below.

<a name="attributes"></a>

# Attributes

For an explanation of the terms used in this section, see
**attributes**(7).
.TS
allbox;
lb lb lb
l l l.
Interface	Attribute	Value
T{
**getdtablesize**()
T}	Thread safety	MT-Safe
.TE

<a name="conforming-to"></a>

# Conforming to

SVr4, 4.4BSD (the
**getdtablesize**()
function first appeared in 4.2BSD).
It is not specified in POSIX.1;
portable applications should employ
_sysconf(_SC_OPEN_MAX)_
instead of this call.

<a name="notes"></a>

# Notes

**getdtablesize**()
is implemented as a libc library function.
The glibc version calls
**getrlimit**(2)
and returns the current
**RLIMIT_NOFILE**
limit, or
**OPEN_MAX**
when that fails.




<a name="see-also"></a>

# See Also

**close**(2),
**dup**(2),
**getrlimit**(2),
**open**(2)

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
