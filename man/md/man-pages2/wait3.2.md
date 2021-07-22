# wait4(2) - wait for process to change state, BSD style

    #include <sys/types.h>
    #include <sys/time.h>
    #include <sys/resource.h>
    #include <sys/wait.h>
    
    pid_t wait3(int *wstatus, int options,
                struct rusage *rusage);
    
    pid_t wait4(pid_t pid, int *wstatus, int options,
                struct rusage *rusage);
```

 .in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in 
 wait3():     Since glibc 2.19:         _DEFAULT_SOURCE || _XOPEN_SOURCE&nbsp;>=&nbsp;500     Glibc 2.19 and earlier:         _BSD_SOURCE || _XOPEN_SOURCE&nbsp;>=&nbsp;500
</synopsis>

<synopsis>

wait4():     Since glibc 2.19:         _DEFAULT_SOURCE     Glibc 2.19 and earlier:         _BSD_SOURCE
```

<a name="description"></a>

# Description

These functions are nonstandard; in new programs, the use of
**waitpid**(2)
or
**waitid**(2)
is preferable.

The
**wait3**()
and
**wait4**()
system calls are similar to
**waitpid**(2),
but additionally return resource usage information about the
child in the structure pointed to by
_rusage_.

Other than the use of the
_rusage_
argument, the following
**wait3**()
call:

.in +4n
.EX
wait3(wstatus, options, rusage);
.EE
.in

is equivalent to:

.in +4n
.EX
waitpid(-1, wstatus, options);
.EE
.in

Similarly, the following
**wait4**()
call:

.in +4n
.EX
wait4(pid, wstatus, options, rusage);
.EE
.in

is equivalent to:

.in +4n
.EX
waitpid(pid, wstatus, options);
.EE
.in

In other words,
**wait3**()
waits of any child, while
**wait4**()
can be used to select a specific child, or children, on which to wait.
See
**wait**(2)
for further details.

If
_rusage_
is not NULL, the
_struct rusage_
to which it points will be filled with accounting information
about the child.
See
**getrusage**(2)
for details.

<a name="return-value"></a>

# Return Value

As for
**waitpid**(2).

<a name="errors"></a>

# Errors

As for
**waitpid**(2).

<a name="conforming-to"></a>

# Conforming to

4.3BSD.

SUSv1 included a specification of
**wait3**();
SUSv2 included
**wait3**(),
but marked it LEGACY;
SUSv3 removed it.

<a name="notes"></a>

# Notes

Including
_&lt;sys/time.h&gt;_
is not required these days, but increases portability.
(Indeed,
_&lt;sys/resource.h&gt;_
defines the
_rusage_
structure with fields of type
_struct timeval_
defined in
_&lt;sys/time.h&gt;_.)

<a name="c-librarykernel-differences"></a>

### C library/kernel differences

On Linux,
**wait3**()
is a library function implemented on top of the
**wait4**()
system call.

<a name="see-also"></a>

# See Also

**fork**(2),
**getrusage**(2),
**sigaction**(2),
**signal**(2),
**wait**(2),
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
