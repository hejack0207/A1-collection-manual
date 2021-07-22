# termio(7) - System V terminal driver interface

Linux, 2017-05-03


<a name="description"></a>

# Description

**termio**
is the name of the old System V terminal driver interface.
This interface defined a
_termio_
structure used to store terminal settings, and a range of
**ioctl**(2)
operations to get and set terminal attributes.

The
**termio**
interface is now obsolete: POSIX.1-1990 standardized a modified
version of this interface, under the name
**termios**.
The POSIX.1 data structure differs slightly from the
System V version, and POSIX.1 defined a suite of functions
to replace the various
**ioctl**(2)
operations that existed in System V.
(This was done because
**ioctl**(2)
was unstandardized, and its variadic third argument
does not allow argument type checking.)

If you're looking for a page called "termio", then you can probably
find most of the information that you seek in either
**termios**(3)
or
**ioctl_tty**(2).

<a name="see-also"></a>

# See Also

**reset**(1),
**setterm**(1),
**stty**(1),
**ioctl_tty**(2),
**termios**(3),
**tty**(4)

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
