# full(4) - always full device

Linux, 2007-11-24


<a name="configuration"></a>

# Configuration

If your system does not have
_/dev/full_
created already, it
can be created with the following commands:

.in +4n
.EX
mknod -m 666 /dev/full c 1 7
chown root:root /dev/full
.EE
.in

<a name="description"></a>

# Description

File
_/dev/full_
has major device number 1
and minor device number 7.

Writes to the
_/dev/full_
device fail with an
**ENOSPC**
error.
This can be used to test how a program handles disk-full errors.

Reads from the
_/dev/full_
device will return \\0 characters.

Seeks on
_/dev/full_
will always succeed.

<a name="files"></a>

# Files

_/dev/full_

<a name="see-also"></a>

# See Also

**mknod**(1),
**null**(4),
**zero**(4)

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
