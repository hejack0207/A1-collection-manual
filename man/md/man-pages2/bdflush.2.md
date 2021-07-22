# bdflush(2) - start, flush, or tune buffer-dirty-flush daemon

Linux, 2016-10-08

    #include <sys/kdaemon.h>
    
    int bdflush(int func, long *address);
    int bdflush(int func, long data);

<a name="description"></a>

# Description

_Note_:
Since Linux 2.6,

this system call is deprecated and does nothing.
It is likely to disappear altogether in a future kernel release.
Nowadays, the task performed by
**bdflush**()
is handled by the kernel
_pdflush_
thread.

**bdflush**()
starts, flushes, or tunes the buffer-dirty-flush daemon.
Only a privileged process (one with the
**CAP_SYS_ADMIN**
capability) may call
**bdflush**().

If
_func_
is negative or 0, and no daemon has been started, then
**bdflush**()
enters the daemon code and never returns.

If
_func_
is 1,
some dirty buffers are written to disk.

If
_func_
is 2 or more and is even (low bit is 0), then
_address_
is the address of a long word,
and the tuning parameter numbered
(_func_-2)/2
is returned to the caller in that address.

If
_func_
is 3 or more and is odd (low bit is 1), then
_data_
is a long word,
and the kernel sets tuning parameter numbered
(_func_-3)/2
to that value.

The set of parameters, their values, and their valid ranges
are defined in the Linux kernel source file
_fs/buffer.c_.

<a name="return-value"></a>

# Return Value

If
_func_
is negative or 0 and the daemon successfully starts,
**bdflush**()
never returns.
Otherwise, the return value is 0 on success and -1 on failure, with
_errno_
set to indicate the error.

<a name="errors"></a>

# Errors


* **EBUSY**  
  An attempt was made to enter the daemon code after
  another process has already entered.
* **EFAULT**  
  _address_
  points outside your accessible address space.
* **EINVAL**  
  An attempt was made to read or write an invalid parameter number,
  or to write an invalid value to a parameter.
* **EPERM**  
  Caller does not have the
  **CAP_SYS_ADMIN**
  capability.

<a name="versions"></a>

# Versions

Since version 2.23, glibc no longer supports this obsolete system call.

<a name="conforming-to"></a>

# Conforming to

**bdflush**()
is Linux-specific and should not be used in programs
intended to be portable.

<a name="see-also"></a>

# See Also

**sync**(1),
**fsync**(2),
**sync**(2)

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
