# msr(4) - x86 CPU MSR access device

Linux, 2009-03-31


<a name="description"></a>

# Description

_/dev/cpu/CPUNUM/msr_
provides an interface to read and write the model-specific
registers (MSRs) of an x86 CPU.
_CPUNUM_
is the number of the CPU to access as listed in
_/proc/cpuinfo_.

The register access is done by opening the file and seeking
to the MSR number as offset in the file, and then
reading or writing in chunks of 8 bytes.
An I/O transfer of more than 8 bytes means multiple reads or writes
of the same register.

This file is protected so that it can be read and written only by the user
_root_,
or members of the group
_root_.

<a name="notes"></a>

# Notes

The
_msr_
driver is not auto-loaded.
On modular kernels you might need to use the following command
to load it explicitly before use:

.in +4n
.EX
$ modprobe msr
.EE
.in


<a name="see-also"></a>

# See Also

Intel Corporation Intel 64 and IA-32 Architectures
Software Developer's Manual Volume 3B Appendix B,
for an overview of the Intel CPU MSRs.

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
