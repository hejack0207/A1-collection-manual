# cacheflush(2) - flush contents of instruction and/or data cache

Linux, 2017-09-15

    #include <asm/cachectl.h>
    
    int cacheflush(char *addr, int nbytes, int cache);

<a name="description"></a>

# Description

**cacheflush**()
flushes the contents of the indicated cache(s) for the
user addresses in the range
_addr_
to
_(addr+nbytes-1)_.
_cache_
may be one of:

* **ICACHE**  
  Flush the instruction cache.
* **DCACHE**  
  Write back to memory and invalidate the affected valid cache lines.
* **BCACHE**  
  Same as
  **(ICACHE|DCACHE)**.

<a name="return-value"></a>

# Return Value

**cacheflush**()
returns 0 on success or -1 on error.
If errors are detected,
_errno_
will indicate the error.

<a name="errors"></a>

# Errors


* **EFAULT**  
  Some or all of the address range
  _addr_
  to
  _(addr+nbytes-1)_
  is not accessible.
* **EINVAL**  
  _cache_
  is not one of
  **ICACHE**,
  **DCACHE**,
  or
  **BCACHE**
  (but see BUGS).

<a name="conforming-to"></a>

# Conforming to

Historically, this system call was available on all MIPS UNIX variants
including RISC/os, IRIX, Ultrix, NetBSD, OpenBSD, and FreeBSD
(and also on some non-UNIX MIPS operating systems), so that
the existence of this call in MIPS operating systems is a de-facto
standard.

<a name="caveat"></a>

### Caveat

**cacheflush**()
should not be used in programs intended to be portable.
On Linux, this call first appeared on the MIPS architecture,
but nowadays, Linux provides a
**cacheflush**()
system call on some other architectures, but with different arguments.

<a name="bugs"></a>

# Bugs

Linux kernels older than version 2.6.11 ignore the
_addr_
and
_nbytes_
arguments, making this function fairly expensive.
Therefore, the whole cache is always flushed.

This function always behaves as if
**BCACHE**
has been passed for the
_cache_
argument and does not do any error checking on the
_cache_
argument.

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
