# sched_rr_get_interval(2) - get the SCHED_RR interval for the named process

Linux, 2017-09-15

```
#include <sched.h> 
 int sched_rr_get_interval(pid_t pid, struct timespec *tp);
```

<a name="description"></a>

# Description

**sched_rr_get_interval**()
writes into the
_timespec_
structure pointed to by
_tp_
the round-robin time quantum for the process identified by
_pid_.
The specified process should be running under the
**SCHED_RR**
scheduling policy.

The
_timespec_
structure has the following form:

.in +4n
.EX
struct timespec {
    time_t tv_sec;    /* seconds */
    long   tv_nsec;   /* nanoseconds */
};
.EE
.in

If
_pid_
is zero, the time quantum for the calling process is written into
_*tp_.









<a name="return-value"></a>

# Return Value

On success,
**sched_rr_get_interval**()
returns 0.
On error, -1 is returned, and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **EFAULT**  
  Problem with copying information to user space.
* **EINVAL**  
  Invalid pid.
* **ENOSYS**  
  The system call is not yet implemented (only on rather old kernels).
* **ESRCH**  
  Could not find a process with the ID
  _pid_.

<a name="conforming-to"></a>

# Conforming to

POSIX.1-2001, POSIX.1-2008.

<a name="notes"></a>

# Notes

POSIX systems on which
**sched_rr_get_interval**()
is available define
**_POSIX_PRIORITY_SCHEDULING**
in
_&lt;unistd.h&gt;_.

<a name="linux-notes"></a>

### Linux notes

POSIX does not specify any mechanism for controlling the size of the
round-robin time quantum.
Older Linux kernels provide a (nonportable) method of doing this.
The quantum can be controlled by adjusting the process's nice value (see
**setpriority**(2)).
Assigning a negative (i.e., high) nice value results in a longer quantum;
assigning a positive (i.e., low) nice value results in a shorter quantum.
The default quantum is 0.1 seconds;
the degree to which changing the nice value affects the
quantum has varied somewhat across kernel versions.
This method of adjusting the quantum was removed

starting with Linux 2.6.24.

Linux 3.9 added

a new mechanism for adjusting (and viewing) the
**SCHED_RR**
quantum: the
_/proc/sys/kernel/sched_rr_timeslice_ms_
file exposes the quantum as a millisecond value, whose default is 100.
Writing 0 to this file resets the quantum to the default value.







<a name="see-also"></a>

# See Also

**sched**(7)

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
