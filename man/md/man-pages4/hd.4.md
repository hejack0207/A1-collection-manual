# hd(4) - MFM/IDE hard disk devices

Linux, 2017-09-15


<a name="description"></a>

# Description

The
**hd***
devices are block devices to access MFM/IDE hard disk drives
in raw mode.
The master drive on the primary IDE controller (major device
number 3) is
**hda**;
the slave drive is
**hdb**.
The master drive of the second controller (major device number 22)
is
**hdc**
and the slave is
**hdd**.

General IDE block device names have the form
**hd**_X\c_
, or
**hd**_XP\c_
, where
_X_
is a letter denoting the physical drive, and
_P_
is a number denoting the partition on that physical drive.
The first form,
**hd**_X\c_
, is used to address the whole drive.
Partition numbers are assigned in the order the partitions
are discovered, and only nonempty, nonextended partitions
get a number.
However, partition numbers 1–4 are given to the
four partitions described in the MBR (the "primary" partitions),
regardless of whether they are unused or extended.
Thus, the first logical partition will be
**hd**_X_**5\c**
.
Both DOS-type partitioning and BSD-disklabel partitioning are supported.
You can have at most 63 partitions on an IDE disk.

For example,
_/dev/hda_
refers to all of the first IDE drive in the system; and
_/dev/hdb3_
refers to the third DOS "primary" partition on the second one.

They are typically created by:

.in +4n
.EX
mknod -m 660 /dev/hda b 3 0
mknod -m 660 /dev/hda1 b 3 1
mknod -m 660 /dev/hda2 b 3 2
...
mknod -m 660 /dev/hda8 b 3 8
mknod -m 660 /dev/hdb b 3 64
mknod -m 660 /dev/hdb1 b 3 65
mknod -m 660 /dev/hdb2 b 3 66
...
mknod -m 660 /dev/hdb8 b 3 72
chown root:disk /dev/hd*
.EE
.in

<a name="files"></a>

# Files

_/dev/hd*_

<a name="see-also"></a>

# See Also

**chown**(1),
**mknod**(1),
**sd**(4),
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
