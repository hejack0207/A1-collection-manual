# setup(2) - setup devices and filesystems, mount root filesystem

Linux, 2008-12-03

```
#include <unistd.h> 
 int setup(void);
```

<a name="description"></a>

# Description

**setup**()
is called once from within
_linux/init/main.c_.
It calls initialization functions for devices and filesystems
configured into the kernel and then mounts the root filesystem.

No user process may call
**setup**().
Any user process, even a process with superuser permission,
will receive
**EPERM**.

<a name="return-value"></a>

# Return Value

**setup**()
always returns -1 for a user process.

<a name="errors"></a>

# Errors


* **EPERM**  
  Always, for a user process.

<a name="versions"></a>

# Versions

Since Linux 2.1.121, no such function exists anymore.

<a name="conforming-to"></a>

# Conforming to

This function is Linux-specific, and should not be used in programs
intended to be portable, or indeed in any programs at all.

<a name="notes"></a>

# Notes

The calling sequence varied: at some times
**setup**()
has had a single argument
_void&nbsp;*BIOS_
and at other times a single argument
_int magic_.

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
