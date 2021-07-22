# alarm(2) - set an alarm clock for delivery of a signal

Linux, 2017-05-03

    #include <unistd.h>
    
    unsigned int alarm(unsigned int seconds);

<a name="description"></a>

# Description

**alarm**()
arranges for a
**SIGALRM**
signal to be delivered to the calling process in
_seconds_
seconds.

If
_seconds_
is zero, any pending alarm is canceled.

In any event any previously set
**alarm**()
is canceled.

<a name="return-value"></a>

# Return Value

**alarm**()
returns the number of seconds remaining until any previously scheduled
alarm was due to be delivered, or zero if there was no previously
scheduled alarm.

<a name="conforming-to"></a>

# Conforming to

POSIX.1-2001, POSIX.1-2008, SVr4, 4.3BSD.

<a name="notes"></a>

# Notes

**alarm**()
and
**setitimer**(2)
share the same timer; calls to one will interfere with use of the
other.

Alarms created by
**alarm**()
are preserved across
**execve**(2)
and are not inherited by children created via
**fork**(2).

**sleep**(3)
may be implemented using
**SIGALRM**;
mixing calls to
**alarm**()
and
**sleep**(3)
is a bad idea.

Scheduling delays can, as ever, cause the execution of the process to
be delayed by an arbitrary amount of time.

<a name="see-also"></a>

# See Also

**gettimeofday**(2),
**pause**(2),
**select**(2),
**setitimer**(2),
**sigaction**(2),
**signal**(2),
**timer_create**(2),
**timerfd_create**(2),
**sleep**(3),
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
