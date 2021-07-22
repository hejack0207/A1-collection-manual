# cpuid(4) - x86 CPUID access device

Linux, 2009-03-31


<a name="description"></a>

# Description

CPUID provides an interface for querying information about the x86 CPU.

This device is accessed by
**lseek**(2)
or
**pread**(2)
to the appropriate CPUID level and reading in chunks of 16 bytes.
A larger read size means multiple reads of consecutive levels.

The lower 32 bits of the file position is used as the incoming
_%eax_,
and the upper 32 bits of the file position as the incoming
_%ecx_,
the latter intended for "counting"
_eax_
levels like
_eax=4_.

This driver uses
_/dev/cpu/CPUNUM/cpuid_,
where
_CPUNUM_
is the minor number,
and on an SMP box will direct the access to CPU
_CPUNUM_
as listed in
_/proc/cpuinfo_.

This file is protected so that it can be read only by the user
_root_,
or members of the group
_root_.

<a name="notes"></a>

# Notes

The CPUID instruction can be directly executed by a program
using inline assembler.
However this device allows convenient
access to all CPUs without changing process affinity.

Most of the information in
_cpuid_
is reported by the kernel in cooked form either in
_/proc/cpuinfo_
or through subdirectories in
_/sys/devices/system/cpu_.
Direct CPUID access through this device should only
be used in exceptional cases.

The
_cpuid_
driver is not auto-loaded.
On modular kernels you might need to use the following command
to load it explicitly before use:

.in +4n
.EX
$ modprobe cpuid
.EE
.in

There is no support for CPUID functions that require additional
input registers.

Very old x86 CPUs don't support CPUID.

<a name="see-also"></a>

# See Also

Intel Corporation, Intel 64 and IA-32 Architectures
Software Developer's Manual Volume 2A:
Instruction Set Reference, A-M, 3-180 CPUID reference.

Intel Corporation, Intel Processor Identification and
the CPUID Instruction, Application note 485.

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
