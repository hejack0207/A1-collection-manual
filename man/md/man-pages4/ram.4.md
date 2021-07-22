# ram(4) - ram disk device

Linux, 1992-11-21


<a name="description"></a>

# Description

The
_ram_
device is a block device to access the ram disk in raw mode.

It is typically created by:

.in +4n
.EX
mknod -m 660 /dev/ram b 1 1
chown root:disk /dev/ram
.EE
.in

<a name="files"></a>

# Files

_/dev/ram_

<a name="see-also"></a>

# See Also

**chown**(1),
**mknod**(1),
**mount**(8)

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
