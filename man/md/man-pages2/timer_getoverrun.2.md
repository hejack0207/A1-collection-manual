# timer_getoverrun(2) - get overrun count for a POSIX per-process timer

Linux, 2017-09-15

     #include <time.h>
    
    int timer_getoverrun(timer_t timerid);
```

 Link with -lrt. 
 .in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in 
 timer_getoverrun(): _POSIX_C_SOURCE&nbsp;>=&nbsp;199309L
```

<a name="description"></a>

# Description

**timer_getoverrun**()
returns the "overrun count" for the timer referred to by
_timerid_.
An application can use the overrun count to accurately calculate the number
of timer expirations that would have occurred over a given time interval.
Timer overruns can occur both when receiving expiration notifications
via signals
(**SIGEV_SIGNAL**),
and via threads
(**SIGEV_THREAD**).

When expiration notifications are delivered via a signal,
overruns can occur as follows.
Regardless of whether or not a real-time signal is used for
timer notifications,
the system queues at most one signal per timer.
(This is the behavior specified by POSIX.1.
The alternative, queuing one signal for each timer expiration,
could easily result in overflowing the allowed limits for
queued signals on the system.)
Because of system scheduling delays,
or because the signal may be temporarily blocked,
there can be a delay between the time when the notification
signal is generated and the time when it
is delivered (e.g., caught by a signal handler) or accepted (e.g., using
**sigwaitinfo**(2)).
In this interval, further timer expirations may occur.
The timer overrun count is the number of additional
timer expirations that occurred between the time when the signal
was generated and when it was delivered or accepted.

Timer overruns can also occur when expiration notifications
are delivered via invocation of a thread,
since there may be an arbitrary delay between an expiration of the timer
and the invocation of the notification thread,
and in that delay interval, additional timer expirations may occur.

<a name="return-value"></a>

# Return Value

On success,
**timer_getoverrun**()
returns the overrun count of the specified timer;
this count may be 0 if no overruns have occurred.
On failure, -1 is returned, and
_errno_
is set to indicate the error.

<a name="errors"></a>

# Errors


* **EINVAL**  
  _timerid_
  is not a valid timer ID.

<a name="versions"></a>

# Versions

This system call is available since Linux 2.6.

<a name="conforming-to"></a>

# Conforming to

POSIX.1-2001, POSIX.1-2008.

<a name="notes"></a>

# Notes

When timer notifications are delivered via signals
(**SIGEV_SIGNAL**),
on Linux it is also possible to obtain the overrun count via the
_si_overrun_
field of the
_siginfo_t_
structure (see
**sigaction**(2)).
This allows an application to avoid the overhead of making
a system call to obtain the overrun count,
but is a nonportable extension to POSIX.1.

POSIX.1 discusses timer overruns only in the context of
timer notifications using signals.


<a name="bugs"></a>

# Bugs

POSIX.1 specifies that if the timer overrun count
is equal to or greater than an implementation-defined maximum,
**DELAYTIMER_MAX**,
then
**timer_getoverrun**()
should return
**DELAYTIMER_MAX**.
However, Linux does not implement this feature: instead,
if the timer overrun value exceeds the maximum representable integer,
the counter cycles, starting once more from low values.



<a name="example"></a>

# Example

See
**timer_create**(2).

<a name="see-also"></a>

# See Also

**clock_gettime**(2),
**sigaction**(2),
**signalfd**(2),
**sigwaitinfo**(2),
**timer_create**(2),
**timer_delete**(2),
**timer_settime**(2),
**signal**(7),
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
