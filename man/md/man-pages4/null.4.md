# null(4) - data sink

Linux, 2015-07-23


<a name="description"></a>

# Description

Data written to the
_/dev/null_
and
_/dev/zero_
special files is discarded.

Reads from
_/dev/null_
always return end of file (i.e.,
**read**(2)
returns 0), whereas reads from
_/dev/zero_
always return bytes containing zero ('\e0' characters).

These devices are typically created by:

.in +4n
.EX
mknod -m 666 /dev/null c 1 3
mknod -m 666 /dev/zero c 1 5
chown root:root /dev/null /dev/zero
.EE
.in

<a name="files"></a>

# Files

_/dev/null_  
_/dev/zero_

<a name="notes"></a>

# Notes

If these devices are not writable and readable for all users, many
programs will act strangely.

Since Linux 2.6.31,

reads from
_/dev/zero_
are interruptible by signals.
(This change was made to help with bad latencies for large reads from
_/dev/zero_.)

<a name="see-also"></a>

# See Also

**chown**(1),
**mknod**(1),
**full**(4)

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
