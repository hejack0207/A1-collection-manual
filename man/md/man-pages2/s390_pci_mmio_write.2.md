# s390_pci_mmio_write(2) - transfer data to/from PCI

Linux Programmer's Manual, 2017-09-15

MMIO memory page

<a name="synopsis"></a>

# Synopsis

    #include <asm/unistd.h>
    
    int s390_pci_mmio_write(unsigned long mmio_addr,
                            void *user_buffer, size_t length);
    int s390_pci_mmio_read(unsigned long mmio_addr,
                            void *user_buffer, size_t length);

<a name="description"></a>

# Description

The
**s390_pci_mmio_write**()
system call writes
_length_
bytes of data from the user-space buffer
_user_buffer_
to the PCI MMIO memory location specified by
_mmio_addr_.
The
**s390_pci_mmio_read**()
system call reads
_length_
bytes of
data from the PCI MMIO memory location specified by
_mmio_addr_
to the user-space buffer
_user_buffer_.

These system calls must be used instead of the simple assignment
or data-transfer operations that are used to access the PCI MMIO
memory areas mapped to user space on the Linux System z platform.
The address specified by
_mmio_addr_
must belong to a PCI MMIO memory page mapping in the caller's address space,
and the data being written or read must not cross a page boundary.
The
_length_
value cannot be greater than the system page size.

<a name="return-value"></a>

# Return Value

On success,
**s390_pci_mmio_write**()
and
**s390_pci_mmio_read**()
return 0.
On error, -1 is returned and
_errno_
is set to one of the error codes listed below.

<a name="errors"></a>

# Errors


* **EFAULT**  
  The address in
  _mmio_addr_
  is invalid.
* **EFAULT**  
  _user_buffer_
  does not point to a valid location in the caller's address space.
* **EINVAL**  
  Invalid
  _length_
  argument.
* **ENODEV**  
  PCI support is not enabled.
* **ENOMEM**  
  Insufficient memory.

<a name="versions"></a>

# Versions

These system calls are available since Linux 3.19.

<a name="conforming-to"></a>

# Conforming to

This Linux-specific system call is available only on the s390 architecture.
The required PCI support is available beginning with System z EC12.

<a name="notes"></a>

# Notes

Glibc does not provide a wrapper for this system call, use
**syscall**(2)
to call it.

<a name="see-also"></a>

# See Also

**syscall**(2)

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
