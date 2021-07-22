# posix_fadvise(2) - predeclare an access pattern for file data

Linux, 2017-09-15

    #include <fcntl.h>
    
    int posix_fadvise(int fd, off_t offset, off_t len, int advice);
```

 .in -4n Feature Test Macro Requirements for glibc (see feature_test_macros(7)): .in 
 posix_fadvise(): .RS 4 _POSIX_C_SOURCE&nbsp;>=&nbsp;200112L .RE
```

<a name="description"></a>

# Description

Programs can use
**posix_fadvise**()
to announce an intention to access
file data in a specific pattern in the future, thus allowing the kernel
to perform appropriate optimizations.

The _advice_ applies to a (not necessarily existent) region starting
at _offset_ and extending for _len_ bytes (or until the end of
the file if _len_ is 0) within the file referred to by _fd_.
The _advice_ is not binding;
it merely constitutes an expectation on behalf of
the application.

Permissible values for _advice_ include:

* **POSIX_FADV_NORMAL**  
  Indicates that the application has no advice to give about its access
  pattern for the specified data.
  If no advice is given for an open file,
  this is the default assumption.
* **POSIX_FADV_SEQUENTIAL**  
  The application expects to access the specified data sequentially (with
  lower offsets read before higher ones).
* **POSIX_FADV_RANDOM**  
  The specified data will be accessed in random order.
* **POSIX_FADV_NOREUSE**  
  The specified data will be accessed only once.
* In kernels before 2.6.18, **POSIX\_FADV\_NOREUSE** had the
  same semantics as **POSIX\_FADV\_WILLNEED**.
  This was probably a bug; since kernel 2.6.18, this flag is a no-op.
* **POSIX_FADV_WILLNEED**  
  The specified data will be accessed in the near future.
* **POSIX\_FADV\_WILLNEED** initiates a
  nonblocking read of the specified region into the page cache.
  The amount of data read may be decreased by the kernel depending
  on virtual memory load.
  (A few megabytes will usually be fully satisfied,
  and more is rarely useful.)
* **POSIX_FADV_DONTNEED**  
  The specified data will not be accessed in the near future.
* **POSIX\_FADV\_DONTNEED** attempts to free cached pages associated with
  the specified region.
  This is useful, for example, while streaming large
  files.
  A program may periodically request the kernel to free cached data
  that has already been used, so that more useful cached pages are not
  discarded instead.
* Requests to discard partial pages are ignored.
  It is preferable to preserve needed data than discard unneeded data.
  If the application requires that data be considered for discarding, then
  _offset_
  and
  _len_
  must be page-aligned.
* The implementation
  _may_
  attempt to write back dirty pages in the specified region,
  but this is not guaranteed.
  Any unwritten dirty pages will not be freed.
  If the application wishes to ensure that dirty pages will be released,
  it should call
  **fsync**(2)
  or
  **fdatasync**(2)
  first.

<a name="return-value"></a>

# Return Value

On success, zero is returned.
On error, an error number is returned.

<a name="errors"></a>

# Errors


* **EBADF**  
  The _fd_ argument was not a valid file descriptor.
* **EINVAL**  
  An invalid value was specified for _advice_.
* **ESPIPE**  
  The specified file descriptor refers to a pipe or FIFO.
  (**ESPIPE**
  is the error specified by POSIX,
  but before kernel version 2.6.16,
  
  Linux returned
  **EINVAL**
  in this case.)

<a name="versions"></a>

# Versions

Kernel support first appeared in Linux 2.5.60;
the underlying system call is called
**fadvise64**().

Library support has been provided since glibc version 2.2,
via the wrapper function
**posix_fadvise**().

Since Linux 3.18,

support for the underlying system call is optional,
depending on the setting of the
**CONFIG_ADVISE_SYSCALLS**
configuration option.

<a name="conforming-to"></a>

# Conforming to

POSIX.1-2001, POSIX.1-2008.
Note that the type of the
_len_
argument was changed from
_size_t_
to
_off_t_
in POSIX.1-2003 TC1.

<a name="notes"></a>

# Notes

Under Linux, **POSIX\_FADV\_NORMAL** sets the readahead window to the
default size for the backing device; **POSIX\_FADV\_SEQUENTIAL** doubles
this size, and **POSIX\_FADV\_RANDOM** disables file readahead entirely.
These changes affect the entire file, not just the specified region
(but other open file handles to the same file are unaffected).

The contents of the kernel buffer cache can be cleared via the
_/proc/sys/vm/drop_caches_
interface described in
**proc**(5).

One can obtain a snapshot of which pages of a file are resident
in the buffer cache by opening a file, mapping it with
**mmap**(2),
and then applying
**mincore**(2)
to the mapping.

<a name="c-librarykernel-differences"></a>

### C library/kernel differences

The name of the wrapper function in the C library is
**posix_fadvise**().
The underlying system call is called
**fadvise64**()
(or, on some architectures,
**fadvise64_64**()).

<a name="architecture-specific-variants"></a>

### Architecture-specific variants

Some architectures require
64-bit arguments to be aligned in a suitable pair of registers (see
**syscall**(2)
for further detail).
On such architectures, the call signature of
**posix_fadvise**()
shown in the SYNOPSIS would force
a register to be wasted as padding between the
_fd_
and
_offset_
arguments.
Therefore, these architectures define a version of the
system call that orders the arguments suitably,
but is otherwise exactly the same as
**posix_fadvise**().

For example, since Linux 2.6.14, ARM has the following system call:

.in +4n
.EX
**long arm_fadvise64_64(int **_fd_**, int **_advice_**,**
**                      loff_t **_offset_**, loff_t **_len_**);**
.EE
.in

These architecture-specific details are generally
hidden from applications by the glibc
**posix_fadvise**()
wrapper function,
which invokes the appropriate architecture-specific system call.

<a name="bugs"></a>

# Bugs

In kernels before 2.6.6, if
_len_
was specified as 0, then this was interpreted literally as "zero bytes",
rather than as meaning "all bytes through to the end of the file".

<a name="see-also"></a>

# See Also

**fincore**(1),
**mincore**(2),
**readahead**(2),
**sync_file_range**(2),
**posix_fallocate**(3),
**posix_madvise**(3)

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
