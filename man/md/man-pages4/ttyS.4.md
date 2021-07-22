# ttys(4) - serial terminal lines

Linux, 1992-12-19


<a name="description"></a>

# Description

**ttyS[0-3]**
are character devices for the serial terminal lines.

They are typically created by:

.in +4n
.EX
mknod -m 660 /dev/ttyS0 c 4 64 # base address 0x3f8
mknod -m 660 /dev/ttyS1 c 4 65 # base address 0x2f8
mknod -m 660 /dev/ttyS2 c 4 66 # base address 0x3e8
mknod -m 660 /dev/ttyS3 c 4 67 # base address 0x2e8
chown root:tty /dev/ttyS[0-3]
.EE
.in

<a name="files"></a>

# Files

_/dev/ttyS[0-3]_

<a name="see-also"></a>

# See Also

**chown**(1),
**mknod**(1),
**tty**(4),
**agetty**(8),
**mingetty**(8),
**setserial**(8)

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
