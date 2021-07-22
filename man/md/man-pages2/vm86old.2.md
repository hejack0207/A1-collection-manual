# vm86(2) - enter virtual 8086 mode

Linux, 2009-02-20

```
#include <sys/vm86.h> 
 int vm86old(struct vm86_struct *info); 
 int vm86(unsigned long fn, struct vm86plus_struct *v86);
```

<a name="description"></a>

# Description

The system call
**vm86**()
was introduced in Linux 0.97p2.
In Linux 2.1.15 and 2.0.28, it was renamed to
**vm86old**(),
and a new
**vm86**()
was introduced.
The definition of
_struct vm86_struct_
was changed
in 1.1.8 and 1.1.9.

These calls cause the process to enter VM86 mode (virtual-8086 in Intel
literature), and are used by
**dosemu**.

VM86 mode is an emulation of real mode within a protected mode task.

<a name="return-value"></a>

# Return Value

On success, zero is returned.
On error, -1 is returned, and
_errno_
is set appropriately.

<a name="errors"></a>

# Errors


* **EFAULT**  
  This return value is specific to i386 and indicates a problem with getting
  user-space data.
* **ENOSYS**  
  This return value indicates the call is not implemented on the present
  architecture.
* **EPERM**  
  Saved kernel stack exists.
  (This is a kernel sanity check; the saved
  stack should exist only within vm86 mode itself.)

<a name="conforming-to"></a>

# Conforming to

This call is specific to Linux on 32-bit Intel processors,
and should not be used in programs intended to be portable.

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
