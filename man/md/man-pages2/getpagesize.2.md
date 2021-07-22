# getpagesize(2) - get memory page size

Linux, 2017-09-15

```
#include <unistd.h> 
 int getpagesize(void); 
 .in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in 
 getpagesize(): .RS 4 .TP 4 Since glibc 2.19:
</synopsis>
    _DEFAULT_SOURCE || ! (_POSIX_C_SOURCE&nbsp;>=&nbsp;200112L)
    .TP 4
<synopsis>
From glibc 2.12 to 2.19:
</synopsis>
    _BSD_SOURCE || ! (_POSIX_C_SOURCE&nbsp;>=&nbsp;200112L)
    .TP 4
<synopsis>
Before glibc 2.12: _BSD_SOURCE || _XOPEN_SOURCE&nbsp;>=&nbsp;500
</synopsis>

<synopsis>
.RE
```

<a name="description"></a>

# Description

The function
**getpagesize**()
returns the number of bytes in a memory page,
where "page" is a fixed-length block,
the unit for memory allocation and file mapping performed by
**mmap**(2).



<a name="conforming-to"></a>

# Conforming to

SVr4, 4.4BSD, SUSv2.
In SUSv2 the
**getpagesize**()
call is labeled LEGACY, and in POSIX.1-2001
it has been dropped;
HP-UX does not have this call.

<a name="notes"></a>

# Notes

Portable applications should employ
_sysconf(_SC_PAGESIZE)_
instead of
**getpagesize**():

.in +4n
.EX
#include &lt;unistd.h&gt;
long sz = sysconf(_SC_PAGESIZE);
.EE
.in

(Most systems allow the synonym
**_SC_PAGE_SIZE**
for
**_SC_PAGESIZE**.)

Whether
**getpagesize**()
is present as a Linux system call depends on the architecture.
If it is, it returns the kernel symbol
**PAGE_SIZE**,
whose value depends on the architecture and machine model.
Generally, one uses binaries that are dependent on the architecture but not
on the machine model, in order to have a single binary
distribution per architecture.
This means that a user program
should not find
**PAGE_SIZE**
at compile time from a header file,
but use an actual system call, at least for those architectures
(like sun4) where this dependency exists.
Here glibc 2.0 fails because its
**getpagesize**()
returns a statically derived value, and does not use a system call.
Things are OK in glibc 2.1.

<a name="see-also"></a>

# See Also

**mmap**(2),
**sysconf**(3)

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
