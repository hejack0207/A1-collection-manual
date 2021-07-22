# ttytype(5) - terminal device to default terminal type mapping

Linux, 2012-12-31


<a name="description"></a>

# Description

The
_/etc/ttytype_
file associates
**termcap**(5)/**terminfo**(5)
terminal type names
with tty lines.
Each line consists of a terminal type, followed by
whitespace, followed by a tty name (a device name without the
_/dev/_) prefix.

This association is used by the program
**tset**(1)
to set the environment variable
**TERM**
to the default terminal name for
the user's current tty.

This facility was designed for a traditional time-sharing environment
featuring character-cell terminals hardwired to a UNIX minicomputer.
It is little used on modern workstation and personal UNIX systems.

<a name="files"></a>

# Files


* _/etc/ttytype_  
  the tty definitions file.

<a name="example"></a>

# Example

A typical
_/etc/ttytype_
is:

.in +4n
.EX
con80x25 tty1
vt320 ttys0
.EE
.in

<a name="see-also"></a>

# See Also

**termcap**(5),
**terminfo**(5),
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
