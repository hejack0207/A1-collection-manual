# brk(2) - change data segment size

Linux, 2016-03-15

```
#include <unistd.h> 
 int brk(void *addr); 
 void *sbrk(intptr_t increment); 
 .in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in 
 brk(), sbrk(): .RS 4 .TP 4 Since glibc 2.19:
</synopsis>
    _DEFAULT_SOURCE ||
        (_XOPEN_SOURCE&nbsp;>=&nbsp;500) &&
    
    
        ! (_POSIX_C_SOURCE&nbsp;>=&nbsp;200112L)
<synopsis>
.TP 4 From glibc 2.12 to 2.19:
</synopsis>
    _BSD_SOURCE || _SVID_SOURCE ||
        (_XOPEN_SOURCE&nbsp;>=&nbsp;500) &&
    
    
        ! (_POSIX_C_SOURCE&nbsp;>=&nbsp;200112L)
<synopsis>
.TP 4 Before glibc 2.12: _BSD_SOURCE || _SVID_SOURCE || _XOPEN_SOURCE&nbsp;>=&nbsp;500
</synopsis>

<synopsis>
.RE
```

<a name="description"></a>

# Description

**brk**()
and
**sbrk**()
change the location of the
_program break_,
which defines the end of the process's data segment
(i.e., the program break is the first location after the end of the
uninitialized data segment).
Increasing the program break has the effect of
allocating memory to the process;
decreasing the break deallocates memory.

**brk**()
sets the end of the data segment to the value specified by
_addr_,
when that value is reasonable, the system has enough memory,
and the process does not exceed its maximum data size (see
**setrlimit**(2)).

**sbrk**()
increments the program's data space by
_increment_
bytes.
Calling
**sbrk**()
with an
_increment_
of 0 can be used to find the current location of the program break.

<a name="return-value"></a>

# Return Value

On success,
**brk**()
returns zero.
On error, -1 is returned, and
_errno_
is set to
**ENOMEM**.

On success,
**sbrk**()
returns the previous program break.
(If the break was increased,
then this value is a pointer to the start of the newly allocated memory).
On error,
_(void&nbsp;*)&nbsp;-1_
is returned, and
_errno_
is set to
**ENOMEM**.

<a name="conforming-to"></a>

# Conforming to

4.3BSD; SUSv1, marked LEGACY in SUSv2, removed in POSIX.1-2001.







<a name="notes"></a>

# Notes

Avoid using
**brk**()
and
**sbrk**():
the
**malloc**(3)
memory allocation package is the
portable and comfortable way of allocating memory.

Various systems use various types for the argument of
**sbrk**().
Common are _int_, _ssize\_t_, _ptrdiff\_t_, _intptr\_t_.







<a name="c-librarykernel-differences"></a>

### C library/kernel differences

The return value described above for
**brk**()
is the behavior provided by the glibc wrapper function for the Linux
**brk**()
system call.
(On most other implementations, the return value from
**brk**()
is the same; this return value was also specified in SUSv2.)
However,
the actual Linux system call returns the new program break on success.
On failure, the system call returns the current break.
The glibc wrapper function does some work
(i.e., checks whether the new break is less than
_addr_)
to provide the 0 and -1 return values described above.

On Linux,
**sbrk**()
is implemented as a library function that uses the
**brk**()
system call, and does some internal bookkeeping so that it can
return the old break value.

<a name="see-also"></a>

# See Also

**execve**(2),
**getrlimit**(2),
**end**(3),
**malloc**(3)

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
