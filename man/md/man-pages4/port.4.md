# mem(4) - system memory, kernel memory and system ports

Linux, 2015-01-02


<a name="description"></a>

# Description

_/dev/mem_
is a character device file
that is an image of the main memory of the computer.
It may be used, for example, to examine (and even patch) the system.

Byte addresses in
_/dev/mem_
are interpreted as physical memory addresses.
References to nonexistent locations cause errors to be returned.

Examining and patching is likely to lead to unexpected results
when read-only or write-only bits are present.

Since Linux 2.6.26, and depending on the architecture, the
**CONFIG_STRICT_DEVMEM**
kernel configuration option limits the areas
which can be accessed through this file.
For example: on x86, RAM access is not allowed but accessing
memory-mapped PCI regions is.

It is typically created by:

.in +4n
.EX
mknod -m 660 /dev/mem c 1 1
chown root:kmem /dev/mem
.EE
.in

The file
_/dev/kmem_
is the same as
_/dev/mem_,
except that the kernel virtual memory
rather than physical memory is accessed.
Since Linux 2.6.26, this file is available only if the
**CONFIG_DEVKMEM**
kernel configuration option is enabled.

It is typically created by:

.in +4n
.EX
mknod -m 640 /dev/kmem c 1 2
chown root:kmem /dev/kmem
.EE
.in

_/dev/port_
is similar to
_/dev/mem_,
but the I/O ports are accessed.

It is typically created by:

.in +4n
.EX
mknod -m 660 /dev/port c 1 4
chown root:kmem /dev/port
.EE
.in

<a name="files"></a>

# Files

_/dev/mem_  
_/dev/kmem_  
_/dev/port_

<a name="see-also"></a>

# See Also

**chown**(1),
**mknod**(1),
**ioperm**(2)

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
