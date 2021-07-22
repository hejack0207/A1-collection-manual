# rt_sigqueueinfo(2) - queue a signal and data

Linux, 2017-09-15

    int rt_sigqueueinfo(pid_t tgid, int sig, siginfo_t *uinfo);
    
    int rt_tgsigqueueinfo(pid_t tgid, pid_t tid, int sig,
                          siginfo_t *uinfo);
```

 Note: There are no glibc wrappers for these system calls; see NOTES.
```

<a name="description"></a>

# Description

The
**rt_sigqueueinfo**()
and
**rt_tgsigqueueinfo**()
system calls are the low-level interfaces used to send a signal plus data
to a process or thread.
The receiver of the signal can obtain the accompanying data
by establishing a signal handler with the
**sigaction**(2)
**SA_SIGINFO**
flag.

These system calls are not intended for direct application use;
they are provided to allow the implementation of
**sigqueue**(3)
and
**pthread_sigqueue**(3).

The
**rt_sigqueueinfo**()
system call sends the signal
_sig_
to the thread group with the ID
_tgid_.
(The term "thread group" is synonymous with "process", and
_tid_
corresponds to the traditional UNIX process ID.)
The signal will be delivered to an arbitrary member of the thread group
(i.e., one of the threads that is not currently blocking the signal).

The
_uinfo_
argument specifies the data to accompany the signal.
This argument is a pointer to a structure of type
_siginfo_t_,
described in
**sigaction**(2)
(and defined by including
_&lt;sigaction.h&gt;_).
The caller should set the following fields in this structure:

* _si_code_  
  This must be one of the
  **SI_***
  codes in the Linux kernel source file
  _include/asm-generic/siginfo.h_,
  with the restriction that the code must be negative
  (i.e., cannot be
  **SI_USER**,
  which is used by the kernel to indicate a signal sent by
  **kill**(2))
  and cannot (since Linux 2.6.39) be
  **SI_TKILL**
  (which is used by the kernel to indicate a signal sent using
  
  **tgkill**(2)).
* _si_pid_  
  This should be set to a process ID,
  typically the process ID of the sender.
* _si_uid_  
  This should be set to a user ID,
  typically the real user ID of the sender.
* _si_value_  
  This field contains the user data to accompany the signal.
  For more information, see the description of the last
  (_union sigval_)
  argument of
  **sigqueue**(3).

Internally, the kernel sets the
_si_signo_
field to the value specified in
_sig_,
so that the receiver of the signal can also obtain
the signal number via that field.

The
**rt_tgsigqueueinfo**()
system call is like
**rt_sigqueueinfo**(),
but sends the signal and data to the single thread
specified by the combination of
_tgid_,
a thread group ID,
and
_tid_,
a thread in that thread group.

<a name="return-value"></a>

# Return Value

On success, these system calls return 0.
On error, they return -1 and
_errno_
is set to indicate the error.

<a name="errors"></a>

# Errors


* **EAGAIN**  
  The limit of signals which may be queued has been reached.
  (See
  **signal**(7)
  for further information.)
* **EINVAL**  
  _sig_,
  _tgid_,
  or
  _tid_
  was invalid.
* **EPERM**  
  The caller does not have permission to send the signal to the target.
  For the required permissions, see
  **kill**(2).
  Or:
  _uinfo-&gt;si_code_
  is invalid.
* **ESRCH**  
  **rt_sigqueueinfo**():
  No thread group matching
  _tgid_
  was found.

**rt_tgsigqueinfo**():
No thread matching
_tgid_
and
_tid_
was found.

<a name="versions"></a>

# Versions

The
**rt_sigqueueinfo**()
system call was added to Linux in version 2.2.
The
**rt_tgsigqueueinfo**()
system call was added to Linux in version 2.6.31.

<a name="conforming-to"></a>

# Conforming to

These system calls are Linux-specific.

<a name="notes"></a>

# Notes

Since these system calls are not intended for application use,
there are no glibc wrapper functions; use
**syscall**(2)
in the unlikely case that you want to call them directly.

As with
**kill**(2),
the null signal (0) can be used to check if the specified process
or thread exists.

<a name="see-also"></a>

# See Also

**kill**(2),
**sigaction**(2),
**sigprocmask**(2),
**tgkill**(2),
**pthread_sigqueue**(3),
**sigqueue**(3),
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
