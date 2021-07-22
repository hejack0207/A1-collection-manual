# sched_yield(2) - yield the processor

Linux, 2017-09-15

```
#include <sched.h> 
 int sched_yield(void);
```

<a name="description"></a>

# Description

**sched_yield**()
causes the calling thread to relinquish the CPU.
The thread is moved to the end of the queue for its static
priority and a new thread gets to run.

<a name="return-value"></a>

# Return Value

On success,
**sched_yield**()
returns 0.
On error, -1 is returned, and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors

In the Linux implementation,
**sched_yield**()
always succeeds.

<a name="conforming-to"></a>

# Conforming to

POSIX.1-2001, POSIX.1-2008.

<a name="notes"></a>

# Notes

If the calling thread is the only thread in the highest
priority list at that time,
it will continue to run after a call to
**sched_yield**().

POSIX systems on which
**sched_yield**()
is available define
**_POSIX_PRIORITY_SCHEDULING**
in
_&lt;unistd.h&gt;_.

Strategic calls to
**sched_yield**()
can improve performance by giving other threads or processes
a chance to run when (heavily) contended resources (e.g., mutexes)
have been released by the caller.
Avoid calling
**sched_yield**()
unnecessarily or inappropriately
(e.g., when resources needed by other
schedulable threads are still held by the caller),
since doing so will result in unnecessary context switches,
which will degrade system performance.

**sched_yield**()
is intended for use with read-time scheduling policies (i.e.,
**SCHED_FIFO**
or
**SCHED_RR**).
Use of
**sched_yield**()
with nondeterministic scheduling policies such as
**SCHED_OTHER**
is unspecified and very likely means your application design is broken.

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
