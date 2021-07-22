# iopl(2) - change I/O privilege level

Linux, 2017-09-15

```
#include <sys/io.h> 
 int iopl(int level);
```

<a name="description"></a>

# Description

**iopl**()
changes the I/O privilege level of the calling process,
as specified by the two least significant bits in
_level_.

This call is necessary to allow 8514-compatible X servers to run under
Linux.
Since these X servers require access to all 65536 I/O ports, the
**ioperm**(2)
call is not sufficient.

In addition to granting unrestricted I/O port access, running at a higher
I/O privilege level also allows the process to disable interrupts.
This will probably crash the system, and is not recommended.

Permissions are not inherited by the child process created by
**fork**(2)
and are not preserved across
**execve**(2)
(but see NOTES).

The I/O privilege level for a normal process is 0.

This call is mostly for the i386 architecture.
On many other architectures it does not exist or will always
return an error.

<a name="return-value"></a>

# Return Value

On success, zero is returned.
On error, -1 is returned, and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **EINVAL**  
  _level_
  is greater than 3.
* **ENOSYS**  
  This call is unimplemented.
* **EPERM**  
  The calling process has insufficient privilege to call
  **iopl**();
  the
  **CAP_SYS_RAWIO**
  capability is required to raise the I/O privilege level
  above its current value.

<a name="conforming-to"></a>

# Conforming to

**iopl**()
is Linux-specific and should not be used in programs that are
intended to be portable.

<a name="notes"></a>

# Notes




Glibc2 has a prototype both in
_&lt;sys/io.h&gt;_
and in
_&lt;sys/perm.h&gt;_.
Avoid the latter, it is available on i386 only.

Prior to Linux 3.7,
on some architectures (such as i386), permissions
_were_
inherited by the child produced by
**fork**(2)
and were preserved across
**execve**(2).
This behavior was inadvertently changed in Linux 3.7,
and won't be reinstated.

<a name="see-also"></a>

# See Also

**ioperm**(2),
**outb**(2),
**capabilities**(7)

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
