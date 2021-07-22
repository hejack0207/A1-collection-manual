# tty(4) - controlling terminal

Linux, 2017-11-26


<a name="description"></a>

# Description

The file
_/dev/tty_
is a character file with major number 5 and
minor number 0, usually of mode 0666 and owner.group root.tty.
It is a synonym for the controlling terminal of a process, if any.

In addition to the
**ioctl**(2)
requests supported by the device that
**tty**
refers to, the
**ioctl**(2)
request
**TIOCNOTTY**
is supported.

<a name="tiocnotty"></a>

### TIOCNOTTY

Detach the calling process from its controlling terminal.

If the process is the session leader,
then
**SIGHUP**
and
**SIGCONT**
signals are sent to the foreground process group
and all processes in the current session lose their controlling tty.

This
**ioctl**(2)
call works only on file descriptors connected
to
_/dev/tty_.
It is used by daemon processes when they are invoked
by a user at a terminal.
The process attempts to open
_/dev/tty_.
If the open succeeds, it
detaches itself from the terminal by using
**TIOCNOTTY**,
while if the
open fails, it is obviously not attached to a terminal and does not need
to detach itself.

<a name="files"></a>

# Files

_/dev/tty_

<a name="see-also"></a>

# See Also

**chown**(1),
**mknod**(1),
**ioctl**(2),
**ioctl_console**(2),
**ioctl_tty**(2),
**termios**(3),
**ttyS**(4),
**agetty**(8),
**mingetty**(8)

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
