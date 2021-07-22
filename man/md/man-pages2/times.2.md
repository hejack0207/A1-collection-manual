# times(2) - get process times

Linux, 2017-09-15

```
#include <sys/times.h> 
 clock_t times(struct tms *buf);
```

<a name="description"></a>

# Description

**times**()
stores the current process times in the
_struct tms_
that
_buf_
points to.
The
_struct tms_
is as defined in
_&lt;sys/times.h&gt;_:

.in +4n
.EX
struct tms {
    clock_t tms_utime;  /* user time */
    clock_t tms_stime;  /* system time */
    clock_t tms_cutime; /* user time of children */
    clock_t tms_cstime; /* system time of children */
};
.EE
.in

The
_tms_utime_
field contains the CPU time spent executing instructions
of the calling process.
The
_tms_stime_
field contains the CPU time spent executing inside the kernel
while performing tasks on behalf of the calling process.

The
_tms_cutime_
field contains the sum of the
_tms_utime_
and
_tms_cutime_
values for all waited-for terminated children.
The
_tms_cstime_
field contains the sum of the
_tms_stime_
and
_tms_cstime_
values for all waited-for terminated children.

Times for terminated children (and their descendants)
are added in at the moment
**wait**(2)
or
**waitpid**(2)
returns their process ID.
In particular, times of grandchildren
that the children did not wait for are never seen.

All times reported are in clock ticks.

<a name="return-value"></a>

# Return Value

**times**()
returns the number of clock ticks that have elapsed since
an arbitrary point in the past.
The return value may overflow the possible range of type
_clock_t_.
On error, _(clock_t)&nbsp;-1_ is returned, and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **EFAULT**  
  _tms_
  points outside the process's address space.

<a name="conforming-to"></a>

# Conforming to

POSIX.1-2001, POSIX.1-2008, SVr4, 4.3BSD.

<a name="notes"></a>

# Notes

The number of clock ticks per second can be obtained using:

.in +4n
.EX
sysconf(_SC_CLK_TCK);
.EE
.in

In POSIX.1-1996 the symbol **CLK\_TCK** (defined in
_&lt;time.h&gt;_)
is mentioned as obsolescent.
It is obsolete now.

In Linux kernel versions before 2.6.9,
if the disposition of
**SIGCHLD**
is set to
**SIG_IGN**,
then the times of terminated children
are automatically included in the
_tms_cstime_
and
_tms_cutime_
fields, although POSIX.1-2001 says that this should happen
only if the calling process
**wait**(2)s
on its children.
This nonconformance is rectified in Linux 2.6.9 and later.




On Linux, the
_buf_
argument can be specified as NULL, with the result that
**times**()
just returns a function result.
However, POSIX does not specify this behavior, and most
other UNIX implementations require a non-NULL value for
_buf_.

Note that
**clock**(3)
also returns a value of type
_clock_t_,
but this value is measured in units of
**CLOCKS_PER_SEC**,
not the clock ticks used by
**times**().

On Linux, the "arbitrary point in the past" from which the return value of
**times**()
is measured has varied across kernel versions.
On Linux 2.4 and earlier, this point is the moment the system was booted.
Since Linux 2.6, this point is _(2^32/HZ) - 300_
seconds before system boot time.
This variability across kernel versions (and across UNIX implementations),
combined with the fact that the returned value may overflow the range of
_clock_t_,
means that a portable application would be wise to avoid using this value.
To measure changes in elapsed time, use
**clock_gettime**(2)
instead.




<a name="historical"></a>

### Historical

SVr1-3 returns
_long_
and the struct members are of type
_time_t_
although they store clock ticks, not seconds since the Epoch.
V7 used
_long_
for the struct members, because it had no type
_time_t_
yet.

<a name="bugs"></a>

# Bugs

A limitation of the Linux system call conventions on some architectures
(notably i386) means that on Linux 2.6 there is a small time window
(41 seconds) soon after boot when
**times**()
can return -1, falsely indicating that an error occurred.
The same problem can occur when the return value wraps past
the maximum value that can be stored in
**clock_t**.







<a name="see-also"></a>

# See Also

**time**(1),
**getrusage**(2),
**wait**(2),
**clock**(3),
**sysconf**(3),
**time**(7)

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
