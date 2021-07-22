# gettid(2) - get thread identification

Linux, 2017-09-15

    #include <sys/types.h>
    
    pid_t gettid(void);
```

 Note: There is no glibc wrapper for this system call; see NOTES.
```

<a name="description"></a>

# Description

**gettid**()
returns the caller's thread ID (TID).
In a single-threaded process, the thread ID
is equal to the process ID (PID, as returned by
**getpid**(2)).
In a multithreaded process, all threads
have the same PID, but each one has a unique TID.
For further details, see the discussion of
**CLONE_THREAD**
in
**clone**(2).

<a name="return-value"></a>

# Return Value

On success, returns the thread ID of the calling process.

<a name="errors"></a>

# Errors

This call is always successful.

<a name="versions"></a>

# Versions

The
**gettid**()
system call first appeared on Linux in kernel 2.4.11.

<a name="conforming-to"></a>

# Conforming to

**gettid**()
is Linux-specific and should not be used in programs that
are intended to be portable.

<a name="notes"></a>

# Notes

Glibc does not provide a wrapper for this system call; call it using
**syscall**(2).



The thread ID returned by this call is not the same thing as a
POSIX thread ID (i.e., the opaque value returned by
**pthread_self**(3)).

In a new thread group created by a
**clone**(2)
call that does not specify the
**CLONE_THREAD**
flag (or, equivalently, a new process created by
**fork**(2)),
the new process is a thread group leader,
and its thread group ID (the value returned by
**getpid**(2))
is the same as its thread ID (the value returned by
**gettid**()).

<a name="see-also"></a>

# See Also

**capget**(2),
**clone**(2),
**fcntl**(2),
**fork**(2),
**getpid**(2),
**get_robust_list**(2),

**ioprio_set**(2),


**perf_event_open**(2),


**sched_setaffinity**(2),
**sched_setparam**(2),
**sched_setscheduler**(2),
**tgkill**(2),
**timer_create**(2)

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
