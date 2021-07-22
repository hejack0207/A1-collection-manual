# sigqueue(3) - queue a signal and data to a process

Linux, 2017-09-15

```
#include <signal.h> 
 int sigqueue(pid_t pid, int sig, const union sigval value); 
 .in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in 
 sigqueue(): _POSIX_C_SOURCE&nbsp;>=&nbsp;199309L
```

<a name="description"></a>

# Description

**sigqueue**()
sends the signal specified in
_sig_
to the process whose PID is given in
_pid_.
The permissions required to send a signal are the same as for
**kill**(2).
As with
**kill**(2),
the null signal (0) can be used to check if a process with a given
PID exists.

The
_value_
argument is used to specify an accompanying item of data (either an integer
or a pointer value) to be sent with the signal, and has the following type:

.in +4n
.EX
union sigval {
    int   sival_int;
    void *sival_ptr;
};
.EE
.in

If the receiving process has installed a handler for this signal using the
**SA_SIGINFO**
flag to
**sigaction**(2),
then it can obtain this data via the
_si_value_
field of the
_siginfo_t_
structure passed as the second argument to the handler.
Furthermore, the
_si_code_
field of that structure will be set to
**SI_QUEUE**.

<a name="return-value"></a>

# Return Value

On success,
**sigqueue**()
returns 0, indicating that the signal was successfully
queued to the receiving process.
Otherwise, -1 is returned and
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
  _sig_
  was invalid.
* **EPERM**  
  The process does not have permission to send the signal
  to the receiving process.
  For the required permissions, see
  **kill**(2).
* **ESRCH**  
  No process has a PID matching
  _pid_.

<a name="versions"></a>

# Versions

**sigqueue**()
and the underlying
**rt_sigqueueinfo**()
system call first appeared in Linux 2.2.

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
**sigqueue**()
T}	Thread safety	MT-Safe
.TE

<a name="conforming-to"></a>

# Conforming to

POSIX.1-2001, POSIX.1-2008.

<a name="notes"></a>

# Notes

If this function results in the sending of a signal to the process
that invoked it, and that signal was not blocked by the calling thread,
and no other threads were willing to handle this signal (either by
having it unblocked, or by waiting for it using
**sigwait**(3)),
then at least some signal must be delivered to this thread before this
function returns.

<a name="c-librarykernel-differences"></a>

### C library/kernel differences

On Linux,
**sigqueue**()
is implemented using the
**rt_sigqueueinfo**(2)
system call.
The system call differs in its third argument, which is the
_siginfo_t_
structure that will be supplied to the receiving process's
signal handler or returned by the receiving process's
**sigtimedwait**(2)
call.
Inside the glibc
**sigqueue**()
wrapper, this argument,
_uinfo_,
is initialized as follows:

.in +4n
.EX
uinfo.si_signo = sig;      /* Argument supplied to sigqueue() */
uinfo.si_code = SI_QUEUE;
uinfo.si_pid = getpid();   /* Process ID of sender */
uinfo.si_uid = getuid();   /* Real UID of sender */
uinfo.si_value = val;      /* Argument supplied to sigqueue() */
.EE
.in

<a name="see-also"></a>

# See Also

**kill**(2),
**rt_sigqueueinfo**(2),
**sigaction**(2),
**signal**(2),
**pthread_sigqueue**(3),
**sigwait**(3),
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
