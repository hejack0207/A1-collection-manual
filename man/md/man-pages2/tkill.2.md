# tkill(2) - send a signal to a thread

Linux, 2017-09-15

    int tkill(int tid, int sig);
    
    int tgkill(int tgid, int tid, int sig);
```

 Note: There are no glibc wrappers for these system calls; see NOTES.
```

<a name="description"></a>

# Description

**tgkill**()
sends the signal
_sig_
to the thread with the thread ID
_tid_
in the thread group
_tgid_.
(By contrast,
**kill**(2)
can be used to send a signal only to a process (i.e., thread group)
as a whole, and the signal will be delivered to an arbitrary
thread within that process.)

**tkill**()
is an obsolete predecessor to
**tgkill**().
It allows only the target thread ID to be specified,
which may result in the wrong thread being signaled if a thread
terminates and its thread ID is recycled.
Avoid using this system call.


























These are the raw system call interfaces, meant for internal
thread library use.

<a name="return-value"></a>

# Return Value

On success, zero is returned.
On error, -1 is returned, and _errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **EINVAL**  
  An invalid thread ID, thread group ID, or signal was specified.
* **EPERM**  
  Permission denied.
  For the required permissions, see
  **kill**(2).
* **ESRCH**  
  No process with the specified thread ID (and thread group ID) exists.
* **EAGAIN**  
  The
  **RLIMIT_SIGPENDING**
  resource limit was reached and
  _sig_
  is a real-time signal.
* **EAGAIN**  
  Insufficient kernel memory was available and
  _sig_
  is a real-time signal.

<a name="versions"></a>

# Versions

**tkill**()
is supported since Linux 2.4.19 / 2.5.4.
**tgkill**()
was added in Linux 2.5.75.

<a name="conforming-to"></a>

# Conforming to

**tkill**()
and
**tgkill**()
are Linux-specific and should not be used
in programs that are intended to be portable.

<a name="notes"></a>

# Notes

See the description of
**CLONE_THREAD**
in
**clone**(2)
for an explanation of thread groups.

Glibc does not provide wrappers for these system calls; call them using
**syscall**(2).

<a name="see-also"></a>

# See Also

**clone**(2),
**gettid**(2),
**kill**(2),
**rt_sigqueueinfo**(2)

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
