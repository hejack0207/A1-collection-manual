# arch_prctl(2) - set architecture-specific thread state

Linux, 2017-09-15

    #include <asm/prctl.h>
    #include <sys/prctl.h>
    
    int arch_prctl(int code, unsigned long addr);
    int arch_prctl(int code, unsigned long *addr);

<a name="description"></a>

# Description

**arch_prctl**()
sets architecture-specific process or thread state.
_code_
selects a subfunction
and passes argument
_addr_
to it;
_addr_
is interpreted as either an
_unsigned long_
for the "set" operations, or as an
_unsigned long&nbsp;*_,
for the "get" operations.

Subfunctions for x86-64 are:

* **ARCH_SET_FS**  
  Set the 64-bit base for the
  _FS_
  register to
  _addr_.
* **ARCH_GET_FS**  
  Return the 64-bit base value for the
  _FS_
  register of the current thread in the
  _unsigned long_
  pointed to by
  _addr_.
* **ARCH_SET_GS**  
  Set the 64-bit base for the
  _GS_
  register to
  _addr_.
* **ARCH_GET_GS**  
  Return the 64-bit base value for the
  _GS_
  register of the current thread in the
  _unsigned long_
  pointed to by
  _addr_.

<a name="return-value"></a>

# Return Value

On success,
**arch_prctl**()
returns 0; on error, -1 is returned, and
_errno_
is set to indicate the error.

<a name="errors"></a>

# Errors


* **EFAULT**  
  _addr_
  points to an unmapped address or is outside the process address space.
* **EINVAL**  
  _code_
  is not a valid subcommand.
* **EPERM**  
  _addr_
  is outside the process address space.
  
  

<a name="conforming-to"></a>

# Conforming to

**arch_prctl**()
is a Linux/x86-64 extension and should not be used in programs intended
to be portable.

<a name="notes"></a>

# Notes

**arch_prctl**()
is supported only on Linux/x86-64 for 64-bit programs currently.

The 64-bit base changes when a new 32-bit segment selector is loaded.

**ARCH_SET_GS**
is disabled in some kernels.

Context switches for 64-bit segment bases are rather expensive.
As an optimization, if a 32-bit TLS base address is used,
**arch_prctl**()
may use a real TLS entry as if
**set_thread_area**(2)
had been called, instead of manipulating the segment base register directly.
Memory in the first 2&nbsp;GB of address space can be allocated by using
**mmap**(2)
with the
**MAP_32BIT**
flag.

Because of the aforementioned optimization, using
**arch_prctl**()
and
**set_thread_area**(2)
in the same thread is dangerous, as they may overwrite each other's
TLS entries.

As of version 2.7, glibc provides no prototype for
**arch_prctl**().
You have to declare it yourself for now.
This may be fixed in future glibc versions.

_FS_
may be already used by the threading library.
Programs that use
**ARCH_SET_FS**
directly are very likely to crash.

<a name="see-also"></a>

# See Also

**mmap**(2),
**modify_ldt**(2),
**prctl**(2),
**set_thread_area**(2)

AMD X86-64 Programmer's manual

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
