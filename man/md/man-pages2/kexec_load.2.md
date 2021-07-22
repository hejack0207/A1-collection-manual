# kexec_load(2) - load a new kernel for later execution

Linux, 2017-09-15

    #include <linux/kexec.h>
    
    long kexec_load(unsigned long entry, unsigned long nr_segments,
                    struct kexec_segment *segments, unsigned long flags);
    
    long kexec_file_load(int kernel_fd, int initrd_fd,
                        unsigned long cmdline_len, const char *cmdline,
                        unsigned long flags);
```

 Note: There are no glibc wrappers for these system calls; see NOTES.
```

<a name="description"></a>

# Description

The
**kexec_load**()
system call loads a new kernel that can be executed later by
**reboot**(2).

The
_flags_
argument is a bit mask that controls the operation of the call.
The following values can be specified in
_flags_:

* **KEXEC_ON_CRASH** (since Linux 2.6.13)  
  Execute the new kernel automatically on a system crash.
  This "crash kernel" is loaded into an area of reserved memory that
  is determined at boot time using the
  _crashkernel_
  kernel command-line parameter.
  The location of this reserved memory is exported to user space via the
  _/proc/iomem_
  file, in an entry labeled "Crash kernel".
  A user-space application can parse this file and prepare a list of
  segments (see below) that specify this reserved memory as destination.
  If this flag is specified, the kernel checks that the
  target segments specified in
  _segments_
  fall within the reserved region.
* **KEXEC_PRESERVE_CONTEXT** (since Linux 2.6.27)  
  Preserve the system hardware and
  software states before executing the new kernel.
  This could be used for system suspend.
  This flag is available only if the kernel was configured with
  **CONFIG_KEXEC_JUMP**,
  and is effective only if
  _nr_segments_
  is greater than 0.

The high-order bits (corresponding to the mask 0xffff0000) of
_flags_
contain the architecture of the to-be-executed kernel.
Specify (OR) the constant
**KEXEC_ARCH_DEFAULT**
to use the current architecture,
or one of the following architecture constants
**KEXEC_ARCH_386**,
**KEXEC_ARCH_68K**,
**KEXEC_ARCH_X86_64**,
**KEXEC_ARCH_PPC**,
**KEXEC_ARCH_PPC64**,
**KEXEC_ARCH_IA_64**,
**KEXEC_ARCH_ARM**,
**KEXEC_ARCH_S390**,
**KEXEC_ARCH_SH**,
**KEXEC_ARCH_MIPS**,
and
**KEXEC_ARCH_MIPS_LE**.
The architecture must be executable on the CPU of the system.

The
_entry_
argument is the physical entry address in the kernel image.
The
_nr_segments_
argument is the number of segments pointed to by the
_segments_
pointer;
the kernel imposes an (arbitrary) limit of 16 on the number of segments.
The
_segments_
argument is an array of
_kexec_segment_
structures which define the kernel layout:

.in +4n
.EX
struct kexec_segment {
    void   *buf;        /* Buffer in user space */
    size_t  bufsz;      /* Buffer length in user space */
    void   *mem;        /* Physical address of kernel */
    size_t  memsz;      /* Physical address length */
};
.EE
.in

The kernel image defined by
_segments_
is copied from the calling process into
the kernel either in regular
memory or in reserved memory (if
**KEXEC_ON_CRASH**
is set).
The kernel first performs various sanity checks on the
information passed in
_segments_.
If these checks pass, the kernel copies the segment data to kernel memory.
Each segment specified in
_segments_
is copied as follows:

* *  
  _buf_
  and
  _bufsz_
  identify a memory region in the caller's virtual address space
  that is the source of the copy.
  The value in
  _bufsz_
  may not exceed the value in the
  _memsz_
  field.
* *  
  _mem_
  and
  _memsz_
  specify a physical address range that is the target of the copy.
  The values specified in both fields must be multiples of
  the system page size.
* *  
  _bufsz_
  bytes are copied from the source buffer to the target kernel buffer.
  If
  _bufsz_
  is less than
  _memsz_,
  then the excess bytes in the kernel buffer are zeroed out.

In case of a normal kexec (i.e., the
**KEXEC_ON_CRASH**
flag is not set), the segment data is loaded in any available memory
and is moved to the final destination at kexec reboot time (e.g., when the
**kexec**(8)
command is executed with the
_-e_
option).

In case of kexec on panic (i.e., the
**KEXEC_ON_CRASH**
flag is set), the segment data is
loaded to reserved memory at the time of the call, and, after a crash,
the kexec mechanism simply passes control to that kernel.

The
**kexec_load**()
system call is available only if the kernel was configured with
**CONFIG_KEXEC**.

<a name="kexec_file_load"></a>

### kexec_file_load()

The
**kexec_file_load**()
system call is similar to
**kexec_load**(),
but it takes a different set of arguments.
It reads the kernel to be loaded from the file referred to by
the file descriptor
_kernel_fd_,
and the initrd (initial RAM disk)
to be loaded from file referred to by the file descriptor
_initrd_fd_.
The
_cmdline_
argument is a pointer to a buffer containing the command line
for the new kernel.
The
_cmdline_len_
argument specifies size of the buffer.
The last byte in the buffer must be a null byte ('\\0').

The
_flags_
argument is a bit mask which modifies the behavior of the call.
The following values can be specified in
_flags_:

* **KEXEC_FILE_UNLOAD**  
  Unload the currently loaded kernel.
* **KEXEC_FILE_ON_CRASH**  
  Load the new kernel in the memory region reserved for the crash kernel
  (as for
  **KEXEC_ON_CRASH).**
  This kernel is booted if the currently running kernel crashes.
* **KEXEC_FILE_NO_INITRAMFS**  
  Loading initrd/initramfs is optional.
  Specify this flag if no initramfs is being loaded.
  If this flag is set, the value passed in
  _initrd_fd_
  is ignored.

The
**kexec_file_load**()

system call was added to provide support for systems
where "kexec" loading should be restricted to
only kernels that are signed.
This system call is available only if the kernel was configured with
**CONFIG_KEXEC_FILE**.

<a name="return-value"></a>

# Return Value

On success, these system calls returns 0.
On error, -1 is returned and
_errno_
is set to indicate the error.

<a name="errors"></a>

# Errors


* **EADDRNOTAVAIL**  
  
  The
  **KEXEC_ON_CRASH**
  flags was specified, but the region specified by the
  _mem_
  and
  _memsz_
  fields of one of the
  _segments_
  entries lies outside the range of memory reserved for the crash kernel.
* **EADDRNOTAVAIL**  
  The value in a
  _mem_
  or
  _memsz_
  field in one of the
  _segments_
  entries is not a multiple of the system page size.
* **EBADF**  
  _kernel_fd_
  or
  _initrd_fd_
  is not a valid file descriptor.
* **EBUSY**  
  Another crash kernel is already being loaded
  or a crash kernel is already in use.
* **EINVAL**  
  _flags_
  is invalid.
* **EINVAL**  
  The value of a
  _bufsz_
  field in one of the
  _segments_
  entries exceeds the value in the corresponding
  _memsz_
  field.
* **EINVAL**  
  _nr_segments_
  exceeds
  **KEXEC_SEGMENT_MAX**
  (16).
* **EINVAL**  
  Two or more of the kernel target buffers overlap.
* **EINVAL**  
  The value in
  _cmdline[cmdline_len-1]_
  is not '\\0'.
* **EINVAL**  
  The file referred to by
  _kernel_fd_
  or
  _initrd_fd_
  is empty (length zero).
* **ENOEXEC**  
  _kernel_fd_
  does not refer to an open file, or the kernel can't load this file.
  Currently, the file must be a bzImage and contain an x86 kernel that
  is loadable above 4&nbsp;GiB in memory (see the kernel source file
  _Documentation/x86/boot.txt_).
* **ENOMEM**  
  Could not allocate memory.
* **EPERM**  
  The caller does not have the
  **CAP_SYS_BOOT**
  capability.

<a name="versions"></a>

# Versions

The
**kexec_load**()
system call first appeared in Linux 2.6.13.
The
**kexec_file_load**()
system call first appeared in Linux 3.17.

<a name="conforming-to"></a>

# Conforming to

These system calls are Linux-specific.

<a name="notes"></a>

# Notes

Currently, there is no glibc support for these system calls.
Call them using
**syscall**(2).

<a name="see-also"></a>

# See Also

**reboot**(2),
**syscall**(2),
**kexec**(8)

The kernel source files
_Documentation/kdump/kdump.txt_
and
_Documentation/admin-guide/kernel-parameters.txt_

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
